--[[
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]]
config = {}
config.ESX = "esx:getSharedObject"

function addVehicle(vehicleName)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local heading = GetEntityHeading(playerPed)
	ESX.Game.SpawnVehicle(vehicleName, coords, heading, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		local newPlate     = exports['esx_vehicleshop']:GeneratePlate()
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		SetVehicleNumberPlateText(vehicle, newPlate)
		TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
		--TriggerServerEvent('Lorraxs:vongquay', GetPlayerName(PlayerId()).." "..tenphanthuong[stt])
		--ESX.ShowNotification('đã nhận được một chiếc xe từ vòng quay may mắn')
    end)
end

function addskin(id, skinName)
	local xPlayer = ESX.GetPlayerFromId(id)
	local identifier = xPlayer.getIdentifier()
	MySQL.Sync.execute("INSERT INTO vipskin (identifier, name) VALUE (@identifier, @name)", {['@identifier'] = identifier, ['@name'] = skinName})
	TriggerClientEvent('esx:showNotification', id, 'Bạn đã nhận được một skin')
	TriggerClientEvent("vipskin:update", id)
end