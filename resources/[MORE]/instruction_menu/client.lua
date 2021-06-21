ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local TutorialOpen = true
Citizen.CreateThread(function() 
	local sleep = 1000
	while true do
		Wait(sleep)
		if IsControlPressed(0, 19) then
			sleep = 5
			if IsControlJustPressed(0, 244) then
				TutorialOpen = not TutorialOpen
				SendNUIMessage({
					msg = 'toggleT',
					toggle = TutorialOpen
				})	
			end	
		end
	end
end)
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(1000)
		SendNUIMessage({action = "update", show = IsPauseMenuActive()})
		if TutorialOpen then
			SendNUIMessage({mgs = "toggleT", toggle = not IsPauseMenuActive()})	
		end
	end
end)
