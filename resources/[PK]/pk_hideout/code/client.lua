-- *** illegal hideout
-- ! by kapu

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local taking = false
local targetLocation = nil
local location = {
  -- lsdf = vector3(506.215, -2145.755, 5.917),
  lf = vector3(-813.78, 178.26, 75.74),
  -- lsf = vector3(-202.050, 309.455, 96.94),
  -- lsfg = vector3(1375.868, -740.676, 67.23),
  -- sf = vector3(-884.14, -1487.44, 5.02)
}

local blips = {
-- {x = 506.215, y = -2145.755, z = 5.917}, 
 {x = -813.78, y = 178.26, z = 46.74}, 
-- {x = -202.050, y = 309.455, z = 96.94},
-- {x = 1375.868, y = -740.676, z = 67.23},
-- {x = -884.14, y = -1487.44, z = 5.02},

}

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
end)
	
police = {}
	function UpdatePlayerTable(connectedPlayers)
		local formattedPlayerList, num = {}, 1
		local police, players = 0, 0

		for k,v in pairs(connectedPlayers) do

		

			players = players + 1

			
			if v.job == 'police' then
				police = police + 1
			end

			
			
		end
		
	end

CreateThread(function()
  while true do
    Wait(0)
    for _, val in pairs(location) do
      DrawMarker(29, val.x, val.y, val.z + 2, 0.0, 0.0, 88.5, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 255, true, true, 2, 'GolfPutting', nil, false)
    end
  end
end)

Citizen.CreateThread(function()
	Citizen.Wait(0)
	local bool = true
	if bool then
		for k,v in pairs(blips) do
               zoneblip = AddBlipForRadius(v.x,v.y,v.z, 1250.0)
                          SetBlipSprite(zoneblip,1)
                          SetBlipColour(zoneblip,38)
                          SetBlipAlpha(zoneblip,75)
        end
	   bool = false
   end
end)



function interrupt()
  TriggerServerEvent('pk_hideout:captureHideoutInterrupt', targetLocation)
  --exports['progressBars']:stopUI()
  taking = false
  targetLocation = nil
  -- TriggerEvent('chat:addMessage', {
    -- color = { 255, 0, 0},
    -- multiline = true,
    -- args = {"capture interrupted!"}
  -- })
  TriggerEvent('chat:addMessage', { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 123, 235, 0.6); border-radius: 3px;"><i class="fas fa-balance-scale"></i> {0} : {1}</div>',
					args = { '[HIDEOUT]',"Việc chiếm giữ khu vực đã bị cản trở!"}
		})
end

function capture(time)
  time = time or 10
  taking = true
 -- exports['progressBars']:startUI(time or 30000, "กำลังยึดไฮเอ้า . . .")
 exports['pk_LoadBar']:startUI(time or 30000, "Giữ Hi-A...")
--  TriggerEvent("mythic_progressbar:client:progress", {
						 
--   name = "unique_action_name",
--   duration = time,
--   label = "กำลังยึดจุด...",
--   useWhileDead = false,
--   canCancel = false,
--   controlDisables = {
--      disableMovement = true,
--      disableCarMovement = true,
--      disableMouse = false,
--       disableCombat = true,
--       },
                  
--    }, function(status)
--       if not status then
--       -- Do Something If Event Wasn't Cancelled
--       end
-- end)
Citizen.Wait(time)
  local coords = nil
  local pedId = PlayerPedId()
  local finishTime = GetGameTimer() + time
  while finishTime > GetGameTimer() do
    Wait(0)
    coords = GetEntityCoords(pedId)
    if GetDistanceBetweenCoords(coords, location[targetLocation], true) > 10 then
      interrupt()
      return
    end
  end
  taking = false
  targetLocation = nil
end

function getLocation(pedId, rad)
  for key, val in pairs(location) do
    if GetDistanceBetweenCoords(GetEntityCoords(pedId), val, true) < rad then 
      return key
    end
  end
end

RegisterNetEvent("pk_hideout:set")
AddEventHandler("pk_hideout:set", function(gg)
    taking = gg
end)

CreateThread(function()
  
  while true do
	local pedId = PlayerPedId()
	local me = GetPlayerServerId(PlayerId())
    Wait(0)
    targetLocation = getLocation(pedId, 2)
	--print(taking)
    if not taking and targetLocation ~= nil then
      ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ ~w~to capture ~r~illegal hideout')
      if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        ESX.TriggerServerCallback('pk_hideout:captureHideout', function(taker, time)
          if taker == 'owned' then
            -- TriggerEvent('chat:addMessage', {
              -- color = { 255, 0, 0},
              -- multiline = true,
              -- args = {"you own this"}
            -- })
            TriggerEvent('chat:addMessage', { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 123, 235, 0.6); border-radius: 3px;"><i class="fas fa-balance-scale"></i> {0} : {1}</div>',
						args = { '[HIDEOUT]',"Bạn là chủ sở hữu"}
      })
            return
          elseif me ~= taker then
            -- TriggerEvent('chat:addMessage', {
              -- color = { 255, 0, 0},
              -- multiline = true,
              -- args = {"this is being captured by others player!"}
            -- })
            TriggerEvent('chat:addMessage', { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 123, 235, 0.6); border-radius: 3px;"><i class="fas fa-balance-scale"></i> {0} : {1}</div>',
					args = { '[HIDEOUT]',"Ai đó đang cố gắng chiếm lãnh thổ của bạn!"}
			})
            return
          end
          capture(time)
          
        end, targetLocation)
			Citizen.Wait(1000)
		end
    end
  end
end)



