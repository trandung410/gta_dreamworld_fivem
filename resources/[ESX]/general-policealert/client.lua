local ESX = nil
local gender = "male"

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent("general-policealert:sendLocation")
AddEventHandler("general-policealert:sendLocation", function(pos)
	SetNewWaypoint(pos.x, pos.y)
	TriggerEvent("pNotify:SendNotification",  {
		text = "<span style='font-size:16;font-weight: 900'>System</span><br>Mark GPS to Location",
		type = "success",
		timeout = 2000,
		layout = Config["alert_position"]
	})

	TriggerServerEvent("general-policealert:accept", name)
end)

local ispressed = function(input, key)
	return IsControlPressed(input, key) or IsDisabledControlPressed(input, key)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		local num
		
		if ispressed(1, 157) then
			num = 1
		elseif ispressed(1, 158) then
			num = 2
		elseif ispressed(1, 160) then
			num = 3
		elseif ispressed(1, 164) then
			num = 4
		elseif ispressed(1, 165) then
			num = 5
		elseif ispressed(1, 159) then
			num = 6
		elseif ispressed(1, 161) then
			num = 7
		elseif ispressed(1, 162) then
			num = 8
		elseif ispressed(1, 163) then
			num = 9
		end

		if ispressed(1, Config["base_key"]) and num and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			TriggerServerEvent("general-policealert:getLocation", num)
			Citizen.Wait(1000)
		end
	end
end)

local getStreetName = function()
	local pos = GetEntityCoords(PlayerPedId())
	local streetName, _ = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	streetName = GetStreetNameFromHashKey(streetName)
	return streetName
end

AddEventHandler('skinchanger:loadSkin', function(c)
	gender = (c.sex == 0 and "male" or "female")
end)

RegisterNetEvent('general-policealert:alertArea')
AddEventHandler('general-policealert:alertArea', function(pos)

	Citizen.CreateThread(function()
		SendNUIMessage({
			type = 'playsound',
		})
	
		local v = AddBlipForRadius(pos.x, pos.y, pos.z, Config["red_radius"])
		
		SetBlipHighDetail(v, true)
		SetBlipColour(v, 1)
		SetBlipAlpha(v, 200)
		SetBlipAsShortRange(v, true)
		
		local a = 200
		local t = (a / Config["duration"]) * 100
		local r = (a / Config["duration"])
		while a > 0 do
			a = a - r
			if a <= 0 then
				RemoveBlip(v)
			else
				SetBlipAlpha(v, math.floor(a))
			end
			Citizen.Wait(t)
		end
	end)
end)

AddEventHandler("general-policealert:alertNet", function(event_type)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	TriggerServerEvent("general-policealert:defaultAlert", event_type, gender, getStreetName(), pos)
end)

RegisterNetEvent("general-policealert:getalertNet")
AddEventHandler("general-policealert:getalertNet", function(event_type)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	TriggerServerEvent("general-policealert:defaultAlert", event_type, gender, getStreetName(), pos)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if Config["alert_section"]["carjacking"] and IsPedJacking(ped) then
			Citizen.Wait(1000)
			local car = GetVehiclePedIsIn(ped)
			local seat = GetPedInVehicleSeat(car,-1)
			if seat == ped then
				local pos = GetEntityCoords(ped)
				TriggerServerEvent("general-policealert:defaultAlert", "carjacking", gender, getStreetName(), pos)
			end
			Citizen.Wait(Config["duration"] * 1000)
		elseif Config["alert_section"]["melee"] and IsPedInMeleeCombat(ped) then
			Citizen.Wait(1000)
			local pos = GetEntityCoords(ped)
			TriggerServerEvent("general-policealert:defaultAlert", "melee", gender, getStreetName(), pos)
			Citizen.Wait(Config["duration"] * 1000)
		elseif Config["alert_section"]["gunshot"] and IsPedShooting(ped) and not IsPedCurrentWeaponSilenced(ped) then
			Citizen.Wait(1000)
			local pos = GetEntityCoords(ped)
			TriggerServerEvent("general-policealert:defaultAlert", "gunshot", gender, getStreetName(), pos)
			Citizen.Wait(Config["duration"] * 1000)
		end
	end
end)