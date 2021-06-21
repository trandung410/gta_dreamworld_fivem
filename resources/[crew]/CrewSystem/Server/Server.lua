crews = {}

RegisterNetEvent('CrewSystem: loadCrew')
AddEventHandler('CrewSystem: loadCrew', function()
	local idJ = source
	getIdentifier(idJ)

	local crew, player = getPlayerCrew(idJ)

	if crew then
		player.source = idJ
		
		for i, iplayer in pairs(crew.players) do
			local cPlayer = GetPlayerFromIdentifier(iplayer.identifier)

			if cPlayer then
				if iplayer.source ~= -1 then
					TriggerClientEvent('CrewSystem: loadCrew', iplayer.source, crew)
				end
			end
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local idJ = source
	local crew, player = getPlayerCrew(idJ)

	if crew and player.source then
		player.source = -1

		for i, iplayer in pairs(crew.players) do
			local cPlayer = GetPlayerFromIdentifier(iplayer.identifier)

			if cPlayer then
				if iplayer.source ~= -1 then
					TriggerClientEvent('CrewSystem: loadCrew', iplayer.source, crew)
				end
			end
		end
	end
end)

RegisterCommand(commands.createcrew, function(source, args)
	local nameCrew = args[1]
	local identifier = getIdentifier(source)

	if nameCrew then
		for _, crew in pairs(crews) do
			if crew.name == nameCrew then
				showNotification(source, translate.TR_CANOT_NAME)
				return
			end

			for _, player in pairs(crew.players) do
				if player.identifier == identifier then
					showNotification(source, translate.TR_CANOT_CREATE)
					TriggerClientEvent('chat:addMessage', source, { args = { translate.TR_CANOT_CREATE2 }})

					return
				end
			end
		end

		table.insert(crews, {
			name = nameCrew,
			players = {
				{identifier = identifier, source = source, grade = "owner"}
			}
		})

		_insertcrew(nameCrew, identifier, 'owner')
		_insertranking(nameCrew)

		local crew = getPlayerCrew(source)
		TriggerClientEvent('CrewSystem: loadCrew', source, crew)
		
		showNotification(source, translate.TR_CREATE_CREW .. ' ' .. nameCrew)
	end
end)

RegisterCommand(commands.invitecrew, function(source, args)
	local xPlayers = GetPlayersOnline()
	local players = {}

	for i,k in pairs(xPlayers) do
		local name = getName(k)

		table.insert(players, {name = name, source = k})
	end
	TriggerClientEvent('CrewSystem: OpenInviteMenu', source, players)
end)

RegisterNetEvent('CrewSystem: InvitePlayer')
AddEventHandler('CrewSystem: InvitePlayer', function(targetSource)
	-- local namePlayer = args[1]
	local idJ = source
	local identifier = getIdentifier(idJ)

	local hasPermission = false
	local crewName = ""
	for _, crew in pairs(crews) do
		for _, player in pairs(crew.players) do
			if player.identifier == identifier then
				if player.grade == "owner" or player.grade == "manager" then
					hasPermission = true
					crewName = crew.name
				end

				break
			end
		end
	end

	if hasPermission then		
		if targetSource then
			local hasCrew = getPlayerCrew(targetSource)

			if not hasCrew then
				InvitePlayerCrew(targetSource, crewName)
				
				showNotification(idJ, translate.TR_SEND_INVITE)
			else
				showNotification(idJ, translate.TR_HAS_CREW)
			end
		else
			showNotification(idJ, translate.TR_NOT_FOUND)
		end
	else
		showNotification(idJ, translate.TR_NOT_PERMISSION)
	end
end)

function GetPlayerByName(namePlayer)
	local xPlayers = GetPlayersOnline()

	for i,k in pairs(xPlayers) do
		local xName = getName(k)

		if xName == namePlayer then
			return k
		end
	end

	return nil
end

function getPlayerCrew(source)
	local identifier = getIdentifier(source)

	for _, crew in pairs(crews) do
		for _, player in pairs(crew.players) do
			if player.identifier == identifier then
				return crew, player
			end
		end
	end

	return nil
end

function InvitePlayerCrew(source, crewName)	
	showNotification(source, translate.TR_RECEIVE_INVITE .. ' ' .. crewName)
	TriggerClientEvent('chat:addMessage', source, { args = { translate.TR_RECEIVE_INVITE2 }})

	TriggerClientEvent('CrewSystem: receiveInvite', source, crewName)
end

RegisterNetEvent('CrewSystem: joinCrew')
AddEventHandler('CrewSystem: joinCrew', function(crewName)
	local idJ = source
	
	if not getPlayerCrew(idJ) then
		JoinPlayerCrew(idJ, crewName)
	else
		showNotification(idJ, translate.TR_HAS_CREW2)
	end
end)

function JoinPlayerCrew(source, crewName)
	local identifier = getIdentifier(source)

	for _, crew in pairs(crews) do
		if crew.name == crewName then
			_insertcrew(crewName, identifier, 'user')

			table.insert(crew.players, {
				identifier = identifier, 
				source = source, 
				grade = "user"
			})	

			for _, player in pairs(crew.players) do
				local cPlayer = GetPlayerFromIdentifier(player.identifier)

				if cPlayer then
					if player.source ~= -1 then
						TriggerClientEvent('CrewSystem: loadCrew', player.source, crew)
					end
				end
			end
		end
	end
end

RegisterCommand(commands.leftcrew, function(source, args)
	local idJ = source
	local crew = getPlayerCrew(idJ)
	if crew then
		LeftPlayerCrew(idJ, crew.name)
	else
		showNotification(idJ, translate.TR_NOT_HAS)
	end
end)

function LeftPlayerCrew(source, crewName)
	local identifier = getIdentifier(source)

	for _, crew in pairs(crews) do
		if crew.name == crewName then
			for i, player in pairs(crew.players) do
				if player.identifier == identifier then
					if player.grade ~= "owner" then
						table.remove(crew.players, i)
						_leftcrew(identifier)
						showNotification(source, translate.TR_EXIT)
					else
						showNotification(source, translate.TR_DONT_EXIT)
						TriggerClientEvent('chat:addMessage', source, { args = { translate.TR_DONT_EXIT2 }})
						return
					end
					
					break
				end
			end

			for _, player in pairs(crew.players) do
				local cPlayer = GetPlayerFromIdentifier(player.identifier)

				if cPlayer then
					if player.source ~= -1 then
						TriggerClientEvent('CrewSystem: loadCrew', player.source, crew)
					end
				end
			end

			TriggerClientEvent('CrewSystem: loadCrew', source, {})
		end
	end
end

RegisterCommand(commands.prove, function(source, args)
	local crew = getPlayerCrew(source)

	local players = {}

	if not crew then
		return
	end

	for i,k in pairs(crew.players) do
		local xPlayer = GetPlayerFromIdentifier(k.identifier)

		if xPlayer then
			local name = getName(k.source)

			table.insert(players, {name = name, source = k.source})
		end
	end

	TriggerClientEvent('CrewSystem: OpenProveMenu', source, players)
end)

RegisterNetEvent('CrewSystem: provePlayer')
AddEventHandler('CrewSystem: provePlayer', function(targetSource)
	local idJ = source
	local myCrew, myPlayer = getPlayerCrew(idJ)

	if myPlayer.grade ~= "owner" then
		showNotification(idJ, translate.TR_NOT_PERMISSION)
		return
	end	

	if not targetSource or targetSource == idJ then
		showNotification(idJ, translate.TR_NOT_FOUND)
		return
	end

	local crew, player = getPlayerCrew(targetSource)

	if not crew or crew.name ~= myCrew.name then
		showNotification(idJ, translate.TR_NOT_PART)
		return
	end

	player.grade = "manager"

	local targetIdentifier = getIdentifier(targetSource)
	_updatecrew(targetIdentifier, 'manager')

	showNotification(idJ, translate.TR_RECEIVE_PROVE)
	showNotification(targetSource, translate.TR_RECEIVE_PROVE2)

	-- else
	-- 	TriggerClientEvent('esx:showNotification', xPlayer.source, translate.TR_NOT_FOUND)
	-- 	TriggerClientEvent('chat:addMessage', idJ, { args = { translate.TR_NOT_FOUND }})
	-- end
end)

RegisterCommand(commands.demote, function(source, args)
	local crew = getPlayerCrew(source)

	local players = {}

	if not crew then
		return
	end

	for i,k in pairs(crew.players) do
		local xPlayer = GetPlayerFromIdentifier(k.identifier)

		if xPlayer then
			local name = getName(k.source)

			table.insert(players, {name = name, source = k.source})
		end
	end

	TriggerClientEvent('CrewSystem: OpenDemoteMenu', source, players)
end)

RegisterNetEvent('CrewSystem: demotePlayer')
AddEventHandler('CrewSystem: demotePlayer', function(targetSource)
	local idJ = source
	local myCrew, myPlayer = getPlayerCrew(idJ)

	if myPlayer.grade ~= "owner" then
		showNotification(idJ, translate.TR_NOT_PERMISSION)
		return
	end	

	if not targetSource or targetSource == idJ then
		showNotification(idJ, translate.TR_NOT_FOUND)
		return
	end

	local crew, player = getPlayerCrew(targetSource)

	if not crew or crew.name ~= myCrew.name then
		showNotification(idJ, translate.TR_NOT_PART)
		return
	end

	player.grade = "user"

	local targetIdentifier = getIdentifier(targetSource)
	_updatecrew(targetIdentifier, 'user')

	showNotification(idJ, translate.TR_RECEIVE_DEMOTE)
	showNotification(targetSource, translate.TR_RECEIVE_DEMOTE)

	-- else
	-- 	TriggerClientEvent('esx:showNotification', xPlayer.source, translate.TR_NOT_FOUND)
	-- 	TriggerClientEvent('chat:addMessage', idJ, { args = { translate.TR_NOT_FOUND }})
	-- end
end)

RegisterCommand(commands.kick, function(source, args)
	local crew = getPlayerCrew(source)

	local players = {}

	if not crew then
		return
	end

	for i,k in pairs(crew.players) do
		local xPlayer = GetPlayerFromIdentifier(k.identifier)

		if xPlayer then
			local name = getName(k.source)

			table.insert(players, {name = name, source = k.source})
		end
	end

	TriggerClientEvent('CrewSystem: OpenKickMenu', source, players)
end)

RegisterCommand(commands.list, function(source, args)
	local crew = getPlayerCrew(source)

	local players = {}

	if not crew then
		return
	end

	for i,k in pairs(crew.players) do
		local xPlayer = GetPlayerFromIdentifier(k.identifier)

		if xPlayer then
			local name = getName(k.source)

			table.insert(players, {grade = k.grade, name = name, source = k.source})
		end
	end

	TriggerClientEvent('CrewSystem: OpenListMenu', source, players)
end)

RegisterNetEvent('CrewSystem: kickPlayer')
AddEventHandler('CrewSystem: kickPlayer', function(targetSource)
	local idJ = source	
	-- local namePlayer = args[1]
	local myCrew, myPlayer = getPlayerCrew(idJ)

	if myPlayer.grade ~= "owner" and myPlayer.grade ~= "manager" then
		showNotification(idJ, translate.TR_NOT_PERMISSION)
		return
	end

	if not targetSource or targetSource == idJ then
		showNotification(idJ, translate.TR_NOT_FOUND)
		return
	end

	local crew, player = getPlayerCrew(targetSource)

	if not crew or crew.name ~= myCrew.name then	
		showNotification(idJ, translate.TR_NOT_PART)
		return
	end

	local targetIdentifier = getIdentifier(targetSource)

	for i, iplayer in pairs(myCrew.players) do
		if iplayer.identifier == targetIdentifier then
			if iplayer.grade ~= "owner" and ((myPlayer.grade == "manager" and iplayer.grade ~= "manager") or myPlayer.grade == "owner" ) then
				table.remove(myCrew.players, i)
				_leftcrew(targetIdentifier)
			else
				showNotification(idJ, translate.TR_NOT_PERMISSION)
				-- TriggerClientEvent('chat:addMessage', source, { args = { translate.TR_DONT_EXIT2 }})
				return
			end
			
			break
		end
	end

	for _, iplayer in pairs(myCrew.players) do
		local cPlayer = GetPlayerFromIdentifier(iplayer.identifier)

		if cPlayer then
			-- print(iplayer.source)
			if iplayer.source ~= -1 then
				TriggerClientEvent('CrewSystem: loadCrew', iplayer.source, myCrew)
			end
		end
	end

	TriggerClientEvent('CrewSystem: loadCrew', targetSource, {})

	showNotification(idJ, translate.TR_KICK)
	showNotification(targetSource, translate.TR_KICK2)
	-- else
	-- 	TriggerClientEvent('esx:showNotification', xPlayer.source, translate.TR_NOT_FOUND)
	-- 	TriggerClientEvent('chat:addMessage', idJ, { args = { translate.TR_NOT_FOUND }})
	-- end
end)

RegisterCommand(commands.deletecrew, function(source, args)
	local idJ = source
	local crew, player = getPlayerCrew(idJ)
	if crew and player.grade == "owner" then
		DeleteCrew(idJ, crew)
	else
		showNotification(idJ, translate.TR_NOT_HAS)
	end
end)

function DeleteCrew(source, crew)
	local identifier = getIdentifier(source)

	for i, player in pairs(crew.players) do
		local cPlayer = GetPlayerFromIdentifier(player.identifier)

		if cPlayer then
			showNotification(player.source, translate.TR_NOTIFY_DELETE)	
			TriggerClientEvent('CrewSystem: deletedCrew', player.source)
		end
		
	end

	for i,k in pairs(crews) do
		if k.name == crew.name then
			table.remove(crews, i)
			break
		end
	end
	
	_deletecrew(crew.name)
	_deleteranking(crew.name)
end

RegisterCommand(commands.ranking, function(source, args)
	if enable_rank then
		MySQL.Async.fetchAll('SELECT *, DATE_FORMAT(created, "'.. date_format .. '") AS createdat FROM ranking_crew ORDER BY kills DESC', {},
		function(result)
			TriggerClientEvent('CrewSystem: OpenRanking', source, result)
		end)
	end
end)

RegisterNetEvent('CrewSystem: addKillCrew')
AddEventHandler('CrewSystem: addKillCrew', function(sourceKiller)
	local idJ = source

	local victimCrew = getPlayerCrew(idJ)
	local killerCrew = getPlayerCrew(sourceKiller)

	if killerCrew then
		if victimCrew and victimCrew.name == killerCrew.name then
			return
		end

		MySQL.Async.execute('UPDATE ranking_crew SET members = @members, kills = (kills + 1) WHERE name = @name',{
			['@name'] = killerCrew.name,
			['@members'] = #killerCrew.players
		})
	end
end)

function _insertcrew(crewName, identifier, grade)
	MySQL.Async.execute('INSERT INTO crew (name, identifier, grade) VALUES (@name, @identifier, @grade)',{
		['@name'] = crewName,
		['@identifier'] = identifier,
		['@grade'] = grade
	}, function() end)
end

function _updatecrew(identifier, grade)
	MySQL.Async.execute('UPDATE crew SET grade = @grade WHERE identifier =  @identifier ',{
		['@identifier'] = identifier,
		['@grade'] = grade
	}, function() end)
end

function _leftcrew(identifier)
	MySQL.Async.execute('DELETE FROM crew WHERE identifier = @identifier',{
		['@identifier'] = identifier
	}, function() end)
end

function _deletecrew(crewName)
	MySQL.Async.execute('DELETE FROM crew WHERE name = @name',{
		['@name'] = crewName
	}, function() end)
end

function _insertranking(crewName)
	MySQL.Async.execute('INSERT INTO ranking_crew (name, kills) VALUES (@name, @kills)',{
		['@name'] = crewName,
		['@kills'] = 0,
	}, function() end)
end

function _deleteranking(crewName)
	MySQL.Async.execute('DELETE FROM ranking_crew WHERE name = @name',{
		['@name'] = crewName
	}, function() end)
end