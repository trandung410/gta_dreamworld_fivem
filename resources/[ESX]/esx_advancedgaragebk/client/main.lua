Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local PlayerData              = {}
local JobBlips                = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local this_Garage             = {}
local privateBlips            = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    ESX.PlayerData = ESX.GetPlayerData()
	for k,v in pairs(Config.CarGarages) do
		TriggerEvent('esx:registerMarker', 17, {x = v.GaragePoint.x, y = v.GaragePoint.y, z = v.GaragePoint.z})
		TriggerEvent('esx:registerMarker', 17, {x = v.DeletePoint.x, y = v.DeletePoint.y, z = v.DeletePoint.z})
	end
	for k,v in pairs(Config.CarPounds) do 
		TriggerEvent('esx:registerMarker', 17, {x = v.PoundPoint.x, y = v.PoundPoint.y, z = v.PoundPoint.z})
	end
	Citizen.Wait(10000)
    refreshBlips()

end)
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		
		SetNuiFocus(false, false)
	end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	Citizen.Wait(10000)
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
	Citizen.Wait(10000)
	deleteBlips()
	refreshBlips()
end)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Open Main Menu
function OpenMenuGarage(PointType)
	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	
	if PointType == 'car_garage_point' then
		table.insert(elements, {label = _U('list_owned_cars'), value = 'list_owned_cars'})
	elseif PointType == 'boat_garage_point' then
		table.insert(elements, {label = _U('list_owned_boats'), value = 'list_owned_boats'})
	elseif PointType == 'aircraft_garage_point' then
		table.insert(elements, {label = _U('list_owned_aircrafts'), value = 'list_owned_aircrafts'})
	elseif PointType == 'car_store_point' then
		table.insert(elements, {label = _U('store_owned_cars'), value = 'store_owned_cars'})
	elseif PointType == 'boat_store_point' then
		table.insert(elements, {label = _U('store_owned_boats'), value = 'store_owned_boats'})
	elseif PointType == 'aircraft_store_point' then
		table.insert(elements, {label = _U('store_owned_aircrafts'), value = 'store_owned_aircrafts'})
	elseif PointType == 'car_pound_point' then
		table.insert(elements, {label = _U('return_owned_cars').." ($"..Config.CarPoundPrice..")", value = 'return_owned_cars'})
	elseif PointType == 'boat_pound_point' then
		table.insert(elements, {label = _U('return_owned_boats').." ($"..Config.BoatPoundPrice..")", value = 'return_owned_boats'})
	elseif PointType == 'aircraft_pound_point' then
		table.insert(elements, {label = _U('return_owned_aircrafts').." ($"..Config.AircraftPoundPrice..")", value = 'return_owned_aircrafts'})
	elseif PointType == 'policing_pound_point' then
		table.insert(elements, {label = _U('return_owned_policing').." ($"..Config.PolicingPoundPrice..")", value = 'return_owned_policing'})
	elseif PointType == 'ambulance_pound_point' then
		table.insert(elements, {label = _U('return_owned_ambulance').." ($"..Config.AmbulancePoundPrice..")", value = 'return_owned_ambulance'})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
		title    = _U('garage'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		local action = data.current.value
		
		if action == 'list_owned_cars' then
			ListOwnedCarsMenu()
			Citizen.Wait(10000)
		elseif action == 'list_owned_boats' then
			ListOwnedBoatsMenu()
			Citizen.Wait(10000)
		elseif action == 'list_owned_aircrafts' then
			ListOwnedAircraftsMenu()
			Citizen.Wait(10000)
		elseif action== 'store_owned_cars' then
			StoreOwnedCarsMenu()
			Citizen.Wait(10000)
		elseif action== 'store_owned_boats' then
			StoreOwnedBoatsMenu()
			Citizen.Wait(10000)
		elseif action== 'store_owned_aircrafts' then
			StoreOwnedAircraftsMenu()
			Citizen.Wait(10000)
		elseif action == 'return_owned_cars' then
			ReturnOwnedCarsMenu()
			Citizen.Wait(10000)
		elseif action == 'return_owned_boats' then
			ReturnOwnedBoatsMenu()
			Citizen.Wait(10000)
		elseif action == 'return_owned_aircrafts' then
			ReturnOwnedAircraftsMenu()
			Citizen.Wait(10000)
		elseif action == 'return_owned_policing' then
			ReturnOwnedPolicingMenu()
			Citizen.Wait(10000)
		elseif action == 'return_owned_ambulance' then
			ReturnOwnedAmbulanceMenu()
			Citizen.Wait(10000)
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- List Owned Cars Menu
function ListOwnedCarsMenu()
	local elements = {}
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification(_U('garage_nocars'))
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = v.vehicle.model
				local plate        = v.plate
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				if v.vehicle.label ~= '' then
					vehicleName  = v.vehicle.label
				end
				table.insert(elements, {value = v, name = vehicleName, plate = plate, stored = v.stored})
			end
		end
		SetNuiFocus(true, true)
		SendNUIMessage({
			type = "shop",
			result = elements,
			pos = "getVehicle",
		})
	end)
end

-- Pound Owned Cars Menu
function ReturnOwnedCarsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
		local elements = {}
		for _,v in pairs(ownedCars) do
			local hashVehicule = v.vehicle.model
			local plate        = v.plate
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			if v.vehicle.label ~= '' then
				vehicleName  = v.vehicle.label
			end
			table.insert(elements, {value = v, name = vehicleName, plate = plate, stored = v.stored})
		end

		SetNuiFocus(true, true)
		SendNUIMessage({
			type = "shop",
			result = elements,
			pos = "returnVehicle",
		})
	end)
end

RegisterNUICallback('notify', function(data)
	ESX.ShowNotification(data.msg)
end)

RegisterNUICallback('spawnVehicle', function(data)
	SpawnVehicle(data.vehicle, data.plate)
end)

RegisterNUICallback('changeName', function(PlateVehicle)
	SetNuiFocus(false, false)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name', {
		title = 'Đổi tên xe của bạn'
	}, function(data, menu)
		local NewName = tostring(data.value)
		menu.close()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
			title    = 'Bạn đồng ý đổi tên xe của mình chứ',
			align    = 'center',
			elements = {
				{label ='Đồng ý ($'..ESX.Math.GroupDigits(Config.PriceChangName)..')', value = 'yes'},
				{label = 'Không đồng ý', value = 'no'}
			}
		}, function(data2, menu2)
			menu2.close()
			if data2.current.value == 'yes' then
				TriggerServerEvent('esx_advancedgarage:ChangNameVehicle', PlateVehicle.plate, NewName)
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	

	end, function(data, menu)
		menu.close()
	end)
end)

local coldown = false
local timecoldown = Config.TimeColdownReturnCar
RegisterNUICallback('returnVehiclePound', function(data)
	 if coldown then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
			title    = 'Chuộc xe với giá x5',
			align    = 'center',
			elements = {
				{label ='Đồng ý', value = 'yes'},
				{label = 'Không đồng ý', value = 'no'}
			}
		}, function(data2, menu2)
			menu2.close()
			
			if data2.current.value == 'yes' then
				local fee = Config.CarPoundPrice * Config.CarPoundPriceColdown 
				SpawnPoundedVehicle(data.vehicle, data.plate, fee)
			elseif data2.current.value == 'no' then
				ESX.ShowNotification('Bạn có thể quay lại sau: '.. timecoldown .. ' giây')
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	 else
		SpawnPoundedVehicle(data.vehicle, data.plate, Config.CarPoundPrice)
	 end
end)

-- Spawn Cars
function SpawnVehicle(vehicle, plate)
	-- TriggerServerEvent("esx_advancedgarage:server:removeOldVehicle", plate)
	ESX.ShowNotification("Phương tiện của bạn đang được chuẩn bị, vui lòng chờ ...")
	Wait(3000)
	for k,v in pairs(this_Garage.SpawnPoint) do 
		if ESX.Game.IsSpawnPointClear(v, 2.0) then
			ESX.Game.SpawnVehicle(vehicle.model, {
				x = v.x,
				y = v.y,
				z = v.z + 1
			}, v.h, function(callback_vehicle)
				ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
				SetVehRadioStation(callback_vehicle, "OFF")
				TaskWarpPedIntoVehicle(GetPlayerPed( -1), callback_vehicle, -1)
				SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
				SetVehicleEngineHealth(callback_vehicle, vehicle.engineHealth + 0.0)
			end)
			TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
			return
		end
	end
	ESX.ShowNotification('Bãi đỗ xe đã hết chỗ')
end

-- Spawn Pound Cars
function SpawnPoundedVehicle(vehicle, plate, money)
	TriggerServerEvent("esx_advancedgarage:server:removeOldVehicle", plate)
	ESX.ShowNotification("Phương tiện của bạn đang được chuẩn bị, vui lòng chờ ...")
	Wait(3000)
	for k,v in pairs(this_Garage.SpawnPoint) do 
		if ESX.Game.IsSpawnPointClear(v, 2.0) then
			ESX.Game.SpawnVehicle(vehicle.model, {
				x = v.x,
				y = v.y,
				z = v.z + 1
			}, v.h, function(callback_vehicle)
				ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
				SetVehRadioStation(callback_vehicle, "OFF")
				TaskWarpPedIntoVehicle(GetPlayerPed( -1), callback_vehicle, -1)
				SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
				SetVehicleEngineHealth(callback_vehicle, vehicle.engineHealth + 0.0)
			end)
			TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
			TriggerServerEvent('esx_advancedgarage:payCar', money)
			coldown = true 
			return
		end
	end
	ESX.ShowNotification('Bãi đỗ xe đã hết chỗ')
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
		if coldown then
			timecoldown = timecoldown - 1
			if timecoldown == 0 then
				coldown = false
				timecoldown = Config.TimeColdownReturnCar
			end
		end
	end
end)

RegisterNUICallback('escape', function(data, cb)
	 
	SetNuiFocus(false, false)

	SendNUIMessage({
		type = "close",
	})
end)

-- List Owned Boats Menu
function ListOwnedBoatsMenu()
	local elements = {}
	
	if Config.ShowGarageSpacer1 then
		table.insert(elements, {label = _U('spacer1')})
	end
	
	if Config.ShowGarageSpacer2 then
		table.insert(elements, {label = _U('spacer2')})
	end
	
	if Config.ShowGarageSpacer3 then
		table.insert(elements, {label = _U('spacer3')})
	end
	
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedBoats', function(ownedBoats)
		if #ownedBoats == 0 then
			ESX.ShowNotification(_U('garage_noboats'))
		else
			for _,v in pairs(ownedBoats) do
				if Config.UseVehicleNamesLua then
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName  = GetLabelText(aheadVehName)
					local plate        = v.plate
					local labelvehicle
					
					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_garage')..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_pound')..' |'
						end
					else
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						end
					end
					
					table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
				else
					local hashVehicule = v.vehicle.model
					local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
					local plate        = v.plate
					local labelvehicle
					
					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_garage')..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_pound')..' |'
						end
					else
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						end
					end
					
					table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
				end
			end
		end
		SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = elements,
					pos = "getVehicle",
				})
		
	end)
end

-- List Owned Aircrafts Menu
function ListOwnedAircraftsMenu()
	local elements = {}
	
	if Config.ShowGarageSpacer1 then
		table.insert(elements, {label = _U('spacer1')})
	end
	
	if Config.ShowGarageSpacer2 then
		table.insert(elements, {label = _U('spacer2')})
	end
	
	if Config.ShowGarageSpacer3 then
		table.insert(elements, {label = _U('spacer3')})
	end
	
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAircrafts', function(ownedAircrafts)
		if #ownedAircrafts == 0 then
			ESX.ShowNotification(_U('garage_noaircrafts'))
		else
			for _,v in pairs(ownedAircrafts) do
				if Config.UseVehicleNamesLua then
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName  = GetLabelText(aheadVehName)
					local plate        = v.plate
					local labelvehicle
					
					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_garage')..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_pound')..' |'
						end
					else
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						end
					end
					
					table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
				else
					local hashVehicule = v.vehicle.model
					local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
					local plate        = v.plate
					local labelvehicle
					
					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_garage')..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('loc_pound')..' |'
						end
					else
						if v.stored then
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						else
							labelvehicle = '| '..plate..' | '..vehicleName..' |'
						end
					end
					
					table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
				end
			end
		end
		SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = elements,
					pos = "getVehicle",
				})
	
	end)
end


-- Store Owned Cars Menu
function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed( -1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed    = GetPlayerPed( -1)
		local coords       = GetEntityCoords(playerPed)
		local vehicle      = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current 	   = GetPlayersLastVehicle(GetPlayerPed( -1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate        = vehicleProps.plate
		
		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				putaway(vehicle, vehicleProps)
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

-- Store Owned Boats Menu
function StoreOwnedBoatsMenu()
	local playerPed  = GetPlayerPed( -1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed     = GetPlayerPed( -1)
		local coords        = GetEntityCoords(playerPed)
		local vehicle       = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
		local current 	    = GetPlayersLastVehicle(GetPlayerPed( -1), true)
		local engineHealth  = GetVehicleEngineHealth(current)
		local plate         = vehicleProps.plate
		
		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				putaway(vehicle, vehicleProps)
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

-- Store Owned Aircrafts Menu
function StoreOwnedAircraftsMenu()
	local playerPed  = GetPlayerPed( -1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed     = GetPlayerPed( -1)
		local coords        = GetEntityCoords(playerPed)
		local vehicle       = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
		local current 	    = GetPlayersLastVehicle(GetPlayerPed( -1), true)
		local engineHealth  = GetVehicleEngineHealth(current)
		local plate         = vehicleProps.plate
		
		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				putaway(vehicle, vehicleProps)
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end



-- Pound Owned Boats Menu
function ReturnOwnedBoatsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedBoats', function(ownedBoats)
		local elements = {}
		
		if Config.ShowPoundSpacer2 then
			table.insert(elements, {label = _U('spacer2')})
		end
		
		if Config.ShowPoundSpacer3 then
			table.insert(elements, {label = _U('spacer3')})
		end
		
		for _,v in pairs(ownedBoats) do
			if Config.UseVehicleNamesLua then
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName  = GetLabelText(aheadVehName)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			else
				local hashVehicule = v.model
				local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			end
		end
		SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = elements,
					pos = "returnVehicle",
				})

	end)
end

-- Pound Owned Aircrafts Menu
function ReturnOwnedAircraftsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(ownedAircrafts)
		local elements = {}
		
		if Config.ShowPoundSpacer2 then
			table.insert(elements, {label = _U('spacer2')})
		end
		
		if Config.ShowPoundSpacer3 then
			table.insert(elements, {label = _U('spacer3')})
		end
		
		for _,v in pairs(ownedAircrafts) do
			if Config.UseVehicleNamesLua then
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName  = GetLabelText(aheadVehName)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			else
				local hashVehicule = v.model
				local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			end
		end
		SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = elements,
					pos = "returnVehicle",
				})

	end)
end

-- Pound Owned Policing Menu
function ReturnOwnedPolicingMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedPolicingCars', function(ownedPolicingCars)
		local elements = {}
		
		if Config.ShowPoundSpacer2 then
			table.insert(elements, {label = _U('spacer2')})
		end
		
		if Config.ShowPoundSpacer3 then
			table.insert(elements, {label = _U('spacer3')})
		end
		
		for _,v in pairs(ownedPolicingCars) do
			if Config.UseVehicleNamesLua then
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName  = GetLabelText(aheadVehName)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			else
				local hashVehicule = v.model
				local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			end
		end
		SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = elements,
					pos = "returnVehicle",
				})
	
	end)
end

-- Pound Owned Ambulance Menu
function ReturnOwnedAmbulanceMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAmbulanceCars', function(ownedAmbulanceCars)
		local elements = {}
		
		if Config.ShowPoundSpacer2 then
			table.insert(elements, {label = _U('spacer2')})
		end
		
		if Config.ShowPoundSpacer3 then
			table.insert(elements, {label = _U('spacer3')})
		end
		
		for _,v in pairs(ownedAmbulanceCars) do
			if Config.UseVehicleNamesLua then
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName  = GetLabelText(aheadVehName)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			else
				local hashVehicule = v.model
				local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
				local plate        = v.plate
				local labelvehicle
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | '.._U('return')..' |'
				
				table.insert(elements, {label = labelvehicle, value = v, name = vehicleName, plate = plate, stored = v.stored})
			end
		end
		SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = elements,
					pos = "returnVehicle",
				})

	end)
end

-- Put Away Vehicles
function putaway(vehicle, vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	ESX.ShowNotification(_U('vehicle_in_garage'))
end




-- Entered Marker
AddEventHandler('esx_advancedgarage:hasEnteredMarker', function(zone)
	if zone == 'car_garage_point' then
		CurrentAction     = 'car_garage_point'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'boat_garage_point' then
		CurrentAction     = 'boat_garage_point'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'aircraft_garage_point' then
		CurrentAction     = 'aircraft_garage_point'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'car_store_point' then
		CurrentAction     = 'car_store_point'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction     = 'boat_store_point'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction     = 'aircraft_store_point'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'car_pound_point' then
		CurrentAction     = 'car_pound_point'
		CurrentActionMsg  = _U('press_to_impound',Config.CarPoundPrice)
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction     = 'boat_pound_point'
		CurrentActionMsg  = _U('press_to_impound',Config.BoatPoundPrice)
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction     = 'aircraft_pound_point'
		CurrentActionMsg  = _U('press_to_impound',Config.AircraftPoundPrice)
		CurrentActionData = {}
	elseif zone == 'policing_pound_point' then
		CurrentAction     = 'policing_pound_point'
		CurrentActionMsg  = _U('press_to_impound',Config.PolicingPoundPrice)
		CurrentActionData = {}
	elseif zone == 'ambulance_pound_point' then
		CurrentAction     = 'ambulance_pound_point'
		CurrentActionMsg  = _U('press_to_impound',Config.AmbulancePoundPrice)
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedgarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)
-- Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local canSleep  = true
		
		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.DrawDistance) then
					canSleep = false
					DrawMarker(Config.MarkerType, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
					DrawMarker(Config.MarkerType, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, false, false, false)	
				end
			end
			
			for k,v in pairs(Config.CarPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
					canSleep = false
					DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
		
		if Config.UsePrivateCarGarages then
			for k,v in pairs(Config.PrivateCarGarages) do
				if not v.Private or has_value(userProperties, v.Private) then
					if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.DrawDistance) then
						canSleep = false
						DrawMarker(Config.MarkerType, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
						DrawMarker(Config.MarkerType, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, false, false, false)	
					end
				end
			end
		end
		
		if Config.UseJobCarGarages then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PolicePounds) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
						canSleep = false
						DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.JobPoundMarker.x, Config.JobPoundMarker.y, Config.JobPoundMarker.z, Config.JobPoundMarker.r, Config.JobPoundMarker.g, Config.JobPoundMarker.b, 100, false, true, 2, false, false, false, false)
					end
				end
			end
			
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulancePounds) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
						canSleep = false
						DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.JobPoundMarker.x, Config.JobPoundMarker.y, Config.JobPoundMarker.z, Config.JobPoundMarker.r, Config.JobPoundMarker.g, Config.JobPoundMarker.b, 100, false, true, 2, false, false, false, false)
					end
				end
			end
		end
		
		if canSleep then
			 Citizen.Wait(100)
		end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	local currentZone = 'garage'
	while true do
		Citizen.Wait(500)
		
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local isInMarker = false
		
		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.PointMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_garage_point'
				end
				
				if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_store_point'
				end
			end
			
			for k,v in pairs(Config.CarPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_pound_point'
				end
			end
		end
		
		if Config.UseBoatGarages then
			for k,v in pairs(Config.BoatGarages) do
				if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.PointMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'boat_garage_point'
				end
				
				if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'boat_store_point'
				end
			end
			
			for k,v in pairs(Config.BoatPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'boat_pound_point'
				end
			end
		end
		
		if Config.UseAircraftGarages then
			for k,v in pairs(Config.AircraftGarages) do
				if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.PointMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'aircraft_garage_point'
				end
				
				if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'aircraft_store_point'
				end
			end
			
			for k,v in pairs(Config.AircraftPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'aircraft_pound_point'
				end
			end
		end

		
		if Config.UseJobCarGarages then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PolicePounds) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.JobPoundMarker.x) then
						isInMarker  = true
						this_Garage = v
						currentZone = 'policing_pound_point'
					end
				end
			end
			
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulancePounds) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.JobPoundMarker.x) then
						isInMarker  = true
						this_Garage = v
						currentZone = 'ambulance_pound_point'
					end
				end
			end
		end
		
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_advancedgarage:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedgarage:hasExitedMarker', LastZone)
		end
		
		if not isInMarker then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'car_garage_point' then
					--OpenMenuGarage('car_garage_point')
					ListOwnedCarsMenu()
				elseif CurrentAction == 'boat_garage_point' then
					OpenMenuGarage('boat_garage_point')
				elseif CurrentAction == 'aircraft_garage_point' then
					OpenMenuGarage('aircraft_garage_point')
				elseif CurrentAction == 'car_store_point' then
					--OpenMenuGarage('car_store_point')
					StoreOwnedCarsMenu()
				elseif CurrentAction == 'boat_store_point' then
					OpenMenuGarage('boat_store_point')
				elseif CurrentAction == 'aircraft_store_point' then
					OpenMenuGarage('aircraft_store_point')
				elseif CurrentAction == 'car_pound_point' then
					--OpenMenuGarage('car_pound_point')
					ReturnOwnedCarsMenu()
					--TriggerServerEvent('esx_advancedgarage:payCar')
				elseif CurrentAction == 'boat_pound_point' then
					OpenMenuGarage('boat_pound_point')
				elseif CurrentAction == 'aircraft_pound_point' then
					OpenMenuGarage('aircraft_pound_point')
				elseif CurrentAction == 'policing_pound_point' then
					OpenMenuGarage('policing_pound_point')
				elseif CurrentAction == 'ambulance_pound_point' then
					OpenMenuGarage('ambulance_pound_point')
				end
				
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips


function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function refreshBlips()
	local blipList = {}
	local JobBlips = {}

	if Config.UseCarGarages then
		for k,v in pairs(Config.CarGarages) do
			table.insert(blipList, {
				coords = { v.GaragePoint.x, v.GaragePoint.y },
				text   = _U('blip_garage'),
				sprite = Config.BlipGarage.Sprite,
				color  = Config.BlipGarage.Color,
				scale  = Config.BlipGarage.Scale
			})
		end
		
		for k,v in pairs(Config.CarPounds) do
			table.insert(blipList, {
				coords = { v.PoundPoint.x, v.PoundPoint.y },
				text   = _U('blip_pound'),
				sprite = Config.BlipPound.Sprite,
				color  = Config.BlipPound.Color,
				scale  = Config.BlipPound.Scale
			})
		end
	end
	
	if Config.UseBoatGarages then
		for k,v in pairs(Config.BoatGarages) do
			table.insert(blipList, {
				coords = { v.GaragePoint.x, v.GaragePoint.y },
				text   = _U('blip_garage'),
				sprite = Config.BlipGarage.Sprite,
				color  = Config.BlipGarage.Color,
				scale  = Config.BlipGarage.Scale
			})
		end
		
		for k,v in pairs(Config.BoatPounds) do
			table.insert(blipList, {
				coords = { v.PoundPoint.x, v.PoundPoint.y },
				text   = _U('blip_pound'),
				sprite = Config.BlipPound.Sprite,
				color  = Config.BlipPound.Color,
				scale  = Config.BlipPound.Scale
			})
		end
	end
	
	if Config.UseAircraftGarages then
		for k,v in pairs(Config.AircraftGarages) do
			table.insert(blipList, {
				coords = { v.GaragePoint.x, v.GaragePoint.y },
				text   = _U('blip_garage'),
				sprite = Config.BlipGarage.Sprite,
				color  = Config.BlipGarage.Color,
				scale  = Config.BlipGarage.Scale
			})
		end
		
		for k,v in pairs(Config.AircraftPounds) do
			table.insert(blipList, {
				coords = { v.PoundPoint.x, v.PoundPoint.y },
				text   = _U('blip_pound'),
				sprite = Config.BlipPound.Sprite,
				color  = Config.BlipPound.Color,
				scale  = Config.BlipPound.Scale
			})
		end
	end
	
	if Config.UseJobCarGarages then
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
			for k,v in pairs(Config.PolicePounds) do
				table.insert(JobBlips, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   = _U('blip_police_pound'),
					sprite = Config.BlipJobPound.Sprite,
					color  = Config.BlipJobPound.Color,
					scale  = Config.BlipJobPound.Scale
				})
			end
		end
		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
			for k,v in pairs(Config.AmbulancePounds) do
				table.insert(JobBlips, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   = _U('blip_ambulance_pound'),
					sprite = Config.BlipJobPound.Sprite,
					color  = Config.BlipJobPound.Color,
					scale  = Config.BlipJobPound.Scale
				})
			end
		end
	end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end
	
	for i=1, #JobBlips, 1 do
		CreateBlip(JobBlips[i].coords, JobBlips[i].text, JobBlips[i].sprite, JobBlips[i].color, JobBlips[i].scale)
	end
end

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(table.unpack(coords))
	
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('CUSTOM_STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
	table.insert(JobBlips, blip)
end
