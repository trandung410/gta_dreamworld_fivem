local spawnedShells = 0
local shellss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.ShellField.coords, true) < 50 then
			SpawnShellls()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #shellss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(shellss[i]), false) < 1 then
				DrawText3Ds(GetEntityCoords(shellss[i]).x,GetEntityCoords(shellss[i]).y, GetEntityCoords(shellss[i]).z + 0.5, "[E]-Drilling")
				nearbyObject, nearbyID = shellss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			        if not isPickingUp then
				       ESX.ShowHelpNotification("Nhấn ~r~[E]~s~ để ~g~đào đá")
			        end

					if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
						
					    ESX.TriggerServerCallback('esx_oiljob:haveItem', function(haveItem)
					        if haveItem then
				                isPickingUp = true


				                ESX.TriggerServerCallback('esx_oiljob:canPickUp', function(canPickUp)
										
									IsProcessing = true
									if canPickUp then
											--if minigame1 == 100 then
												TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CONST_DRILL', 0, false)
												TriggerEvent("mythic_progbar:client:progress", {
						 
													name = "unique_action_name",
													duration = 10000,
													label = "Đang đào đá...",
													useWhileDead = false,
													canCancel = false,
													controlDisables = {
													   disableMovement = true,
													   disableCarMovement = true,
													   disableMouse = false,
														disableCombat = true,
														},
																	
													 }, function(status)
														if not status then
														-- Do Something If Event Wasn't Cancelled
														end
												end)
						             			Citizen.Wait(10000)
						               			ClearPedTasks(playerPed)
						               			Citizen.Wait(1000)		
						               			spawnedShells = spawnedShells - 1
												TriggerServerEvent('esx_oiljob:pickedUpCannabis')
												ESX.Game.DeleteObject(nearbyObject)
												table.remove(shellss, nearbyID)
												IsProcessing = false 
											--else
												--IsProcessing = false
											--end		   
									end

					                isPickingUp = false
				            	end, 'stone')
						else
							ESX.ShowNotification("You need to buy Drill")
						end
                    end)
				end
		else
			Citizen.Wait(500)
		end

	end

end)




AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(shellss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnShellls()
	while spawnedShells < 15 do
		Citizen.Wait(0)
		local shellCoords = GenerateShellCoords()

		ESX.Game.SpawnLocalObject('prop_rock_4_d', shellCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(shellss, obj)
			spawnedShells = spawnedShells + 1
		end)
	end
end

function ValidateShellCoord(plantCoord)
	if spawnedShells > 0 then
		local validate = true

		for k, v in pairs(shellss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 8 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.ShellField.coords, false) > 80 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateShellCoords()
	while true do
		Citizen.Wait(100)

		local shellCoordX, shellCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		shellCoordX = Config.CircleZones.ShellField.coords.x + modX
		shellCoordY = Config.CircleZones.ShellField.coords.y + modY

		local coordZ = GetCoordZ(shellCoordX, shellCoordY)
		local coord = vector3(shellCoordX, shellCoordY, coordZ)

		if ValidateShellCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end
function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

Citizen.CreateThread(function()
	
	LoadAnimDict('mini@repair')
	
end)

local isProcessing = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		
		if GetDistanceBetweenCoords(coords, Config.CircleZones.process.coords, true) < 1 then
		    DrawText3Ds(Config.CircleZones.process.coords.x,Config.CircleZones.process.coords.y, Config.CircleZones.process.coords.z + 0.5, "<FONT FACE='Montserrat'>Khu vực rửa đá")
			if not isProcessing then
				ESX.ShowHelpNotification("Nhấn ~r~[E]~s~ rửa ~g~đá")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					TriggerEvent("mythic_progbar:client:progress", {
						name = "chicken_process",
						duration = 4000,
						label = "Rửa đá",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
							TaskPlayAnim(PlayerPedId(), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 48, 0, false, false, false )	
						}
					}, function(status)
					if not status then
						TriggerServerEvent('tgt_stone:process')
						ClearPedTasks(PlayerPedId())
						isProcessing = false
						end
					end)
			end			
		else
			Citizen.Wait(500)
		end
	end
end)


local isPacking = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		
		if GetDistanceBetweenCoords(coords, Config.CircleZones.Packing.coords, true) < 1 then
		    DrawText3Ds(Config.CircleZones.Packing.coords.x,Config.CircleZones.Packing.coords.y, Config.CircleZones.Packing.coords.z + 0.5, "<FONT FACE='Montserrat'>Khu vực nung đá")
			if not isPacking then
				ESX.ShowHelpNotification("Nhấn ~r~[E]~s~ nung ~g~đá")
			end

		if IsControlJustReleased(0, 38) and not isPacking then
			TriggerEvent("mythic_progbar:client:progress", {
				name = "stone_packing",
				duration = 9000,
				label = "Nung đá...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
				TaskPlayAnim(PlayerPedId(), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 48, 0, false, false, false )
			}
		 }, function(status)
        if not status then
			TriggerServerEvent('tgt_stone:packing')
			ClearPedTasks(PlayerPedId())
			isProcessing = false
			end
		end)					
			end	
		else
			Citizen.Wait(500)
		end
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.3, 0.3)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 450
    DrawRect(_x, _y + 0.0110, 0.015 + factor, 0.03, 41, 11, 41, 100)
end