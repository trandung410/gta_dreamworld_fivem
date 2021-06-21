local playersProcessingCannabis = {}

RegisterServerEvent('esx_illegal:pickedUpCannabis')
AddEventHandler('esx_illegal:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cannabis')
	local count = 1
	if xItem.limit ~= -1 and (xItem.count + count) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, count)
	end
end)

RegisterServerEvent('esx_illegal:processCannabis')
AddEventHandler('esx_illegal:processCannabis', function()
	if not playersProcessingCannabis[source] then
		local _source = source

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xMarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('marijuana')
			if (xMarijuana.count + 1) > xMarijuana.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xCannabis.count < 5 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			else
				xPlayer.removeInventoryItem('cannabis', 5)
				xPlayer.addInventoryItem('marijuana', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end
			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
	end
end

RegisterServerEvent('esx_illegal:cancelProcessing')
AddEventHandler('esx_illegal:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
