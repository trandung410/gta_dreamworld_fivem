ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('meeta_shops:requestDBItems', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM shops_new LEFT JOIN items ON items.name = shops_new.item', {}, function(shopResult)
		cb(shopResult)
	end)
	
end)

RegisterServerEvent('meeta_shops:buyItem')
AddEventHandler('meeta_shops:buyItem', function(itemName, amount, index)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	amount = ESX.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('meeta_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end


	MySQL.Async.fetchAll('SELECT * FROM shops_new WHERE item = @item', {
		['@item'] = itemName
	}, function(shopResult)
		if shopResult[1] then
			local price = shopResult[1].price
			local itemLabel = shopResult[1].label
		


			price = price * amount














			if xPlayer.getMoney() >= price then
				if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = '<strong class="red-text">Bạn bị đầy túi</strong>',
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
				else
					xPlayer.removeMoney(price)
					xPlayer.addInventoryItem(itemName, amount)
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = '<strong class="blue-text">Đã mua</strong>',
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
				end
			else
				local missingMoney = price - xPlayer.getMoney()
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="red-text">bạn không có đủ tiền</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end
	end)
end)
