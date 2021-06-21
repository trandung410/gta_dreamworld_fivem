Config = {}

-- Config.Directions = { [0] = 'N', [1] = 'NW', [2] = 'W', [3] = 'SW', [4] = 'S', [5] = 'SE', [6] = 'E', [7] = 'NE', [8] = 'N' } 
Config.Directions = { [0] = 'N', [1] = 'NW', [2] = 'W', [3] = 'SW', [4] = 'S', [5] = 'SE', [6] = 'E', [7] = 'NE', [8] = 'N' } 
Config.Zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

Config.seatbeltInput = 29 -- Toggle seatbelt on/off with B
Config.seatbeltEjectSpeed = 45 -- Speed threshold to eject player (MPH)
Config.seatbeltEjectAccel = 100 -- Acceleration threshold to eject player (G's)

Config.BeltClass = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = false,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = true,
    [18] = true,
    [19] = true,
}


-- SPEEDOMETER PARAMETERS

-- Globals
local pedInVeh = false
local timeText = ""
local locationText = ""
local position, heading, zoneNameFull, streetName, locationText
local currentFuel = 0.0
local seatbeltIsOn = false

-- Main thread
Citizen.CreateThread(function()
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
    while true do
        Citizen.Wait(100)

        -- Loop forever and update HUD every frame

        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehicleSpeedSource = GetEntitySpeed(vehicle)
        local vehicleSpeed
            vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
            
        local fuelShowPercentage = false             -- Show fuel as a percentage (disabled shows fuel in liters)
        local fuelWarnLimit = 25.0                  -- Fuel limit for triggering warning color

        -- Vehicle Gradient Speed
        local vehicleNailSpeed

        if vehicleSpeed > 999 then
            vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(999 * 205) / 999) )
        else
            vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / 999) )
        end

        -- Set vehicle states
        if IsPedInAnyVehicle(player, false) then
            pedInVeh = true
            position = GetEntityCoords(player)
            heading = Config.Directions[math.floor((GetEntityHeading(player) + 22.5) / 45.0)]
            zoneNameFull = Config.Zones[GetNameOfZone(position.x, position.y, position.z)]
            streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            locationText = heading
            locationText = (streetName == "" or streetName == nil) and (locationText) or (locationText .. " | " .. streetName)
            locationText = (zoneNameFull == "" or zoneNameFull == nil) and (locationText) or (locationText .. " | " .. zoneNameFull)
        else
            -- Reset states when not in car
            pedInVeh = false
            
            SendNUIMessage({
                message		= "hide",
                hasBelt = hasBelt,
                beltOn = seatbeltIsOn,
                gear = 0,
                maxGear = 0,
                engineStatus = false,
                clear = true
            })
        end
        
            

            if pedInVeh and GetIsVehicleEngineRunning(vehicle) and vehicleClass ~= 13 then
                -- Save previous speed and get current speed
                local prevSpeed = currSpeed
                currSpeed = GetEntitySpeed(vehicle)
                currentFuel = math.ceil(1 * GetVehicleFuelLevel(vehicle))

                local vehicle = GetVehiclePedIsIn(player, false)

                local prevSpeed = currSpeed
                currSpeed = GetEntitySpeed(vehicle)

                -- Check vehicle class if has belt or not
                local vehicleClass = GetVehicleClass(vehicle)
                local hasBelt = isVehicleClassHasBelt(vehicleClass)

                if IsControlJustReleased(0, Config.seatbeltInput) and hasBelt then 
                    seatbeltIsOn = not seatbeltIsOn 
                end
                
                if seatbeltIsOn then  
                    --TriggerEvent("pNotify:SendNotification", {text ="Locked Seatbelt", type = "success", queue = "belt", timeout = 5000, layout = "centerright"})
                else 
                   -- TriggerEvent("pNotify:SendNotification", {text = "Unlocked Seatbelt", type = "error", queue = "belt", timeout = 5000, layout = "centerright"}) 
                end

                if not hasBelt then
                    seatbeltIsOn = false
                end

                if (not seatbeltIsOn or not hasBelt) then
                    -- Eject PED when moving forward, vehicle was going over 45 MPH and acceleration over 100 G's
                    local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (Config.seatbeltEjectSpeed/2.237)) and (vehAcc > (Config.seatbeltEjectAccel*9.81))) then
                        SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        Citizen.Wait(1)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end
                else
                    -- Disable vehicle exit when seatbelt is on
                    DisableControlAction(0, 75)
                end


                SendNUIMessage({
                    message	= "show",
                    clear = true,
                    speed = vehicleSpeed,
                    fuel = currentFuel,
                    streetName = locationText,
                    hasBelt = hasBelt,
                    beltOn = seatbeltIsOn,
                    gear = GetVehicleCurrentGear(vehicle),
                    maxGear = GetVehicleHighGear(vehicle),
                    engineStatus = GetIsVehicleEngineRunning(vehicle),
                })
                -- Set PED flags
                SetPedConfigFlag(PlayerPedId(), 32, true)    
            end
        end
end)

function isVehicleClassHasBelt(class)
    if (not class or class == nil) then return false end

    local hasBelt = Config.BeltClass[class]
    if (not hasBelt or hasBelt == nil) then return false end

    return hasBelt
end 


-- OnAtEnter = false

-- -- Change 'false' to 'true' to use a key instead of a button
-- UseKey = true

-- if UseKey then
-- 	-- Change this to change the key to toggle the engine (Other Keys at wiki.fivem.net/wiki/Controls)
-- 	ToggleKey = 311
-- end


-- RegisterNetEvent('EngineToggle:Engine')
-- RegisterNetEvent('EngineToggle:RPDamage')

-- local vehicles = {}; RPWorking = true

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if UseKey and ToggleKey then
-- 			if IsControlJustReleased(1, ToggleKey) then
-- 				TriggerEvent('EngineToggle:Engine')
-- 			end
-- 		end
-- 		if GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 and not table.contains(vehicles, GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))) then
-- 			table.insert(vehicles, {GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)), IsVehicleEngineOn(GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)))})
-- 		elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) and not table.contains(vehicles, GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
-- 			table.insert(vehicles, {GetVehiclePedIsIn(GetPlayerPed(-1), false), IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false))})
-- 		end
-- 		for i, vehicle in ipairs(vehicles) do
-- 			if DoesEntityExist(vehicle[1]) then
-- 				if (GetPedInVehicleSeat(vehicle[1], -1) == GetPlayerPed(-1)) or IsVehicleSeatFree(vehicle[1], -1) then
-- 					if RPWorking then
-- 						SetVehicleEngineOn(vehicle[1], vehicle[2], true, false)
-- 						SetVehicleJetEngineOn(vehicle[1], vehicle[2])
-- 						if not IsPedInAnyVehicle(GetPlayerPed(-1), false) or (IsPedInAnyVehicle(GetPlayerPed(-1), false) and vehicle[1]~= GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
-- 							if IsThisModelAHeli(GetEntityModel(vehicle[1])) or IsThisModelAPlane(GetEntityModel(vehicle[1])) then
-- 								if vehicle[2] then
-- 									SetHeliBladesFullSpeed(vehicle[1])
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			else
-- 				table.remove(vehicles, i)
-- 			end
-- 		end
-- 	end
-- end)

-- AddEventHandler('EngineToggle:Engine', function()
-- 	local veh
-- 	local StateIndex
-- 	for i, vehicle in ipairs(vehicles) do
-- 		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
-- 			veh = vehicle[1]
-- 			StateIndex = i
-- 		end
-- 	end
-- 	Citizen.Wait(500)
-- 	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
-- 		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
-- 			vehicles[StateIndex][2] = not GetIsVehicleEngineRunning(veh)
-- 			if vehicles[StateIndex][2] then
-- 				--exports['mythic_notify']:DoHudText('success', 'สตาร์ทเครื่องยนต์')
-- 				TriggerEvent("pNotify:SendNotification", {
-- 									text = "<span style='font-size:14;font-weight: 900'>Vehicle</span><br>สตาร์ทเครื่องยนต์",
-- 									type = "info",
-- 									timeout = 5000,
-- 									layout = "topRight"
-- 								})
-- 			else
-- 				--exports['mythic_notify']:DoHudText('error', 'ดับเครื่องยนต์')
-- 				TriggerEvent("pNotify:SendNotification", {
-- 									text = "<span style='font-size:14;font-weight: 900'>Vehicle</span><br>ดับเครื่องยนต์",
-- 									type = "info",
-- 									timeout = 5000,
-- 									layout = "topRight"
-- 								})
								
-- 			end
-- 		end 
--     end 
-- end)

-- AddEventHandler('EngineToggle:RPDamage', function(State)
-- 	RPWorking = State
-- end)

-- if OnAtEnter then
-- 	Citizen.CreateThread(function()
-- 		while true do
-- 			Citizen.Wait(0)
-- 			if GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 then
-- 				for i, vehicle in ipairs(vehicles) do
-- 					if vehicle[1] == GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) and not vehicle[2] then
-- 						Citizen.Wait(500)
-- 						vehicle[2] = true
-- 						TriggerEvent("pNotify:SendNotification", {
-- 									text = 'สตาร์ทเครื่องยนต์',
-- 									type = "info",
-- 									timeout = 5000,
-- 									layout = "topRight"
-- 								})
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end)
-- end

-- function table.contains(table, element)
--   for _, value in pairs(table) do
--     if value[1] == element then
--       return true
--     end
--   end
--   return false
-- end
