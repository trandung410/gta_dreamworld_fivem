RegisterServerEvent("stores:addInventoryItem")
AddEventHandler("stores:addInventoryItem",function(xPlayer,item,amount)
    xPlayer.addInventoryItem(item, amount)
end)