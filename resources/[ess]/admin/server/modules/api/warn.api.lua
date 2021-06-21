APIcalls['warn'] = function(data, author)
    if data.source ~= nil and data.message ~= nil then
        if GetPlayerPing(tonumber(data.source)) then
            TriggerClientEvent('chat:addMessage', tonumber(data.source), {
                args = {"^3WARNING", "^7"..data.message}
            })
            WarnPlayer(data.source, data.message)
            SendWebhook("Warning",
                ("Warned %s (%s) reason: %s"):format(GetPlayerName(tonumber(data.source)), data.source, data.message),
                author)
            return {executed = true}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end