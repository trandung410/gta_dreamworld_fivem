AddEventHandler('es:playerLoaded', function(source, _player)
	local _source = source
	local tasks   = {}

	local userData = {
		accounts     = {},
		inventory    = {},
		job          = {},
		loadout      = {},
		playerName   = GetPlayerName(_source),
		lastPosition = nil
	}

	TriggerEvent('es:getPlayerFromId', _source, function(player)
		-- Update user name in DB
		table.insert(tasks, function(cb)
			MySQL.Async.execute('UPDATE `users` SET `name` = @name WHERE `identifier` = @identifier', {
				['@identifier'] = player.getIdentifier(),
				['@name'] = userData.playerName
			}, function(rowsChanged)
				cb()
			end)
		end)

		-- Get accounts
		table.insert(tasks, function(cb)
			MySQL.Async.fetchAll('SELECT * FROM `user_accounts` WHERE `identifier` = @identifier', {
				['@identifier'] = player.getIdentifier()
			}, function(accounts)
				for i=1, #Config.Accounts, 1 do
					for j=1, #accounts, 1 do
						if accounts[j].name == Config.Accounts[i] then
							table.insert(userData.accounts, {
								name  = accounts[j].name,
								money = accounts[j].money,
								label = Config.AccountLabels[accounts[j].name]
							})
							break
						end
					end
				end

				cb()
			end)
		end)

		-- Get inventory
		table.insert(tasks, function(cb)

			MySQL.Async.fetchAll('SELECT * FROM `user_inventory` WHERE `identifier` = @identifier', {
				['@identifier'] = player.getIdentifier()
			}, function(inventory)
				local tasks2 = {}

				for i=1, #inventory do
					local item = ESX.Items[inventory[i].item]

					if item then
						table.insert(userData.inventory, {
							name = inventory[i].item,
							count = inventory[i].count,
							label = item.label,
							limit = item.limit,
							usable = ESX.UsableItemsCallbacks[inventory[i].item] ~= nil,
							rare = item.rare,
							canRemove = item.canRemove
						})
					else
						print(('es_extended: invalid item "%s" ignored!'):format(inventory[i].item))
					end
				end

				for k,v in pairs(ESX.Items) do
					local found = false

					for j=1, #userData.inventory do
						if userData.inventory[j].name == k then
							found = true
							break
						end
					end

					if not found then
						table.insert(userData.inventory, {
							name = k,
							count = 0,
							label = ESX.Items[k].label,
							limit = ESX.Items[k].limit,
							usable = ESX.UsableItemsCallbacks[k] ~= nil,
							rare = ESX.Items[k].rare,
							canRemove = ESX.Items[k].canRemove
						})

						local scope = function(item, identifier)
							table.insert(tasks2, function(cb2)
								MySQL.Async.execute('INSERT INTO user_inventory (identifier, item, count) VALUES (@identifier, @item, @count)', {
									['@identifier'] = identifier,
									['@item'] = item,
									['@count'] = 0
								}, function(rowsChanged)
									cb2()
								end)
							end)
						end

						scope(k, player.getIdentifier())
					end
					

				end

				Async.parallelLimit(tasks2, 5, function(results) end)

				table.sort(userData.inventory, function(a,b)
					return a.label < b.label
				end)

				cb()
			end)

		end)

		-- Get job and loadout
		table.insert(tasks, function(cb)

			local tasks2 = {}

			-- Get job name, grade and last position
			table.insert(tasks2, function(cb2)

				MySQL.Async.fetchAll('SELECT job, job_grade, loadout, position FROM `users` WHERE `identifier` = @identifier', {
					['@identifier'] = player.getIdentifier()
				}, function(result)
					local job, grade = result[1].job, tostring(result[1].job_grade)

					if ESX.DoesJobExist(job, grade) then
						local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

						userData.job = {}

						userData.job.id    = jobObject.id
						userData.job.name  = jobObject.name
						userData.job.label = jobObject.label

						userData.job.grade        = tonumber(grade)
						userData.job.grade_name   = gradeObject.name
						userData.job.grade_label  = gradeObject.label
						userData.job.grade_salary = gradeObject.salary

						userData.job.skin_male    = {}
						userData.job.skin_female  = {}

						if gradeObject.skin_male ~= nil then
							userData.job.skin_male = json.decode(gradeObject.skin_male)
						end
			
						if gradeObject.skin_female ~= nil then
							userData.job.skin_female = json.decode(gradeObject.skin_female)
						end
					else
						print(('es_extended: %s had an unknown job [job: %s, grade: %s], setting as unemployed!'):format(player.getIdentifier(), job, grade))

						local job, grade = 'unemployed', '0'
						local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

						userData.job = {}

						userData.job.id    = jobObject.id
						userData.job.name  = jobObject.name
						userData.job.label = jobObject.label
			
						userData.job.grade        = tonumber(grade)
						userData.job.grade_name   = gradeObject.name
						userData.job.grade_label  = gradeObject.label
						userData.job.grade_salary = gradeObject.salary
			
						userData.job.skin_male    = {}
						userData.job.skin_female  = {}
					end

					if result[1].loadout ~= nil then
						userData.loadout = json.decode(result[1].loadout)

						-- Compatibility with old loadouts prior to components update
						for k,v in ipairs(userData.loadout) do
							if v.components == nil then
								v.components = {}
							end
						end
					end

					if result[1].position ~= nil then
						userData.lastPosition = json.decode(result[1].position)
					end

					cb2()
				end)

			end)

			Async.series(tasks2, cb)

		end)

		-- Run Tasks
		Async.parallel(tasks, function(results)
			local xPlayer = CreateExtendedPlayer(player, userData.accounts, userData.inventory, userData.job, userData.loadout, userData.playerName, userData.lastPosition)

			xPlayer.getMissingAccounts(function(missingAccounts)
				if #missingAccounts > 0 then

					for i=1, #missingAccounts, 1 do
						table.insert(xPlayer.accounts, {
							name  = missingAccounts[i],
							money = 0,
							label = Config.AccountLabels[missingAccounts[i]]
						})
					end

					xPlayer.createAccounts(missingAccounts)
				end

				ESX.Players[_source] = xPlayer

				TriggerEvent('esx:playerLoaded', _source, xPlayer)

				TriggerClientEvent('esx:playerLoaded', _source, {
					identifier   = xPlayer.identifier,
					accounts     = xPlayer.getAccounts(),
					inventory    = xPlayer.getInventory(),
					job          = xPlayer.getJob(),
					loadout      = xPlayer.getLoadout(),
					lastPosition = xPlayer.getLastPosition(),
					money        = xPlayer.getMoney()
				})

				xPlayer.displayMoney(xPlayer.getMoney())
			end)
		end)

	end)
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer then
		TriggerEvent('esx:playerDropped', _source, reason)
		if xPlayer.team then 
			ESX.LeaveTeam(xPlayer.team, playerId)
		end
		ESX.SavePlayer(xPlayer, function()
			ESX.Players[_source] = nil
			ESX.LastPlayerData[_source] = nil
		end)
	end
end)

RegisterServerEvent('esx:updateLoadout')
AddEventHandler('esx:updateLoadout', function(loadout)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent("2k-cheese:WeaponLog", source, xPlayer.loadout, loadout)
	xPlayer.loadout = loadout
end)

RegisterServerEvent('esx:updateLastPosition')
AddEventHandler('esx:updateLastPosition', function(position)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setLastPosition(position)
end)

RegisterServerEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == 'item_standard' then

		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then

			if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				-- TriggerClientEvent('esx:showNotification', _source, _U('ex_inv_lim', targetXPlayer.name))
			else
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)
				
				-- TriggerClientEvent('esx:showNotification', _source, _U('gave_item', itemCount, ESX.Items[itemName].label, targetXPlayer.name))
				-- TriggerClientEvent('esx:showNotification', target,  _U('received_item', itemCount, ESX.Items[itemName].label, sourceXPlayer.name))
				TriggerEvent("esx:giveitemalert",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount)				
			end

		else
			-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
		end

	elseif type == 'item_money' then

		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney   (itemCount)

			--TriggerClientEvent('esx:showNotification', _source, _U('gave_money', ESX.Math.GroupDigits(itemCount), targetXPlayer.name))
			--TriggerClientEvent('esx:showNotification', target,  _U('received_money', ESX.Math.GroupDigits(itemCount), sourceXPlayer.name))
			TriggerEvent("esx:givemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount)
		else
			---TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		end

	elseif type == 'item_account' then

		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

			--TriggerClientEvent('esx:showNotification', _source, _U('gave_account_money', ESX.Math.GroupDigits(itemCount), Config.AccountLabels[itemName], targetXPlayer.name))
			--TriggerClientEvent('esx:showNotification', target,  _U('received_account_money', ESX.Math.GroupDigits(itemCount), Config.AccountLabels[itemName], sourceXPlayer.name))
			TriggerEvent("esx:givemoneybankalert",sourceXPlayer.name,targetXPlayer.name,itemCount)
		else
			--TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		end

	elseif type == 'item_weapon' then

		if not targetXPlayer.hasWeapon(itemName) then
			sourceXPlayer.removeWeapon(itemName)
			targetXPlayer.addWeapon(itemName, itemCount)

			local weaponLabel = ESX.GetWeaponLabel(itemName)
            TriggerEvent("esx:giveweaponalert", sourceXPlayer.name, targetXPlayer.name, weaponLabel)
			if itemCount > 0 then
				-- TriggerClientEvent('esx:showNotification', _source, _U('gave_weapon_ammo', weaponLabel, itemCount, targetXPlayer.name))
				-- TriggerClientEvent('esx:showNotification', target,  _U('received_weapon_ammo', weaponLabel, itemCount, sourceXPlayer.name))
			else
				-- TriggerClientEvent('esx:showNotification', _source, _U('gave_weapon', weaponLabel, targetXPlayer.name))
				-- TriggerClientEvent('esx:showNotification', target,  _U('received_weapon', weaponLabel, sourceXPlayer.name))
				TriggerEvent("esx:giveweaponalert", sourceXPlayer.name, targetXPlayer.name, weaponLabel)
			end
		else
			-- TriggerClientEvent('esx:showNotification', _source, _U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel))
			-- TriggerClientEvent('esx:showNotification', _source, _U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel))
		end

	end
end)

-- RegisterServerEvent('esx:removeInventoryItem')
-- AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
-- 	local _source = source

-- 	if type == 'item_standard' then

-- 		if itemCount == nil or itemCount < 1 then
-- 			-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
-- 		else
-- 			local xPlayer = ESX.GetPlayerFromId(source)
-- 			local xItem = xPlayer.getInventoryItem(itemName)

-- 			if (itemCount > xItem.count or xItem.count < 1) then
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
-- 			else
-- 				xPlayer.removeInventoryItem(itemName, itemCount)

-- 				-- local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
-- 				-- ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, _source)
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('threw_standard', itemCount, xItem.label))
-- 				TriggerEvent("new_GTX:removeitem", xPlayer.name, xItem.label, itemCount, type)
-- 			end
-- 		end

-- 	elseif type == 'item_money' then

-- 		if itemCount == nil or itemCount < 1 then
-- 			-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
-- 		else
-- 			local xPlayer = ESX.GetPlayerFromId(source)
-- 			local playerCash = xPlayer.getMoney()

-- 			if (itemCount > playerCash or playerCash < 1) then
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
-- 			else
-- 				xPlayer.removeMoney(itemCount)

-- 				-- local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(_U('cash'), _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
-- 				-- ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source)
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('threw_money', ESX.Math.GroupDigits(itemCount)))
-- 				TriggerEvent("new_GTX:removemoney", xPlayer.name, itemName, itemCount, type)
-- 			end
-- 		end

-- 	elseif type == 'item_account' then

-- 		if itemCount == nil or itemCount < 1 then
-- 			-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
-- 		else
-- 			local xPlayer = ESX.GetPlayerFromId(source)
-- 			local account = xPlayer.getAccount(itemName)

-- 			if (itemCount > account.money or account.money < 1) then
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
-- 			else
-- 				xPlayer.removeAccountMoney(itemName, itemCount)
-- 				TriggerEvent("new_GTX:removemoney", xPlayer.name, itemName, itemCount, type)

-- 				-- local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(account.label, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
-- 				-- ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source)
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
-- 			end
-- 		end

-- 	elseif type == 'item_weapon' then

-- 		local xPlayer = ESX.GetPlayerFromId(source)
-- 		local loadout = xPlayer.getLoadout()

-- 		for i=1, #loadout, 1 do
-- 			if loadout[i].name == itemName then
-- 				itemCount = loadout[i].ammo
-- 				break
-- 			end
-- 		end

-- 		if xPlayer.hasWeapon(itemName) then
-- 			local weaponLabel, weaponPickup = ESX.GetWeaponLabel(itemName), 'PICKUP_' .. string.upper(itemName)

-- 			xPlayer.removeWeapon(itemName)

-- 			if itemCount > 0 then
-- 				TriggerClientEvent('esx:pickupWeapon', _source, weaponPickup, itemName, itemCount)
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('threw_weapon_ammo', weaponLabel, itemCount))
-- 				TriggerEvent("new_GTX:removeitem", xPlayer.name, weaponLabel, itemCount, type)
-- 			else
-- 				-- workaround for CreateAmbientPickup() giving 30 rounds of ammo when you drop the weapon with 0 ammo
-- 				TriggerClientEvent('esx:pickupWeapon', _source, weaponPickup, itemName, 1)
-- 				-- TriggerClientEvent('esx:showNotification', _source, _U('threw_weapon', weaponLabel))
-- 				TriggerEvent("new_GTX:removeitem", xPlayer.name, weaponLabel, 1, type)
-- 			end
-- 		end

-- 	end
-- end)
RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_quantity'))
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showNotification(_U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				local pickupLabel = ('<FONT FACE="Montserrat">~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
				ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, playerId)
				xPlayer.showNotification(_U('threw_standard', itemCount, xItem.label))
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_amount'))
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showNotification(_U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
				local pickupLabel = ('<FONT FACE="Montserrat">~y~%s~s~ [~g~%s~s~]'):format(account.label, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, playerId)
				xPlayer.showNotification(_U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
			end
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local _, weapon = xPlayer.getWeapon(itemName)
			local _, weaponObject = ESX.GetWeapon(itemName)
			local components, pickupLabel = ESX.Table.Clone(weapon.components)
			xPlayer.removeWeapon(itemName)
			if weaponObject.ammo and weapon.ammo > 0 then
				local ammoLabel = weaponObject.ammo.label
				pickupLabel = ('<FONT FACE="Montserrat">~y~%s~s~ [~g~%s~s~ %s]'):format(weapon.label, weapon.ammo, ammoLabel)
				xPlayer.showNotification(_U('threw_weapon_ammo', weapon.label, weapon.ammo, ammoLabel))
			else
				pickupLabel = ('<FONT FACE="Montserrat">~y~%s~s~'):format(weapon.label)
				xPlayer.showNotification(_U('threw_weapon', weapon.label))
			end

			ESX.CreatePickup('item_weapon', itemName, weapon.ammo, pickupLabel, playerId, components, weapon.tintIndex)
		end
	end
end)
RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count   = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('act_imp'))
	end
end)

local lastTaken = 0
-- RegisterServerEvent('esx:onPickup')
-- AddEventHandler('esx:onPickup', function(id)
-- 	local _source = source
-- 	local pickup  = ESX.Pickups[id]
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	if pickup.type == 'item_standard' then

-- 		local item      = xPlayer.getInventoryItem(pickup.name)
-- 		local canTake   = ((item.limit == -1) and (pickup.count)) or ((item.limit - item.count > 0) and (item.limit - item.count)) or 0
-- 		local total     = pickup.count < canTake and pickup.count or canTake
-- 		local remaining = pickup.count - total


-- 		Citizen.Wait(math.random(15, 1000))
-- 		pickup  = ESX.Pickups[id]
-- 		if pickup ~= nil and lastTaken ~= id then
-- 			lastTaken = id
-- 			TriggerClientEvent('esx:removePickup', -1, id)

-- 			if total > 0 then
-- 				xPlayer.addInventoryItem(pickup.name, total)
-- 				TriggerEvent("new_GTX:Pickup", xPlayer.name, pickup.name, total, type)
-- 			end

-- 			if remaining > 0 then
-- 				TriggerClientEvent('esx:showNotification', _source, _U('cannot_pickup_room', item.label))

-- 				local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(item.label, remaining)
-- 				ESX.CreatePickup('item_standard', pickup.name, remaining, pickupLabel, _source)
-- 			end
-- 		end
-- 	elseif pickup.type == 'item_money' then
-- 		TriggerClientEvent('esx:removePickup', -1, id)
-- 		xPlayer.addMoney(pickup.count)
-- 		TriggerEvent("new_GTX:Pickup", xPlayer.name, pickup.name, pickup.count, type)
-- 	elseif pickup.type == 'item_account' then
-- 		TriggerClientEvent('esx:removePickup', -1, id)
-- 		xPlayer.addAccountMoney(pickup.name, pickup.count)
-- 		TriggerEvent("new_GTX:Pickup", xPlayer.name, pickup.name, pickup.count, type)
-- 	end
-- end)
RegisterNetEvent('esx:onPickup')
AddEventHandler('esx:onPickup', function(id)
	local pickup, xPlayer, success = ESX.Pickups[id], ESX.GetPlayerFromId(source)

	if pickup then
		local xItem = xPlayer.getInventoryItem(pickup.name)

		if pickup.type == 'item_standard' then
			if xItem.limit == -1 or xItem.limit - xItem.count > 0 then
				xPlayer.addInventoryItem(pickup.name, pickup.count)
				success = true
			else
				xPlayer.showNotification(_U('threw_cannot_pickup'))
			end
		elseif pickup.type == 'item_account' then
			success = true
			xPlayer.addAccountMoney(pickup.name, pickup.count)
		elseif pickup.type == 'item_weapon' then
			if xPlayer.hasWeapon(pickup.name) then
				xPlayer.showNotification(_U('threw_weapon_already'))
			else
				success = true
				xPlayer.addWeapon(pickup.name, pickup.count)
				xPlayer.setWeaponTint(pickup.name, pickup.tintIndex)

				for k,v in ipairs(pickup.components) do
					xPlayer.addWeaponComponent(pickup.name, v)
				end
			end
		end

		if success then
			ESX.Pickups[id] = nil
			TriggerClientEvent('esx:removePickup', -1, id)
		end
	end
end)

RegisterNetEvent('esx:joinTeam')
AddEventHandler('esx:joinTeam', function(teamId)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.joinTeam(teamId)
end)


ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		money        = xPlayer.getMoney()
	})
end)

TriggerEvent("es:addGroup", "jobmaster", "user", function(group) end)

ESX.StartDBSync()
ESX.StartPayCheck()
