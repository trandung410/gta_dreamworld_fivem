local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)

RegisterCommand("tpm", function(source)
    TeleportToWaypoint()
end)

TeleportToWaypoint = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank == 'admin' or playerRank == 'superadmin' then
            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end

                ESX.ShowNotification("Bạn đã teleport")
            else
                ESX.ShowNotification("Vui lòng chọn điểm đến")
            end
        else
            ESX.ShowNotification("Bạn không có quyền làm điều này")
        end
    end)
end

AddEventHandler("gameEventTriggered", function(name, args)
	-- exports['mythic_notify']:DoLongHudText('error',name)
   if name == "CEventNetworkVehicleUndrivable" then
  -- --exports['mythic_notify']:DoLongHudText('error','Đã hoạt động')
     local entity, destoyer, weapon = table.unpack(args)
	-- local serverid = dump(args)
	-- exports['mythic_notify']:DoLongHudText('error',entity.." "..serverid.." "..weapon)
	 SetEntityAsMissionEntity(entity, false, false)
	 DeleteEntity(entity)
     print( entity, destoyer, weapon)
    -- -- etc
   end
 end)