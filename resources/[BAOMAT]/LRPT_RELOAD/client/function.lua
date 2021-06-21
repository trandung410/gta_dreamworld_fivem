function DrawText3D(coords, text, size, font)
    coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function DrawH(target, lastH, lastA, coords)
    Citizen.CreateThread(function()
        local newH = GetEntityHealth(target)
        local newA = GetPedArmour(target)
        if lastA == 0 then 
            while newH == lastH do 
                newH = GetEntityHealth(target)
                coroutine.yield(0)
            end
            local dmg = lastH - newH
            if dmg > 0 then 
                for i = 1, 100, 1 do 
                    local tCoords = GetEntityCoords(target)
                    DrawText3D({x = tCoords.x, y = tCoords.y, z = tCoords.z + 1 + (i/100)}, '~r~'..dmg, 2.0, 7)
                    Wait(10)
                end
            end
        else
            while newA == lastA do 
                newA = GetPedArmour(target)
                coroutine.yield(0)
            end
            local dmg = lastA - newA
            if dmg > 0 then 
                for i = 1, 100, 1 do 
                    local tCoords = GetEntityCoords(target)
                    DrawText3D({x = tCoords.x, y = tCoords.y, z = tCoords.z + 1 + (i/100)}, '~b~'..dmg, 2.0, 7)
                    Wait(10)
                end
            end
        end
    end)
end

SpawnVehicle = function(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		LRRequestModel(model)

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
		local networkId = NetworkGetNetworkIdFromEntity(vehicle)
		local timeout = 0

		SetNetworkIdCanMigrate(networkId, true)
		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehRadioStation(vehicle, 'OFF')
		SetModelAsNoLongerNeeded(model)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		-- we can get stuck here if any of the axies are "invalid"
		while not HasCollisionLoadedAroundEntity(vehicle) and timeout < 2000 do
			Citizen.Wait(0)
			timeout = timeout + 1
		end
		if cb then
			cb(vehicle)
		end
	end)
end

function LRRequestModel(modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end