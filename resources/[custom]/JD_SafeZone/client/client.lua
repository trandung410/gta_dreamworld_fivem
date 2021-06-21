local notify = false
local hasRun = false

local function insidePolygon( point)
    local oddNodes = false
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
            if (Zone[i][2] < point.y and Zone[j][2] >= point.y or Zone[j][2] < point.y and Zone[i][2] >= point.y) then
                if (Zone[i][1] + ( point[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < point.x) then
                    oddNodes = not oddNodes;
                end
            end
            j = i;
        end
    end
    return oddNodes 
end

Citizen.CreateThread(function()
    while true do
        local iPed = GetPlayerPed(-1)
        Citizen.Wait(0)
        point = GetEntityCoords(iPed,true)
        local inZone = insidePolygon(point)
        if Config.ShowBorder then
            drawPoly(inZone)
        end
        if inZone then
            if Config.TopLeftInfoBox then
                DisplayHelpText("~BLIP_INFO_ICON~ You are in a ~g~SafeZone")
            end
            NetworkSetFriendlyFireOption(false)
            DisablePlayerFiring(iPed, true)      
            SetCurrentPedWeapon(_source,GetHashKey("WEAPON_UNARMED"),true)
            if IsPedInAnyVehicle(iPed, false) then
                veh = GetVehiclePedIsUsing(iPed)
                SetEntityCanBeDamaged(veh, false)
                if Config.MaxVehicleSpeed then
                    SetVehicleMaxSpeed(veh, Config.MaxVehicleSpeed)
                end
            end
            SetEntityInvincible(iPed, true)
			SetPedCanRagdoll(iPed, false)
			ClearPedBloodDamage(iPed)
			ResetPedVisibleDamage(iPed)
            ClearPedLastWeaponDamage(iPed)
            for _, players in ipairs(GetActivePlayers()) do
                if IsPedInAnyVehicle(GetPlayerPed(players), true) then
                    veh = GetVehiclePedIsUsing(GetPlayerPed(players))
                    SetEntityNoCollisionEntity(iPed, veh, true)
                end
            end
            hasRun = false
        else
            if not hasRun then
                hasRun = true
                SetEntityInvincible(iPed, false)
                SetPedCanRagdoll(iPed, true)
                NetworkSetFriendlyFireOption(true)
                if IsPedInAnyVehicle(iPed, false) then
                    veh = GetVehiclePedIsUsing(iPed)
                    SetEntityCanBeDamaged(veh, true)
                    if Config.MaxVehicleSpeed then
                        SetVehicleMaxSpeed(veh, 1000.00)
                    end
                end
                if IsPedInAnyVehicle(GetPlayerPed(players), true) then
                    veh = GetVehiclePedIsUsing(GetPlayerPed(players))
                    SetEntityNoCollisionEntity(iPed, veh, false)
                end
            end
        end
    end 
end)

function DisplayHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end


function drawPoly(isEntityZone)
    local iPed = GetPlayerPed(-1)
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
                
            local zone = Zone[i]
            if i < #Zone then
                local p2 = Zone[i+1]
                _drawWall(zone, p2)
            end
        end
    
        if #Zone > 2 then
            local firstPoint = Zone[1]
            local lastPoint = Zone[#Zone]
            _drawWall(firstPoint, lastPoint)
        end
    end
end


  function _drawWall(p1, p2)
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 1.5)
    local topLeft = vector3(p1[1], p1[2],  p1[3] + Config.BorderHight)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 1.5)
    local topRight = vector3(p2[1], p2[2], p2[3] + Config.BorderHight)
    
    DrawPoly(bottomLeft,topLeft,bottomRight,0,255,0,48)
    DrawPoly(topLeft,topRight,bottomRight,0,255,0,48)
    DrawPoly(bottomRight,topRight,topLeft,0,255,0,48)
    DrawPoly(bottomRight,topLeft,bottomLeft,0,255,0,48)
  end