local Boxes = {}
local boxObjects = {}

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('dzp_treasure:getBoxes')
end)

RegisterNetEvent('dzp_treasures:setBoxes')
AddEventHandler('dzp_treasures:setBoxes', function(boxes)
    for i = 1, #boxObjects do
        DeleteObject(boxObjects[i])
    end
    Citizen.Wait(100)
    Boxes = {}
    boxObjects = {}
    while ESX == nil do
        Citizen.Wait(100)
    end
    Boxes = boxes
    for boxId, box in pairs(Boxes) do
        boxCoords = vector3(box.coords.x, box.coords.y, box.coords.z-1)
        local hash = 0
        if box.contents.car == nil then
            hash = 90805875
        else
            hash = box.contents.car
        end
        ESX.Game.SpawnObject(hash, boxCoords, function(box)
            table.insert(boxObjects, 1, box)
            FreezeEntityPosition(box, true)
            SetEntityAsMissionEntity(object, true, false)
            SetEntityCollision(box, true, true)
        end, false)
    end
end)

RegisterNetEvent('dzp_treasures:tpToBox')
AddEventHandler('dzp_treasures:tpToBox', function(coords)
    local ped = PlayerPedId()
    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
end)

Citizen.CreateThread(function()
    Citizen.Wait(200)
    while true do
        local ped = GetPlayerPed(-1)
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(ped)
        for boxId, box in pairs(Boxes) do
            local boxCoords = vector3(box.coords.x, box.coords.y, box.coords.z)
            local dist = #(playerCoords - boxCoords)
            if dist < 100.0 then
                if dist < 2.5 then
                    local hash = 0
                    if box.contents.car == nil then
                        hash = 90805875
                        ESX.ShowHelpNotification('~i~~o~Bạn Đã tìm Thấy Kho báu. ~o~Nhấn~g~[E] ~o~Để mở !')
                    else
                        hash = box.contents.car
                        ESX.ShowHelpNotification('~o~Bạn Đã tìm Thấy xe Event. ~o~Nhưng hãy Nhấn ~g~[E] ~o~Khi Đã có chìa khóa!')
                    end
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent('dzp_treasure:lootTreasureBox', boxId, exports['esx_vehicleshop']:GeneratePlate())
                        local box = GetClosestObjectOfType(boxCoords, 1.5, hash, false, false, false)
                        DeleteObject(box)
                    end
                end
            end
        end
    end
end)
