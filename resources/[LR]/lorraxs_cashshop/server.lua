
ESX = nil 
TriggerEvent(config.ESX, function(obj) ESX = obj end)
local Cashshop_Items = {}
function LoadDataBase()
	MySQL.Async.fetchAll('SELECT * FROM `cashshop`', {}, function(result)
		Cashshop_Items = result
	end)
end

MySQL.ready(function ()
	LoadDataBase()
end)
-- MySQL.ready(function ()
-- 	MySQL.Async.fetchAll('SELECT * FROM `cashshop`', {}, function(result)
-- 		Cashshop_Items = result
-- 	end)
-- end)

ESX.RegisterServerCallback("cashshop:server:getItems", function(source, cb)
	cb(Cashshop_Items)
end)

RegisterCommand('LoadCashshop', function(source, args, arr)
	LoadDataBase()
end)

function GetPlayerCash(playerId, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	MySQL.Async.fetchScalar('SELECT cash FROM `users` WHERE identifier=@identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		print(json.encode(result))
		if result then
			cb(result)
		else
			cb(nil)
		end
	end)
end

function RemovePlayerCash(playerId, amount, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	GetPlayerCash(playerId, function(result)
		local cash = tonumber(result)
		if cash >= amount and amount > 0 then
			MySQL.Async.execute('UPDATE users SET cash = cash - @amount WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@amount'] = tonumber(amount)
			}, function(rowsChanged)
				if rowsChanged > 0 then 
					cb(true)
					TriggerClientEvent("cashshop:client:updateCash", xPlayer.source, cash-amount)
				else
					cb(false)
				end
			end)
		else
			cb(false)
		end
	end)
end

function AddPlayerCash(playerId, amount, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	GetPlayerCash(playerId, function(result)
		local cash = tonumber(result)
		if amount > 0 then
			MySQL.Async.execute('UPDATE users SET cash = cash + @amount WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@amount'] = tonumber(amount)
			}, function(rowsChanged)
				if rowsChanged > 0 then 
					cb(true)
					TriggerClientEvent("cashshop:client:updateCash", xPlayer.source, cash+amount)

				else
					cb(false)
				end
			end)
		else
			cb(false)
		end
	end)
end

AddEventHandler('cashshop:server:getPlayerCash', function(playerId, cb)
	local _playerId = playerId
	GetPlayerCash(_playerId, function(result)
		cb(result)
	end)
end)
AddEventHandler('cashshop:server:removePlayerCash', function(playerId, amount, cb)
	local _playerId = playerId
	local _amount = amount
	RemovePlayerCash(_playerId, _amount, function(result)
		cb(result)
	end)
end)
AddEventHandler('cashshop:server:addPlayerCash', function(playerId, amount, cb)
	local _playerId = playerId
	local _amount = amount
	AddPlayerCash(_playerId, _amount, function(result)
		cb(result)
	end)
end)

function CheckItem(itemName, type, cb)
	MySQL.Async.fetchScalar("SELECT price FROM cashshop WHERE name = @name AND `type` = @type", {
		['@name'] = itemName,
		['@type'] = type
	}, function(result)
		cb(result)
	end)
end
-------------------PLATEGENERATE--------------------------------
local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function GeneratePlate()
	local generatedPlate
	local doBreak = false 
	--Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(2)
			math.randomseed(os.time())
			generatedPlate = string.upper(GetRandomLetter(3) .. " " .. GetRandomNumber(3))
			MySQL.Async.fetchScalar("SELECT plate FROM owned_vehicles WHERE plate = @plate", {
				['@plate'] = generatedPlate
			}, function(result)
				if result == nil then 
					doBreak = true
				end
			end)
			if doBreak then break end
		end
	--end)
	return generatedPlate
end

RegisterServerEvent('cashshop:server:buyItem')
AddEventHandler('cashshop:server:buyItem', function(data)
	local _source = source
	local type = data.type
	local itemName = data.name
	local amount = math.floor(tonumber(data.amount))
	local price = tonumber(data.price)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xCoin = xPlayer.getAccount('vcoin').money
	print(amount)
	if amount > 0 and amount < 10000 then
		CheckItem(itemName, type, function(result)
			if result ~= nil and tonumber(result) == price and xCoin >= amount*price then
				if type == 'vehicle' then
					local plate = GeneratePlate()
					MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
						['@owner'] = xPlayer.identifier,
						['@plate'] = plate,
						['@vehicle'] = json.encode({model = GetHashKey(itemName), plate = plate})
					}, function(rowChanged)
						TriggerClientEvent('esx:showNotification', _source, ("Phương tiện với biển số %s đã thuộc về bạn"):format(plate))
						TriggerClientEvent('cashshop:client:spawnVehicle', _source, itemName, plate)
						xPlayer.removeAccountMoney('vcoin', amount*price)
					end)
					--[[ RemovePlayerCash(_source, amount*price, function(hasMoney)
						if hasMoney == true then
							MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
								['@owner'] = xPlayer.identifier,
								['@plate'] = plate,
								['@vehicle'] = json.encode({model = GetHashKey(itemName), plate = plate})
							}, function(rowChanged)
								TriggerClientEvent('esx:showNotification', _source, ("Phương tiện với biển số %s đã thuộc về bạn"):format(plate))
								TriggerClientEvent('cashshop:client:spawnVehicle', _source, itemName, plate)
							end)
						end
					end) ]]
				elseif type == 'item' then 
					xPlayer.addInventoryItem(itemName, amount)
					xPlayer.removeAccountMoney('vcoin', amount*price)
					--[[ RemovePlayerCash(_source, amount*price, function(hasMoney)
						if hasMoney == true then 
							xPlayer.addInventoryItem(itemName, amount)
						end
					end) ]]
				elseif type == 'skin' then 
					addskin(_source, itemName)
					xPlayer.removeAccountMoney('vcoin', amount*price)
					--[[ RemovePlayerCash(_source, amount*price, function(hasMoney)
						if hasMoney == true then
							AddSkin(_source, itemName)
						end
					end) ]]
				elseif type == 'weapon' then
					xPlayer.addWeapon(itemName, 500)
					xPlayer.removeAccountMoney('vcoin', amount*price)
					MySQL.Sync.execute("INSERT INTO owned_weapon (identifier, name) VALUES (@identifier, @name)", {['@identifier'] = xPlayer.identifier, ['@name'] = itemName})
					TriggerClientEvent('weaponcheck:update', source)
					--[[ RemovePlayerCash(_source, amount*price, function(hasMoney)
						if hasMoney == true then
							xPlayer.addWeapon(itemName, 500)
						end
					end) ]]
				end
			end
		end)
	else
		print("asdasdasd")
	end
end)

function addskin(id, skinName)
	local xPlayer = ESX.GetPlayerFromId(id)
	local identifier = xPlayer.identifier
	MySQL.Sync.execute("INSERT INTO vipskin (identifier, name) VALUE (@identifier, @name)", {['@identifier'] = identifier, ['@name'] = skinName})
	TriggerClientEvent('esx:showNotification', id, 'Bạn đã nhận được một skin')
	TriggerClientEvent("vipskin:update", id)
end

ESX.RegisterServerCallback("cashshop:server:getCurrentCash", function(source, cb)
	GetPlayerCash(source, function(result)
		cb(result)
	end)
end)



RegisterCommand('test', function(source ,args, rawCommand)
	if source ==0 then 
		print(GeneratePlate())
	end
end)