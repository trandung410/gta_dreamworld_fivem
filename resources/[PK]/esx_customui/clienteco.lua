local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(1000)
		local hour = GetClockHours()
		local minutes = GetClockMinutes()
        SendNUIMessage({
			show = 		IsPauseMenuActive(),
			hora = 		hour.. ":" ..minutes,	
		})	
	end
end)