local function GetAccount(xPlayer, account)
    if IS_ESX_FINAL then return xPlayer.getAccount(account) end
    if account == "money" then
        return {name = 'money', money = xPlayer.getMoney()}
    else
        return xPlayer.getAccount(account)
    end
end

local function SetAccount(xPlayer, account, amount)
    if IS_ESX_FINAL then return xPlayer.setAccountMoney(account, tonumber(amount)) end
    if account == "money" then
        return xPlayer.setMoney(tonumber(amount))
    end
    return xPlayer.setAccountMoney(account, tonumber(amount))
end

APIcalls['setAccount'] = function(data, author)
    if data.source ~= nil and data.account ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            local xAccount = GetAccount(xPlayer, data.account)
            if xAccount then
                SetAccount(xPlayer, data.account, data.amount)
                SendWebhook("Set account",
                ("Setted %s %s$ of %s (%s)"):format(data.account, data.amount, GetPlayerName(tonumber(data.source)), data.source),
                author)
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

APIcalls['setCoords'] = function(data, author)
    if data.source ~= nil and data.coords ~= nil 
    and tonumber(data.coords.x) ~= nil 
    and tonumber(data.coords.y) ~= nil 
    and tonumber(data.coords.z) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            xPlayer.setCoords(data.coords)
            if not IS_ESX_FINAL then
                SetEntityCoords(GetPlayerPed(tonumber(data.source)), data.coords.x, data.coords.y, data.coords.z, 0, 0, 0, false)
            end
            SendWebhook("Set coords",
                ("Teleported %s (%s) to (%s, %s, %s)"):format(GetPlayerName(tonumber(data.source)), data.source, data.coords.x, data.coords.y, data.coords.z),
                author)
            return {executed = true}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

APIcalls['setGroup'] = function(data, author)
    if data.source ~= nil and data.group ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            if IS_ESX_FINAL then xPlayer.setGroup(data.group)
            else MySQL.Async.execute('UPDATE `users` SET `group` = @group WHERE `identifier` = @identifier', {['@group']=data.group, ['@identifier']=xPlayer.identifier}) end
            SendWebhook("Set group",
                ("Changed group of %s (%s) to `%s`"):format(GetPlayerName(tonumber(data.source)), data.source, data.group),
                author)
            return {executed = true, group = data.group}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

local function UpdatePlayerName(xPlayer, firstname, lastname)
    local identity  = {
        firstname   = xPlayer.get('firstname'),
        lastname    = xPlayer.get('lastname'),
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

APIcalls['setName'] = function(data, author)
    if data.source ~= nil and data.firstname ~= nil and data.lastname ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            UpdatePlayerName(xPlayer, data.firstname, data.lastname)
            SendWebhook("Set name",
                ("Updated name of %s (%s) to `%s %s`"):format(GetPlayerName(tonumber(data.source)), data.source, data.firstname, data.lastname),
                author)
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