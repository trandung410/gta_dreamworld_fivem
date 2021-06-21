ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_oiljob:pickedUpCannabis')
AddEventHandler('esx_oiljob:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('stone')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

ESX.RegisterServerCallback('esx_oiljob:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)

ESX.RegisterServerCallback('esx_oiljob:haveItem', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('drill')

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('tgt_stone:process')
AddEventHandler('tgt_stone:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(500, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMax = xPlayer.getInventoryItem('stone'), xPlayer.getInventoryItem('washed_stone')
			if xMax.limit ~= -1 and (xMax.count + 1) > xMax.limit then
				TriggerClientEvent('esx:showNotification', _source,"Quá trình ~r~bị hủy~s~ vì đầy túi")
			elseif xMin.count < 1 then
				TriggerClientEvent('esx:showNotification', _source,"Bạn cần phải có ~b~1x~s~ ~g~đá~s~ để rửa")
			else
				xPlayer.removeInventoryItem('stone', 1)
				xPlayer.addInventoryItem('washed_stone', 1)
			end

			playersProcessing[_source] = nil
		end)
	end
end)

RegisterServerEvent('tgt_stone:packing')
AddEventHandler('tgt_stone:packing', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(500, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xStone, xIron = xPlayer.getInventoryItem('washed_stone'), xPlayer.getInventoryItem('iron')
			local xMine = math.random(1, 100)
			if xIron.limit ~= -1 and (xIron.count + 1) >= xIron.limit then
				--
			elseif xStone.count < 1 then
				TriggerClientEvent('esx:showNotification', _source,"Bạn cần phải có ~b~1x~s~ ~g~đá đã rửa~s~ để nung")
			else
				if(xMine >= 31 and xMine < 69) then
					xPlayer.removeInventoryItem('washed_stone', 1)
					xPlayer.addInventoryItem('copper', 1)
					elseif(xMine >= 70 and xMine < 90) then
					xPlayer.removeInventoryItem('washed_stone', 1)
					xPlayer.addInventoryItem('iron', 1)
					elseif(xMine >= 91 and xMine < 96) then
					xPlayer.removeInventoryItem('washed_stone', 1)
					xPlayer.addInventoryItem('gold', 1)
					elseif(xMine >= 97 and xMine < 98) then
					xPlayer.removeInventoryItem('washed_stone', 1)
					xPlayer.addInventoryItem('diamond', 1)
				end
			end

			playersProcessing[_source] = nil
		end)
	else
		--
	end
end)