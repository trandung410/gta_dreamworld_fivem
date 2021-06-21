ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('pk_drugs:pickedUp')
AddEventHandler('pk_drugs:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])

	if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<strong class="red-text">'..xItem.label..' đã dầy</strong> ',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		}) 
	else
		xPlayer.addInventoryItem(xItem.name, xItemCount)
	end
end)

function CheckPolice()
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	return cops
end

ESX.RegisterServerCallback('pk_drugs:checkPolice', function(source, cb)
	local cops = CheckPolice()

	if cops < Config.CopsRequiredToSell then
		cb(false)
	else
		cb(true)
	end
end)

ESX.RegisterServerCallback('pk_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	
	if CheckPolice() < Config.CopsRequiredToSell then
		TriggerClientEvent('esx:showNotification', source, 'there must be at least ~b~ 3 cops~s~ in town')
		cb(false)
	end

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)