ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterUsableItem("armor", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("armor")
    xPlayer.removeInventoryItem("armor", 1)
    TriggerClientEvent('ic_item:client:armour', source, 1, xItem.label)
end)
ESX.RegisterUsableItem("armour_vest_police", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("armour_vest_police")
    if xPlayer.job.name == 'police' then
        xPlayer.removeInventoryItem("armour_vest_police", 1)
        TriggerClientEvent('ic_item:client:armour', source, 4, xItem.label)
    else
        TriggerClientEvent('esx:showNotification', source, 'Bạn không thể dùng ~r~ Áo giáp cảnh sát')
    end
end)