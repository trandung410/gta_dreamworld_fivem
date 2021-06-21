APIcalls['giveItem'] = function(data, author)
    if data.source ~= nil and data.name ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer ~= nil then
            local xItem = xPlayer.getInventoryItem(data.name)
            if not xItem then return {executed = false, message = "Invalid item name"} end
            if IS_ESX_FINAL and not xPlayer.canCarryItem(data.name, tonumber(data.amount)) then
                return {executed = false, message = "Insufficient space at player's inventory"}
            end

            xPlayer.addInventoryItem(data.name, tonumber(data.amount))
            SendWebhook("Give item",
            ("Gived %s (x%s) item(s) to %s (%s)"):format(xItem.label, data.amount, GetPlayerName(tonumber(data.source)), data.source),
            author)
            return {
                executed = true,
                name = xItem.name,
                count = xItem.count + tonumber(data.amount)
            }
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

local function GetAccount(xPlayer, account)
    if IS_ESX_FINAL then return xPlayer.getAccount(account) end
    if account == "money" then
        return {name = 'money', money = xPlayer.getMoney()}
    else
        return xPlayer.getAccount(account)
    end
end

local function AddAccount(xPlayer, account, amount)
    if IS_ESX_FINAL then return xPlayer.addAccountMoney(account, tonumber(amount)) end
    if account == "money" then return xPlayer.addMoney(tonumber(amount)) end
    return xPlayer.addAccountMoney(account, tonumber(amount))
end

APIcalls['giveAccount'] = function(data, author)
    if data.source ~= nil and data.account ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            local xAccount = GetAccount(xPlayer, data.account)
            if xAccount then
                AddAccount(xPlayer, data.account, data.amount)
                SendWebhook("Give account",
                ("Gived %s %s$ to %s (%s)"):format(data.account, data.amount, GetPlayerName(tonumber(data.source)), data.source),
                author)
                return {
                    executed = true,
                    account = data.account,
                    current = xAccount.money + tonumber(data.amount)
                }
            end
            return {executed = false, message = "Invalid account"}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end