
--CORE CARSHARING 0.2

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local vehicles = {}
local current = nil
local currentFare = 0
local lastDamage = 0
local time = 0


function inZone()
    local ped = GetPlayerPed(-1)
    local pedcoords = GetEntityCoords(ped)

    for __, z in ipairs(Config.Zones) do
        if GetDistanceBetweenCoords(z.Center, pedcoords) <= z.Size then
            return z
        end
    end

    return false
end

function spawnCar(x, y, z, h)
    local model = Config.Vehicles[math.random(1, #Config.Vehicles)]

    local car = CreateVehicle(GetHashKey(model.Model), x, y, z, h, true, true)
    SetVehicleDoorsLocked(car, 2)
    SetVehicleNumberPlateText(car, Config.vehiclePlateText)
    SetVehicleCustomPrimaryColour(car, 255, 255, 255)
    SetVehicleCustomSecondaryColour(car, 255, 255, 255)
    SetEntityAsMissionEntity(car, true, true)
end

RegisterNetEvent('core_carsharing:unlockVehicle')
AddEventHandler('core_carsharing:unlockVehicle', function(veh)
    SetVehicleDoorsLocked(NetworkGetEntityFromNetworkId(veh), 0)
end)

Citizen.CreateThread(
    function()
        while true do
            local zone = inZone()

            Citizen.Wait(Config.vehicleSpawnRate * 1000)
            if zone ~= false then
                local spawnpoint = zone.SpawnPoints[math.random(1, #zone.SpawnPoints)]
                if ESX.Game.IsSpawnPointClear(vector3(spawnpoint.x, spawnpoint.y, spawnpoint.z), 1.5) then
                    spawnCar(spawnpoint.x, spawnpoint.y, spawnpoint.z, spawnpoint.h)
                end
            end
         
        end
    end
)

--Find every vehicle around you
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            vehicles = {}
            for v in EnumerateVehicles() do
                local vehplate = GetVehicleNumberPlateText(v)
                if vehplate ~= nil then
                    if string.match(vehplate, Config.vehiclePlateText) then
                        for __, i in pairs(Config.Vehicles) do
                            if string.upper(i.Model) == string.upper(GetDisplayNameFromVehicleModel(GetEntityModel(v))) then
                                table.insert(vehicles, {vehicle = v, display = i.Display, price = i.Price})
                            end
                        end
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        for __, i in pairs(Config.Vehicles) do
            local model = GetHashKey(i.Model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                RequestModel(model)
                Citizen.Wait(0)
            end
        end
    end
)

--Set up blips
Citizen.CreateThread(
    function()
        for _, zone in ipairs(Config.Zones) do
            local radius = AddBlipForRadius(zone.Center, zone.Size)

            SetBlipSprite(radius, 9)
            SetBlipColour(radius, Config.ZoneBlipColor)
            SetBlipAlpha(radius, 75)

            local blip = AddBlipForCoord(zone.Center)

            SetBlipSprite(blip, Config.ZoneBlipDisplay)
            SetBlipColour(blip, Config.ZoneBlipColor)
            SetBlipAsShortRange(blip, true)
            SetBlipScale(blip, 0.9)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.ZoneBlipText)
            EndTextCommandSetBlipName(blip)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = GetPlayerPed(-1)
            local currentveh = GetVehiclePedIsIn(ped, false)

            if currentveh == current then
                time = time + 1
                currentHealth = GetVehicleEngineHealth(currentveh)
                if currentHealth < lastDamage - (1000 * (Config.damagePercentForPenalty / 100)) then
                    lastDamage = currentHealth
                    TriggerServerEvent("core_carsharing:pay", Config.damagePenalty)
                    SendTextMessage(string.gsub(Config.Text['damagePenalty'], '{penaltyPrice}', Config.damagePenalty))
                end
            elseif current ~= nil then
                if Config.badParkingDelete and inZone() == false then
                    DeleteEntity(current)
                else
                    SetVehicleDoorsLocked(current, 2)
                end

                if Config.penaltyOutsideZone > 0 and inZone() == false then
                	TriggerServerEvent("core_carsharing:pay", Config.penaltyOutsideZone)
                	SendTextMessage(string.gsub(Config.Text['penaltyPaid'], '{penaltyPrice}', Config.penaltyOutsideZone))

                end

                local price = math.floor((currentFare * (time / 60)) + 0.5)
                TriggerServerEvent("core_carsharing:pay", price)
                SendTextMessage(string.gsub(Config.Text['paid'], '{price}', tostring(price)))
                SetVehicleEngineHealth(current, 9999)
				SetVehiclePetrolTankHealth(current, 9999)
				SetVehicleFixed(current)
                current = nil
                time = 0
            end
        end
    end
)



Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)

            local mycoords = GetEntityCoords(GetPlayerPed(-1))
            local ped = GetPlayerPed(-1)
            local currentveh = GetVehiclePedIsIn(ped, false)
            local vehtryingtoenter = GetVehiclePedIsTryingToEnter(ped)

             for __, z in ipairs(Config.Zones) do
        if GetDistanceBetweenCoords(z.Center, mycoords) <= z.Size then
           Draw3DText(
                                z.Center[1],
                                z.Center[2],
                                z.Center[3] - 1.0,
                                Config.Text['zoneTitle'],
                                4,
                                0.1,
                                0.1,
                                Config.Text['primaryColor']
                            )
                            Draw3DText(
                                z.Center[1],
                                z.Center[2],
                                z.Center[3] - 1.2,
                                Config.Text['zoneInfo'],
                                4,
                                0.06,
                                0.06,
                               	Config.Text['secondaryColor']
                            )
                           
        end
    end

            for _, i in ipairs(vehicles) do
                local vehcoords = GetEntityCoords(i.vehicle)

                if currentveh == i.vehicle then
                    if current == nil and GetPedInVehicleSeat(currentveh, -1) == GetPlayerPed(-1) then
                        current = i.vehicle
                        lastDamage = GetVehicleEngineHealth(currentveh)
                        currentFare = i.price
                    end
                else
                    if DoesEntityExist(i.vehicle) then
                        local distance = GetDistanceBetweenCoords(vehcoords, mycoords)
                        if distance < 20 and GetPedInVehicleSeat(i.vehicle, -1) == 0 then
                            Draw3DText(
                                vehcoords[1],
                                vehcoords[2],
                                vehcoords[3] - 0.5,
                                Config.Text['serviceName'],
                                4,
                                0.1,
                                0.1,
                                Config.Text['primaryColor']
                            )
                            Draw3DText(
                                vehcoords[1],
                                vehcoords[2],
                                vehcoords[3] - 0.70,
                                string.gsub(Config.Text['vehicleInfo'], '{info}', i.display),
                                4,
                                0.06,
                                0.06,
                               	Config.Text['secondaryColor']
                            )
                            Draw3DText(
                                vehcoords[1],
                                vehcoords[2],
                                vehcoords[3] - 0.80,
                                 string.gsub(Config.Text['pricePerMinute'], '{price}', i.price),
                                4,
                                0.06,
                                0.06,
                              	 Config.Text['secondaryColor']
                            )
                            if GetVehicleDoorLockStatus(i.vehicle) == 2 and distance < 2.5 then
                                Draw3DText(
                                    vehcoords[1],
                                    vehcoords[2],
                                    vehcoords[3] - 0.90,
                                    string.gsub(Config.Text['unlockText'], '{price}', Config.vehicleUnlockFee),
                                    4,
                                    0.06,
                                    0.06,
                                    Config.Text['primaryColor']
                                )
                                if IsControlJustReleased(1, Keys[Config.vehicleUnlockKey]) then
                                    ESX.TriggerServerCallback(
                                        "core_carsharing:unlockFee",
                                        function(hasMoney)
                                            if hasMoney then
                                            	ClearPedTasks(ped)
                                            	PlayVehicleDoorCloseSound(i.vehicle, 1)

												SetVehicleLights(i.vehicle, 2)
                       						 	SetVehicleLightMultiplier(i.vehicle, 0.0)
     
                        						Citizen.Wait(100)
                  							 	SetVehicleLights(i.vehicle, 0)
                                                SetVehicleLightMultiplier(i.vehicle, 1.0)   
                        	                    Citizen.Wait(200)
                                                SetVehicleLights(i.vehicle, 2)
                        						SetVehicleLightMultiplier(i.vehicle, 0.0)
                        						Citizen.Wait(100)
                        						SetVehicleLights(i.vehicle, 0)
                        						SetVehicleLightMultiplier(i.vehicle, 1.0) 

                                                TriggerServerEvent('core_carsharing:unlockVehicle', NetworkGetNetworkIdFromEntity(i.vehicle))
                                                SendTextMessage(Config.Text['vehicleUnlocked'])
                                            else
                                                SendTextMessage(Config.Text['noMoneyOrLicense'])
                                            end
                                        end,
                                        Config.vehicleUnlockFee
                                    )
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)




function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,color)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  local scale = (1/dist)*20
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov
  SetTextScale(scaleX*scale, scaleY*scale)
  SetTextFont(fontId)
  SetTextProportional(1)
  SetTextColour(color.r, color.g, color.b, color.a)
  SetTextDropshadow(1, 1, 1, 1, 255)
  SetTextEdge(2, 0, 0, 0, 150)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(textInput)
  SetDrawOrigin(x,y,z+2, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end

local entityEnumerator = {
  __gc = function(enum)
  if enum.destructor and enum.handle then
    enum.destructor(enum.handle)
  end
  enum.destructor = nil
  enum.handle = nil
end
}

function GetAllVehicles()
local ret = {}
for veh in EnumerateVehicles() do
  table.insert(ret, veh)
end
return ret
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
return coroutine.wrap(function()
local iter, id = initFunc()
if not id or id == 0 then
  disposeFunc(iter)
  return
end

local enum = {handle = iter, destructor = disposeFunc}
setmetatable(enum, entityEnumerator)

local next = true
repeat
  coroutine.yield(id)
  next, id = moveFunc(iter)
until not next

enum.destructor, enum.handle = nil, nil
disposeFunc(iter)
end)
end

function EnumerateObjects()
return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end