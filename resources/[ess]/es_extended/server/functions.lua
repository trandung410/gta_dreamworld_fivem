ESX.Trace = function(str)
	if Config.EnableDebug then
		print('ESX> ' .. str)
	end
end

ESX.SetTimeout = function(msec, cb)
	local id = ESX.TimeoutCount + 1

	SetTimeout(msec, function()
		if ESX.CancelledTimeouts[id] then
			ESX.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	ESX.TimeoutCount = id

	return id
end

ESX.RegisterCommand = function(name, group, cb, allowConsole, suggestion)
	if type(name) == 'table' then
		for k,v in ipairs(name) do
			ESX.RegisterCommand(v, group, cb, allowConsole, suggestion)
		end

		return
	end

	if ESX.RegisteredCommands[name] then
		print(('[es_extended] [^3WARNING^7] An command "%s" is already registered, overriding command'):format(name))

		if ESX.RegisteredCommands[name].suggestion then
			TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
		end
	end

	if suggestion then
		if not suggestion.arguments then suggestion.arguments = {} end
		if not suggestion.help then suggestion.help = '' end

		TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
	end

	ESX.RegisteredCommands[name] = {group = group, cb = cb, allowConsole = allowConsole, suggestion = suggestion}

	RegisterCommand(name, function(playerId, args, rawCommand)
		local command = ESX.RegisteredCommands[name]

		if not command.allowConsole and playerId == 0 then
			print('[es_extended] [^3WARNING^7] That command can not be run from console')
		else
			local xPlayer, error = ESX.GetPlayerFromId(playerId), nil

			if command.suggestion then
				if command.suggestion.validate then
					if #args ~= #command.suggestion.arguments then
						error = ('Argument count mismatch (passed %s, wanted %s)'):format(#args, #command.suggestion.arguments)
					end
				end

				if not error and command.suggestion.arguments then
					local newArgs = {}

					for k,v in ipairs(command.suggestion.arguments) do
						if v.type then
							if v.type == 'number' then
								local newArg = tonumber(args[k])

								if newArg then
									newArgs[v.name] = newArg
								else
									error = ('Argument #%s type mismatch (passed string, wanted number)'):format(k)
								end
							elseif v.type == 'player' or v.type == 'playerId' then
								local targetPlayer = tonumber(args[k])

								if args[k] == 'me' then targetPlayer = playerId end

								if targetPlayer then
									local xTargetPlayer = ESX.GetPlayerFromId(targetPlayer)

									if xTargetPlayer then
										if v.type == 'player' then
											newArgs[v.name] = xTargetPlayer
										else
											newArgs[v.name] = targetPlayer
										end
									else
										error = 'Player not online'
									end
								else
									error = ('Argument #%s type mismatch (passed string, wanted number)'):format(k)
								end
							elseif v.type == 'string' then
								newArgs[v.name] = args[k]
							elseif v.type == 'item' then
								if ESX.Items[args[k]] then
									newArgs[v.name] = args[k]
								else
									error = _U('invalid_item')
								end
							elseif v.type == 'weapon' then
								if ESX.GetWeapon(args[k]) then
									newArgs[v.name] = string.upper(args[k])
								else
									error = 'Invalid weapon'
								end
							elseif v.type == 'any' then
								newArgs[v.name] = args[k]
							end
						end

						if error then break end
					end

					args = newArgs
				end
			end

			if error then
				if playerId == 0 then
					print(('[es_extended] [^3WARNING^7] %s^7'):format(error))
				else
					xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', error}})
				end
			else
				cb(xPlayer or false, args, function(msg)
					if playerId == 0 then
						print(('[es_extended] [^3WARNING^7] %s^7'):format(msg))
					else
						xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', msg}})
					end
				end)
			end
		end
	end, true)

	ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
end

ESX.ClearTimeout = function(id)
	ESX.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
	ESX.ServerCallbacks[name] = cb
end

ESX.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ESX.ServerCallbacks[name] ~= nil then
		ESX.ServerCallbacks[name](source, cb, ...)
	else
		print('es_extended: TriggerServerCallback => [' .. name .. '] does not exist')
	end
end

ESX.SavePlayer = function(xPlayer, cb)
	local asyncTasks = {}
	xPlayer.setLastPosition(xPlayer.getCoords())

	-- User accounts
	for i=1, #xPlayer.accounts, 1 do
		if ESX.LastPlayerData[xPlayer.source].accounts[xPlayer.accounts[i].name] ~= xPlayer.accounts[i].money then
			table.insert(asyncTasks, function(cb)
				MySQL.Async.execute('UPDATE user_accounts SET `money` = @money WHERE identifier = @identifier AND name = @name', {
					['@money']      = xPlayer.accounts[i].money,
					['@identifier'] = xPlayer.identifier,
					['@name']       = xPlayer.accounts[i].name
				}, function(rowsChanged)
					cb()
				end)
			end)

			ESX.LastPlayerData[xPlayer.source].accounts[xPlayer.accounts[i].name] = xPlayer.accounts[i].money
		end
	end

	-- Inventory items
	for i=1, #xPlayer.inventory, 1 do
		if ESX.LastPlayerData[xPlayer.source].items[xPlayer.inventory[i].name] ~= xPlayer.inventory[i].count then
			table.insert(asyncTasks, function(cb)
				MySQL.Async.execute('UPDATE user_inventory SET `count` = @count WHERE identifier = @identifier AND item = @item', {
					['@count']      = xPlayer.inventory[i].count,
					['@identifier'] = xPlayer.identifier,
					['@item']       = xPlayer.inventory[i].name
				}, function(rowsChanged)
					cb()
				end)
			end)

			ESX.LastPlayerData[xPlayer.source].items[xPlayer.inventory[i].name] = xPlayer.inventory[i].count
		end
	end

	-- Job, loadout and position
	table.insert(asyncTasks, function(cb)
		MySQL.Async.execute('UPDATE users SET `job` = @job, `job_grade` = @job_grade, `loadout` = @loadout, `position` = @position WHERE identifier = @identifier', {
			['@job']        = xPlayer.job.name,
			['@job_grade']  = xPlayer.job.grade,
			['@loadout']    = json.encode(xPlayer.getLoadout()),
			['@position']   = json.encode(xPlayer.getLastPosition()),
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			cb()
		end)
	end)

	Async.parallel(asyncTasks, function(results)
		RconPrint('[SAVED] ' .. xPlayer.name .. "^7\n")

		if cb ~= nil then
			cb()
		end
	end)
end

ESX.SavePlayers = function(cb)
	local asyncTasks = {}
	local xPlayers   = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb)
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			ESX.SavePlayer(xPlayer, cb)
		end)
	end

	Async.parallelLimit(asyncTasks, 8, function(results)
		RconPrint('[SAVED] All players' .. "\n")

		if cb ~= nil then
			cb()
		end
	end)
end

ESX.StartDBSync = function()
	function saveData()
		ESX.SavePlayers()
		SetTimeout(10 * 60 * 1000, saveData)
	end

	SetTimeout(10 * 60 * 1000, saveData)
end

ESX.GetPlayers = function()
	local sources = {}

	for k,v in pairs(ESX.Players) do
		table.insert(sources, k)
	end

	return sources
end


ESX.GetPlayerFromId = function(source)
	return ESX.Players[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(ESX.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

ESX.RegisterUsableItem = function(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item)
	ESX.UsableItemsCallbacks[item](source)
end

ESX.GetItemLabel = function(item)
	if ESX.Items[item] ~= nil then
		return ESX.Items[item].label
	end
end

-- ESX.CreatePickup = function(type, name, count, label, player)
-- 	local pickupId = (ESX.PickupId == 65635 and 0 or ESX.PickupId + 1)

-- 	ESX.Pickups[pickupId] = {
-- 		type  = type,
-- 		name  = name,
-- 		count = count
-- 	}

-- 	TriggerClientEvent('esx:pickup', -1, pickupId, label, player)
-- 	ESX.PickupId = pickupId
-- end
ESX.CreatePickup = function(type, name, count, label, playerId, components, tintIndex)
	local pickupId = (ESX.PickupId == 65635 and 0 or ESX.PickupId + 1)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local coords = xPlayer.getCoords()
	ESX.Pickups[pickupId] = {
		type  = type,
		name  = name,
		count = count,
		label = label,
		coords = coords,
	}
	if type == 'item_weapon' then
		ESX.Pickups[pickupId].components = components
		ESX.Pickups[pickupId].tintIndex = tintIndex
	end
	ESX.SetTimeout(Config.TimeToRemovePickup , function()
		TriggerClientEvent('esx:removePickup', -1, pickupId)
		ESX.Pickups[pickupId] = nil
	end)

	TriggerClientEvent('esx:createPickup', -1, pickupId, label, coords, type, name, components, tintIndex)
	ESX.PickupId = pickupId
	xPlayer.showNotification("Vật phẩm của bạn vừa vứt ra sẽ bị xóa sau 1 phút")
end
ESX.DoesJobExist = function(job, grade)
	grade = tostring(grade)

	if job and grade then
		if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end

ESX.UpdateTeam = function(teamId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		TriggerClientEvent('esx:Teamup', ESX.RegisteredTeams[teamId].ownerId, ESX.RegisteredTeams[teamId])
		for k, v in ipairs(ESX.RegisteredTeams[teamId].members) do 
			TriggerClientEvent('esx:Teamup', v.Id, ESX.RegisteredTeams[teamId])
		end 
	end 
end

ESX.TeamNotification = function(teamId, msg)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		TriggerClientEvent('esx:showNotification', ESX.RegisteredTeams[teamId].ownerId, msg)
		for k, v in ipairs(ESX.RegisteredTeams[teamId].members) do 
			TriggerClientEvent('esx:showNotification', v.Id, msg)
		end 
	end 
end

ESX.TeamTriggerEvent = function(teamId, eventName, ...)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		TriggerClientEvent(eventName, ESX.RegisteredTeams[teamId].ownerId, ...)
		for k, v in ipairs(ESX.RegisteredTeams[teamId].members) do 
			TriggerClientEvent(eventName, v.Id, ...)
		end 
	end 
end

ESX.CreateTeam = function(playerId)
	ESX.TeamId = ESX.TeamId + 1 
	local xPlayer = ESX.GetPlayerFromId(playerId)
	ESX.RegisteredTeams[ESX.TeamId] = {
		ownerId = playerId,
		ownerName = xPlayer.getName(),
		members = {}
	}
	xPlayer.triggerEvent('esx:Teamup', ESX.RegisteredTeams[ESX.TeamId])
	xPlayer.showNotification('Bạn đã tạo tổ đội với id : '..ESX.TeamId)
	return ESX.TeamId
end

ESX.JoinTeam = function(teamId, playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		ESX.TeamNotification(teamId, xPlayer.getName().." vừa gia nhập tổ đội")
		table.insert(ESX.RegisteredTeams[teamId].members, {Id = playerId, name = xPlayer.getName()})
		ESX.UpdateTeam(teamId)
		xPlayer.showNotification('Bạn đã gia nhập tổ đội với id : '..teamId)
		return teamId
	else 
		xPlayer.showNotification('Tổ đội không tồn tại')
	end
end

ESX.LeaveTeam = function(teamId, playerId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		if ESX.RegisteredTeams[teamId].ownerId == playerId then 
			if #ESX.RegisteredTeams[teamId].members > 0 then 
				ESX.TeamNotification(teamId, ESX.RegisteredTeams[teamId].ownerName..' đã rời khỏi tổ đội, '.. ESX.RegisteredTeams[teamId].members[1].name.. ' sẽ làm đội trưởng')
				ESX.RegisteredTeams[teamId].ownerId = ESX.RegisteredTeams[teamId].members[1].Id
				ESX.RegisteredTeams[teamId].ownerName = ESX.RegisteredTeams[teamId].members[1].name
				table.remove(ESX.RegisteredTeams[teamId].members, 1)
				ESX.UpdateTeam(teamId)
				TriggerClientEvent('esx:disbandTeam', playerId)
			else 
				TriggerClientEvent('esx:disbandTeam', playerId)
				ESX.RegisteredTeams[teamId] = nil 
			end 
		else 
			for k, v in ipairs(ESX.RegisteredTeams[teamId].members) do 
				if v.Id == playerId then 
					ESX.TeamNotification(teamId, v.name..' đã rời khỏi tổ đội')
					table.remove(ESX.RegisteredTeams[teamId].members, k)
				end
			end 
			ESX.UpdateTeam(teamId)
			TriggerClientEvent('esx:disbandTeam', playerId)
		end 
	end 
end

ESX.GetTeams = function()
	return ESX.RegisteredTeams
end

ESX.GetTeamOwner = function(teamId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		return {ownerId = ESX.RegisteredTeams[teamId].ownerId, ownerName = ESX.RegisteredTeams[teamId].ownerName}
	end 
end

ESX.InviteToTeam = function(teamId, playerId, targetId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		if ESX.RegisteredTeams[teamId].ownerId == playerId then 
			local targetPlayer = ESX.GetPlayerFromId(targetId)
			targetPlayer.triggerEvent('esx:requestInvite', teamId, ESX.RegisteredTeams[teamId].ownerName)
		else 
			TriggerClientEvent('esx:showNotification', playerId, 'Bạn không phải đội trưởng')
		end 
	end 
end

ESX.KickFromTeam = function(teamId, playerId, targetId)
	if ESX.RegisteredTeams[teamId] ~= nil then
		if ESX.RegisteredTeams[teamId].ownerId == playerId then 
			local targetPlayer = ESX.GetPlayerFromId(targetId)
			targetPlayer.leaveTeam()
		else 
			TriggerClientEvent('esx:showNotification', playerId, 'Bạn không phải đội trưởng')
		end 
	end 
end

ESX.GetTeamMember= function(teamId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		local cacheId = {}
		table.insert(cacheId, ESX.RegisteredTeams[teamId].ownerId)
		for i = 1, #ESX.RegisteredTeams[teamId].members, 1 do 
			table.insert(cacheId, ESX.RegisteredTeams[teamId].members[i].Id)
		end 
		return {#ESX.RegisteredTeams[teamId].members + 1, cacheId}
	end 
end

ESX.IsTeamOwner = function(teamId, playerId)
	if ESX.RegisteredTeams[teamId] ~= nil then 
		if ESX.RegisteredTeams[teamId].ownerId == playerId then 
			return true 
		else 
			return false 
		end 
	end 
end

ESX.GetPlayerInJob = function(jobName)
	local count = 0
	local players = {}
	for k, v in pairs(ESX.Players) do 
		if v.job.name == jobName then
			count = count + 1
			table.insert(players, v)
		end
	end
	return count, players
end

ESX.AddJob = function(jobName, jobLabel)
	if not ESX.Jobs[jobName] then
		ESX.Jobs[jobName] = {
			name = jobName,
			label = jobLabel,
			whitelisted = 1,
			job_logo = "",
			job_slogan = "Băng đảng mới",
			level = 0,
			point = 0
		}
		ESX.Jobs[jobName].grades = {}
		ESX.Jobs[jobName].grades["0"] = {
			id = math.random(100, 222),
			job_name = jobName,
			grade = 0,
			name = "recruit",
			label = "Đàn Em",
			salary = 0,
			skin_male = "{}",
			skin_female = "{}"
		} 
		ESX.Jobs[jobName].grades["1"] = {
			id = math.random(100, 222),
			job_name = jobName,
			grade = 1,
			name = "employed",
			label = "Đàn Anh",
			salary = 0,
			skin_male = "{}",
			skin_female = "{}"
		} 
		ESX.Jobs[jobName].grades["2"] = {
			id = math.random(100, 222),
			job_name = jobName,
			grade = 2,
			name = "co",
			label = "Đại Ca",
			salary = 0,
			skin_male = "{}",
			skin_female = "{}"
		} 
		ESX.Jobs[jobName].grades["3"] = {
			id = math.random(100, 222),
			job_name = jobName,
			grade = 3,
			name = "boss",
			label = "Ông Trùm",
			salary = 0,
			skin_male = "{}",
			skin_female = "{}"
		} 
		MySQL.Async.execute("INSERT INTO jobs (name, label, job_logo, job_slogan, level, jobPoint) VALUES (@name, @label, @job_logo, @job_slogan, @level, @jobPoint)", {
			['@name'] = jobName,
			['@label'] = jobLabel,
			['@job_logo'] = "",
			['@job_slogan'] = "Băng đảng mới",
			['@level'] = 0,
			['@jobPoint'] = 0
		}, function(rowChanged)
			print("JOB CREATED")
		end)
		MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
			['@job_name'] = jobName,
			['@grade'] = 0,
			['@name'] = "recruit",
			['@label'] = "Đàn Em",
			['@salary'] = 0,
			['@skin_male'] = "{}",
			['@skin_female'] = "{}"
		}, function(rowChanged)
			print("GRADE 0 CREATED")
		end)
		MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
			['@job_name'] = jobName,
			['@grade'] = 1,
			['@name'] = "employed",
			['@label'] = "Đàn Anh",
			['@salary'] = 0,
			['@skin_male'] = "{}",
			['@skin_female'] = "{}"
		}, function(rowChanged)
			print("GRADE 1 CREATED")
		end)
		MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
			['@job_name'] = jobName,
			['@grade'] = 2,
			['@name'] = "co",
			['@label'] = "Đại Ca",
			['@salary'] = 0,
			['@skin_male'] = "{}",
			['@skin_female'] = "{}"
		}, function(rowChanged)
			print("GRADE 2 CREATED")
		end)
		MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
			['@job_name'] = jobName,
			['@grade'] = 3,
			['@name'] = "boss",
			['@label'] = "Ông Trùm",
			['@salary'] = 0,
			['@skin_male'] = "{}",
			['@skin_female'] = "{}"
		}, function(rowChanged)
			print("GRADE 3 CREATED")
		end)
	end

end