APIcalls["kick"] = function(data)
    if data ~= nil and tonumber(data.source) ~= nil then
        local source = tonumber(data.source)
        if GetPlayerPing(source) ~= nil then
            DropPlayer(source, 'Kicked from server (ESX Manager)')
            return {executed = true, source = data.source}
        end
    else
        print 'API call "kick" missing source'
    end
    return {executed = false, message = "Source not connected"}
end