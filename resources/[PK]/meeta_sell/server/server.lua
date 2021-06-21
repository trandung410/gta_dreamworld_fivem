-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'eco', 'admin', function(source, args, user)
	for k,v in pairs(Config.SellZone) do
		for i=1, #v.Item, 1 do
			if v.Item[i].Eco_Max > 0 then
				Citizen.Wait(300)
				if v.Item[i].RandomPrice then
					local random_price1 = math.random(v.Item[i].Eco_Price[1], v.Item[i].Eco_Price[2])
					local random_price2 = math.random(v.Item[i].Eco_Price[3], v.Item[i].Eco_Price[4])
					MySQL.Async.execute("UPDATE meeta_economy SET price=@price,price2=@price2 WHERE item=@item",
					{
						['@item'] = v.Item[i].ItemName,
						['@price'] = random_price1,
						['@price2'] = random_price2
					})
				else
					local random_price = math.random(v.Item[i].Eco_Price[1], v.Item[i].Eco_Price[2])
					MySQL.Async.execute("UPDATE meeta_economy SET price=@price,price2=@price2 WHERE item=@item",
					{
						['@item'] = v.Item[i].ItemName,
						['@price'] = random_price,
						['@price2'] = random_price
					})
				end
				
			end				
		end
	end
end)

AddEventHandler('onMySQLReady', function()
	MySQL.Async.execute("UPDATE meeta_economy SET count=0", {})
end)

AddEventHandler('onMySQLReady', function()
	while true do
		for k,v in pairs(Config.SellZone) do
			for i=1, #v.Item, 1 do
				if v.Item[i].Eco_Max > 0 then
					Citizen.Wait(300)
					if v.Item[i].RandomPrice then
						local random_price1 = math.random(v.Item[i].Eco_Price[1], v.Item[i].Eco_Price[2])
						local random_price2 = math.random(v.Item[i].Eco_Price[3], v.Item[i].Eco_Price[4])
						MySQL.Async.execute("UPDATE meeta_economy SET price=@price,price2=@price2 WHERE item=@item",
						{
							['@item'] = v.Item[i].ItemName,
							['@price'] = random_price1,
							['@price2'] = random_price2
						})
					else
						local random_price = math.random(v.Item[i].Eco_Price[1], v.Item[i].Eco_Price[2])
						MySQL.Async.execute("UPDATE meeta_economy SET price=@price,price2=@price2 WHERE item=@item",
						{
							['@item'] = v.Item[i].ItemName,
							['@price'] = random_price,
							['@price2'] = random_price
						})
					end
					
				end				
			end
		end
		print("Update Emo")
		Citizen.Wait(3600000) --เวลารีเซิฟ 1ชม = 3600000
	end
end)

ESX.RegisterServerCallback("meeta_selling:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory})
	else
		cb(nil)
	end
end)

ESX.RegisterServerCallback("meeta_selling:getPriceItems", function(source, cb)
	local result_price = MySQL.Sync.fetchAll("SELECT label, item, count, price, price2, difference FROM meeta_economy ORDER BY price DESC")
	cb(result_price)
end)

RegisterServerEvent('meeta_selling:sellFunction')
AddEventHandler('meeta_selling:sellFunction', function(Index, CurrentZone, Count)
	local _source = source
	local Item = CurrentZone.Item[Index]
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem(Item.ItemName)
	local Price = 0

	local result_price = MySQL.Sync.fetchAll("SELECT price,price2 FROM meeta_economy WHERE item = @item", {
		['@item'] = Item.ItemName
	})

	if Item.Eco_Max > 0 then
		if Item.RandomPrice then
			Price = math.random(result_price[1].price, result_price[1].price2)
		else
			Price = result_price[1].price
		end
	else
		if Item.RandomPrice then
			Price = math.random(Item.Price[1], Item.Price[2])
		else
			Price = Item.Price
		end
	end

	if Price > 0 then
		if xItem.count <= 0 then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = "<span style='font-size:14;font-weight: 900'>Economy</span><br><strong class='red-text'>Bạn không có đủ "..Item.Text.." </strong> ",
				type = "success",
				timeout = 3000,
				layout = "topRight",
				queue = "global"
			}) 
		else
	
			if Item.Negotiating then
				TriggerClientEvent("meeta_selling:confirmToSell", _source, Item.ItemName, Item.ItemCount, Price) 
			else
	
				if xItem.count >= Count then
					Price = Price*Count
	
					xPlayer.addMoney(Price)
					xPlayer.removeInventoryItem(Item.ItemName, Count)
	
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = "<span style='font-size:14;font-weight: 900'>Economy</span><br>Bạn đã bán <strong class='yellow-text'>"..Item.Text_TH.." x"..Count.."</strong> với giá <strong class='green-text'>$"..Price.."</strong> ",
						type = "success",
						timeout = 3000,
						layout = "topRight",
						queue = "global"
					})
					
					if Item.Eco_Max > 0 then
	
						MySQL.Async.execute('UPDATE meeta_economy SET count = count+@count WHERE item = @item', {
							['@item']  = Item.ItemName,
							['@count'] = Count,
						}, function(rows)
							MySQL.Async.fetchAll('SELECT * FROM meeta_economy WHERE item = @item', {
								['@item'] = Item.ItemName
							}, function(result)
							

								MySQL.Async.execute("UPDATE meeta_economy SET difference=@difference WHERE item=@item", 
								{
									['@item'] = Item.ItemName,
									['@difference'] = result[1].price
								})

								if result[1].count >= Item.Eco_Max then
		
									if Item.RandomPrice then
			
										local discount_price1 = result[1].price * Config.Discount
										local discount_price2 = result[1].price2 * Config.Discount
			
										MySQL.Async.execute("UPDATE meeta_economy SET price=@price, price2=@price2 WHERE item = @item", {
											['@item'] = Item.ItemName, 
											['@price'] = discount_price1,
											['@price2'] = discount_price2
										})
		
									else
		
										local discount_price = result[1].price * Config.Discount
										MySQL.Async.execute("UPDATE meeta_economy SET price=@price WHERE item = @item", {
											['@item'] = Item.ItemName, 
											['@price'] = discount_price
										})
		
									end
									
									MySQL.Async.execute("UPDATE meeta_economy SET count=0 WHERE item=@item", 
									{
										['@item'] = Item.ItemName
									})
		
								end
							end)
						end)
					end
	
					
	
				else
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = "<span style='font-size:14;font-weight: 900'>Economy</span><br><strong class='red-text'>Bạn không có đủ "..Item.Text.." </strong> ",
						type = "success",
						timeout = 3000,
						layout = "topRight",
						queue = "global"
					}) 
				end
			end
		end
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = "<span style='font-size:14;font-weight: 900'>Economy</span><br><strong class='red-text'>Cửa hàng tạm thời đóng cửa</strong> ",
			type = "error",
			timeout = 3000,
			layout = "topRight",
			queue = "global"
		}) 
	end

	

	
end)

RegisterServerEvent('meeta_selling:confirmToSell')
AddEventHandler('meeta_selling:confirmToSell', function(ItemName, ItemCount, ItemPrice)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem(ItemName)
	if xItem.count <= 0 then
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = "<span style='font-size:14;font-weight: 900'>Economy</span><br><strong class='red-text'>Bạn không có đủ "..xItem.label.." </strong> ",
			type = "success",
			timeout = 3000,
			layout = "topRight",
			queue = "global"
		}) 
	else
		xPlayer.addMoney(ItemPrice)
		xPlayer.removeInventoryItem(ItemName, ItemCount)

		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = "<span style='font-size:14;font-weight: 900'>Economy</span><br>Bạn đã bán <strong class='yellow-text'>"..xItem.label.." x1</strong> với giá <strong class='green-text'>$"..ItemPrice.."</strong> ",
			type = "success",
			timeout = 3000,
			layout = "topRight",
			queue = "global"
		}) 
	end
end)