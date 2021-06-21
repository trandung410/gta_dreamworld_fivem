-- Variables

UIDS = {}
UIDtoID = {}


RegisterServerEvent('RufiUID:GetInfo')
AddEventHandler('RufiUID:GetInfo', function()
 local source = source
	local id = GetPlayerIdentifiers(source)[1]
    local name = GetPlayerName(source) 
	
	MySQL.Async.fetchAll('SELECT uid FROM players_uid WHERE steam = @steam', {['@steam'] = id}, function(players)
	--MySQL.Async.fetchAll('SELECT uid FROM users WHERE identifier = @steam', {['@steam'] = id}, function(players)
		if players[1] then
			id = players[1].uid
			--id = players[1].uid
			idmia = id
			UIDS[source] = id
			UIDtoID[id] = source
			TriggerClientEvent('RufiUID:GetInfo', -1, UIDS, UIDtoID)
		else
       		MySQL.Async.execute("INSERT INTO players_uid (name,steam) VALUES (@name,@steam)", {['@name'] = name, ['@steam'] = id}, function(rowsChanged)
				if rowsChanged ~= nil then
					MySQL.Async.fetchAll('SELECT uid FROM players_uid WHERE steam = @steam', {['@steam'] = id}, function(players)
					--MySQL.Async.fetchAll('SELECT uid FROM users WHERE identifier = @steam', {['@steam'] = id}, function(players)
						if players[1] then
							id = players[1].uid
							--id = players[1].uid
							idmia = id
							UIDS[source] = id
							UIDtoID[id] = source
							TriggerClientEvent('RufiUID:GetInfo', -1, UIDS, UIDtoID)
						end
					end)
				end
	   		end)
	   	end
	end)
end)



exports('GetUIDfromID', function(ID)
	local id = ID
	return UIDS[id]
end)


exports('GetIDfromUID', function(PUID)
	local id = PUID
	return UIDtoID[id]
end)
