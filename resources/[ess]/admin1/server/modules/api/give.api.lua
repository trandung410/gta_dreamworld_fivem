APIcalls['giveItem'] = function(data)
    if data.source ~= nil and data.name ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer ~= nil then
            local xItem = xPlayer.getInventoryItem(data.name)
            if not xItem then return {executed = false, message = "Invalid item name"} end
            if xPlayer.canCarryItem(data.name, tonumber(data.amount)) then
                xPlayer.addInventoryItem(data.name, tonumber(data.amount))
                return {
                    executed = true,
                    name = xItem.name,
                    count = xItem.count + tonumber(data.amount)
                }
            else
                return {executed = false, message = "Insufficient space at player's inventory"}
            end
        end
        return {executed = false, message = "Invalid source"}
    end
    return {executed = false, message = "Invalid data"}
end

APIcalls['giveAccount'] = function(data)
    if data.source ~= nil and data.account ~= nil and tonumber(data.amount) ~= nil then
        local xPlayer = ESX.GetPlayerFromId(tonumber(data.source))
        if xPlayer then
            local xAccount = xPlayer.getAccount(data.account)
            if xAccount then
                xPlayer.addAccountMoney(data.account, tonumber(data.amount))
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