--[[
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]]
-- Local
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local cash = 0
PlayerData = {}
ESX = nil 
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		SetNuiFocus(false, false)
	end
end)
Citizen.CreateThread(function()
	while ESX == nil do 
		Citizen.Wait(0)
		TriggerEvent(config.ESX, function(obj) ESX = obj end)
	end
	while not ESX.IsPlayerLoaded() do Wait(1) end
	PlayerData = ESX.GetPlayerData()
	for k, v in pairs(PlayerData.accounts) do 
		if v.name == 'vcoin' then 
			cash = v.money
		end
	end
end)

RegisterNetEvent("esx:setAccountMoney")
AddEventHandler("esx:setAccountMoney", function(account)
	if account.name == 'vcoin' then 
		cash = account.money
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if IsControlJustPressed(0, 243) then
			ESX.TriggerServerCallback('cashshop:server:getItems', function(result)
				SetNuiFocus(true, true)
				local dumped = ESX.DumpTable(result)
				print(dumped)
				SendNUIMessage({
					type = 'shop',
					result = result,
					cash = cash,
				})
			end)
		end
	end
end)

-- RegisterCommand('cashshop', function()
-- 	ESX.TriggerServerCallback('cashshop:server:getItems', function(result)
-- 		SetNuiFocus(true, true)
-- 		local dumped = ESX.DumpTable(result)
-- 		print(dumped)
-- 		SendNUIMessage({
-- 			type = 'shop',
-- 			result = result,
-- 			cash = cash,
-- 		})
-- 	end)
-- end)

AddEventHandler("cashshop:client:open", function()
	ESX.TriggerServerCallback('cashshop:server:getItems', function(result)
		SetNuiFocus(true, true)
		local dumped = ESX.DumpTable(result)
		print(dumped)
		SendNUIMessage({
			type = 'shop',
			result = result,
			cash = cash,
		})
	end)
end)

RegisterNUICallback('escape', function(data, cb)
	 
	SetNuiFocus(false, false)

	SendNUIMessage({
		type = "close",
	})
end)
RegisterNUICallback('notify', function(data, cb)
	ESX.ShowNotification(data.msg)
end)
RegisterNUICallback('buy', function(data, cb)	
	TriggerServerEvent('cashshop:server:buyItem', data)
end)
RegisterNUICallback('refresh', function(data, cb)
	ESX.TriggerServerCallback('cashshop:server:getItems', function(result)
		SetNuiFocus(true, true)
		local dumped = ESX.DumpTable(result)
		print(dumped)
		SendNUIMessage({
			type = 'shop',
			result = result,
			cash = cash,
		})
	end)
end)

RegisterNetEvent("cashshop:client:spawnVehicle")
AddEventHandler("cashshop:client:spawnVehicle", function(model, plate)
	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local heading = GetEntityHeading(playerPed)
	ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleNumberPlateText(vehicle, plate)
    end)
end)
RegisterCommand("tatcashshop", function()
    
    SetNuiFocus(false, false)
end)
