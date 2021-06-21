ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)

AddEventHandler('chatMessage', function(source,name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		
		if Config.EnableESXIdentity then
			name = GetCharacterName(source)
		end			
			local xPlayer = ESX.GetPlayerFromId(source)
			local name = xPlayer.getName()
			str = xPlayer.job.name
			str = str:gsub("^%l", string.upper)
			str2 = xPlayer.job2.name
			str2 = str2:gsub("^%l", string.upper)
			if(str == 'Police') then
			TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
			template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(64, 101, 243, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',

			args = {  "Cảnh Sát | " .. name, message }, color = { 255, 255, 255 } })
			elseif(str == 'Ambulance') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 5, 171, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
		
					args = {"Bác Sĩ | " .. name, message }, color = { 255, 255, 255 } })
			elseif(str2 == 'Mafia') or (str2 == 'Cartel')  or (str2 == 'Gangster') or (str2 == 'GSgang') or (str2 == 'Star') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(137, 104, 205, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
		
					args = {  " Xã Hội Đen | " .. name, message }, color = { 255, 255, 255 } })
			
			elseif(str2 == 'F88') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 0 , 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
		
					args = { " F88 | " .. name, message }, color = { 255, 255, 255 } })
			elseif(str2 == 'Biker') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(78, 223, 42 , 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
			
					args = { " GHL | " .. name, message }, color = { 255, 255, 255 } })
			elseif(str2 == 'Ast') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(140, 26, 255 , 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
			
					args = { " AST | " .. name, message }, color = { 255, 255, 255 } })

			elseif(str == 'Taxi') then
					TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
						template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 159, 1 , 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
			
						args = { "Taxi | " .. name, message }, color = { 255, 255, 255 } })
					
			elseif(str == 'Reporter') then
					TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
						template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(153, 51, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
			
						args = { "Nhà Báo | " .. name, message }, color = { 255, 255, 255 } })
					
			elseif(str == 'Mechanic') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(12, 172, 17, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
		
					args = {  "Sửa Xe | " .. name, message }, color = { 255, 255, 255 } })
			elseif(str == 'Casino') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(1, 1, 1, 0.6); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
			
					args = {  "Casino | " .. name, message }, color = { 255, 255, 255 } })
					
			elseif(str == 'ADMIN') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(90, 200, 215, 0.7); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
		
					args = { "ADMIN ׀ " .. name, message }, color = { 255, 0, 0 } })
			elseif(str == 'Mami') then
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 204, 255, 0.6); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
				
					args = {  "Má Mì | " .. name, message }, color = { 255, 255, 255 } })
			else 
				TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, { 
					template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(153, 51, 0, 0.5); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>',
		
					args = {  " Thường Dân | " .. name, message }, color = { 255, 255, 255 } })

			end
			
			
	end
end)

RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, {
		template = '<div style="padding: 0.3vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
		args = { _U('twt_prefix', name), args }, color = { 0, 153, 204 } })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', name), args, { 255, 0, 0 })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', name), args, { 0, 0, 255 })
	--print(('%s: %s'):format(name, args))
end, false)

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
