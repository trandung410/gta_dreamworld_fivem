ESX 					= nil
TriggerEvent(Config.ESX.ESXSHAREDOBJECT, function(obj) ESX = obj end)

RegisterServerEvent("vrp_legacyfuel2:pagamento")
AddEventHandler("vrp_legacyfuel2:pagamento",function(price,galao,vehicle,fuel,fuel2,key)
	local source = source
	local output = {}
	local query = nil
	if key then
		local sql = "SELECT stock,price FROM gas_station_business WHERE gas_station_id = @gas_station_id";
		query = MySQL.Sync.fetchAll(sql, {['@gas_station_id'] = key});
		if query and query[1] then
			output = {
				['price'] = (query[1].price/100),
				['stock'] = query[1].stock,
			}
			local sql = "UPDATE `gas_station_business` SET total_visits = total_visits + 1 WHERE gas_station_id = @gas_station_id";
			MySQL.Sync.execute(sql, {['@gas_station_id'] = key});
		else
			output = {
				['price'] = Config.stock.default_price,
				['stock'] = Config.stock.default_stock,
			}
		end
	else
		output = {
			['price'] = Config.stock.default_price, 	-- Default price
			['stock'] = Config.stock.default_stock,		-- Default amount
		}
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	if price > 0 then
		local amount = 0
		if galao then
			amount = price
		else
			amount = math.floor(price/output.price)
			fuel = math.floor(fuel/output.price)
		end
		if galao or output.stock > amount then
			money = xPlayer.getMoney()
			if money >= price then
				xPlayer.removeMoney(price)
				if galao then
					TriggerClientEvent('vrp_legacyfuel2:galao',source)
					TriggerClientEvent("gas_station:Notify",source,"sucesso","Đã thanh toán<b>$"..price.." </b> cho <b>gallon</b>.",8000)
				else
					if key and query and query[1] then
						local sql = "UPDATE `gas_station_business` SET stock = @stock, customers = customers + 1, money = money + @price, total_money_earned = total_money_earned + @price, gas_sold = gas_sold + @amount WHERE gas_station_id = @gas_station_id";
						MySQL.Sync.execute(sql, {['@gas_station_id'] = key, ['@stock'] = ((output.stock) - amount), ['@price'] = price, ['@amount'] = amount});
						
						local sql = "INSERT INTO `gas_station_balance` (gas_station_id,income,title,amount,date) VALUES (@gas_station_id,@income,@title,@amount,@date)";
						MySQL.Sync.execute(sql, {['@gas_station_id'] = key, ['@income'] = 0, ['@title'] = "Nhiên liệu đã bán ("..amount.." lít)", ['@amount'] = price, ['@date'] = os.time()});
					end
					
					TriggerClientEvent('syncfuel',-1,vehicle,fuel)
					TriggerClientEvent("gas_station:Notify",source,"sucesso","Đã thanh toán <b>$"..price.." </b> cho "..amount.." lít.",8000)
				end
			else
				TriggerClientEvent('vrp_legacyfuel2:insuficiente',source,vehicle,fuel2)
				TriggerClientEvent("gas_station:Notify",source,"negado","Không đủ tiền.",8000)
			end
		else
			TriggerClientEvent('vrp_legacyfuel2:insuficiente',source,vehicle,fuel2)
			TriggerClientEvent("gas_station:Notify",source,"negado","Thiếu nhiên liệu dự trữ (Tối đa: "..output.stock.." lít).",8000)
		end
	end
end)

RegisterServerEvent('vrp_legacyfuel2:LixeiroCB')
AddEventHandler('vrp_legacyfuel2:LixeiroCB', function(key)
	local source = source
	if key then
		local sql = "SELECT stock,price FROM gas_station_business WHERE gas_station_id = @gas_station_id";
		local query = MySQL.Sync.fetchAll(sql, {['@gas_station_id'] = key});
		local output = {}
		if query and query[1] then
			output = {
				['price'] = (query[1].price/100),
				['stock'] = query[1].stock,
			}
			local sql = "UPDATE `gas_station_business` SET total_visits = total_visits + 1 WHERE gas_station_id = @gas_station_id";
			MySQL.Sync.execute(sql, {['@gas_station_id'] = key});
		else
			output = {
				['price'] = Config.stock.default_price,
				['stock'] = Config.stock.default_stock,
			}
		end

		TriggerClientEvent('vrp_legacyfuel2:LixeiroCB', source, output)
	else
		local output = {
			['price'] = Config.stock.default_price,
			['stock'] = Config.stock.default_stock,
		}
		TriggerClientEvent('vrp_legacyfuel2:LixeiroCB', source, output)
	end
end)