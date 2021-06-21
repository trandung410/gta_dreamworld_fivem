local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local HasKey, IsHotwiring, IsRobbing, isLoggedIn, AlertSend = false, false, false, false, false
local LastVehicle = nil
local NeededAttempts, SucceededAttempts, FailedAttemps = 0, 0, 0
local vehicleSearched, vehicleHotwired = {}, {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        if ESX ~= nil then
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), true), -1) == GetPlayerPed(-1) then
                local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
                if LastVehicle ~= GetVehiclePedIsIn(GetPlayerPed(-1), false) then
                    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
                        if result then
                            HasKey = true
                            SetVehicleEngineOn(veh, true, false, true)
                        else
                            HasKey = false
                            SetVehicleEngineOn(veh, false, false, true)
                        end
                        LastVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                    end, plate)
                end
            else
                if SucceededAttempts ~= 0 then
                    SucceededAttempts = 0
                end
                if NeededAttempts ~= 0 then
                    NeededAttempts = 0
                end
                if FailedAttemps ~= 0 then
                    FailedAttemps = 0
                end
            end
        end

        if not HasKey and IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and ESX ~= nil and not IsHotwiring then
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            SetVehicleEngineOn(veh, false, false, true)
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0.0, 2.0, 1.0)
            DrawText3D(vehpos.x, vehpos.y, vehpos.z, "[G] Search / [H] Hotwire" )
            SetVehicleEngineOn(veh, false, false, true)

            if IsControlJustPressed(0, Keys["H"]) then
                Hotwire()
            end

            if IsControlJustPressed(1, Keys["G"]) then
                Search()
            end
        end

        if IsControlJustPressed(1, Keys["L"]) then
            LockVehicle()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if not IsRobbing and ESX ~= nil then
            if GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= nil and GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
						exports["cn-taskbar"]:taskBar(3000, "Taking Keys")
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                            HasKey = true
                            IsRobbing = false

                            TriggerEvent("debug", 'Keys: Rob', 'success')
                    end
                end
            end

        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer  
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate, vehicle)
    local VehPlate = plate
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
    end

    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate, vehicle)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), true), true, false, true)
    end
    HasKey = true
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local latestveh = getVehicleInDirection(coordA, coordB)
    
    if latestveh == nil or not DoesEntityExist(latestveh) then
		TriggerEvent('DoLongHudText', 'Vehicle not found!', 2)
        return
    end
    
    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(hasKey)
        if not hasKey then
			TriggerEvent('DoLongHudText', 'No keys for target vehicle!', 2)
            return
        end

        if #(GetEntityCoords(latestveh) - GetEntityCoords(PlayerPedId(), 0)) > 5 then
			TriggerEvent('DoLongHudText', 'You are too far away from the vehicle!', 2)
            return
        end
        
        t, distance = ESX.Game.GetClosestPlayer()
        if(distance ~= -1 and distance < 5) then
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', GetVehicleNumberPlateText(latestveh), GetPlayerServerId(t))
            TriggerEvent("debug", 'Keys: Give Vehicle Keys', 'success')
        else
			TriggerEvent('DoLongHudText', 'No player near you!', 2)
            TriggerEvent("debug", 'Keys: No Player Nearby', 'error')
        end
    end, GetVehicleNumberPlateText(latestveh))
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
  
    for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0) 
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1
  
      if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end
  
      return vehicle ~= nil and vehicle or 0
  end

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1)))
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(GetPlayerPed(-1))) then
        if not HasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

function RobVehicle(target)
    IsRobbing = true
    Citizen.CreateThread(function()
        while IsRobbing do
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")

            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Citizen.Wait(1000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, GetPlayerPed(-1), 0, false)

            Citizen.Wait(RandWait)

            --TaskReactAndFleePed(target, GetPlayerPed(-1))
            IsRobbing = false
        end
    end)
end

function LockVehicle()
    local veh = ESX.Game.GetClosestVehicle()
    local coordA = GetEntityCoords(GetPlayerPed(-1), true)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 10.0 then
        ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
            if result then
                local isParked = isParked(plate)
                if not isParked then
                    if HasKey then
                        local vehLockStatus = GetVehicleDoorLockStatus(veh)
                        loadAnimDict("anim@mp_player_intmenu@key_fob@")
                        TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
                    
                        if vehLockStatus == 1 then
                            Citizen.Wait(750)
                            ClearPedTasks(GetPlayerPed(-1))
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                            SetVehicleDoorsLocked(veh, 2)
                            if(GetVehicleDoorLockStatus(veh) == 2)then
								TriggerEvent('DoLongHudText', 'Vehicle Locked.', 1)
                            else
								TriggerEvent('DoLongHudText', 'Something is wrong with the locking system...', 1)
                            end
                        else
                            Citizen.Wait(750)
                            ClearPedTasks(GetPlayerPed(-1))
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                            SetVehicleDoorsLocked(veh, 1)
                            if(GetVehicleDoorLockStatus(veh) == 1)then
								TriggerEvent('DoLongHudText', 'Vehicle Unlocked.', 1)
                            else
								TriggerEvent('DoLongHudText', 'Something is wrong with the locking system...', 1)
                            end
                        end
                    
                        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                            SetVehicleInteriorlight(veh, true)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            Citizen.Wait(450)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                            Citizen.Wait(450)
                            SetVehicleInteriorlight(veh, true)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            Citizen.Wait(450)
                            SetVehicleInteriorlight(veh, false)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                        end
                    end
                else
					TriggerEvent('DoLongHudText', 'You can\'t use open your vehicle while its parked.', 2)
                end
            else
				TriggerEvent('DoLongHudText', 'No keys for target vehicle!', 2)
            end
        end, plate, veh)
    end
end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = ESX.Game.GetClosestVehicle()
    local isParked = isParked(GetVehicleNumberPlateText(vehicle))
    if vehicle ~= nil and vehicle ~= 0 and not isParked then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(15000, 30000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                LockpickDoorAnim(lockpickTime)
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
				exports["cn-taskbar"]:taskBar(lockpickTime, "Lockpicking...") 
                    if math.random(1, 100) <= 90 then
                        TriggerEvent("debug", 'Lockpick: Success', 'success')
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(vehicle, 0)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    else
						TriggerEvent('DoLongHudText', 'You can not work out this hotwire.', 2)
                        TriggerEvent("debug", 'Lockpick: Failed', 'error')
                    end
            end
        end
    else
		TriggerEvent('DoLongHudText', 'You can\'t use lockpick on parked vehicles.', 2)
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(GetPlayerPed(-1), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(GetPlayerPed(-1), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition(isAdvanced)
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
                IsHotwiring = true

                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"
				TaskPlayAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer' ,1.0, 4.0, -1, 49, 0, false, false, false)

                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Citizen.Wait(100)
                end

                if exports["cn-taskbarskill"]:taskBar(math.random(5000,25000),math.random(10,20)) ~= 100 then             
					StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    TriggerEvent('DoLongHudText', 'Lockpicking failed!', 2)
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 4))
                    end
                    return
                end
    
                if exports["cn-taskbarskill"]:taskBar(math.random(5000,25000),math.random(10,20)) ~= 100 then
                    StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
					TriggerEvent('DoLongHudText', 'Lockpicking failed!', 2)
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 4))
                    end
                    return
                end

                if exports["cn-taskbarskill"]:taskBar(1500,math.random(5,15)) ~= 100 then
                    StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    TriggerEvent('DoLongHudText', 'Lockpicking failed!', 2)
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 4))
                    end
                    return
                end 

                TriggerEvent("debug", 'Hotwire: Success', 'success')
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
				TriggerEvent('DoLongHudText', 'Ignition Working.', 1)
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                IsHotwiring = false
                TriggerServerEvent('rl-hud:Server:GainStress', math.random(2, 4))

            end
        end
    end
end

function Search()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

        if vehicleSearched[GetVehicleNumberPlateText(vehicle)] then
			TriggerEvent('DoLongHudText', 'You have already searched this vehicle.', 2)
            return
        end

        vehicleSearched[GetVehicleNumberPlateText(vehicle)] = true
        IsHotwiring = true
        local searchTime = 5000
		TriggerEvent('animation:hotwire', true)
		exports["cn-taskbar"]:taskBar(15000, "Searching") 
		    TriggerEvent('animation:hotwire', false)
            if (math.random(0, 100) < 10) then
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
				TriggerEvent('DoLongHudText', 'You have found the keys to the vehicle!', 1)
                TriggerEvent("debug", 'Keys: Found', 'success')
            else
                HasKey = false
                SetVehicleEngineOn(veh, false, false, true)
            end
            IsHotwiring = false
    end
end

function Hotwire()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local isParked = isParked(GetVehicleNumberPlateText(vehicle))
        if not isParked then
            if vehicleHotwired[GetVehicleNumberPlateText(vehicle)] then
				TriggerEvent('DoLongHudText', 'You can not work out this hotwire.', 2)
                return
            end

            vehicleHotwired[GetVehicleNumberPlateText(vehicle)] = true
            IsHotwiring = true
            local hotwireTime = math.random(20000, 40000)
            SetVehicleAlarm(vehicle, true)
            SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
            TriggerEvent('animation:hotwire', true)
			exports["cn-taskbar"]:taskBar(hotwireTime, "Attempting Hotwire")
			    TriggerEvent('animation:hotwire', false)
                if (math.random(0, 100) < 20) then
                    HasKey = true
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
					TriggerEvent('DoLongHudText', 'Ignition Working.', 1)
                    TriggerEvent("debug", 'Hotwire: Success', 'success')
                else
                    TriggerEvent('dispatch:lockpick', vehicle)
                    HasKey = false
                    SetVehicleEngineOn(veh, false, false, true)
					TriggerEvent('DoLongHudText', 'You can not work out this hotwire.', 2)
                    TriggerEvent("debug", 'Hotwire: Failed', 'error')
                end
                IsHotwiring = false
        else
			TriggerEvent('DoLongHudText', 'You can\'t use lockpick on parked vehicles.', 2)
        end
    end
end

function isParked(plate)
    for name, data in pairs(CNGarages.Config['garages']) do
        for key, value in pairs(data['slots']) do
            if value[3] ~= nil and value[3].plate == plate then
                return true
            end
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
   
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            showText = true
   
            -- Exiting
            local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
            if aiming then
                if DoesEntityExist(targetPed) and not IsPedAPlayer(targetPed) and IsPedArmed(PlayerPedId(), 7) and IsPedInAnyVehicle(targetPed, false) then
                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), GetEntityCoords(vehicle, true), false)
                    
                    if distance < 5 and IsPedFacingPed(targetPed, PlayerPedId(), 60.0) then
                        SetVehicleForwardSpeed(vehicle, 0)
                        SetVehicleForwardSpeed(vehicle, 0)
                        TaskLeaveVehicle(targetPed, vehicle, 256)
                        while IsPedInAnyVehicle(targetPed, false) do
                            Citizen.Wait(5)
                        end
                    end
   
                    RequestAnimDict('missfbi5ig_22')
                    RequestAnimDict('mp_common')
   
                    SetPedDropsWeaponsWhenDead(targetPed,false)
                    ClearPedTasks(targetPed)
                    TaskTurnPedToFaceEntity(targetPed, GetPlayerPed(-1), 3.0)
                    TaskSetBlockingOfNonTemporaryEvents(targetPed, true)
                    SetPedFleeAttributes(targetPed, 0, 0)
                    SetPedCombatAttributes(targetPed, 17, 1)
                    SetPedSeeingRange(targetPed, 0.0)
                    SetPedHearingRange(targetPed, 0.0)
                    SetPedAlertness(targetPed, 0)
                    SetPedKeepTask(targetPed, true)
                            
                    TaskPlayAnim(targetPed, "missfbi5ig_22", "hands_up_anxious_scientist", 8.0, -8, -1, 12, 1, 0, 0, 0)
                    Wait(1500)
                    TaskPlayAnim(targetPed, "missfbi5ig_22", "hands_up_anxious_scientist", 8.0, -8, -1, 12, 1, 0, 0, 0)
                    Wait(2500)
   
                    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), GetEntityCoords(vehicle, true), false)
                    if not IsEntityDead(targetPed) and distance < 5 then
                        TaskPlayAnim(targetPed, "mp_common", "givetake1_a", 8.0, -8, -1, 12, 1, 0, 0, 0)
                        Wait(750)
						exports["cn-taskbar"]:taskBar(3000, "Taking Keys")
						TriggerEvent('DoLongHudText', 'You just recieved keys to a vehicle!', 1)
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                        Citizen.Wait(500)
                        TaskReactAndFleePed(targetPed, GetPlayerPed(-1))
                        SetPedKeepTask(targetPed, true)
                        Wait(2500)
                        TaskReactAndFleePed(targetPed, GetPlayerPed(-1))
                        SetPedKeepTask(targetPed, true)
                        Wait(2500)
                        TaskReactAndFleePed(targetPed, GetPlayerPed(-1))
                        SetPedKeepTask(targetPed, true)
                        Wait(2500)
                        TaskReactAndFleePed(targetPed, GetPlayerPed(-1))
                        SetPedKeepTask(targetPed, true)
                    end
                end
            end
        end
    end
end)

-- functions
function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, GetPlayerPed(-1), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = ESX.Game.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 5.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
    if weapon ~= nil then
        for _, v in pairs(CNGarages.Config['settings']['blacklistedWeapons']) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

local disable = false

RegisterNetEvent('animation:hotwire')
AddEventHandler('animation:hotwire', function(disable)
 local lPed = GetPlayerPed(-1)
 ClearPedTasks(lPed)
   ClearPedSecondaryTask(lPed)

 RequestAnimDict("mini@repair")
 while not HasAnimDictLoaded("mini@repair") do
  Citizen.Wait(0)
 end
 if disable ~= nil then
  if not disable then
   lockpicking = false
   return
  else
   lockpicking = true
  end
 end
 while lockpicking do

  if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
   ClearPedSecondaryTask(lPed)
   TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
  end
  Citizen.Wait(1)
 end
 ClearPedTasks(lPed)
end)


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end