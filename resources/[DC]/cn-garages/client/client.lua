local playerData, playerJob = {}, {}
local createdPeds, ownedVehicles = {}, {}
local loggedIn = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	playerData = ESX.GetPlayerData()
    playerJob = ESX.GetPlayerData().job
    loggedIn = true
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(jobInfo)
	playerJob = jobInfo
	playerData = ESX.GetPlayerData()
end)

RegisterNetEvent("cn-garages:client:activatedLicense")
AddEventHandler("cn-garages:client:activatedLicense", function(urlz)
	SendNUIMessage({
        createurl = true,
        url = urlz
    })
end)

RegisterNetEvent('cn-garages:client:syncConfig')
AddEventHandler('cn-garages:client:syncConfig', function(t, g, garage, typ, data)
    if t == 1 then
        CNGarages.Config = g

        CreateThread(function() 
            for k, v in pairs(CNGarages.Config) do
                for name, data in pairs(v) do
                    if DoesEntityExist(createdPeds[name]) then 
                        local ped = createdPeds[name]
                        SetPedKeepTask(ped, false)
                        TaskSetBlockingOfNonTemporaryEvents(ped, false)
                        ClearPedTasks(ped)
                        TaskWanderStandard(ped, 10.0, 10)
                        SetPedAsNoLongerNeeded(ped)
                        DeleteEntity(ped)
                        createdPeds[name] = nil
                    end
                end
            end
        end)
    elseif t == 2 then
        CNGarages.Config[g][garage][typ] = data
    elseif t == 3 then
        CNGarages.Config[g][garage] = typ
    end

    CNGarages.Functions.DeleteBlips()
    CNGarages.Functions.CreateBlips()
end)

-- main thread
CreateThread(function()
    Wait(3500)
    --ESX.TriggerServerCallback('cn-garages:server:getConfig', function(serverConfig, isAuthorized, lmfao)
        while not serverConfig do Wait(0) end
        if isAuthorized == true then
            CNGarages.Config = serverConfig
            TriggerEvent('cn-garages:client:activatedLicense', lmfao)
        else
            while true do Wait(0) print('Nice leaked product, CN Shop https://discord.gg/ySJ2B29skd') end
        end
    --end)
	
	loggedIn = true
    Wait(1500)
    playerCid = ESX.GetPlayerData().identifier
    CNGarages.Functions.CreateBlips()

    while true do
        if CNGarages.Config ~= nil then
            local playerPed = PlayerPedId()

            if CNGarages.Config ~= nil and loggedIn == true then
                for key, value in pairs(CNGarages.Config) do
                    if key == 'garages' or key == 'impounds' then
                        for name, data in pairs(value) do
                            if data['ped'] ~= nil then
                                local dst = #(GetEntityCoords(playerPed) - vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z))
                                if data['ped']['enable'] == true then
                                    -- ped
                                    if dst < 250.0 and data['ped']['created'] == false then
                                        data['ped']['created'] = true
                                        CreateThread(function() -- create ped
                                            local pedModel = data['ped']['type']
                                        
                                            RequestModel(pedModel)
                                            while not HasModelLoaded(pedModel) do
                                                RequestModel(pedModel)
                                                Wait(100)
                                            end
                                        
                                            local createdPed = CreatePed(5, pedModel, data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z - 1.0, data['ped']['heading'], false, false)
                                            ClearPedTasks(createdPed)
                                            ClearPedSecondaryTask(createdPed)
                                            TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
                                            SetPedFleeAttributes(createdPed, 0, 0)
                                            SetPedCombatAttributes(createdPed, 17, 1)
                                        
                                            SetPedSeeingRange(createdPed, 0.0)
                                            SetPedHearingRange(createdPed, 0.0)
                                            SetPedAlertness(createdPed, 0)
                                            SetPedKeepTask(createdPed, true)
                                        
                                            createdPeds[name] = createdPed
                                        
                                            --Wait(750) -- for better freeze (not in air)
                                            FreezeEntityPosition(createdPed, true)
                                            SetEntityInvincible(createdPed, true)
                                        end)
                                    elseif dst > 250.0 and data['ped']['created'] == true then
                                        data['ped']['created'] = false
                                        CreateThread(function() -- delete ped
                                            if DoesEntityExist(createdPeds[name]) then 
                                                local ped = createdPeds[name]
                                                SetPedKeepTask(ped, false)
                                                TaskSetBlockingOfNonTemporaryEvents(ped, false)
                                                ClearPedTasks(ped)
                                                TaskWanderStandard(ped, 10.0, 10)
                                                SetPedAsNoLongerNeeded(ped)
                                                DeleteEntity(ped)
                                                createdPeds[name] = nil
                                            end
                                        end)
                                    end
                                
                                    -- text
                                    if data['ped']['created'] == true then              
                                        if not IsPedInAnyVehicle(playerPed, false) then
                                            if dst < 3.0 then
                                                CNGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, CNGarages.Config['settings']['interactions']['to_interact'])
                                                if IsControlJustPressed(0, 38) then
                                                    CNGarages.Functions.TriggerNUI(false, name, data, key)
                                                end
                                            elseif dst < 7.0 then
                                                CNGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, CNGarages.Config['settings']['interactions']['interact'])
                                            end
                                        else
                                            if dst < 5.0 then
                                                CNGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, CNGarages.Config['settings']['interactions']['to_interact'])
                                                if IsControlJustPressed(0, 38) then
                                                    CNGarages.Functions.TriggerNUI(true, name, data, key)
                                                end
                                            elseif dst < 7.0 then
                                                CNGarages.Functions.DrawText3D({x = data['ped']['coords'].x, y = data['ped']['coords'].y, z = data['ped']['coords'].z + 0.9}, CNGarages.Config['settings']['interactions']['interact'])
                                            end
                                        end
                                    end
                                else
                                    -- text
                                    if not IsPedInAnyVehicle(playerPed, false) then
                                        if dst < 3.0 then
                                            CNGarages.Functions.DrawText3D(data['ped']['coords'], CNGarages.Config['settings']['interactions']['to_interact'])
                                            if IsControlJustPressed(0, 38) then
                                                CNGarages.Functions.TriggerNUI(false, name, data, key)
                                            end
                                        elseif dst < 7.0 then
                                            CNGarages.Functions.DrawText3D(data['ped']['coords'], CNGarages.Config['settings']['interactions']['interact'])
                                        end
                                    else
                                        if dst < 5.0 then
                                            CNGarages.Functions.DrawText3D(data['ped']['coords'], CNGarages.Config['settings']['interactions']['to_interact'])
                                            if IsControlJustPressed(0, 38) then
                                                CNGarages.Functions.TriggerNUI(true, name, data, key)
                                            end
                                        elseif dst < 7.0 then
                                            CNGarages.Functions.DrawText3D(data['ped']['coords'], CNGarages.Config['settings']['interactions']['interact'])
                                        end
                                    end
                                end
                            
                                SetAllVehicleGeneratorsActiveInArea(vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z) - 100.0, vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z) + 100.0, false, false)
                            end
                        end
                        
                    elseif key == 'houses' then
                        for name, data in pairs(value) do
                            if CNGarages.Functions.HasHouseAccess(name) == true then
                                local dst = #(GetEntityCoords(playerPed) - vector3(data['coords'].x, data['coords'].y, data['coords'].z))

                                if not IsPedInAnyVehicle(playerPed, false) then
                                    if dst < 3.0 then
                                        CNGarages.Functions.DrawText3D(data['coords'], CNGarages.Config['settings']['interactions']['to_interact'])
                                        if IsControlJustPressed(0, 38) then
                                            CNGarages.Functions.TriggerNUI(false, name, data, key)
                                        end
                                    elseif dst < 7.0 then
                                        CNGarages.Functions.DrawText3D(data['coords'], CNGarages.Config['settings']['interactions']['interact'])
                                    end
                                else
                                    if dst < 5.0 then
                                        CNGarages.Functions.DrawText3D(data['coords'], CNGarages.Config['settings']['interactions']['to_interact'])
                                        if IsControlJustPressed(0, 38) then
                                            CNGarages.Functions.TriggerNUI(true, name, data, key)
                                        end
                                    elseif dst < 7.0 then
                                        CNGarages.Functions.DrawText3D(data['coords'], CNGarages.Config['settings']['interactions']['interact'])
                                    end
                                end

                                SetAllVehicleGeneratorsActiveInArea(vector3(data['coords'].x, data['coords'].y, data['coords'].z) - 100.0, vector3(data['coords'].x, data['coords'].y, data['coords'].z) + 100.0, false, false)
                            end
                        end
                    end
                end
            end
        end

        for key, vehicle in pairs(ownedVehicles) do
            if DoesEntityExist(vehicle[2]) == false then
                TriggerServerEvent('cn-garages:server:impoundVehicle', vehicle[1])
                table.remove(ownedVehicles, key)
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent('cn-garages:client:createParkingVehicle')
AddEventHandler('cn-garages:client:createParkingVehicle', function(all, slotz)
    while not CNGarages.Config['garages'] do Wait(0) end
    if all == true then
        for garage, data in pairs(CNGarages.Config['garages']) do
            if data['slots'] ~= nil then
                for key, slot in pairs(data['slots']) do
                    if slot[3] ~= nil then
                        CNGarages.SpawnVehicle(slot[3].model, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, slot[3].props)
                            SetEntityAsMissionEntity(vehicle, true, true)
			                SetEntityInvincible(vehicle, true)
			                FreezeEntityPosition(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityHeading(vehicle, slot[1].h)
                            Wait(10)
                            SetVehicleOnGroundProperly(vehicle)
                        end, slot[1], true)
                    end
                end
            end
        end

        for garage, data in pairs(CNGarages.Config['houses']) do
            if data['slots'] ~= nil then
                for key, slot in pairs(data['slots']) do
                    if slot[3] ~= nil then
                        CNGarages.SpawnVehicle(slot[3].model, function(vehicle)
                            ESX.Game.SetVehicleProperties(vehicle, slot[3].props)
                            SetEntityAsMissionEntity(vehicle, true, true)
			                SetEntityInvincible(vehicle, true)
			                FreezeEntityPosition(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityHeading(vehicle, slot[1].h)
                            Wait(10)
                            SetVehicleOnGroundProperly(vehicle)
                        end, slot[1], true)
                    end
                end
            end
        end
    else
        CNGarages.SpawnVehicle(slotz[3].model, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, slotz[3].props)
            SetEntityAsMissionEntity(vehicle, true, true)
            SetEntityInvincible(vehicle, true)
            FreezeEntityPosition(vehicle, true)
            SetVehicleDoorsLocked(vehicle, 2)
            SetEntityHeading(vehicle, slotz[1].h)
            Wait(10)
            SetVehicleOnGroundProperly(vehicle)
        end, slotz[1], true)
    end
end)

RegisterNetEvent('cn-garages:client:releaseVehicle')
AddEventHandler('cn-garages:client:releaseVehicle', function(data, typ, name)
    local playerPed = PlayerPedId()
    local nearbyVehicles = ESX.Game.GetVehicles()
    local released = false

    if typ ~= 'impounds' then
        for k, v in pairs(nearbyVehicles) do
            local parking = json.decode(data.parking)
            if DoesEntityExist(v) then
                if GetVehicleNumberPlateText(v) == data.plate then
                    NetworkRequestControlOfEntity(v)
                    FreezeEntityPosition(v, false)
					SetEntityInvincible(v, false)
                    table.insert(ownedVehicles, {GetVehicleNumberPlateText(v), v})
                    released = true
                    
                    local stats = json.decode(data.stats)
                    if stats.fuel ~= nil then
                        SetVehicleFuelLevel(v, stats.fuel)
                        SetVehicleEngineHealth(v, stats.engine_damage)
                        SetVehicleBodyHealth(v, stats.body_damage)
                        SetVehicleDirtLevel(v, stats.dirty)
                    end

                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, v)
					TriggerEvent('DoLongHudText', "Successfully released your vehicle [Slot " .. parking[1] .. ']', 1)

                    while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if GetVehicleNumberPlateText(vehicle) == data.plate then
                        TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                    end
                    return
                end
            end
        end

        if not released then
            local parking = json.decode(data.parking)

            if CNGarages.Functions.IsSpawnClear(CNGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1], 2.0) then
                CNGarages.SpawnVehicle(data.model, function(vehicle)
                    local props = json.decode(data.props)
                    if props['color1'] ~= nil then
                       ESX.Game.SetVehicleProperties(vehicle, props)
                    end

                    SetVehicleNumberPlateText(vehicle, data.plate)
                    SetEntityHeading(vehicle, CNGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1].h)
                    table.insert(ownedVehicles, {GetVehicleNumberPlateText(vehicle), vehicle})

                    local stats = json.decode(data.stats)
                    if stats.fuel ~= nil then
                        SetVehicleFuelLevel(vehicle, stats.fuel)
                        SetVehicleEngineHealth(vehicle, stats.engine_damage)
                        SetVehicleBodyHealth(vehicle, stats.body_damage)
                        SetVehicleDirtLevel(vehicle, stats.dirty)
                    end
                    table.insert(ownedVehicles, {GetVehicleNumberPlateText(vehicle), vehicle})
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                end, CNGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1], true)
                
				TriggerEvent('DoLongHudText', "Successfully released your vehicle [Slot " .. parking[1] .. ']', 1)

                while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if GetVehicleNumberPlateText(vehicle) == data.plate then
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                end
                return
            else
				TriggerEvent('DoLongHudText', "Someone is parking on your slot! [Slot " .. parking[1] .. ' Isn\'t Free]', 2)
            end
        end
    elseif typ == 'impounds' then
        CNGarages.SpawnVehicle(data.model, function(vehicle)
            local props = json.decode(data.props)
            if props['color1'] ~= nil then
               ESX.Game.SetVehicleProperties(vehicle, props)
            end

            SetVehicleNumberPlateText(vehicle, data.plate)
            SetEntityHeading(vehicle, CNGarages.Config['impounds'][name]['spawn'].h)
            table.insert(ownedVehicles, {GetVehicleNumberPlateText(vehicle), vehicle})
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
			TriggerEvent('DoLongHudText', "Successfully released your vehicle", 1)
        end, CNGarages.Config['impounds'][name]['spawn'], true)

        while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        print(GetVehicleNumberPlateText(vehicle))
        if GetVehicleNumberPlateText(vehicle) == data.plate then
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
        end
    elseif typ == 'house' then
        local parking = json.decode(data.parking)

        print(json.encode(CNGarages.Config['house'][parking[2]]['slots'][parking[1]][1]))
		CNGarages.SpawnVehicle(data.model, function(vehicle)
            local props = json.decode(data.props)
            if props['color1'] ~= nil then
               ESX.Game.SetVehicleProperties(vehicle, props)
            end

            SetVehicleNumberPlateText(vehicle, data.plate)
            SetEntityHeading(vehicle, CNGarages.Config['house'][parking[2]]['slots'][parking[1]][1].h)
            table.insert(ownedVehicles, {GetVehicleNumberPlateText(vehicle), vehicle})
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
			TriggerEvent('DoLongHudText', "Successfully released your vehicle", 1)
        end, CNGarages.Config['house'][parking[2]]['slots'][parking[1]][1], true)

        
        while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(0) end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        print(GetVehicleNumberPlateText(vehicle))
        if GetVehicleNumberPlateText(vehicle) == data.plate then
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
        end
    end
end)

RegisterNetEvent('cn-garages:client:fakeplate:steal')
AddEventHandler('cn-garages:client:fakeplate:steal', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local dst = #(vehicleCoords - pedCoords)
    local plate = GetVehicleNumberPlateText(vehicle)

    if dst <= 7.0 then
        if plate:gsub(" ", "") ~= '' and plate:gsub(" ", "") ~= '       ' then
            local plateHeading = GetEntityHeading(vehicleplateEntity)
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            CNGarages.Functions.playAnim()
            Wait(1000)

            local skillbarAmount = math.random(CNGarages.Config['settings']['fakeplates']['skillbars-max-random'])
		    for counter = 1, skillbarAmount do
		    	local finished = exports[CNGarages.Config['settings']['fakeplates']['taskbarskill-export']]:taskBar(math.random(600, 2500), math.random(5, 15))
                if finished ~= 100 then
                    Wait(500)
                    local chances = math.random(10)
                    if chances <= 3 then
                        TriggerServerEvent('cn-garages:server:fakeplate:breakScrewdriver')
                    end
            		ClearPedTasks(playerPed)
            		return
		    	end
            end

            Wait(3000)
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do Wait(0) end

            TriggerServerEvent('cn-garages:server:isPlayerVehicle', 'STEAL', plate, vehicle)
            SetVehicleNumberPlateText(vehicle, '')
            TriggerServerEvent('cn-garages:server:fakeplate:createLicensePlate', plate)

            ClearPedTasks(PlayerPedId())
        else
			TriggerEvent('DoLongHudText', "This vehicle doesn\'t have license plate on, what are you trying to do bruh", 2)
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

RegisterNetEvent('cn-garages:client:fakeplate:usePlate')
AddEventHandler('cn-garages:client:fakeplate:usePlate', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local dst = #(vehicleCoords - pedCoords)

    if dst <= 7.0 then
        if plate == '' or plate == '        ' then
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            Wait(1000)
            CNGarages.Functions.playAnim()
            Wait(7000)
            
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do Wait(0) end

            TriggerServerEvent('cn-garages:server:isPlayerVehicle', 'SET', data['info']['plate'], vehicle)
            SetVehicleNumberPlateText(vehicle, data['info']['plate'])
            TriggerServerEvent('cn-garages:server:fakeplate:removeLicensePlate', data['slot'])
            ClearPedTasks(PlayerPedId())
        else
			TriggerEvent('DoLongHudText', "This vehicle already has license plate on, remove it first", 2)
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

------------ coords

local coordsSaver, coordsDistance, coordsFor, coordsMove = false, 2.5, 'LEFT', false
local fileName, fileIndex, fileNews = '', 1, {}

CreateThread(function()
    while true do
        if coordsSaver == true then
            CNGarages.Functions.drawTxt(0.02, 1.1, 0.8, true, 'COORD SAVER ENABLED', 255, 255, 255, 255)
            CNGarages.Functions.drawTxt(0.02, 1.14, 0.5, true, 'DISTANCE: ~r~' .. tostring(coordsDistance) .. '~w~ [ ARROWKEYS UP / DOWN ]', 255, 255, 255, 255)
            CNGarages.Functions.drawTxt(0.02, 1.165, 0.5, true, 'AUTOMOVE: ~r~' .. tostring(coordsMove) .. '~w~ [ BACKSPACE ] | FOR: ~r~' .. tostring(coordsFor) .. '~w~ [ LALT ]', 255, 255, 255, 255)
            --CNGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex) .. '~w~ [ ARROWKEYS LEFT / RIGHT ]', 255, 255, 255, 255)
            CNGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex), 255, 255, 255, 255)
            CNGarages.Functions.drawTxt(0.02, 1.215, 0.5, true, 'SAVE: ~r~ENTER~w~ | UPDATE: ~r~SHIFT+ENTER', 255, 255, 255, 255)

            if IsControlJustPressed(0, 194) then
                coordsMove = not coordsMove
            end
            
            if IsControlJustPressed(0, 19) then
                coordsFor = coordsFor == 'LEFT' and 'RIGHT' or 'LEFT'
            end
            
            if IsControlJustPressed(0, 299) then
                coordsDistance = coordsDistance - 0.1
            end
            
            if IsControlJustPressed(0, 300) then
                coordsDistance = coordsDistance + 0.1
            end
            
            --[[
            if IsControlJustPressed(0, 307) then
                fileIndex = fileIndex - 1
            end
            
            if IsControlJustPressed(0, 308) then
                fileIndex = fileIndex + 1
            end]]

            if IsControlJustPressed(0, 191) then
                fileNews[fileIndex] = {GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())}
                fileIndex = fileIndex + 1
                
                if coordsMove == true then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if coordsFor == 'LEFT' then
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance * -1.0, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance * -1.0, 0.0, 0.0))
                        end
                    else
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance, 0.0, 0.0))
                        end
                    end
                end
            end

            if IsControlPressed(0, 209) then
                if IsControlJustPressed(0, 191) then
                    TriggerServerEvent('cn-garages:server:dev:saveCoords', fileName, fileNews)
                    fileNews = {}
                end
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent('cn-garages:client:coords:updateStatus')
AddEventHandler('cn-garages:client:coords:updateStatus', function()
    coordsSaver = not coordsSaver
    fileName = CNGarages.Functions.GetClosestGarage()[2]
    fileIndex = #CNGarages.Config['garages'][fileName]['slots'] + 1
end)

RegisterNetEvent('cn-garages:client:GetPlayerCoords')
AddEventHandler('cn-garages:client:GetPlayerCoords', function(trigger, params, lmfao)
    if lmfao then
        TriggerServerEvent(trigger, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), params, exports['rl-houses']:GetClosestHouse())
    else
        TriggerServerEvent(trigger, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), params)
    end
end)


------------ nui

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('park', function(data)
    local typ = data.typ
    local garage = data.garage
    local plate = data.plate
    local freeSlots = CNGarages.Functions.GetFreeSlots(garage, typ)
    local stats = CNGarages.Functions.DeletePlayerVehicle(plate)

    TriggerServerEvent('cn-garages:server:parkVehicle', garage, typ, freeSlots, plate, stats)                         
end)

RegisterNUICallback('waypoint', function(data)
    local name = data.name
    local typ = data.type

    if typ == 'garage' then
        local garage = CNGarages.Config['garages'][name]
        if garage ~= nil then
            SetNewWaypoint(garage['blip']['coords'].x, garage['blip']['coords'].y)
            print('[cn-garages] Updated garage waypoint')
			TriggerEvent('DoLongHudText', "Updated closest garage waypoint on your GPS", 1)
        else
            print('[cn-garages] Error while setting garage waypoint')
			TriggerEvent('DoLongHudText', "Error while setting garage waypoint", 2)
        end
    elseif typ == 'impound' then
        local closestImpound = CNGarages.Functions.GetClosestImpound()
        SetNewWaypoint(closestImpound[2].x, closestImpound[2].y)
        print('[cn-garages] Updated closest impound waypoint')
		TriggerEvent('DoLongHudText', "Updated closest impound waypoint on your GPS", 1)
    end                      
end)

RegisterNUICallback('vehicleblip', function(data)
    local playerPed = PlayerPedId()
    local vehicles = ESX.Game.GetVehicles()
    local plate = data.plate
    local found = false

    for _, vehicle in pairs(ownedVehicles) do
        if vehicle[1] == plate then
            found = true
            CreateThread(function()
                local blip = AddBlipForCoord(GetEntityCoords(vehicle[2]))
                SetBlipSprite(blip, 523)
                SetBlipColour(blip, 66)
                SetBlipNameToPlayerName(blip, id)
                SetBlipScale(blip, 0.9)
                SetBlipAsShortRange(blip, false)

                Wait(15000)
                local a = 255
                while a > 0 do
                    SetBlipAlpha(blip, a)
                    a = a - 1
                    Wait(1)
                end
                RemoveBlip(blip)
            end)

			TriggerEvent('DoLongHudText', "Updated your vehicle on the GPS", 1)
            return
        end
    end

    if found == false then
		TriggerEvent('DoLongHudText', "Could not find your vehicle, it placed on the impound", 2)
        TriggerServerEvent('cn-garages:server:impoundVehicle', plate)
    end
end)

RegisterNUICallback('payout', function(data)
    local garage = data.garage
    local plate = data.plate
    local price = data.price
    local typ = data.type
    
    if typ == 'impounds' then
        if CNGarages.Functions.IsSpawnClear(CNGarages.Config['impounds'][garage]['spawn'], 2.0) then
            TriggerServerEvent('cn-garages:server:vehiclePayout', garage, plate, price, typ) 
        else
			TriggerEvent('DoLongHudText', "The spawnpoint isn\'t free, check it out", 2)
        end
    else
        TriggerServerEvent('cn-garages:server:vehiclePayout', garage, plate, price, typ) 
    end         
end)
