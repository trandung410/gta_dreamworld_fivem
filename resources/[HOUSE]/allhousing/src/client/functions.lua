function GetBlipData(t,zoneCoord)
  if t == "owner" then
    if not Config.HideOwnBlips then
      local color,sprite
      if Config.UseZoneSprites then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        sprite = (Config.ZoneBlipSprites[zone] and Config.ZoneBlipSprites[zone].OwnerSprite or Config.BlipOwnerSprite)
      else
        sprite = Config.BlipOwnerSprite
      end
      if Config.UseZoneColoring then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        color = (Config.ZoneBlipColors[zone] and Config.ZoneBlipColors[zone].OwnerColor or Config.BlipOwnerColor)
      else
        color = Config.BlipOwnerColor
      end
      return color,sprite
    else
      return false
    end
  elseif t == "owned" then
    if not Config.HideSoldBlips then
      local color,sprite
      if Config.UseZoneSprites then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        sprite = (Config.ZoneBlipSprites[zone] and Config.ZoneBlipSprites[zone].OwnedSprite or Config.BlipOwnedSprite)
      else
        sprite = Config.BlipOwnedSprite
      end
      if Config.UseZoneColoring then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        color = (Config.ZoneBlipColors[zone] and Config.ZoneBlipColors[zone].OwnedColor or Config.BlipOwnedColor)
      else
        color = Config.BlipOwnedColor
      end
      return color,sprite
    else
      return false
    end
  elseif t == "empty" then
    if not Config.HideEmptyBlips then
      local color,sprite
      if Config.UseZoneSprites then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        sprite = (Config.ZoneBlipSprites[zone] and Config.ZoneBlipSprites[zone].EmptySprite or Config.BlipEmptySprite)
      else
        sprite = Config.BlipEmptySprite
      end
      if Config.UseZoneColoring then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        color = (Config.ZoneBlipColors[zone] and Config.ZoneBlipColors[zone].EmptyColor or Config.BlipEmptyColor)
      else
        color = Config.BlipEmptyColor
      end
      return color,sprite
    else
      return false
    end
  end
end

function RefreshBlips()
  local identifier = GetPlayerIdentifier()
  if Config.UseBlips then
    for _,house in pairs(Houses) do
      if house.Blip then
        RemoveBlip(house.Blip)
      end

      local color,sprite,text
      if house.Owned and house.Owner and (house.Owner == identifier) then
        text = "<FONT FACE='Montserrat'>Nhà của bạn"
        color,sprite = GetBlipData("owner",house.Entry)
      elseif house.Owned then
        text = "<FONT FACE='Montserrat'>Nhà đã có chủ"
        color,sprite = GetBlipData("owned",house.Entry)
      else
        text = "<FONT FACE='Montserrat'>Nhà đang bán"
        color,sprite = GetBlipData("empty",house.Entry)
      end

      if color and sprite then
        house.Blip = CreateBlip(house.Entry,sprite,color,text)
      end
    end
  end
end

function CreateBlip(pos,sprite,color,text,scale,display,shortRange,highDetail)
  local blip = AddBlipForCoord(pos.x,pos.y,pos.z)
  SetBlipSprite               (blip, (sprite or 1))
  SetBlipColour               (blip, (color or 4))
  SetBlipScale                (blip, (scale or 1.0))
  SetBlipDisplay              (blip, (display or 3))
  SetBlipAsShortRange         (blip, (shortRange or false))
  SetBlipHighDetail           (blip, (highDetail or true))
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ((text or "Blip "..tostring(blip)))
  EndTextCommandSetBlipName   (blip)
  return blip
end

function ShowNotification(msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentSubstringPlayerName(msg)
  DrawNotification(false, true)
end

function ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
  if saveToBrief == nil then saveToBrief = true end
  AddTextEntry('ahAdvancedNotification', msg)
  BeginTextCommandThefeedPost('ahAdvancedNotification')
  if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
  EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
  EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
  AddTextEntry('ahHelpNotification', msg)

  if thisFrame then
    DisplayHelpTextThisFrame('ahHelpNotification', false)
  else
    if beep == nil then beep = true end
    BeginTextCommandDisplayHelp('ahHelpNotification')
    EndTextCommandDisplayHelp(0, false, beep, duration or -1)
  end
end

DrawText3D = function(_x,_y,_z, text, size)
  local coords = vector3(_x,_y,_z)
  local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
  local camCoords      = GetGameplayCamCoords()
  local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
  local size           = size

  if size == nil then
    size = 1
  end

  local scale = (size / dist) * 2
  local fov   = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)

    AddTextComponentString(text)
    DrawText(x, y)
  end
end

_Callbacks = {}
_CallbackID = 0
function Callback(event,...)
  local myId = _CallbackID  
  _Callbacks[myId] = false
  _CallbackID = _CallbackID + 1
  TriggerServerEvent("Allhousing:Callback",myId,event,...)

  local start = GetGameTimer()
  while not (_Callbacks[myId]) and (GetGameTimer() - start < 30000) do Wait(0); end

  if not _Callbacks[myId] then 
    return false
  else 
    return table.unpack(_Callbacks[myId])
  end
end

function _Calledback(id,...)
  _Callbacks[id] = {...}
end

GoToDoor = function(p)
  local plyPed = GetPlayerPed(-1)
  TaskGoStraightToCoord(plyPed, p.x, p.y, p.z, 10.0, 10, p.w, 0.5)
  local dist = 999
  local tick = 0
  while dist > 0.5 and tick < 10000 do
    local pPos = GetEntityCoords(plyPed)
    dist = Vdist(pPos.x,pPos.y,pPos.z, p.x,p.y,p.z)
    tick = tick + 1
    Citizen.Wait(100)  
  end
  ClearPedTasksImmediately(plyPed)
end

FaceCoordinate = function(pos)
  local plyPed = GetPlayerPed(-1)
  TaskTurnPedToFaceCoord(plyPed, pos.x,pos.y,pos.z, -1)
  Wait(1500)
  ClearPedTasks(plyPed)
end

GetVehicleProperties = function(vehicle)
  if Config.UsingESX then 
    return ESX.Game.GetVehicleProperties(vehicle)
  end
  
  if DoesEntityExist(vehicle) then
    local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    local extras = {}

    for id=0, 12 do
      if DoesExtraExist(vehicle, id) then
        local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
        extras[tostring(id)] = state
      end
    end

    local esxTrim = function(value)
      if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
      else
        return nil
      end
    end

    return {
      model             = GetEntityModel(vehicle),

      plate             = esxTrim(GetVehicleNumberPlateText(vehicle)),
      plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

      bodyHealth        = GetVehicleBodyHealth(vehicle, 1),
      engineHealth      = math.round(GetVehicleEngineHealth(vehicle), 1),

      fuelLevel         = math.round(GetVehicleFuelLevel(vehicle), 1),
      dirtLevel         = math.round(GetVehicleDirtLevel(vehicle), 1),
      color1            = colorPrimary,
      color2            = colorSecondary,

      pearlescentColor  = pearlescentColor,
      wheelColor        = wheelColor,

      wheels            = GetVehicleWheelType(vehicle),
      windowTint        = GetVehicleWindowTint(vehicle),
      xenonColor        = GetVehicleXenonLightsColour(vehicle),

      neonEnabled       = {
        IsVehicleNeonLightEnabled(vehicle, 0),
        IsVehicleNeonLightEnabled(vehicle, 1),
        IsVehicleNeonLightEnabled(vehicle, 2),
        IsVehicleNeonLightEnabled(vehicle, 3)
      },

      neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
      extras            = extras,
      tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

      modSpoilers       = GetVehicleMod(vehicle, 0),
      modFrontBumper    = GetVehicleMod(vehicle, 1),
      modRearBumper     = GetVehicleMod(vehicle, 2),
      modSideSkirt      = GetVehicleMod(vehicle, 3),
      modExhaust        = GetVehicleMod(vehicle, 4),
      modFrame          = GetVehicleMod(vehicle, 5),
      modGrille         = GetVehicleMod(vehicle, 6),
      modHood           = GetVehicleMod(vehicle, 7),
      modFender         = GetVehicleMod(vehicle, 8),
      modRightFender    = GetVehicleMod(vehicle, 9),
      modRoof           = GetVehicleMod(vehicle, 10),

      modEngine         = GetVehicleMod(vehicle, 11),
      modBrakes         = GetVehicleMod(vehicle, 12),
      modTransmission   = GetVehicleMod(vehicle, 13),
      modHorns          = GetVehicleMod(vehicle, 14),
      modSuspension     = GetVehicleMod(vehicle, 15),
      modArmor          = GetVehicleMod(vehicle, 16),

      modTurbo          = IsToggleModOn(vehicle, 18),
      modSmokeEnabled   = IsToggleModOn(vehicle, 20),
      modXenon          = IsToggleModOn(vehicle, 22),

      modFrontWheels    = GetVehicleMod(vehicle, 23),
      modBackWheels     = GetVehicleMod(vehicle, 24),

      modPlateHolder    = GetVehicleMod(vehicle, 25),
      modVanityPlate    = GetVehicleMod(vehicle, 26),
      modTrimA          = GetVehicleMod(vehicle, 27),
      modOrnaments      = GetVehicleMod(vehicle, 28),
      modDashboard      = GetVehicleMod(vehicle, 29),
      modDial           = GetVehicleMod(vehicle, 30),
      modDoorSpeaker    = GetVehicleMod(vehicle, 31),
      modSeats          = GetVehicleMod(vehicle, 32),
      modSteeringWheel  = GetVehicleMod(vehicle, 33),
      modShifterLeavers = GetVehicleMod(vehicle, 34),
      modAPlate         = GetVehicleMod(vehicle, 35),
      modSpeakers       = GetVehicleMod(vehicle, 36),
      modTrunk          = GetVehicleMod(vehicle, 37),
      modHydrolic       = GetVehicleMod(vehicle, 38),
      modEngineBlock    = GetVehicleMod(vehicle, 39),
      modAirFilter      = GetVehicleMod(vehicle, 40),
      modStruts         = GetVehicleMod(vehicle, 41),
      modArchCover      = GetVehicleMod(vehicle, 42),
      modAerials        = GetVehicleMod(vehicle, 43),
      modTrimB          = GetVehicleMod(vehicle, 44),
      modTank           = GetVehicleMod(vehicle, 45),
      modWindows        = GetVehicleMod(vehicle, 46),
      modLivery         = GetVehicleLivery(vehicle)
    }
  else
    return {}
  end
end

SetVehicleProperties = function(vehicle, props)
  if Config.UsingESX then
    ESX.Game.SetVehicleProperties(vehicle,props)
  else
    local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleModKit(vehicle, 0)

    if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
    if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
    if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
    if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
    if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
    if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
    if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
    if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
    if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
    pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    if props.wheelColor then SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor) end
    if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
    if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end

    if props.neonEnabled then
      SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
      SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
      SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
      SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
    end

    if props.extras then
      for id,enabled in pairs(props.extras) do
        if enabled then
          SetVehicleExtra(vehicle, tonumber(id), 0)
        else
          SetVehicleExtra(vehicle, tonumber(id), 1)
        end
      end
    end

    if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
    if props.xenonColor then SetVehicleXenonLightsColour(vehicle, props.xenonColor) end
    if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
    if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
    if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
    if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
    if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
    if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
    if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
    if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
    if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
    if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
    if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
    if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
    if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
    if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
    if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
    if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
    if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
    if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
    if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
    if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) end
    if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) end
    if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
    if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
    if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
    if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
    if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
    if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
    if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
    if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
    if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
    if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
    if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
    if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
    if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
    if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
    if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
    if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
    if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
    if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
    if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
    if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
    if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
    if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
    if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
    if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end

    if props.modLivery then
      SetVehicleMod(vehicle, 48, props.modLivery, false)
      SetVehicleLivery(vehicle, props.modLivery)
    end
  end
end

SetWeatherAndTime = function(syncTime)
  if not syncTime then
    if Config.UsingVSync then
      TriggerEvent('vSync:toggle',false)
    end
    
    SetRainFxIntensity(0.0)
    SetBlackout(false)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist('CLEAR')
    SetWeatherTypeNow('CLEAR')
    SetWeatherTypeNowPersist('CLEAR')
    NetworkOverrideClockTime(23,0,0)
  else
    if Config.UsingVSync then
      TriggerEvent('vSync:toggle',true)
      TriggerServerEvent('vSync:requestSync')
    else
      h,m,s = NetworkGetGlobalMultiplayerClock()
      NetworkOverrideClockTime(h,m,s)
    end
  end
end

RegisterNetEvent("Allhousing:Calledback")
AddEventHandler("Allhousing:Calledback",_Calledback)

RegisterNetEvent("Allhousing:NotifyPlayer")
AddEventHandler("Allhousing:NotifyPlayer",ShowNotification)