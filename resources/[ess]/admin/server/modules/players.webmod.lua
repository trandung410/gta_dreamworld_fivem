local playerList = {}

for _, pid in pairs(GetAllPeds()) do
    if IsPedAPlayer(pid) then
        local source = NetworkGetEntityOwner(pid)
        playerList[tostring(source)] = GetPlayerName(source)
    end
end

RegisterNetEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = tonumber(source)
    print('Checking player ', name, source)
    deferrals.defer(); Wait(1)
    deferrals.update "[ESX_MANAGER]: Checking ban list..."
    local ban = IsPlayerBanned(source)
    if ban then
        deferrals.done(("You're banned from this server. (\"%s\")"):format(ban.reason))
        SendWebhook("Connection",
                ("User %s tried to connect, but it's banned due to: %s"):format(ban.name, ban.reason), 'server')
        return
    end
    deferrals.done()
end)

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