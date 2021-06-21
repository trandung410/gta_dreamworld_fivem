APIcalls['respawn'] = function(data, author)
    if data.source ~= nil then
        if GetPlayerPing(data.source) ~= nil then
            TriggerClientEvent('esx_ambulancejob:revive', tonumber(data.source))
            SendWebhook("Respawn",
                ("Revived %s (%s)"):format(GetPlayerName(tonumber(data.source)), data.source),
                author)
            return {executed = true}
        end
        return {executed = false, message = "Invaid source"}
    end
    return {executed = false, message = "Invalid data"}
end