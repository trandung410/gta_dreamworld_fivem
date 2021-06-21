APIcalls['getInventoryFromSource'] = function(data)
    if data.source and GetPlayerPing(data.source) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            return {
                executed    = true,
                source      = data.source,
                inventory   = xPlayer.getInventory(),
            }
        end
    end
    return {executed = false, message = "Invalid source"}
end