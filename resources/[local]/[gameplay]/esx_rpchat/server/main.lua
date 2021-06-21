ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local playerarray = {}
AddEventHandler('playerArray',function(phonenumber)
		playerarray = phonenumber
end)
function HasRole(jobName)
	for k, v in pairs(Config.Job) do 
		if jobName == k then 
			return v 
		end 
	end
	return false
end
AddEventHandler('chatMessage', function(source,name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		if Config.EnableESXIdentity then
			name = GetCharacterName(source)
		end			
		local xPlayer = ESX.GetPlayerFromId(source)
		local name = xPlayer.getName()
		local jobName = xPlayer.job.name
		local jobLabel = HasRole(jobName)
		if jobLabel ~= false then
			TriggerClientEvent('chat:addMessage', -1, { 
				--template = jobLabel.template,
				args = { jobLabel.label .. name, message }, color = { 255, 255, 255 } 
			})
		else
			TriggerClientEvent('chat:addMessage', -1, { 
				--template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(153, 51, 0, 0.5); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
				args = {  " Cư Dân | ^2" .. name, message }, color = { 255, 255, 255 } 
			})
		end
	end
end)

-- RegisterCommand('twt', function(args, rawCommand)
-- 	if source == 0 then
-- 		print('esx_rpchat: you can\'t use this command from rcon!')
-- 		return
-- 	end

-- 	args = table.concat(args, ' ')
-- 	local name = GetPlayerName(source)
-- 	if Config.EnableESXIdentity then name = GetCharacterName(source) end

-- 	TriggerClientEvent('chat:addMessage', -1, {
-- 		template = '<div style="padding: 0.3vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
-- 		args = { _U('twt_prefix', name), args }, color = { 0, 153, 204 } })
-- 	--print(('%s: %s'):format(name, args))
-- end, false)

-- RegisterCommand('me', function(args, rawCommand)
-- 	if source == 0 then
-- 		print('esx_rpchat: you can\'t use this command from rcon!')
-- 		return
-- 	end

-- 	args = table.concat(args, ' ')
-- 	local name = GetPlayerName(source)
-- 	if Config.EnableESXIdentity then name = GetCharacterName(source) end

-- 	TriggerClientEvent('chat:addMessage', -1, _U('me_prefix', name), args, { 255, 0, 0 })
-- 	--print(('%s: %s'):format(name, args))
-- end, false)

-- RegisterCommand('do', function(args, rawCommand)
-- 	if source == 0 then
-- 		print('esx_rpchat: you can\'t use this command from rcon!')
-- 		return
-- 	end

-- 	args = table.concat(args, ' ')
-- 	local name = GetPlayerName(source)
-- 	if Config.EnableESXIdentity then name = GetCharacterName(source) end

-- 	TriggerClientEvent('chat:addMessage', -1, _U('do_prefix', name), args, { 0, 0, 255 })
-- 	--print(('%s: %s'):format(name, args))
-- end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
