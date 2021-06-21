
ESX                           = nil
local PlayerData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
	TriggerServerEvent("esx:playerconnected")


end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local isJacking = true
local isStolen = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsPedInAnyVehicle(GetPlayerPed(-1)))then
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
			if(IsVehicleStolen(vehicle) and isStolen )then
				Wait(1000)
				TriggerServerEvent("esx:jackingcar",GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
				isStolen = false
			end
		else
			isStolen = true
			vehicle = nil
		end

		if(IsPedJacking(GetPlayerPed(-1))) then
				if(settings.LogPedJacking == true and isJacking) then
					local playerPed = GetPlayerPed(-1)
					local coords    = GetEntityCoords(playerPed)

					local vehicle = nil

					if IsPedInAnyVehicle(playerPed) then
						vehicle = GetVehiclePedIsIn(playerPed)

					else
						vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)

					end
					Wait(1000)
					TriggerServerEvent("esx:jackingcar",GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

					isJacking = false
					vehicle = nil

				end
		else
			isJacking = true
		end




	end
end)


--add re car inventoryhud_trunk
RegisterNetEvent('discordbot:add2cars')
AddEventHandler('discordbot:add2cars', function(plate, type, item, count)
	local plates = plate
	local types = type
	local items = item
	local counts = count
	TriggerServerEvent("discordbot:add2cars_sv",plates, items, counts, types)
end)

RegisterNetEvent('discordbot:re2cars')
AddEventHandler('discordbot:re2cars', function(plate, type, item, count)
	local plates = plate
	local types = type
	local items = item
	local counts = count
	TriggerServerEvent("discordbot:re2cars_sv", plates, items, counts, types)
end)

RegisterNetEvent('discordbot:buycar_cl')
AddEventHandler('discordbot:buycar_cl', function(name, price, player)
	local names = name
	local prices = price
	local players = player
	TriggerServerEvent("discordbot:buycar_sv", names, prices, players)
end)

RegisterNetEvent('discordbot:selldrugs_cl')
AddEventHandler('discordbot:selldrugs_cl', function(drugType, count)
	local drugTypes = drugType
	local counts = count
	TriggerServerEvent("discordbot:selldrugs_sv", drugTypes, counts)
end)

RegisterNetEvent('discordbot:transfermoney_cl')
AddEventHandler('discordbot:transfermoney_cl', function(redmoney, greenmoney)
	local redmoneys = redmoney
	local greenmoneys = greenmoney
	TriggerServerEvent("discordbot:transfermoney_sv", redmoneys, greenmoneys)
end)

RegisterNetEvent('discordbot:crafting_cl')
AddEventHandler('discordbot:crafting_cl', function(item, amount, type)
	local items = item
	local amounts = amount
	local types = type
	TriggerServerEvent("discordbot:crafting_sv", items, amounts, types)
end)

--------------------------- Yoz add ons -------------------------


-- garage
RegisterNetEvent('discordbot:delcargarage_cl')
AddEventHandler('discordbot:delcargarage_cl', function(plate)
	local plates = plate
	TriggerServerEvent("discordbot:delcargarage_sv", plates)
end)

RegisterNetEvent('discordbot:addcargarage_cl')
AddEventHandler('discordbot:addcargarage_cl', function(plate)
	local plates = plate
	TriggerServerEvent("discordbot:addcargarage_sv", plates)
end)

RegisterNetEvent('discordbot:poundcargarage_cl')
AddEventHandler('discordbot:poundcargarage_cl', function(plate)
	local plates = plate
	TriggerServerEvent("discordbot:poundcargarage_sv", plates)
end)

-- Shops --


RegisterNetEvent('discordbot:buyitem_cl')
AddEventHandler('discordbot:buyitem_cl', function(item, price)
	local items = item
	local prices = price
	TriggerServerEvent("discordbot:buyitem_sv", items, prices)
end)

-- Vault --
RegisterNetEvent('discordbot:addvault_cl')
AddEventHandler('discordbot:addvault_cl', function(plate, type, item, count)
	local plates = plate
	local types = type
	local items = item
	local counts = count
	TriggerServerEvent("discordbot:addvault_sv",plates, items, counts, types)
end)

RegisterNetEvent('discordbot:revault_cl')
AddEventHandler('discordbot:revault_cl', function(plate, type, item, count)
	local plates = plate
	local types = type
	local items = item
	local counts = count
	TriggerServerEvent("discordbot:revault_sv",plates, items, counts, types)
end)
-- Homes --


RegisterNetEvent('discordbot:putitemhome_cl')
AddEventHandler('discordbot:putitemhome_cl', function(count, item)
	local counts = count
	local items = item
	TriggerServerEvent("discordbot:putitemhome_sv", counts, items)
end)

RegisterNetEvent('discordbot:putmoneyhome_cl')
AddEventHandler('discordbot:putmoneyhome_cl', function(count, item)
	local counts = count
	local items = item
	TriggerServerEvent("discordbot:putmoneyhome_sv", counts, items)
end)

RegisterNetEvent('discordbot:putweaponhome_cl')
AddEventHandler('discordbot:putweaponhome_cl', function(count, item)
	local counts = count
	local items = item
	TriggerServerEvent("discordbot:putweaponhome_sv", counts, items)
end)


RegisterNetEvent('discordbot:getitemhome_cl')
AddEventHandler('discordbot:getitemhome_cl', function(count, item)
	local counts = count
	local items = item
	TriggerServerEvent("discordbot:getitemhome_sv", counts, items)
end)

RegisterNetEvent('discordbot:getmoneyhome_cl')
AddEventHandler('discordbot:getmoneyhome_cl', function(count, item)
	local counts = count
	local items = item
	TriggerServerEvent("discordbot:getmoneyhome_sv", counts, items)
end)

RegisterNetEvent('discordbot:getweaponhome_cl')
AddEventHandler('discordbot:getweaponhome_cl', function(count, item)
	local counts = count
	local items = item
	TriggerServerEvent("discordbot:getweaponhome_sv", counts, items)
end)


local isIncarPolice = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
				if(settings.LogEnterPoliceVehicle == true and not isIncarPolice and PlayerData.job.name ~= "police") then
					TriggerServerEvent("esx:enterpolicecar",GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))
					isIncarPolice = true
				end

		else
			isIncarPolice = false
		end

	end
end)




local isIncar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)


		if(IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then

				if(settings.LogEnterPoliceVehicle == true and not isIncar) then

					for i=1, #blacklistedModels, 1 do

						if(blacklistedModels[i] == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))then
							TriggerServerEvent("esx:enterblacklistedcar",GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))
							isIncar = true
						end
					end
				end
		else
			isIncar = false
		end

	end
end)




local base = 0
Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
	local diedAt

    while true do
        Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end

                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
				local killerentitytype = GetEntityType(killer)
				local killertype = -1
				local killerinvehicle = false
				local killervehiclename = ''
                local killervehicleseat = 0
				if killerentitytype == 1 then
					killertype = GetPedType(killer)
					if IsPedInAnyVehicle(killer, false) == 1 then
						killerinvehicle = true
						killervehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(killer)))
                        killervehicleseat = GetPedVehicleSeat(killer)
					else killerinvehicle = false
					end
				end

				local killerid = GetPlayerByEntityID(killer)
				if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
				else killerid = -1
				end

                if killer == ped or killer == -1 then
                    TriggerEvent('esx:killerlog',0, killertype, { table.unpack(GetEntityCoords(ped)) })
                    TriggerServerEvent('esx:killerlog',0, killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('esx:killerlog', 1,killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    TriggerServerEvent('esx:killerlog',1, killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end
        end
    end
end)



function GetPlayerByEntityID(id)
	for i=0,256 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end
