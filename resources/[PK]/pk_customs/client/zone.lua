
local zones = {
	{ ['x'] = 297.44, ['y'] = -587.26, ['z'] = 43.27 },
	{ ['x'] = 335.49, ['y'] = -578.89, ['z'] = 43.32 }
}

local notifIn = false
local notifOut = false
local closestZone = 1


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	for i = 1, #zones, 1 do
		local blip = AddBlipForRadius(zones[i].x, zones[i].y, zones[i].z, 50.0)
	
		SetBlipColour(blip,0)
		SetBlipAlpha(blip,0)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		if (safe ~= 0) then
			local player = GetPlayerPed(-1)
			local x,y,z = table.unpack(GetEntityCoords(player, true))
			local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
		
			if dist <= 50.0 then 
				if not notifIn then																			
					ClearPlayerWantedLevel(PlayerId())
					SetEntityInvincible(player, true)
					--SetPedArmour(player, 500)
					ClearPedBloodDamage(player)
					ResetPedVisibleDamage(player)
					ClearPedLastWeaponDamage(player)
					ResetPedMovementClipset(player, 0)
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
					TriggerEvent("pNotify:SendNotification",{
						text = "<span style='font-size:14;font-weight: 900'>Safezone</span><br>Bạn đã vào Safezone.",
						type = "info",
						timeout = (3000),
						layout = "topRight",
						queue = "global"
					})
					notifIn = true
					notifOut = false
				end
			else
				if not notifOut then
					SetEntityInvincible(player, false)
					TriggerEvent("pNotify:SendNotification",{
						text = "<span style='font-size:14;font-weight: 900'>Safezone</span><br>Bạn đã ra khỏi Safezone.",
						type = "error",
						timeout = (3000),
						layout = "topRight",
						queue = "global"
					})
					notifOut = true
					notifIn = false
				end
			end
			if notifIn then
			DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			--DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(2, 263, true) -- Disable in-game mouse controls
			DisableControlAction(2, 140, true)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisableControlAction(2, 25, true) -- disable RIGHT MOUSE
			DisableControlAction(2, 141, true) -- disable Q
			DisableControlAction(2, 44, true) -- disable แอบ
			DisableControlAction(2, 345, true) -- disable X
			DisableControlAction(2, 56, true) -- disable F9
			DisableControlAction(2, 36, true) -- disable CTRL
			DisableControlAction(2, 36, true) -- disable CTRL
			DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(2, 263, true) -- Disable in-game mouse controls
				if IsDisabledControlJustPressed(2, 37, 56) then
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				end
				if IsDisabledControlJustPressed(0, 106, 56) then 
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				end
				if IsDisabledControlJustPressed(0, 263, 56) then 
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				end
			end
			Citizen.Wait(safe == 0 and 5000 or 1000);
		end
	end
end)