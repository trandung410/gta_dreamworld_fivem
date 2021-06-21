function CreateExtendedPlayer(player, accounts, inventory, job, loadout, name, lastPosition,NumberPhone)
	local self = {}

	self.player       = player
	self.accounts     = accounts
	self.inventory    = inventory
	self.job          = job
	self.loadout      = loadout
	self.name         = name
	self.lastPosition = lastPosition
	self.PhoneNumber = NumberPhone
	self.source     = self.player.get('source')
	self.identifier = self.player.get('identifier')
	self.team = nil

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end
	self.setMoney = function(money)
		money = ESX.Math.Round(money)

		if money >= 0 then
			self.player.setMoney(money)
		else
			print(('es_extended: %s attempted exploiting! (reason: player tried setting -1 cash balance)'):format(self.identifier))
		end
	end

	self.getMoney = function()
		return self.player.get('money')
	end

	self.setBankBalance = function(money)
		money = ESX.Math.Round(money)

		if money >= 0 then
			self.player.setBankBalance(money)
		else
			print(('es_extended: %s attempted exploiting! (reason: player tried setting -1 bank balance)'):format(self.identifier))
		end
	end

	self.getBank = function()
		return self.player.get('bank')
	end

	self.getCoords = function()
		return self.player.get('coords')
	end

	self.setCoords = function(x, y, z)
		self.player.coords = {x = x, y = y, z = z}
	end

	self.kick = function(reason)
		self.player.kick(reason)
	end

	self.addMoney = function(money)
		money = ESX.Math.Round(money)

		if money >= 0 then
			self.player.addMoney(money)
		else
			print(('es_extended: %s attempted exploiting! (reason: player tried adding -1 cash balance)'):format(self.identifier))
		end
	end

	self.removeMoney = function(money)
		money = ESX.Math.Round(money)

		if money >= 0 then
			self.player.removeMoney(money)
		else
			print(('es_extended: %s attempted exploiting! (reason: player tried removing -1 cash balance)'):format(self.identifier))
		end
	end

	self.addBank = function(money)
		money = ESX.Math.Round(money)

		if money >= 0 then
			self.player.addBank(money)
		else
			print(('es_extended: %s attempted exploiting! (reason: player tried adding -1 bank balance)'):format(self.identifier))
		end
	end

	self.removeBank = function(money)
		money = ESX.Math.Round(money)

		if money >= 0 then
			self.player.removeBank(money)
		else
			print(('es_extended: %s attempted exploiting! (reason: player tried removing -1 bank balance)'):format(self.identifier))
		end
	end

	self.displayMoney = function(money)
		self.player.displayMoney(money)
	end

	self.displayBank = function(money)
		self.player.displayBank(money)
	end

	self.setSessionVar = function(key, value)
		self.player.setSessionVar(key, value)
	end

	self.getSessionVar = function(k)
		return self.player.getSessionVar(k)
	end

	self.getPermissions = function()
		return self.player.getPermissions()
	end

	self.setPermissions = function(p)
		self.player.setPermissions(p)
	end

	self.getIdentifier = function()
		return self.player.getIdentifier()
	end

	self.getGroup = function()
		return self.player.getGroup()
	end

	self.set = function(k, v)
		self.player.set(k, v)
	end

	self.get = function(k)
		return self.player.get(k)
	end

	self.getPlayer = function()
		return self.player
	end

	self.getAccounts = function()
		local accounts = {}

		for i=1, #Config.Accounts, 1 do
			if Config.Accounts[i] == 'bank' then

				table.insert(accounts, {
					name  = 'bank',
					money = self.get('bank'),
					label = Config.AccountLabels['bank']
				})

			else

				for j=1, #self.accounts, 1 do
					if self.accounts[j].name == Config.Accounts[i] then
						table.insert(accounts, self.accounts[j])
					end
				end

			end
		end

		return accounts
	end

	self.getAccount = function(a)
		if a == 'bank' then
			return {
				name  = 'bank',
				money = self.get('bank'),
				label = Config.AccountLabels['bank']
			}
		end

		for i=1, #self.accounts, 1 do
			if self.accounts[i].name == a then
				return self.accounts[i]
			end
		end
	end

	self.getInventory = function()
		return self.inventory
	end

	self.getJob = function()
		return self.job
	end

	self.getLoadout = function()
		return self.loadout
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(newName)
		self.name = newName
	end

	self.getLastPosition = function()
		if self.lastPosition and self.lastPosition.x and self.lastPosition.y and self.lastPosition.z then
			self.lastPosition.x = ESX.Math.Round(self.lastPosition.x, 1)
			self.lastPosition.y = ESX.Math.Round(self.lastPosition.y, 1)
			self.lastPosition.z = ESX.Math.Round(self.lastPosition.z, 1)
		end

		return self.lastPosition
	end

	self.setLastPosition = function(position)
		self.lastPosition = position
	end

	self.getMissingAccounts = function(cb)
		MySQL.Async.fetchAll('SELECT * FROM `user_accounts` WHERE `identifier` = @identifier', {
			['@identifier'] = self.getIdentifier()
		}, function(result)
			local missingAccounts = {}

			for i=1, #Config.Accounts, 1 do
				if Config.Accounts[i] ~= 'bank' then
					local found = false

					for j=1, #result, 1 do
						if Config.Accounts[i] == result[j].name then
							found = true
							break
						end
					end

					if not found then
						table.insert(missingAccounts, Config.Accounts[i])
					end
				end
			end

			cb(missingAccounts)
		end)
	end

	self.createAccounts = function(missingAccounts, cb)
		for i=1, #missingAccounts, 1 do
			MySQL.Async.execute('INSERT INTO `user_accounts` (identifier, name) VALUES (@identifier, @name)', {
				['@identifier'] = self.getIdentifier(),
				['@name']       = missingAccounts[i]
			}, function(rowsChanged)
				if cb ~= nil then
					cb()
				end
			end)
		end
	end

	self.setAccountMoney = function(acc, money)
		if money < 0 then
			print(('es_extended: %s attempted exploiting! (reason: player tried setting -1 account balance)'):format(self.identifier))
			return
		end

		local account   = self.getAccount(acc)
		local prevMoney = account.money
		local newMoney  = ESX.Math.Round(money)

		account.money = newMoney

		if acc == 'bank' then
			self.set('bank', newMoney)
		end

		TriggerClientEvent('esx:setAccountMoney', self.source, account)
	end

	self.addAccountMoney = function(acc, money)
		if money < 0 then
			print(('es_extended: %s attempted exploiting! (reason: player tried adding -1 account balance)'):format(self.identifier))
			return
		end

		local account  = self.getAccount(acc)
		local newMoney = account.money + ESX.Math.Round(money)

		account.money = newMoney

		if acc == 'bank' then
			self.set('bank', newMoney)
		end

		TriggerClientEvent('esx:setAccountMoney', self.source, account)
	end

	self.removeAccountMoney = function(a, m)
		if m < 0 then
			print(('es_extended: %s attempted exploiting! (reason: player tried removing -1 account balance)'):format(self.identifier))
			return
		end

		local account  = self.getAccount(a)
		local newMoney = account.money - m

		account.money = newMoney

		if a == 'bank' then
			self.set('bank', newMoney)
		end

		TriggerClientEvent('esx:setAccountMoney', self.source, account)
	end

	self.getInventoryItem = function(name)
		for i=1, #self.inventory, 1 do
			if self.inventory[i].name == name then
				return self.inventory[i]
			end
		end
	end

	self.addInventoryItem = function(name, count)
		local item     = self.getInventoryItem(name)
		local newCount = item.count + count
		item.count     = newCount

		TriggerEvent('esx:onAddInventoryItem', self.source, item, count)
		TriggerClientEvent('esx:addInventoryItem', self.source, item, count)
	end

	self.removeInventoryItem = function(name, count)
		local item     = self.getInventoryItem(name)
		local newCount = item.count - count
		item.count     = newCount

		TriggerEvent('esx:onRemoveInventoryItem', self.source, item, count)
		TriggerClientEvent('esx:removeInventoryItem', self.source, item, count)
	end

	self.setInventoryItem = function(name, count)
		local item     = self.getInventoryItem(name)
		local oldCount = item.count
		item.count     = count

		if oldCount > item.count  then
			TriggerEvent('esx:onRemoveInventoryItem', self.source, item, oldCount - item.count)
			TriggerClientEvent('esx:removeInventoryItem', self.source, item, oldCount - item.count)
		else
			TriggerEvent('esx:onAddInventoryItem', self.source, item, item.count - oldCount)
			TriggerClientEvent('esx:addInventoryItem', self.source, item, item.count - oldCount)
		end
	end

	self.setJob = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.job.id    = jobObject.id
			self.job.name  = jobObject.name
			self.job.label = jobObject.label

			self.job.grade        = tonumber(grade)
			self.job.grade_name   = gradeObject.name
			self.job.grade_label  = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			self.job.skin_male    = {}
			self.job.skin_female  = {}

			if gradeObject.skin_male ~= nil then
				self.job.skin_male = json.decode(gradeObject.skin_male)
			end

			if gradeObject.skin_female ~= nil then
				self.job.skin_female = json.decode(gradeObject.skin_female)
			end

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			TriggerClientEvent('esx:setJob', self.source, self.job)
		else
			print(('es_extended: ignoring setJob for %s due to job not found!'):format(self.source))
		end
	end

	self.addWeapon = function(weaponName, ammo)
		local weaponLabel = ESX.GetWeaponLabel(weaponName)

		if not self.hasWeapon(weaponName) then
			table.insert(self.loadout, {
				name = weaponName,
				ammo = ammo,
				label = weaponLabel,
				components = {}
			})
		end

		TriggerClientEvent('esx:addWeapon', self.source, weaponName, ammo)
		TriggerClientEvent('esx:addInventoryItem', self.source, {label = weaponLabel}, 1)
	end

	self.addWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if self.hasWeaponComponent(weaponName, weaponComponent) then
			return
		end

		table.insert(self.loadout[loadoutNum].components, weaponComponent)

		TriggerClientEvent('esx:addWeaponComponent', self.source, weaponName, weaponComponent)
	end

	self.removeWeapon = function(weaponName, ammo)
		local weaponLabel

		for i=1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then
				weaponLabel = self.loadout[i].label

				for j=1, #self.loadout[i].components, 1 do
					TriggerClientEvent('esx:removeWeaponComponent', self.source, weaponName, self.loadout[i].components[j])
				end

				table.remove(self.loadout, i)
				break
			end
		end

		if weaponLabel then
			TriggerClientEvent('esx:removeWeapon', self.source, weaponName, ammo)
			TriggerClientEvent('esx:removeInventoryItem', self.source, {label = weaponLabel}, 1)
		end
	end

	self.removeWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if not weapon then
			return
		end

		for i=1, #self.loadout[loadoutNum].components, 1 do
			if self.loadout[loadoutNum].components.name == weaponComponent then
				table.remove(self.loadout[loadoutNum].components, i)
				break
			end
		end

		TriggerClientEvent('esx:removeWeaponComponent', self.source, weaponName, weaponComponent)
	end

	self.hasWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if not weapon then
			return false
		end

		for i=1, #weapon.components, 1 do
			if weapon.components[i] == weaponComponent then
				return true
			end
		end

		return false
	end

	self.hasWeapon = function(weaponName)
		for i=1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then
				return true
			end
		end

		return false
	end

	self.getWeapon = function(weaponName)
		for i=1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then
				return i, self.loadout[i]
			end
		end

		return nil
	end
	self.showNotification = function(msg, flash, saveToBrief, hudColorIndex)
		self.triggerEvent('esx:showNotification', msg, flash, saveToBrief, hudColorIndex)
	end

	self.showHelpNotification = function(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end
	self.createTeam = function()
		if self.team ~= nil then 
			self.showNotification('Bạn đã ở trong tổ đội', false, true, 130)
		else 
			self.team = ESX.CreateTeam(self.source)
		end 
	end

	self.joinTeam = function(teamId)
		if self.team ~= nil then 
			self.showNotification('Bạn đã ở trong tổ đội', false, true, 130)
		else 
			self.team = ESX.JoinTeam(teamId, self.source)
		end 
	end

	self.leaveTeam = function()
		if self.team ~= nil then 
			ESX.LeaveTeam(self.team, self.source)
			self.team = nil
		else 
			self.showNotification('Bạn không có tổ đội', false, true, 130)
		end 
	end

	self.inviteToTeam = function(targetID)
		if self.team ~= nil then 
			ESX.InviteToTeam(self.team, self.source, targetID)
		else 
			self.showNotification('Bạn không có tổ đội')
		end 
	end

	self.kickFromTeam = function(targetID)
		if self.team ~= nil then 
			ESX.KickFromTeam(self.team, self.source, targetID)
		else 
			self.showNotification('Bạn không có tổ đội')
		end
	end

	self.updateJobLogo = function(imgSrc)
		if self.job.grade_name == "boss" then 
			ESX.Jobs[self.job.name].job_logo = imgSrc
			MySQL.Async.execute("UPDATE jobs SET job_logo = @jobLogo WHERE name = @name", {
				['@jobLogo'] = imgSrc,
				['@name'] = self.job.name
			}, function(rowsChanged)
				if rowsChanged >0 then 
					self.showNotification("~g~ THÀNH CÔNG ~w~")
				end
			end)
		else
			self.showNotification("Bạn không đủ quyền hạn!")
		end
	end

	self.updateJobSlogan = function(slg)
		if self.job.grade_name == "boss" then 
			ESX.Jobs[self.job.name].job_slogan = slg
			MySQL.Async.execute("UPDATE jobs SET job_slogan = @jobLogo WHERE name = @name", {
				['@jobLogo'] = slg,
				['@name'] = self.job.name
			}, function(rowsChanged)
				if rowsChanged >0 then 
					self.showNotification("~g~ THÀNH CÔNG ~w~")
				end
			end)
		else
			self.showNotification("Bạn không đủ quyền hạn!")
		end
	end

	self.upgradeGangLevel = function()
		if self.job.grade_name == "boss" then 
			ESX.Jobs[self.job.name].level = ESX.Jobs[self.job.name].level + 1
			self.job.level = ESX.Jobs[self.job.name].level
			MySQL.Async.execute("UPDATE jobs SET level = @level WHERE name = @name", {
				['@level'] = ESX.Jobs[self.job.name].level,
				['@name'] = self.job.name
			}, function(rowsChanged)
				if rowsChanged >0 then 
					self.showNotification("~g~ THÀNH CÔNG ~w~")
				end
			end)
		end
	end

	self.getJobData = function()
		return ESX.Jobs[self.job.name]
	end

	return self
end
