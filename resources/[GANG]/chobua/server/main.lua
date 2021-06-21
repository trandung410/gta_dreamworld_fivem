ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'chobua', Config.MaxInService)
end

-- TriggerEvent('esx_phone:registerNumber', 'chobua', _U('alert_gang1'), true, true)
TriggerEvent('esx_society:registerSociety', 'chobua', 'chobua', 'society_chobua', 'society_chobua', 'society_chobua', {type = 'public'})

RegisterServerEvent('esx_chobua:giveWeapon')
AddEventHandler('esx_chobua:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)



RegisterServerEvent('esx_chobua:getStockItem')
AddEventHandler('esx_chobua:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_chobua', function(inventory)
    local item = inventory.getItem(itemName)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    -- is there enough in the society?
    if count > 0 and item.count >= count then
        -- can the player carry the said amount of x item?
        if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
          TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
        else
          inventory.removeItem(itemName, count)
          xPlayer.addInventoryItem(itemName, count)
          TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
        end
   else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
   end
  end)
end)

RegisterServerEvent('esx_chobua:putStockItems')
AddEventHandler('esx_chobua:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_chobua', function(inventory)
    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end
  end)

end)


ESX.RegisterServerCallback('esx_chobua:getStockItems', function(source, cb)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_chobua', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_chobua:getPlayerInventory', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items,
	})
end)
