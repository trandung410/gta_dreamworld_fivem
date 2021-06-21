
Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

local obg1 = 0
local Pop1 = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false
local standardVolumeOutput = 1.0;

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
end)

function GenerateCoords(Zone) 
	while true do
		Citizen.Wait(1)

		local CoordX, CoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		CoordX = Zone.x + modX
		CoordY = Zone.y + modY

		local coordZ = GetCoordZ(CoordX, CoordY)
		local coord = vector3(CoordX, CoordY, coordZ)

		if ValidateObjectCoord(coord) then
			return coord
		end
	end
end

function GenerateCrabCoords()
	while true do
		Citizen.Wait(1)

		local crabCoordX, crabCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		crabCoordX = Config.Zone.Pos.x + modX
		crabCoordY = Config.Zone.Pos.y + modY

		local coordZ = GetCoordZ(crabCoordX, crabCoordY)
		local coord = vector3(crabCoordX, crabCoordY, coordZ)

		if ValidateObjectCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function ValidateObjectCoord(plantCoord)
	if obg1 > 0 then
		local validate = true

		for k, v in pairs(Pop1) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end


function SpawnObjects()
	while obg1 < 3 do
		Citizen.Wait(0)
		local CrabCoords = GenerateCrabCoords()

		local Listobg1 = {
			{ Name = Config.object },
			{ Name = Config.object }
		}

		local random_obg1 = math.random(#Listobg1)

		ESX.Game.SpawnLocalObject(Listobg1[random_obg1].Name, CrabCoords, function(object)
			PlaceObjectOnGroundProperly(object)
			FreezeEntityPosition(object, true)

			table.insert(Pop1, object)
			obg1 = obg1 + 1
			
		end)
	end
end


-- Spawn Object
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local PlayerCoords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(PlayerCoords, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, true) < 50 then
			SpawnObjects()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()

	local Config1 = Config.Zone
	local blip1 = AddBlipForCoord(Config1.Pos.x, Config1.Pos.y, Config1.Pos.z)

	SetBlipSprite (blip1, Config1.Blips.Id)
	SetBlipDisplay(blip1, 4)
	SetBlipScale  (blip1, Config1.Blips.Size)
	SetBlipColour (blip1, Config1.Blips.Color)
	SetBlipAsShortRange(blip1, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config1.Blips.Text)
	EndTextCommandSetBlipName(blip1)

end)


RegisterNetEvent('pk_cabbage:pic')
AddEventHandler('pk_cabbage:pic', function ()
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local x = math.random(1,Config.deleteobject)
		
			for i=1, #Pop1, 1 do
			    if GetDistanceBetweenCoords(coords, GetEntityCoords(Pop1[i]), false) < 2 then
				    nearbyObject, nearbyID = Pop1[i], i				
				end	
			end
			
				GiveHand()
				animazione()
				FreezeEntityPosition(playerPed, true)
							     
				TriggerEvent("mythic_progbar:client:progress", {
							name = "unique_action_name",
							duration = Config.time,
							label = Config.bartext,
							useWhileDead = false,
							canCancel = false,
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
						--

					Citizen.Wait(Config.time)							
							
			    ClearPedTasks(playerPed)

				if x == 1 then
					ESX.Game.DeleteObject(nearbyObject)
					table.remove(Pop1, nearbyID)
					obg1 = obg1 - 1
				end
				FreezeEntityPosition(playerPed, false)
				ClearPedTasks(playerPed)
					
				DeteHan()
				Citizen.Wait(100)
				animazione2()
				Citizen.Wait(1000)
				ClearPedTasks(playerPed)
				Detehand()
				Citizen.Wait(100)
				TriggerServerEvent('pk_cabbage:pickedUp')
						

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local x = math.random(1,Config.deleteobject)

		for i=1, #Pop1, 1 do
			    if GetDistanceBetweenCoords(coords, GetEntityCoords(Pop1[i]), false) < 2 then
				    nearbyObject, nearbyID = Pop1[i], i				
				end
				
	    end
		if nearbyObject and IsPedOnFoot(playerPed) then
			ESX.ShowHelpNotification("Nhấn ~r~[E]~s~ để lấy ~g~bắp cải")
			if IsDisabledControlJustReleased(0, 38) then
				TriggerServerEvent('pk_cabbage:Check')
				Citizen.Wait(Config.time + 2000)	
			end
		end
	end

end) 


function animazione2()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local prop2 = CreateObject(GetHashKey(Config.prop2), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(ped, 57005)

	AttachEntityToEntity(prop2, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)

	RequestAnimDict(Config.RequestAnimDict2)
	while (not HasAnimDictLoaded(Config.RequestAnimDict2)) do Citizen.Wait(0) end
	Citizen.Wait(100)
	
	TaskPlayAnim(GetPlayerPed(-1), Config.RequestAnimDict2, Config.TaskPlayAnim2, 8.0, 8.0, -1, 50, 0, false, false, false)

	
end

function Detehand() ----ลบ prop 
	local ped = GetPlayerPed(-1)
	local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop2), false, false, false)
	if object ~= 0 then
		DeleteObject(object)
		DetachEntity(prop2, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
	end
end

	
function DeteHan()
	local ped = GetPlayerPed(-1)
	local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop), false, false, false)
	if object ~= 0 then
		 DeleteObject(object)
	end
end

function GiveHand()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local prop = CreateObject(GetHashKey(Config.prop), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(ped, 57005)

	AttachEntityToEntity(prop, ped, boneIndex, 0.09, 0.0, 0.0, 420.0, 175.0, 20.0, true, true, false, true, 1, true)
end


function animazione()
	local ped = PlayerPedId()

	RequestAnimDict(Config.RequestAnimDict)
	while (not HasAnimDictLoaded(Config.RequestAnimDict)) do Citizen.Wait(0) end
	Citizen.Wait(100)
	TaskPlayAnim(ped, Config.RequestAnimDict, Config.TaskPlayAnim, 20.0, -20.0, -1, 1, 0, false, false, false) 
	
end


function deleteobject ()

    local nearbyObject, nearbyID
    local x = math.random(1,2)

    if x == 2 then
        ESX.Game.DeleteObject(nearbyObject)
        table.remove(Pop1, nearbyID)
        obg1 = obg1 - 1
    end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Pop1) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

