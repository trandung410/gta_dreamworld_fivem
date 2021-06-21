APIcalls['ban'] = function(data, author)
    if data.source ~= nil and data.message ~= nil then
        if GetPlayerPing(tonumber(data.source)) then
            BanPlayerById(data.source, data.message)
            SendWebhook("Ban",
                ("Banned %s (%s) reason: %s"):format(GetPlayerName(tonumber(data.source)), data.source, data.message),
                author)
            DropPlayer(tonumber(data.source), "Banned, reason: " .. data.message)
            return {executed = true}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

APIcalls['unban'] = function(data, author)
    if data.identifier ~= nil then
        if IsIdentifierBanned(data.identifier) then
            SendWebhook("Unban",
                ("Unbanned %s (%s)"):format(GetPlayerName(tonumber(data.source)), data.source, data.message),
                author)
            return {executed = true}
        end
    end
    return {executed = false, message = "Invalid data"}
end