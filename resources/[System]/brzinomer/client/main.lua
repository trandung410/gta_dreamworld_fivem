local ESX	 = nil

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	SendNUIMessage({ action = 'toggleUi', value = true })
end)

local status = false
local showMovie = false
local map = false
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(250)
		local ped = GetPlayerPed(-1)		
		SendNUIMessage({
            action = 'player',
            health = (GetEntityHealth(ped)-100),
						armor = GetPedArmour(ped),
						movie = showMovie
				})
			if IsPedInAnyVehicle(ped, false) then 
					map = true 
			else 
					map = true    ---- true if you want have map outside
			end
		end
end)

RegisterCommand("movie",function(source,args)
	showMovie = not showMovie
end)

 Citizen.CreateThread(function()
	 while true do
		 Citizen.Wait(250)
		 SendNUIMessage({action = 'pause', status = status})
		 DisplayRadar(map)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		HideHudComponentThisFrame( 7 ) -- Area Name
		HideHudComponentThisFrame( 9 ) -- Street Name
		HideHudComponentThisFrame( 3 ) -- SP Cash display 
		HideHudComponentThisFrame( 4 )  -- MP Cash display
		HideHudComponentThisFrame( 13 ) -- Cash changes
		HideHudComponentThisFrame( 6 ) -- Vehicle name
		HideHudComponentThisFrame( 8 ) -- Vehicle class
	end
end)