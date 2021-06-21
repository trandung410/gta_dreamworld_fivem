------ EXPORTS ------

-- Both exports can be used from server and client side:

exports.RufiUniqueID:GetUIDfromID()   -- Get uid from player id

exports.RufiUniqueID:GetIDfromUID()   -- Get id from player uid


---Example on setjob command for es_extended/server/commands.lua:

TriggerEvent('es:addGroupCommand', 'setjob', 'moderator', function(source, args, user)
	if tonumber(args[1]) and args[2] and tonumber(args[3]) then
		local xPlayer = ESX.GetPlayerFromId(exports.RufiUniqueID:GetIDfromUID(args[1]))

		if xPlayer then
			if ESX.DoesJobExist(args[2], args[3]) then
				xPlayer.setJob(args[2], args[3])
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'That job does not exist.' } })
			end

		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('setjob'), params = {{name = "id", help = _U('id_param')}, {name = "job", help = _U('setjob_param2')}, {name = "grade_id", help = _U('setjob_param3')}}})


--- Example for 'esx.registercommand' on es_extended 1.2 version or extendedmode in server/functions.lua:

--Search for 'elseif v.type == 'player' or v.type == 'playerId' then' and bellow it you can see 'targetPlayer' var just use this instead: 
local targetPlayer = exports.RufiUniqueID:GetIDfromUID(tonumber(args[k]))