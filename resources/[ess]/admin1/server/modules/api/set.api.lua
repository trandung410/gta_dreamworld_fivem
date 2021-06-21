APIcalls['setAccount'] = function(data)
    if data.source ~= nil and data.account ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            local xAccount = xPlayer.getAccount(data.account)
            if xAccount then
                xPlayer.setAccountMoney(data.account, tonumber(data.amount))
                return {
                    executed = true,
                    account = data.account,
                    current = tonumber(data.amount)
                }
            end
            return {executed = false, message = "Invalid account"}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

APIcalls['setCoords'] = function(data)
    if data.source ~= nil and data.coords ~= nil 
    and tonumber(data.coords.x) ~= nil 
    and tonumber(data.coords.y) ~= nil 
    and tonumber(data.coords.z) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            xPlayer.setCoords(data.coords)
            return {executed = true}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

APIcalls['setGroup'] = function(data)
    if data.source ~= nil and data.group ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            xPlayer.setGroup(data.group)
            return {executed = true, group = data.group}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

local function UpdatePlayerName(xPlayer, firstname, lastname)
    local identity  = {
        firstname   = xPlayer.get('firstName'),
        lastname    = xPlayer.get('lastName'),
        dateofbirth = xPlayer.get('dateofbirth'),
        sex         = xPlayer.get('sex'),
        height      = xPlayer.get('height'),
    }

    MySQL.Sync.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= firstname,
		['@lastname']		= lastname,
		['@dateofbirth']	= identity.dateofbirth,
		['@sex']			= identity.sex,
		['@height']			= identity.height
	})
    TriggerEvent('esx_identity:characterUpdated', xPlayer.source, identity)
end

APIcalls['setName'] = function(data)
    if data.source ~= nil and data.firstname ~= nil and data.lastname ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            UpdatePlayerName(xPlayer, data.firstname, data.lastname)
            return {
                executed = true,
                firstname = data.firstname,
                lastname = data.lastname,
            }
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end