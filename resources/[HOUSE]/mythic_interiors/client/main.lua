function DespawnInterior(objects, cb)
    for k, v in pairs(objects) do
        if DoesEntityExist(v) then
            SetEntityAsMissionEntity(v,true,true)
            DeleteEntity(v)
        end
    end
end

function TeleportToInterior(x, y, z, h)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(0); end

    local ped = GetPlayerPed(-1)
    SetEntityCoords(ped, x, y, z, 0, 0, 0, false)
    SetEntityHeading(ped, h)

    local start = GetGameTimer()
    FreezeEntityPosition(PlayerPedId(),true)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) and GetGameTimer() - start < 5000 do Wait(0); end
    FreezeEntityPosition(PlayerPedId(),false)

    DoScreenFadeIn(1000)
    Wait(1000)
end

function GetRotation(input)
    return 360 / (10 * input)
end