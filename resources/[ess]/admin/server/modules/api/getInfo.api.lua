local function compatibleAccounts(xPlayer)
    if IS_ESX_FINAL then
        return xPlayer.getAccounts(true)
    else
        return {
            money = xPlayer.getMoney(),
            bank = xPlayer.getBank(),
        }
    end
end

APIcalls['getInfoFromSource'] = function(data)
    if data.source and GetPlayerPing(data.source) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            return {
                executed    = true,
                source      = data.source,
                name        = data.name,
                accounts    = compatibleAccounts(xPlayer),
                firstname   = xPlayer.get('firstname') or 'nil',
                lastname    = xPlayer.get('lastname') or 'nil',
                group       = xPlayer.getGroup(),
            }
        end
    end
    return {executed = false, message = "Invalid source"}
end