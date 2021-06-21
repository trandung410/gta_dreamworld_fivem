
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('pk_cabbage:pickedUp')
AddEventHandler('pk_cabbage:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])


	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<span class="red-text">'..Config.ItemFull..'</span> ',
			type = "error",
			timeout = 3000,
			layout = "Center",
			queue = "global"
		}) 
	else
		if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
			xPlayer.setInventoryItem(xItem.name, xItem.limit)
		else
			xPlayer.addInventoryItem(xItem.name, xItemCount)
			
		for k,v in pairs(Config.ItemBonus) do
			local xPlayer = ESX.GetPlayerFromId(source)
			local xItem2 = xPlayer.getInventoryItem(v.ItemName)
		
				if Config.ItemBonus ~= nil then
					if math.random(1, 100) <= v.Percent then
						xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
					end
				end
		end
	
		end
	end
end)


RegisterServerEvent('pk_cabbage:Check')
AddEventHandler('pk_cabbage:Check', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem(Config.itemuse).count

    if item >= 1  then
        TriggerClientEvent('pk_cabbage:pic',source)        
    else        
        TriggerClientEvent("pNotify:SendNotification", source, {
			text = Config.nohave,
			type = "error",
			timeout = 3000,
			layout = "Center",
			queue = "global"
		}) 
    end

end)


