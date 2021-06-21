local spawnedWeeds1 = 0
local spawnedWeeds2 = 0
local weedPlants1 = {}
local weedPlants2 = {}
local isPickingUp1, isPickingUp2, IsProcessing, IsOpenMenu = false, false, false, false

ObjectLists = 0
ObjectArray = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
end)

-- Spawn Object
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.Zone1.coords, true) < 50 then
			SpawnWeedPlants1()
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
		local nearbyObject1, nearbyID1

		for i=1, #weedPlants1, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants1[i]), false) < 1 then
				nearbyObject1, nearbyID1 = weedPlants1[i], i
			end
		end

		if nearbyObject1 and IsPedOnFoot(playerPed) then

			if not isPickingUp1 then
				ESX.ShowHelpNotification("Nhấn ~INPUT_CONTEXT~ để hái ~g~ cây cần sa~s~")
			end

			if IsControlJustReleased(0, Config.Key['E']) and not isPickingUp1 then
				exports[Config.pro]:startUI(Config.time  * 1000, Config.load)
				isPickingUp1 = true

				ESX.TriggerServerCallback('pk_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(1500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject1)
		
						table.remove(weedPlants1, nearbyID1)
						spawnedWeeds1 = spawnedWeeds1 - 1
		
						TriggerServerEvent('pk_drugs:pickedUp')
					else
						ESX.ShowNotification("you do not have any more inventory space for ~g~Cannabis~s~")
					end

					isPickingUp1 = false

				end, 'cannabis')
			end

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
		local nearbyObject2, nearbyID2

		for i=1, #weedPlants2, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants2[i]), false) < 1 then
				nearbyObject2, nearbyID2 = weedPlants2[i], i
			end
		end

		if nearbyObject2 and IsPedOnFoot(playerPed) then

			if not isPickingUp2 then
				ESX.ShowHelpNotification("Nhấn ~INPUT_CONTEXT~ to harvest the ~g~Cannabis~s~ plant.")
			end

			if IsControlJustReleased(0, Config.Key['E']) and not isPickingUp2 then
				isPickingUp2 = true

				ESX.TriggerServerCallback('pk_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject2)
		
						table.remove(weedPlants2, nearbyID2)
						spawnedWeeds2 = spawnedWeeds2 - 1
		
						TriggerServerEvent('pk_drugs:pickedUp')
					else
						ESX.ShowNotification("you do not have any more inventory space for ~g~Cannabis~s~")
					end

					isPickingUp2 = false

				end, 'cannabis')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

function SpawnWeedPlants1()
	while spawnedWeeds1 < 25 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords1()

		ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants1, obj)
			spawnedWeeds1 = spawnedWeeds1 + 1
		end)
	end
end

function ValidateWeedCoord1(plantCoord)
	if spawnedWeeds1 > 0 then
		local validate = true

		for k, v in pairs(weedPlants1) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.Zone1.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end


function GenerateWeedCoords1()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.WeedField.Zone1.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.Zone1.coords.y + modY

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord1(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 38.0, 39.0, 40.0, 41.0, 42.0, 43.04, 44.0, 45.0, 46.0, 47.0, 18.0, 19.0, 20.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants1) do
			ESX.Game.DeleteObject(v)
		end
		for k, v in pairs(weedPlants2) do
			ESX.Game.DeleteObject(v)
		end
	end
end)