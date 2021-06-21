-- MENU
function clearMenu(menu)
	local tempMenu = deepcopy(menu)

	for i = 1, #tempMenu.options, 1 do
		tempMenu.options[i].onHover = nil
		tempMenu.options[i].onSelect = nil
		tempMenu.options[i].onBack = nil
		tempMenu.options[i].onSubBack = nil
	end

	return tempMenu
end

-- VEHICLE
function GetVehicleData(vehicle)
	local color1, color2 = GetVehicleColours(vehicle)
	
	local color1Custom = {}
	color1Custom[1], color1Custom[2], color1Custom[3] = GetVehicleCustomPrimaryColour(vehicle)
	
	local color2Custom = {}
	color2Custom[1], color2Custom[2], color2Custom[3] = GetVehicleCustomSecondaryColour(vehicle)
	
	local color1Type = GetVehicleModColor_1(vehicle)
	local color2Type = GetVehicleModColor_2(vehicle)

	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
	
	local extras = {}
	for id = 0, 25 do
		if (DoesExtraExist(vehicle, id)) then
			extras[tostring(id)] = IsVehicleExtraTurnedOn(vehicle, id)
		end
	end

	local neonColor = {}
	neonColor[1], neonColor[2], neonColor[3] = GetVehicleNeonLightsColour(vehicle)

	local tyreSmokeColor = {}
	tyreSmokeColor[1], tyreSmokeColor[2], tyreSmokeColor[3] = GetVehicleTyreSmokeColor(vehicle)
	
	local tempData = {
		model             = GetEntityModel(vehicle),

		plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
		plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

		bodyHealth        = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 1),
		engineHealth      = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 1),

		fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),
		dirtLevel         = ESX.Math.Round(GetVehicleDirtLevel(vehicle), 1),

		color1            = color1,
		color1Custom      = color1Custom,
		
		color2            = color2,
		color2Custom      = color2Custom,

		pearlescentColor  = pearlescentColor,

		color1Type 		  = GetVehicleModColor_1(vehicle),
		color2Type 		  = GetVehicleModColor_2(vehicle),

		wheelColor        = wheelColor,
		wheels            = GetVehicleWheelType(vehicle),
		windowTint        = GetVehicleWindowTint(vehicle),

		extras            = extras,

		neonEnabled       = {
			IsVehicleNeonLightEnabled(vehicle, 0),
			IsVehicleNeonLightEnabled(vehicle, 1),
			IsVehicleNeonLightEnabled(vehicle, 2),
			IsVehicleNeonLightEnabled(vehicle, 3)
		},
		
		neonColor         = neonColor,
		tyreSmokeColor    = tyreSmokeColor,

		modSpoilers       = GetVehicleMod(vehicle, 0),
		modFrontBumper    = GetVehicleMod(vehicle, 1),
		modRearBumper     = GetVehicleMod(vehicle, 2),
		modSideSkirt      = GetVehicleMod(vehicle, 3),
		modExhaust        = GetVehicleMod(vehicle, 4),
		modFrame          = GetVehicleMod(vehicle, 5),
		modGrille         = GetVehicleMod(vehicle, 6),
		modHood           = GetVehicleMod(vehicle, 7),
		modFender         = GetVehicleMod(vehicle, 8),
		modRightFender    = GetVehicleMod(vehicle, 9),
		modRoof           = GetVehicleMod(vehicle, 10),

		modEngine         = GetVehicleMod(vehicle, 11),
		modBrakes         = GetVehicleMod(vehicle, 12),
		modTransmission   = GetVehicleMod(vehicle, 13),
		modHorns          = GetVehicleMod(vehicle, 14),
		modSuspension     = GetVehicleMod(vehicle, 15),
		modArmor          = GetVehicleMod(vehicle, 16),

		modTurbo          = IsToggleModOn(vehicle, 18),
		modSmokeEnabled   = IsToggleModOn(vehicle, 20),
		modXenon          = GetVehicleXenonLightsColour(vehicle),

		modFrontWheels    = GetVehicleMod(vehicle, 23),
		modBackWheels     = GetVehicleMod(vehicle, 24),

		modPlateHolder    = GetVehicleMod(vehicle, 25),
		modVanityPlate    = GetVehicleMod(vehicle, 26),
		modTrimA          = GetVehicleMod(vehicle, 27),
		modOrnaments      = GetVehicleMod(vehicle, 28),
		modDashboard      = GetVehicleMod(vehicle, 29),
		modDial           = GetVehicleMod(vehicle, 30),
		modDoorSpeaker    = GetVehicleMod(vehicle, 31),
		modSeats          = GetVehicleMod(vehicle, 32),
		modSteeringWheel  = GetVehicleMod(vehicle, 33),
		modShifterLeavers = GetVehicleMod(vehicle, 34),
		modAPlate         = GetVehicleMod(vehicle, 35),
		modSpeakers       = GetVehicleMod(vehicle, 36),
		modTrunk          = GetVehicleMod(vehicle, 37),
		modHydrolic       = GetVehicleMod(vehicle, 38),
		modEngineBlock    = GetVehicleMod(vehicle, 39),
		modAirFilter      = GetVehicleMod(vehicle, 40),
		modStruts         = GetVehicleMod(vehicle, 41),
		modArchCover      = GetVehicleMod(vehicle, 42),
		modAerials        = GetVehicleMod(vehicle, 43),
		modTrimB          = GetVehicleMod(vehicle, 44),
		modTank           = GetVehicleMod(vehicle, 45),
		modWindows        = GetVehicleMod(vehicle, 46),
		modLivery         = GetVehicleMod(vehicle, 48),
		livery            = GetVehicleLivery(vehicle)
	}

	tempData.modTurbo = tempData.modTurbo or 0
	
	return tempData
end

function SetVehicleData(vehicle, props)
	if (props == nil) then return end

	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (props == nil or vehicle == nil or not DoesEntityExist(vehicle)) then return end
	
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (props.plate) then
		SetVehicleNumberPlateText(vehicle, props.plate)
	end

	if (props.plateIndex) then
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	end

	if (props.bodyHealth) then
		SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
	end

	if (props.engineHealth) then
		SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
	end

	if (props.fuelLevel) then
		SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
	end

	if (props.dirtLevel) then
		SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
	end

	if (props.color1) then
		ClearVehicleCustomPrimaryColour(vehicle)

		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if (props.color1Custom) then
		SetVehicleCustomPrimaryColour(vehicle, props.color1Custom[1], props.color1Custom[2], props.color1Custom[3])
	end

	if (props.color2) then
		ClearVehicleCustomSecondaryColour(vehicle)

		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if (props.color2Custom) then
		SetVehicleCustomSecondaryColour(vehicle, props.color2Custom[1], props.color2Custom[2], props.color2Custom[3])
	end

	if (props.color1Type) then
		SetVehicleModColor_1(vehicle, props.color1Type)
	end

	if (props.color2Type) then
		SetVehicleModColor_2(vehicle, props.color2Type)
	end

	if (props.pearlescentColor) then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	end

	if (props.wheelColor) then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	end

	if (props.wheels) then
		SetVehicleWheelType(vehicle, props.wheels)
	end

	if (props.windowTint) then
		SetVehicleWindowTint(vehicle, props.windowTint)
	end

	if (props.extras) then
		for id = 0, 25 do
			if (DoesExtraExist(vehicle, id)) then
				SetVehicleExtra(vehicle, id, props.extras[tostring(id)] and 0 or 1)
			end
		end
	end

	if (props.neonEnabled) then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1] == true or props.neonEnabled[1] == 1)
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2] == true or props.neonEnabled[2] == 1)
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3] == true or props.neonEnabled[3] == 1)
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4] == true or props.neonEnabled[4] == 1)
	end

	if (props.neonColor) then
		SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if (props.modSmokeEnabled) then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if (props.tyreSmokeColor) then
		SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if (props.modSpoilers) then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if (props.modFrontBumper) then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if (props.modRearBumper) then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if (props.modSideSkirt) then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if (props.modExhaust) then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if (props.modFrame) then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if (props.modGrille) then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if (props.modHood) then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if (props.modFender) then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if (props.modRightFender) then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if (props.modRoof) then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if (props.modEngine) then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if (props.modBrakes) then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if (props.modTransmission) then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if (props.modHorns) then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if (props.modSuspension) then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if (props.modArmor) then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if (props.modTurbo) then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if (props.modXenon) then
        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleXenonLightsColour(vehicle, props.modXenon)
	end

	if (props.modFrontWheels) then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	end

	if (props.modBackWheels) then
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	end

	if (props.modPlateHolder) then
		SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
	end

	if (props.modVanityPlate) then
		SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
	end

	if (props.modTrimA) then
		SetVehicleMod(vehicle, 27, props.modTrimA, false)
	end

	if (props.modOrnaments) then
		SetVehicleMod(vehicle, 28, props.modOrnaments, false)
	end

	if (props.modDashboard) then
		SetVehicleMod(vehicle, 29, props.modDashboard, false)
	end

	if (props.modDial) then
		SetVehicleMod(vehicle, 30, props.modDial, false)
	end

	if (props.modDoorSpeaker) then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
	end

	if (props.modSeats) then
		SetVehicleMod(vehicle, 32, props.modSeats, false)
	end

	if (props.modSteeringWheel) then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
	end

	if (props.modShifterLeavers) then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
	end

	if (props.modAPlate) then
		SetVehicleMod(vehicle, 35, props.modAPlate, false)
	end

	if (props.modSpeakers) then
		SetVehicleMod(vehicle, 36, props.modSpeakers, false)
	end

	if (props.modTrunk) then
		SetVehicleMod(vehicle, 37, props.modTrunk, false)
	end

	if (props.modHydrolic) then
		SetVehicleMod(vehicle, 38, props.modHydrolic, false)
	end

	if (props.modEngineBlock) then
		SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
	end

	if (props.modAirFilter) then
		SetVehicleMod(vehicle, 40, props.modAirFilter, false)
	end

	if (props.modStruts) then
		SetVehicleMod(vehicle, 41, props.modStruts, false)
	end

	if (props.modArchCover) then
		SetVehicleMod(vehicle, 42, props.modArchCover, false)
	end

	if (props.modAerials) then
		SetVehicleMod(vehicle, 43, props.modAerials, false)
	end

	if (props.modTrimB) then
		SetVehicleMod(vehicle, 44, props.modTrimB, false)
	end

	if (props.modTank) then
		SetVehicleMod(vehicle, 45, props.modTank, false)
	end

	if (props.modWindows) then
		SetVehicleMod(vehicle, 46, props.modWindows, false)
	end

	if (props.modLivery) then
		SetVehicleMod(vehicle, 48, props.modLivery, false)
	end

	if (props.livery) then
		SetVehicleLivery(vehicle, props.livery)
	end	
end

function SetVehicleModData(vehicle, modType, data)
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (modType == 'plateIndex') then
		SetVehicleNumberPlateTextIndex(vehicle, data)
	elseif (modType == 'color1') then
		SetVehicleCustomPrimaryColour(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'color2') then
		SetVehicleCustomSecondaryColour(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'paintType1') then
		SetVehicleModColor_1(vehicle, data)
	elseif (modType == 'paintType2') then
		SetVehicleModColor_2(vehicle, data)
	elseif (modType == 'pearlescentColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, tonumber(data), wheelColor)
	elseif (modType == 'wheelColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, tonumber(data))
	elseif (modType == 'wheels') then
		SetVehicleMod(vehicle, 23, -1, false)
		SetVehicleWheelType(vehicle, tonumber(data))
	elseif (modType == 'windowTint') then
		SetVehicleWindowTint(vehicle, tonumber(data))
	elseif (modType == 'extras') then
		local tempList = {}
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				table.insert(tempList, id)
			end
		end
		
		if (DoesExtraExist(vehicle, tempList[data.id])) then
			SetVehicleExtra(vehicle, tempList[data.id], data.enable)
		end
	elseif (modType == 'neonColor') then
		SetVehicleNeonLightEnabled(vehicle, 0, true)
		SetVehicleNeonLightEnabled(vehicle, 1, true)
		SetVehicleNeonLightEnabled(vehicle, 2, true)
		SetVehicleNeonLightEnabled(vehicle, 3, true)
		
		SetVehicleNeonLightsColour(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'tyreSmokeColor') then
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'modXenon') then
		ToggleVehicleMod(vehicle, 22, true)

		if (true) then
			SetVehicleXenonLightsColour(vehicle, tonumber(data))
		end
	elseif (modType == 'livery') then
		SetVehicleLivery(vehicle, data)
	elseif (type(modType) == 'number' and (modType == 23 or modType == 24)) then
		SetVehicleMod(vehicle, 23, data, false)

		if (IsThisModelABike(GetEntityModel(vehicle))) then
			SetVehicleMod(vehicle, 24, data, false)
		end
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then -- TOGGLE
		ToggleVehicleMod(vehicle, modType, data + 1)
	elseif (type(modType) == 'number') then -- MOD
		SetVehicleMod(vehicle, modType, data, false)
	end
end

function GetVehicleCurrentMod(vehicle, modType, data)
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (modType == 'plateIndex') then
		return GetVehicleNumberPlateTextIndex(vehicle)
	elseif (modType == 'color1') then
		return GetVehicleCustomPrimaryColour(vehicle)
	elseif (modType == 'color2') then
		return GetVehicleCustomSecondaryColour(vehicle)
	elseif (modType == 'wheelColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		return wheelColor
	elseif (modType == 'pearlescentColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		return pearlescentColor
	elseif (modType == 'tyreSmokeColor') then
		return GetVehicleTyreSmokeColor(vehicle)
	elseif (modType == 'modXenon') then
		local tempColor = GetVehicleXenonLightsColour(vehicle)
		return tempColor ~= 255 and tempColor or -1
	elseif (modType == 'neonColor') then
		return GetVehicleNeonLightsColour(vehicle)
	elseif (modType == 'paintType1') then
		return GetVehicleModColor_1(vehicle)
	elseif (modType == 'paintType2') then
		return GetVehicleModColor_2(vehicle)
	elseif (modType == 'windowTint') then
		return GetVehicleWindowTint(vehicle)
	elseif (modType == 'livery') then
		return GetVehicleLivery(vehicle)
	elseif (modType == 'extras') then
		local tempList = {}
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				table.insert(tempList, id)
			end
		end
		
		if (tempList[data] ~= nil and IsVehicleExtraTurnedOn(vehicle, tempList[data])) then
			return 0
		end
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		if (IsToggleModOn(vehicle, modType)) then
			return 0
		end
	elseif (type(modType) == 'number') then
		return GetVehicleMod(vehicle, modType)
	end

	return -1
end

function GetNumVehicleModData(vehicle, modType)
	SetVehicleModKit(vehicle, 0)

	if (modType == 'plateIndex') then
		return 5
	elseif (modType == 'color1') then
		return 0
	elseif (modType == 'color2') then
		return 0
	elseif (modType == 'wheelColor') then
		return 0
	elseif (modType == 'pearlescentColor') then
		return 0
	elseif (modType == 'tyreSmokeColor') then
		return 0
	elseif (modType == 'neonColor') then
		return 0
	elseif (modType == 'paintType1' or modType == 'paintType2') then
		return 5
	elseif (modType == 'windowTint') then
		return GetNumVehicleWindowTints(vehicle) - 1
	elseif (modType == 'modXenon') then
		return 12
	elseif (modType == 'livery') then
		return GetVehicleLiveryCount(vehicle) - 1
	elseif (modType == 'extras') then
		local tempCount = -1
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				tempCount = tempCount + 1
			end
		end
		return tempCount
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		return 0
	elseif (type(modType) == 'number') then
		return GetNumVehicleMods(vehicle, modType) - 1
	end

	return -1
end

function GetVehicleModIndexLabel(vehicle, modType, data)
	SetVehicleModKit(vehicle, 0)

	if (data == -1) then
		if (not (type(modType) == 'number' and modType >= 17 and modType <= 22)) then
			return 'Default'
		end
	end

	if (modType == 'plateIndex') then
		return plateIndexLabel[data + 1] or nil
	elseif (modType == 'paintType1' or modType == 'paintType2') then
		return paintTypeLabel[data + 1] or nil
	elseif (modType == 'windowTint') then
		return windowTintLabel[data + 1] or nil
	elseif (modType == 'livery') then
		return GetLabelText(GetLiveryName(vehicle, data)) or nil
	elseif (type(modType) == 'number' and modType >= 11 and modType <= 16 and modType ~= 14) then
		return 'Level ' .. (data + 1)
	elseif (modType == 'extras') then
		return 'Extra ' .. (data + 1)
	elseif (modType == 'modXenon') then
		return modXenonLabel[data + 1] or nil
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		local tempLabel = {'OFF', 'ON'}
		return tempLabel[data + 2]
	elseif (type(modType) == 'number') then
		return GetLabelText(GetModTextLabel(vehicle, modType, data)) or nil
	end

	return nil
end

function openDoors(vehicle, data)
	for i = 0, 6, 1 do
		if (data[i + 1] == 1) then
			SetVehicleDoorOpen(vehicle, i, false, false)
		else
			SetVehicleDoorShut(vehicle, i, false)
		end
	end
end

function repairtVehicle(vehicle)
	if (not isOpenByAdmin) then
		updateMenu('empty')

		local fuel = GetVehicleFuelLevel(vehicle)

		local curEngineHealth = GetVehicleEngineHealth(vehicle)
		local targetEngineHealth = 1000.0

		local curBodyHealth = GetVehicleBodyHealth(vehicle)
		local targetBodyHealth = 1000

		local fixingTime = ((targetEngineHealth - curEngineHealth) + (targetBodyHealth - curBodyHealth)) * 3
		
		exports['mythic_progbar']:Progress({
			duration = fixingTime,
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			label = 'Fixing the vehicle...'
		}, function(cancelled)
			if (not cancelled) then
				SetVehicleFixed(vehicle)
				playCustomSound('construction')

				local curDirtLevel = GetVehicleDirtLevel(vehicle)
				local targetDirtLevel = 0.0

				local cleaningTime = (curDirtLevel - targetDirtLevel) * 200

				exports['mythic_progbar']:Progress({
					duration = fixingTime,
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					label = 'Cleaning the vehicle...'
				}, function(cancelled2)
					if (not cancelled2) then
						SetVehicleDirtLevel(vehicle, 0.0)
					end

					updateMenu('main')
					SetVehicleFuelLevel(vehicle, fuel)
				end)
			else
				updateMenu('main')
				SetVehicleFuelLevel(vehicle, fuel)
			end
		end)
	else
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0.0)
		SetVehicleFuelLevel(vehicle, 100.0)

		playCustomSound('construction')
		updateMenu('main')
	end
end

-- SOUNDS
function playCustomSound(soundName)
	SendNUIMessage({
		type = 'playSound',
		soundName = soundName,
		volume = (GetProfileSetting(300) / 10)
	})
end

function playSound(soundName, audioName, soundId)
	soundId = soundId or -1
    PlaySoundFrontend(soundId, soundName, audioName, false)
end

-- CAMERA
function moveCameraToBoneWithOffset(camera, vehicle, boneName, posOffset, rotOffset)
	posOffset = posOffset or {x = 0.0, y = 0.0, z = 0.0}
	rotOffset = rotOffset or {x = 0.0, y = 0.0, z = 0.0}

	local boneIndexName = GetEntityBoneIndexByName(vehicle, boneName)

	if (boneIndexName == -1) then return false end

	local vehPos = GetEntityCoords(vehicle, false)
	local wheelPos = GetWorldPositionOfEntityBone(vehicle, boneIndexName)
	local leftOffSet = vehPos - GetOffsetFromEntityInWorldCoords(vehicle, posOffset.x, posOffset.y, posOffset.z)
	local camPos = {x = wheelPos.x - leftOffSet.x, y = wheelPos.y - leftOffSet.y, z = wheelPos.z - leftOffSet.z}

	local headingToObject = GetHeadingFromVector_2d(wheelPos.x - camPos.x, wheelPos.y - camPos.y)

	SetCamCoord(camera, camPos.x, camPos.y, camPos.z)
	SetCamRot(camera, 0.0 + rotOffset.x, 0.0 + rotOffset.y, headingToObject + rotOffset.z, 2)

	return true
end

function moveToCameraToBoneSmoth(fromCamera, toCamera, vehicle, boneName, posOffset, rotOffset)
	local hasBone = moveCameraToBoneWithOffset(toCamera, vehicle, boneName, posOffset, rotOffset)

	if (hasBone) then
		SetCamActiveWithInterp(toCamera, fromCamera, 500, true, true)
	end
end

-- MORE
function addBlip(position, spriteId, color, title, scale)
	scale = scale or 0.4

	local tempBlip = AddBlipForCoord(position.x, position.y, position.z)
	
    SetBlipSprite(tempBlip, spriteId)
    SetBlipDisplay(tempBlip, 4)
    SetBlipScale(tempBlip, scale)
    SetBlipColour(tempBlip, color)
    SetBlipAsShortRange(tempBlip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
	EndTextCommandSetBlipName(tempBlip)
	
	return tempBlip
end

function DrawHelpText(text, beep)
	if (beep and IsHelpMessageBeingDisplayed()) then
		beep = false
	end

	BeginTextCommandDisplayHelp('main')
    AddTextEntry('main', text)
    EndTextCommandDisplayHelp(0, false, beep, 1)
end

function numberWithCommas(integer)
    for i = 1, math.floor((string.len(integer)-1) / 3) do
        integer = string.sub(integer, 1, -3*i-i) .. ',' .. string.sub(integer, -3*i-i+1)
    end
    return integer
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function showNotification(type, msg)
    TriggerEvent('DoLongHudText', msg, type)
end