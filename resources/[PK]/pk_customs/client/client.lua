ESX               = nil 
disableallweapons = false

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(1000)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
	Citizen.Wait(60000)   
	SetEntityHealth(GetPlayerPed(-1), 200)
	for i = 1, 15, 1 do
		EnableDispatchService(i, false)
	end

end)
 
-- RegisterNetEvent('esx:setJob') 
-- AddEventHandler('esx:setJob', function(job) 
-- 	PlayerData.job = job 
-- end) 
