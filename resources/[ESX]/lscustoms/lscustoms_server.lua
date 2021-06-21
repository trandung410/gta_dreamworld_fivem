--[[
Los Santos Customs V1.1 
Credits - MythicalBro
/////License/////
Do not reupload/re release any part of this script without my permission
]]
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local tbl = {
[1] = {locked = false, player = nil},
[2] = {locked = false, player = nil},
[3] = {locked = false, player = nil},
[4] = {locked = false, player = nil},
[5] = {locked = false, player = nil},
[6] = {locked = false, player = nil},
}

RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false 
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
	local xPlayer = ESX.GetPlayerFromId(source)
	if button.price then 
		if button.price <= xPlayer.getMoney() then
			xPlayer.removeMoney(button.price)
			TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
		else
			TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
		end
	end
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(vehicleProps)
	MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
		['@vehicle'] = json.encode(vehicleProps),
		['@plate']  = vehicleProps.plate
	}, function (rowsChanged)
		if rowsChanged == 0 then
			print(('esx_advancedgarage: %s attempted to store an vehicle they don\'t own!'):format(GetPlayerIdentifiers(source)[1]))
		end
	end)
end)

ESX.RegisterServerCallback("lscustom:callback:fixVehicle", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 5000 then 
		xPlayer.removeMoney(5000)
		cb(true)
	elseif xPlayer.getAccount("bank").money >= 5000 then 
		xPlayer.removeAccountMoney("bank", 5000)
		cb(true)
	else
		cb(false)
	end
end)