ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pk_wood:pickedUpCannabis')
AddEventHandler('pk_wood:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('wood')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)


ESX.RegisterServerCallback('pk_wood:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)

ESX.RegisterServerCallback('pk_wood:haveItem', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('hatchet_lj')

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('pk_woodprocess:process')
AddEventHandler('pk_woodprocess:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(500, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMax = xPlayer.getInventoryItem('wood'), xPlayer.getInventoryItem('pro_wood')
			if xMax.limit ~= -1 and (xMax.count + 1) >= xMax.limit then
				--
			elseif xMin.count < 1 then
				--
			else
				xPlayer.removeInventoryItem('wood', 1)
				xPlayer.addInventoryItem('pro_wood', 1)
			end

			playersProcessing[_source] = nil
		end)
	else
		--
	end
end)
