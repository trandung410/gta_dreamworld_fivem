ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(0)
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end)

RegisterNetEvent("ic_item:client:armour")
AddEventHandler("ic_item:client:armour", function(armourType, armourLabel)
    TriggerEvent("mythic_progbar:client:progress",{
        name = "Open_Trunk",
        duration = Config.ArmourTime[armourType],
        label = "Đang mặc "..armourLabel,
        useWhileDead = false,
        canCancel = true,
        animation = {
            animDict = "clothingshirt",
            anim = "try_shirt_positive_d",
        },
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }
    },
    function(status)
        ClearPedTasks(PlayerPedId())
        if not status then
            SetPedComponentVariation(PlayerPedId(), 9, 27, Config.ArmourVest[armourType], 0)
            SetPedArmour(PlayerPedId(), Config.ArmourValue[armourType])
        end
    end)
end)