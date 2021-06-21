APIcalls['kill'] = function(data, author)
    if data.source ~= nil then
        if GetPlayerPing(data.source) ~= nil then
            TriggerClientEvent('admin:kill', tonumber(data.source))
            SendWebhook("Kill",
                ("Killed %s (%s)"):format(GetPlayerName(tonumber(data.source)), data.source),
                author)
            return {executed = true}
        end
        return {executed = false, message = "Invaid source"}
    end
    return {executed = false, message = "Invalid data"}
end