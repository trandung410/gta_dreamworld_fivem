APIcalls["kick"] = function(data, author)
    if data.source ~= nil and data.message ~= nil then
        local source = tonumber(data.source)
        if GetPlayerPing(source) ~= nil then
            DropPlayer(source, data.message)
            SendWebhook("Kick",
                ("Kicked %s (%s) reason: %s"):format(GetPlayerName(tonumber(data.source)), data.source, data.message),
                author)
            return {executed = true, source = data.source}
        end
    else
        print 'API call "kick" missing source'
    end
    return {executed = false, message = "Source not connected"}
end