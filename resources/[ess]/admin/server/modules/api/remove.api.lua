APIcalls['removeItem'] = function(data, author)
    if data.source ~= nil and data.name ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer ~= nil then
            local xItem = xPlayer.getInventoryItem(data.name)
            if not xItem then return {executed = false, message = "Invalid item name"} end

            if xItem.count >= tonumber(data.amount) then
                xPlayer.removeInventoryItem(xItem.name, tonumber(data.amount))
                SendWebhook("Remove item",
                ("Removed %s (x%s) item(s) from %s (%s)"):format(xItem.label, data.amount, GetPlayerName(tonumber(data.source)), data.source),
                author)
                return {
                    executed = true,
                    count = xItem.count - tonumber(data.amount)
                }
            end
            return {executed = false, message = "Invalid amount to remove"}
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

local function RemoveAccount(xPlayer, account, amount)
    if IS_ESX_FINAL then return xPlayer.removeAccountMoney(account, tonumber(amount)) end
    if account == "money" then
        return xPlayer.removeMoney(tonumber(amount))
    end
    return xPlayer.removeAccountMoney(account, tonumber(amount))
end

APIcalls['removeAccount'] = function(data, author)
    if data.source ~= nil and data.account ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            local xAccount = GetAccount(xPlayer, data.account)
            if xAccount then
                if xAccount.money >= tonumber(data.amount) then
                    RemoveAccount(xPlayer, data.account, data.amount)
                    SendWebhook("Remove account",
                    ("Removed %s %s$ from %s (%s)"):format(data.account, data.amount, GetPlayerName(tonumber(data.source)), data.source),
                    author)
                    return {
                        executed = true,
                        account = data.account,
                        current = xAccount.money - tonumber(data.amount)
                    }
                end
                return {executed = false, message = "Invalid amount to remove"}
            end
            return {executed = false, message = "Invalid account"}
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end