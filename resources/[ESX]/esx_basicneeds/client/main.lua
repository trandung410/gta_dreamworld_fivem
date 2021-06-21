ESX          = nil
local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#FFFF00', function(status) -- #CFAD0F -- Amarelo
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0099FF', function(status) -- #0C98F1 -- Azul
		return true
	end, function(status)
		status.remove(75)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					ESX.ShowNotification('🚫 Bạn đang đói')
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					ESX.ShowNotification('🚫 Bạn đang khát nước')
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
            	
				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
				--
            -- TriggerEvent("mythic_progbar:client:progress", {
						 
		    --     name = "unique_action_name",
		    --     duration = 5000,
			--     label = "Đang uống...",
			--     useWhileDead = false,
			--     canCancel = false,
			--     controlDisables = {
			--        disableMovement = true,
			--        disableCarMovement = true,
			--        disableMouse = false,
			--         disableCombat = true,
			--         },
								
			--      }, function(status)
			-- 	    if not status then
			-- 		-- Do Something If Event Wasn't Cancelled
			-- 	    end
		    -- end)
				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)


RegisterNetEvent('esx_weedpooch:Onbong')
AddEventHandler('esx_weedpooch:Onbong', function(prop_name)
local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('anim@safehouse@bong')
        
    while not HasAnimDictLoaded('anim@safehouse@bong') do
      Citizen.Wait(0)
    end
    
    ESX.Game.SpawnObject('hei_heist_sh_bong_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    ESX.Game.SpawnObject('p_cs_lighter_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object2)
    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "anim@safehouse@bong", "bong_stage1", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(1500)
      AttachEntityToEntity(object2, playerPed, boneIndex2, 0.10, 0.0, 0, 99.0, 192.0, 180.0, true, true, false, true, 1, true)
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, -0.25, 0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
      Citizen.Wait(30000)
      DeleteObject(object)
      DeleteObject(object2)
      ClearPedSecondaryTask(playerPed)
      end)
     end)
    end)
  end)
end)

-- Cigarett 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx_cigarett:startSmoke')
AddEventHandler('esx_cigarett:startSmoke', function(source)
	SmokeAnimation()
end)

RegisterNetEvent('esx_cigarett:startmarijuana')
AddEventHandler('esx_cigarett:startmarijuana', function(source)
	SmokemarijuanaAnimation()
end)

function SmokeAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)               
	end)
end

function SmokemarijuanaAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, true)               
	end)
end

-- Optionalneeds
function Drunk(level, start)
  
  Citizen.CreateThread(function()
     local playerPed = GetPlayerPed(-1)
     if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end
     if level == 0 then
       RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
     elseif level == 1 then
       RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
     elseif level == 2 then
       RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end
       SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
     end
     SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
     if start then
      DoScreenFadeIn(800)
    end
   end)
 end
 function Reality()
   Citizen.CreateThread(function()
     local playerPed = GetPlayerPed(-1)
     DoScreenFadeOut(800)
    Wait(1000)
     ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
     DoScreenFadeIn(800)
   end)
 end
 AddEventHandler('esx_status:loaded', function(status)
   TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', --roxo
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )
 	Citizen.CreateThread(function()
 		while true do
 			Wait(10000)
 			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				
				if status.val > 0 then
					
          local start = true
           if IsAlreadyDrunk then
            start = false
          end
           local level = 0
           if status.val <= 250000 then
            level = 0
          elseif status.val <= 500000 then
            level = 1
          else
            level = 2
          end
           if level ~= DrunkLevel then
            Drunk(level, start)
          end
           IsAlreadyDrunk = true
          DrunkLevel     = level
				end
 				if status.val == 0 then
          
          if IsAlreadyDrunk then
            Reality()
          end
           IsAlreadyDrunk = false
          DrunkLevel     = -1
 				end
 			end)
 		end
 	end)
 end)
 RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
  local playerPed = GetPlayerPed(-1)
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)
 end) 