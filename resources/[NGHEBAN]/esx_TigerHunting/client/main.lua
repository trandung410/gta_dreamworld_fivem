local Keys = {
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

ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end

local AnimalPositions = {
	{ x = -584.14, y = 1510.65, z = 329.25 },
	{ x = -601.79, y = 1508.05, z = 323.8 },
	{ x = -607.23, y = 1495.25, z = 318.78 },
	{ x = -601.5, y = 1468.03, z = 314.23 },
	{ x = -626.27, y = 1484.14, z = 312.11 },
}

local AnimalsInSession = {}

local Positions = {
	['StartHunting'] = { ['hint'] = '<FONT FACE="Montserrat">[E] Bắt đầu báo trắng', ['x'] = -651.21, ['y'] = 1417.11, ['z'] = 304.35 },
	['Sell'] = { ['hint'] = '<FONT FACE="Montserrat">[E] Bán Thịt Báo', ['x'] = 6.9, ['y'] = -1816.6, ['z'] = 25.4 },
}

local OnGoingHuntSession = false
local HuntCar = nil

function LoadMarkers()

	

	LoadModel('blazer')
	LoadModel('a_c_mtlion')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			
			local plyCoords = GetEntityCoords(PlayerPedId())

			for index, value in pairs(Positions) do
				if value.hint ~= nil then

					if OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '<FONT FACE="Montserrat">[E] ~g~Dừng ~r~Săn Thú'
					elseif not OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '<FONT FACE="Montserrat">[E] ~g~Bắt đầu ~r~Săn Thú'
					end

					local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

					if distance < 5.0 then
						sleep = 5
						DrawM(value.hint, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
						if distance < 1.0 then
							if IsControlJustReleased(0, Keys['E']) then
								if index == 'StartHunting' then
									StartHuntingSession()
								else
									SellItems()
								end
							end
						end
					end

				end
				
			end
			Citizen.Wait(sleep)
		end
	end)
end

function StartHuntingSession()

	if OnGoingHuntSession then

		OnGoingHuntSession = false

		--RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true, true)

		DeleteEntity(HuntCar)

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		OnGoingHuntSession = true

	
		--Animals

		Citizen.CreateThread(function()

				
			for index, value in pairs(AnimalPositions) do
				local Animal = CreatePed(5, GetHashKey('a_c_mtlion'), value.x, value.y, value.z, 0.0, true, false)
				TaskWanderStandard(Animal, true, true)
				SetEntityAsMissionEntity(Animal, true, true)
				--Blips

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 463)
				SetBlipColour(AnimalBlip, 69)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("<FONT FACE='Montserrat'>Báo Trắng")
				EndTextCommandSetBlipName(AnimalBlip)


				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			end

			while OnGoingHuntSession do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						if AnimalHealth <= 0 then
							SetBlipColour(value.Blipid, 49)
							if PlyToAnimal < 2.0 then
								sleep = 5

								ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, '<FONT FACE="Montserrat">[E] Xẻ Thịt', 0.4)

								if IsControlJustReleased(0, Keys['E']) then
									--if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
										if DoesEntityExist(value.id) then
											table.remove(AnimalsInSession, index)
											SlaughterAnimal(value.id)
										end
									--[[else
										ESX.ShowNotification('Bạn phải sử dụng dao găm!')
									end]]
								end

							end
						end
					end
				end

				Citizen.Wait(sleep)

			end
				
		end)
	end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

 	TriggerEvent("mythic_progbar:client:progress", {
						 
		name = "unique_action_name",
		duration = 5000,
		label = "Lấy Thịt....",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			},
			
		}, function(status)
			if not status then
				-- Do Something If Event Wasn't Cancelled
			end
	end)

	Citizen.Wait(5000)

	ClearPedTasksImmediately(  PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

	ESX.ShowNotification('Bạn đã săn được ~y~Báo Trắng~w~ nặng ' ..AnimalWeight.. 'kg')

	TriggerServerEvent('kp_lion:reward', AnimalWeight)

	DeleteEntity(AnimalId)
end

function SellItems()
	TriggerServerEvent('kp_lion:sell')
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DrawM(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end
 
local blip = AddBlipForCoord(-651.21,1417.11,304.35)
SetBlipSprite(blip, 442)
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 1.1)
SetBlipColour(blip, 81)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("<FONT FACE='Montserrat'>Săn Báo Trắng")
EndTextCommandSetBlipName(blip)

 
local blip = AddBlipForCoord( 6.9,-1816.6,25.4)
SetBlipSprite(blip, 442)
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 1.0)
SetBlipColour(blip, 46)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("<FONT FACE='Montserrat'>Bán Thịt Báo")
EndTextCommandSetBlipName(blip)
