APIcalls['getInfoFromSource'] = function(data)
    if data.source and GetPlayerPing(data.source) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            return {
                executed    = true,
                source      = data.source,
                name        = data.name,
                accounts    = xPlayer.getAccounts(true),
                firstname   = xPlayer.get('firstName'),
                lastname    = xPlayer.get('lastName'),
                --bdate       = xPlayer.get('dateofbirth'),
                --sex         = xPlayer.get('sex'),
                --height      = xPlayer.get('height'),
                group       = xPlayer.getGroup(),
            }
        end
    end
    return {executed = false, message = "Invalid source"}
end