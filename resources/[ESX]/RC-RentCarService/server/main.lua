ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("rc-rentCar:TriggerCarSpawn")
AddEventHandler("rc-rentCar:TriggerCarSpawn", function(currentVehicle,playerHasBoughtVeh, currentPrice)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)

    print(currentPrice)
    print(currentVehicle)
    print(playerHasBoughtVeh)

    if xPlayer.getMoney() < currentPrice then
        local playerHasBoughtVehNew = false
        TriggerClientEvent("rc-rentCar:noMoney", source)
        TriggerClientEvent("rc-rentCar:changeStautus", source,playerHasBoughtVehNew)
    else
        xPlayer.removeMoney(currentPrice)
        TriggerClientEvent("rc-rentCar:spawnCar", source, currentVehicle, playerHasBoughtVeh)
    end

    
end)

RegisterNetEvent("change:Status")
AddEventHandler("change:Status", function(playerHasBoughtVehNew)

    TriggerClientEvent("rc-rentCar:changeStautus", source,playerHasBoughtVehNew)

end)