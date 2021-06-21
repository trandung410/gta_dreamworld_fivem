local spawnedPoppys = 0
local PoppyPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinField.coords, true) < 50 then
			SpawnPoppyPlants()
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

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinProcessing.coords, true) < 5 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('heroin_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then
				local PlayerData = ESX.GetPlayerData()
				if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then
					if Config.LicenseEnable then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
							if hasProcessingLicense then
								ProcessHeroin()
							else
								OpenBuyLicenseMenu('heroin_processing')
							end
						end, GetPlayerServerId(PlayerId()), 'heroin_processing')
					else
						ProcessHeroin()
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

function ProcessHeroin()
	isProcessing = true
	TriggerEvent("mythic_progbar:client:progress", {
		name = "unique_action_name",
		duration = Config.Delays.HeroinProcessing,
		label = "Đang chế tạo heroin",
		useWhileDead = false,
		canCancel = true,
	})
	TriggerServerEvent('esx_illegal:processPoppyResin')
	local timeLeft = Config.Delays.HeroinProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.HeroinProcessing.coords, false) > 5 then
			ESX.ShowNotification(_U('heroin_processingtoofar'))
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

		for i=1, #PoppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(PoppyPlants[i]), false) < 1 then
				nearbyObject, nearbyID = PoppyPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('heroin_pickupprompt'))
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
							-- 	label = "Đang hái hoa anh túc",
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
			
							-- table.remove(PoppyPlants, nearbyID)
							-- spawnedPoppys = spawnedPoppys - 1
			
							-- TriggerServerEvent('esx_illegal:pickedUpPoppy')
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
			
									table.remove(PoppyPlants, nearbyID)
									spawnedPoppys = spawnedPoppys - 1
					
									TriggerServerEvent('esx_illegal:pickedUpPoppy')
								end
							end)
						else
							ESX.ShowNotification("Cán bộ nhà nước không thể làm việc này")
						end
					--else
						--ESX.ShowNotification(_U('poppy_inventoryfull'))
					end

					isPickingUp = false

				end, 'poppyresin')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(PoppyPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnPoppyPlants()
	while spawnedPoppys < 15 do
		Citizen.Wait(0)
		local heroinCoords = GenerateHeroinCoords()

		ESX.Game.SpawnLocalObject('prop_cs_plant_01', heroinCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(PoppyPlants, obj)
			spawnedPoppys = spawnedPoppys + 1
		end)
	end
end

function ValidateHeroinCoord(plantCoord)
	if spawnedPoppys > 0 then
		local validate = true

		for k, v in pairs(PoppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HeroinField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateHeroinCoords()
	while true do
		Citizen.Wait(1)

		local heroinCoordX, heroinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		heroinCoordX = Config.CircleZones.HeroinField.coords.x + modX
		heroinCoordY = Config.CircleZones.HeroinField.coords.y + modY

		local coordZ = GetCoordZHeroin(heroinCoordX, heroinCoordY)
		local coord = vector3(heroinCoordX, heroinCoordY, coordZ)

		if ValidateHeroinCoord(coord) then
			return coord
		end
	end
end

function GetCoordZHeroin(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end