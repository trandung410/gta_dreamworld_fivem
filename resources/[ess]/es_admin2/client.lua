ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local group = "user"
local states = {}
states.frozen = false
states.frozenPos = nil
local godmode = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if (IsControlJustPressed(1, 212) and IsControlJustPressed(1, 213)) then
			if group == "superadmin" then
				if true then
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'open', players = getPlayers()})
				end
			end
		end
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback('quick', function(data, cb)
	if data.type == "slay_all" or data.type == "bring_all" or data.type == "slap_all" then
		TriggerServerEvent('es_admin:all', data.type)
	else
		TriggerServerEvent('es_admin:quick', data.id, data.type)
	end
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.type, data.user, data.param)
end)

local noclip = false
RegisterNetEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(t, target)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) end
	if t == "goto" then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
			targetPed = GetVehiclePedIsUsing(GetPlayerPed(-1))
			SetEntityCoordsNoOffset(targetPed, GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))), 0, 0, 1)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), targetPed, -1)
		else
			SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
		end
	end
	if t == "bring" then 
		states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
		SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
	end
	if t == "crash" then 
		Citizen.Trace("You're being crashed, so you know. This server sucks.\n")
		Citizen.CreateThread(function()
			while true do end
		end) 
	end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "noclip" then
		local msg = "disabled"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(PlayerPedId(), false)
		end

		noclip = not noclip

		if(noclip)then
			msg = "enabled"
		end

		TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
	end
	if t == "freeze" then
		local player = PlayerId()

		local ped = PlayerPedId()

		states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)

		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			SetPlayerInvincible(player, true)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		else
			Citizen.Wait(200)
		end
	end
end)

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
			SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

			if(IsControlPressed(1, 34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
		targetPed = GetVehiclePedIsUsing(GetPlayerPed(-1))
		SetEntityCoordsNoOffset(targetPed, x, y, z, 0, 0, 1)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), targetPed, -1)
	else
		SetEntityCoords(PlayerPedId(), x, y, z)
	end
end)

RegisterNetEvent('es_admin:repair')
AddEventHandler('es_admin:repair', function()
	local playerPed = PlayerPedId()
	local vehicle
	if IsPedSittingInAnyVehicle(playerPed) then
		vehicle = GetPlayersLastVehicle()
	else
		vehicle = ESX.Game.GetVehicleInDirection()
	end
	if DoesEntityExist(vehicle) then
		local plate = GetVehicleNumberPlateText(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleFuelLevel(vehicle, 100)
		TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, 100)
	end
end)

RegisterNetEvent('es_admin:teleportGPS')
AddEventHandler('es_admin:teleportGPS', function()
    local blip = GetFirstBlipInfoId(8)
    if (blip ~= 0) then
        local coord = GetBlipCoords(blip)
		if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
			targetPed = GetVehiclePedIsUsing(GetPlayerPed(-1))
			--SetEntityCoordsNoOffset(targetPed, coord.x, coord.y, 0.0, 0, 0, 1)
			--TaskWarpPedIntoVehicle(GetPlayerPed(-1), targetPed, -1)
			local groundz
			for i = 0, 20 do
				groundz = 0 + (i * 50.0)
				SetEntityCoordsNoOffset(PlayerPedId(), coord.x, coord.y, groundz, 0.0, 0, 0, 1)
				Citizen.Wait(10)
				unusedBool, spawnZ = GetGroundZFor_3dCoord(coord.x, coord.y, groundz)
				if unusedBool then
					break
				end
				Citizen.Wait(10)
			end
			Citizen.Wait(10)
			spawnZ = spawnZ + 5.0
			SetEntityCoordsNoOffset(PlayerPedId(), coord.x, coord.y, spawnZ, 0.0, 0, 0, 1)
			SetEntityCoordsNoOffset(targetPed, coord.x, coord.y, spawnZ, 0, 0, 1)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), targetPed, -1)
		else
			local groundz
			for i = 0, 20 do
				groundz = 0 + (i * 50.0)
				SetEntityCoordsNoOffset(PlayerPedId(), coord.x, coord.y, groundz, 0.0, 0, 0, 1)
				Citizen.Wait(10)
				unusedBool, spawnZ = GetGroundZFor_3dCoord(coord.x, coord.y, groundz)
				if unusedBool then
					break
				end
				Citizen.Wait(10)
			end
			Citizen.Wait(10)
			spawnZ = spawnZ + 5.0
			SetEntityCoordsNoOffset(PlayerPedId(), coord.x, coord.y, spawnZ, 0.0, 0, 0, 1)
		end
    end
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = PlayerPedId()

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent('es_admin:crash')
AddEventHandler('es_admin:crash', function()
	while true do
	end
end)

RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	local player = PlayerId()
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
		SetEntityVisible(player, true, false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
		SetEntityVisible(player, false, false)
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)



RegisterNetEvent('es_admin:godmode')
AddEventHandler('es_admin:godmode', function()
	local msg = "disabled"

	godmode = not godmode

	if(godmode)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Godmode has been ^2^*" .. msg)
end)

RegisterNetEvent('es_admin:ccardel')
AddEventHandler('es_admin:ccardel', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()

	if IsPedInAnyVehicle(playerPed, true) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	end

	if DoesEntityExist(vehicle) then
		SetEntityAsMissionEntity(vehicle, true, true)
		--DeleteVehicle(vehicle)
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
	end
end)

function getPlayers()
	local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		--if NetworkIsPlayerActive(player) then
			table.insert(players, {id = GetPlayerServerId(player), name = GetPlayerName(player)})
		--end
	end
	return players
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if (godmode == true) then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
		elseif (godmode == false) then
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		end
	end
end)