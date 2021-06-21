ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local inVehicle = false

Citizen.CreateThread(function()
    local player = PlayerPedId()
    while(true) do
	   Citizen.Wait(1000)
        if inVehicle then
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleClass = GetVehicleClass(vehicle)
            local driver = GetPedInVehicleSeat(vehicle, -1)
            if (vehicleClass == 18 and driver == player) then
                local job = ESX.PlayerData.job.name
                ESX.PlayerData = ESX.GetPlayerData()
                if (job ~= 'police' and job ~= 'ambulance' and job~= 'mechanic') then
                    ESX.ShowNotification("~r~ Bạn không thể đi xe nhà nước.")
                    TaskLeaveVehicle(player, vehicle, 0)
                    Citizen.Wait(5000)
                end
            end
        end
        Citizen.Wait(500)
    end
end)


Citizen.CreateThread(function()
    local player = PlayerPedId()
    while(true) do
        inVehicle = IsPedInAnyVehicle(player, true)
        Citizen.Wait(500)
    end
end)
