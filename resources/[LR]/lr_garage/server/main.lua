ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make sure all Vehicles are Stored on restart
--[[ MySQL.ready(function()
	ParkVehicles()
end)

function ParkVehicles()
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored'] = false
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
		end
	end)
end ]]

-- Get Owned Properties

ESX.RegisterServerCallback("lr_garage:server:getOwnedVehicles", function(source, cb, type)
	local ownedVehs = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.ShowPoundVehicleInGarage == true then 
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job ', {
			['@owner']  = xPlayer.identifier,
			--['@Type']   = 'car',
			['@job']    = ''
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedVehs, {vehicle = vehicle, stored = v.stored, plate = v.plate, customName = v.label, soluong = v.soluong, impound = v.impound, type = v.type})
			end
			cb(ownedVehs)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND `stored` = @stored ', {
			['@owner']  = xPlayer.identifier,
			--['@Type']   = 'car',
			['@job']    = '',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedVehs, {vehicle = vehicle, stored = v.stored, plate = v.plate, customName = v.label, soluong = v.soluong, impound = v.impound, type = v.type})
			end
			cb(ownedVehs)
		end)
	end
end)

ESX.RegisterServerCallback("lr_garages:server:parkVehicle", function(source, cb, plate, props)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored, `vehicle` = @vehicle WHERE plate = @plate', {
		['@stored'] = true,
		['@plate'] = plate,
		['@vehicle'] = json.encode(props)
	}, function(rowsChanged)
		if rowsChanged == 0 then
			cb(false)
		else
			cb(true)
		end
	end)

end)

ESX.RegisterServerCallback("lr_garage:server:returnVehicle", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.ReturnPrice then 
		xPlayer.removeMoney(Config.ReturnPrice)
		cb(true)
	elseif xPlayer.getAccount('bank').money >= Config.ReturnPrice then 
		xPlayer.removeAccountMoney('bank', Config.ReturnPrice)
		cb(true)
	else	
		cb(false)
	end

end)

ESX.RegisterServerCallback("lr_garage:callback:getImpoundData", function(source, cb, data)
	MySQL.Async.fetchAll("SELECT * FROM lr_impound WHERE plate = @plate", {
		['@plate'] = data.plate
	}, function(result)
		print(json.encode(result[1]))
		cb(result[1])
	end)
end)

ESX.RegisterServerCallback("lr_garage:callback:unimpound", function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll("SELECT * FROM lr_impound WHERE plate = @plate", {
		['@plate'] = plate
	}, function(result)
		if xPlayer.getMoney() >= result[1].fine then 
			xPlayer.removeMoney(result[1].fine)
			UnImpoundVehicle(plate)
			cb(true)
		elseif xPlayer.getAccount("bank").money >= result[1].fine then 
			xPlayer.removeAccountMoney("bank", result[1].fine)
			UnImpoundVehicle(plate)
			cb(true)
		else
			xPlayer.showNotification("Bạn không đủ tiền để chuộc phương tiện này")
			cb(false)
		end
	end)
end)

function UnImpoundVehicle(plate)
	MySQL.Async.execute("UPDATE owned_vehicles SET impound = 0 WHERE plate = @plate", {
		['@plate'] = plate
	}, function()
		MySQL.Async.execute("DELETE FROM lr_impound WHERE plate = @plate", {
			['@plate'] = plate
		})
	end)
end

RegisterNetEvent("lr_garage:server:setState")
AddEventHandler("lr_garage:server:setState", function(plate, state)
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_advancedgarage: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

RegisterNetEvent("esx_advancedgarage:changeName")
AddEventHandler("esx_advancedgarage:changeName", function(plate, newName)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET `label` = @label WHERE plate = @plate AND owner = @owner', {
		['@label'] = newName,
		['@plate'] = plate,
		['@owner'] = xPlayer.identifier
	}, function(rowsChanged)
		if rowsChanged == 0 then
			TriggerClientEvent("esx:showNotification", xPlayer.source, ("Phương tiện với biển số: %s đã đổi tên thành ~y~%s~w~"):format(plate, newName))
		end
	end)
end)

RegisterNetEvent("lr_garage:server:deleteVehicle")
AddEventHandler("lr_garage:server:deleteVehicle", function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute("DELETE FROM owned_vehicles WHERE owner = @owner AND plate = @plate", {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(rowDeleted)
		if rowDeleted > 0 then 
			TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã ~r~ XÓA ~w~ phương tiện ~y~[%s]~w~ "):format(plate))
		end
	end)
end)

MySQL.ready(function()
	if Config.ReturnVehicleAfterRS then
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
			['@stored'] = false
		}, function(rowsChanged)
			if rowsChanged > 0 then
				print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
			end
		end)
	end
end)

--[[ RegisterCommand("download", function(source, args, rawCommand)
	if source == 0 then 
		print("Downloading ...")
		for k, v in pairs(Config.ImgSrc) do 
			print("Downloading: ^1"..k.."^0")
			Wait(math.random(1500, 2000))
			PerformHttpRequest(v, function(err, text, headers)
				print(err, text, headers)
				local f = assert(io.open('vehicle_images/'..k..'.png', 'wb'))
				f:write(text)
				f:close()
				print("DONE "..k)
			end, "GET")
		end
	end
end) ]]

RegisterNetEvent("lr_garage:server:removeOldVehicle")
AddEventHandler("lr_garage:server:removeOldVehicle", function(plate)
	plate = ESX.Math.Trim(plate)
	local vehicles = GetAllVehicles()
	for k, v in pairs(vehicles) do
		local p = ESX.Math.Trim(GetVehicleNumberPlateText(v))
		if plate == p then 
			DeleteEntity(v)
		end
	end
end)

--[[ Citizen.CreateThread(function()
	while true do 
		Wait(60000 * 30)
		TriggerClientEvent("esx:showNotification", -1, "Phương tiện không có người sẽ bị xóa sau 1 phút")
		Wait(60000)
		local objects = GetAllObjects()
		local peds = GetAllPeds()
		local vehicles = GetAllVehicles()
		for k, v in pairs(objects) do 
			DeleteEntity(v)
		end
		for k, v in pairs(peds) do 
			DeleteEntity(v)
		end
		for k, v in pairs(vehicles) do 
			local hasStart = GetIsVehicleEngineRunning(v)
			if not hasStart then 
				DeleteEntity(v)
			end
		end
	end
end)]]
-- RegisterCommand("clearserver", function(source, args, rawCommand)
-- 	if source == 0 then 
-- 		TriggerClientEvent("esx:showNotification", -1, "Phương tiện không có người sẽ bị xóa sau 1 phút")
-- 		Wait(60000)
-- 		local objects = GetAllObjects()
-- 		local peds = GetAllPeds()
-- 		local vehicles = GetAllVehicles()
-- 		for k, v in pairs(objects) do 
-- 			DeleteEntity(v)
-- 		end
-- 		for k, v in pairs(peds) do 
-- 			DeleteEntity(v)
-- 		end
-- 		for k, v in pairs(vehicles) do 
-- 			local hasStart = GetIsVehicleEngineRunning(v)
-- 			if not hasStart then 
-- 				DeleteEntity(v)
-- 			end
-- 		end
-- 	end
-- end, true)