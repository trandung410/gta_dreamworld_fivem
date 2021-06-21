ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'yakuza', Config.MaxInService)
end

-- TriggerEvent('esx_phone:registerNumber', 'yakuza', _U('alert_gang1'), true, true)
TriggerEvent('esx_society:registerSociety', 'yakuza', 'yakuza', 'society_yakuza', 'society_yakuza', 'society_yakuza', {type = 'public'})

RegisterServerEvent('esx_yakuza:giveWeapon')
AddEventHandler('esx_yakuza:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)



RegisterServerEvent('esx_yakuza:getStockItem')
AddEventHandler('esx_yakuza:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
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

RegisterServerEvent('esx_yakuza:putStockItems')
AddEventHandler('esx_yakuza:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
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


ESX.RegisterServerCallback('esx_yakuza:getStockItems', function(source, cb)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_yakuza:getPlayerInventory', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items,
	})
end)


-------------
AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'yakuza' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_yakuza:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_yakuza:spawned')
AddEventHandler('esx_yakuza:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'yakuza' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_yakuza:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_yakuza:forceBlip')
AddEventHandler('esx_yakuza:forceBlip', function()
	TriggerClientEvent('esx_yakuza:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_yakuza:updateBlip', -1)
	end
end)