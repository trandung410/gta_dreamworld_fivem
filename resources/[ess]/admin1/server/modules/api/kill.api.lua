APIcalls['kill'] = function(data)
    if data.source ~= nil then
        if GetPlayerPing(data.source) ~= nil then
            TriggerClientEvent('admin:kill', tonumber(data.source))
            return {executed = true}
        end
        return {executed = false, message = "Invaid source"}
    end
    return {executed = false, message = "Invalid data"}
end