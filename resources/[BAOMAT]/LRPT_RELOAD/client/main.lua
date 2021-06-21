--[[ AddEventHandler("LRPT:client:heartbeat", function(cb)
    cb(true)
end)

LRPT = {}
LRPT.__index = LRPT

function LRPT:Start()
    local obj = {}
    setmetatable(obj, LRPT)
    obj.ped = PlayerPedId()
    obj.player = PlayerId()
    obj.serverId = GetPlayerServerId(PlayerId())
    obj.playersData = {}
    return obj
end

function LRPT:MainThread()
    Citizen.CreateThread(function()
        while true do 
            coroutine.yield(0)
            if Config.ScreenShot.active then 
                for i = 1, #Config.ScreenShot.keys, 1 do 
                    if IsControlJustReleased(0, Config.ScreenShot.keys[i]) then 
                        TriggerServerEvent("LRPT:server:screenshot", Config.ScreenShot.keys[i])
                    end
                end
            end
            if Config.ShowHP then 
                local aiming, targetEnt = GetEntityPlayerIsFreeAimingAt(self.player)
                if aiming and DoesEntityExist(targetEnt) then 
                    if IsPedAPlayer(targetEnt) then 
                        local targetCoords = GetEntityCoords(targetEnt)
                        local targetHealth = GetEntityHealth(targetEnt)
                        local targetArmour = GetPedArmour(targetEnt)
                        if self.playersData[targetEnt] == nil or self.playersData[targetEnt] < targetHealth then
                            self.playersData[targetEnt] = targetHealth
                        end
                        DrawText3D({x = targetCoords.x, y = targetCoords.y, z = targetCoords.z + 1.1}, 'Health: '..targetHealth..' Armour: '..targetArmour, 1.0)
                        if IsPedShooting(self.ped) then 
                            DrawH(targetEnt, targetHealth, targetArmour, targetCoords)
                        end
                    end
                end
            end
        end
    end)
end

rt = LRPT:Start()
rt:MainThread()

RegisterCommand("spawn", function()
    SpawnVehicle("cargoplane", GetEntityCoords(PlayerPedId()), 100.0)
end) ]]