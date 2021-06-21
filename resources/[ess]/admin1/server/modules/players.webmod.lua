local playerList = {}

for _, pid in pairs(GetAllPeds()) do
    if IsPedAPlayer(pid) then
        local source = NetworkGetNetworkIdFromEntity(pid)
        playerList[tostring(source)] = GetPlayerName(source)
        print('Added to list', source)
    end
end

RegisterNetEvent('playerJoining')
AddEventHandler('playerJoining', function()
    local source = tonumber(source)
    print('Player added to list', source)
    playerList[tostring(source)] = GetPlayerName(source)
end)

AddEventHandler('playerDropped', function(reason)
    local source = tonumber(source)
    print('Player removed from list', source)
    playerList[tostring(source)] = nil
    collectgarbage "collect"
end)

function GetOnlinePlayerList()
    return playerList
end