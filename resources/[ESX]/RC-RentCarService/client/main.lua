ESX              = nil
local PlayerData = {}
local allCarsSpawned = false
local setTimerStarte = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)





Citizen.CreateThread(function()
local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)
local slot1Used = false

while true do
	Citizen.Wait(4)

	DrawMarker(2, Config.Marker.x, Config.Marker.y, Config.Marker.z,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 110, 0, 1, 0, 1)
	

end


end)

RegisterNetEvent("rc-rentCar:spawnCar")
AddEventHandler("rc-rentCar:spawnCar", function(currentVehicle, playerHasBoughtVeh)
	playerPed = PlayerPedId()
	print(currentVehicle)
	print(playerHasBoughtVeh)

	ESX.Game.SpawnVehicle(currentVehicle, Config.CarSpawnLocation.slot1, 100, function(vehicle) 
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleColours(vehicle, 112, 112)
		ESX.ShowHelpNotification("Xe sẽ hết hạn sau 30 phút nữa")
		if playerHasBoughtVeh == true then
			setTimerStarte = true
			Citizen.SetTimeout(Config.RentTime, function()
				ESX.Game.DeleteVehicle(vehicle)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
				local playerHasBoughtVehNew = false
				TriggerServerEvent("change:Status", playerHasBoughtVehNew)
			end)

			Citizen.SetTimeout(Config.WarningRentTime1, function()
				ESX.ShowHelpNotification("Xe sẽ hết hạn sau 15 phút nữa")
			end)

			Citizen.SetTimeout(Config.WarningRentTime2, function()
				ESX.ShowHelpNotification("Xe sẽ hết hạn sau 1 phút nữa")
			end)

			
	
		end

		
	end)

end)

