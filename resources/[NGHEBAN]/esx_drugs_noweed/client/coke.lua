local spawnedCocaLeaf = 0
local CocaPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeField.coords, true) < 50 then
			SpawnCocaPlants()
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

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeProcessing.coords, true) < 5 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('coke_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then
				local PlayerData = ESX.GetPlayerData()
				if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic' and PlayerData.job.name ~= 'fbi' then

					if Config.LicenseEnable then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
							if hasProcessingLicense then
								ProcessWeed()
							else
								OpenBuyLicenseMenu('coke_processing')
							end
						end, GetPlayerServerId(PlayerId()), 'coke_processing')
					else
						ProcessCoke()
					end
				else
					ESX.ShowNotification("Cán bộ nhà nước không thể làm việc này")
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessCoke()

	isProcessing = true
	TriggerEvent("mythic_progbar:client:progress", {
		name = "unique_action_name",
		duration = Config.Delays.CokeProcessing,
		label = "Đang chế tạo cocain",
		useWhileDead = false,
		canCancel = true,
	})
	TriggerServerEvent('esx_illegal:processCocaLeaf')
	local timeLeft = Config.Delays.CokeProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CokeProcessing.coords, false) > 5 then
			ESX.ShowNotification(_U('coke_processingtoofar'))
			TriggerServerEvent('esx_illegal:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #CocaPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 1 then
				nearbyObject, nearbyID = CocaPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('coke_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true
				local 		PlayerData = ESX.GetPlayerData()

				ESX.TriggerServerCallback('Cothenhat', function(canPickUp)

					if canPickUp then
						if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic' and PlayerData.job.name ~= 'fbi' then

							-- TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
							-- TriggerEvent("mythic_progbar:client:progress", {
							-- 	name = "unique_action_name",
							-- 	duration = 2000,
							-- 	label = "Đang hái lá cocain",
							-- 	useWhileDead = false,
							-- 	canCancel = false,
							-- 	controlDisables = {
							-- 		disableMovement = false,
							-- 		disableCarMovement = false,
							-- 		disableMouse = false,
							-- 		disableCombat = false,
							-- 	}
							-- })
							-- ClearPedTasks(playerPed)
							-- Citizen.Wait(1500)
			
							-- ESX.Game.DeleteObject(nearbyObject)
			
							-- table.remove(CocaPlants, nearbyID)
							-- spawnedCocaLeaf = spawnedCocaLeaf - 1
			
							-- TriggerServerEvent('esx_illegal:pickedUpCocaLeaf')
							TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
							TriggerEvent("mythic_progbar:client:progress",{
								name = "weed_pick",
								duration = 3500,
								label = "Đang hái",
								useWhileDead = false,
								canCancel = false,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true
								}
							},function(status)
								ClearPedTasksImmediately(playerPed)
								isPickingUp = false
								if not status then
									ESX.Game.DeleteObject(nearbyObject)
			
									table.remove(CocaPlants, nearbyID)
									spawnedCocaLeaf = spawnedCocaLeaf - 1
					
									TriggerServerEvent('esx_illegal:pickedUpCocaLeaf')
								end
							end)
						else
							ESX.ShowNotification("Cán bộ nhà nước không thể làm việc này")
						end
					--else
						--ESX.ShowNotification(_U('coke_inventoryfull'))
					end

					isPickingUp = false

				end, 'coca_leaf')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CocaPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCocaPlants()
	while spawnedCocaLeaf < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateCocaLeafCoords()

		ESX.Game.SpawnLocalObject('prop_plant_01a', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(CocaPlants, obj)
			spawnedCocaLeaf = spawnedCocaLeaf + 1
		end)
	end
end

function ValidateCocaLeafCoord(plantCoord)
	if spawnedCocaLeaf > 0 then
		local validate = true

		for k, v in pairs(CocaPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CokeField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCocaLeafCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.CokeField.coords.x + modX
		weedCoordY = Config.CircleZones.CokeField.coords.y + modY

		local coordZ = GetCoordZCoke(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

function GetCoordZCoke(x, y)
	local groundCheckHeights = { 100.0, 111.0, 112.0, 113.0, 114.0, 115.0,116.0, 117.0, 118.0, 119.0, 120.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 70
end