local AnimalPositions = {
	{ x = 1417.57, y = 1073.91, z = 113.37 },
	{ x = 1413.28, y = 1066.87, z = 113.4 },
	{ x = 1412.91, y = 1072.01, z = 113.4 },
	{ x = 1413.57, y = 1080.08, z = 113.42 },
	{ x = 1421.52, y = 1080.18, z = 113.36 },
	{ x = 1421.50, y = 1073.64, z = 113.4 },
	{ x = 1421.62, y = 1067.31, z = 113.4 },
}

local animaltype = {}
local AnimalsInSession = {}

ESX = nil
isPickingUp = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)
function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end
function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

RegisterNetEvent('pk_pig:setup')
AddEventHandler('pk_pig:setup', function()
	LoadModel('a_c_pig')
	--LoadModel('a_c_pig')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	
		for index, value in pairs(AnimalPositions) do
			--local rand = math.random(1,2)
			--	if rand == 1 then
					animaltype = 'a_c_pig'
				--else
				--	animaltype = 'a_c_pig'
				--end
				local Animal = CreatePed(5, GetHashKey(animaltype), value.x, value.y, value.z, 0.0, false, false)
				TaskWanderStandard(Animal, true, true)
				SetEntityAsMissionEntity(Animal, true, true)
				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			
		end
end)

Citizen.CreateThread(function()
	
	LoadModel('a_c_pig')
	--LoadModel('a_c_pig')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	
		for index, value in pairs(AnimalPositions) do
			--local rand = math.random(1,2)
			--	if rand == 1 then
					animaltype = 'a_c_pig'
				--else
				--	animaltype = 'a_c_pig'
				--end
				local Animal = CreatePed(5, GetHashKey(animaltype), value.x, value.y, value.z, 0.0, false, false)
				TaskWanderStandard(Animal, true, true)
				SetEntityAsMissionEntity(Animal, true, true)
				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			
		end
		
	while true do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					--if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)
						 sd = IsPedModel(value.id,GetHashKey('a_c_pig'))

						
							if PlyToAnimal < 2.0 then
								sleep = 5
									DrawMarker(2, AnimalCoords.x, AnimalCoords.y, AnimalCoords.z+0.35, 0, 0, 0, 0, 0, 0, 0.25, 0.25, 0.25, 0, 25, 165, 165, 0,0, 0,0)	
									ESX.ShowHelpNotification("Nhấn ~r~[G]~s~ để ~g~lấy thịt")
										if IsControlJustReleased(0, 38) then
											-- local minigame1 = startminigame1(Zone)
											
											-- 	if minigame1 == 100 then
											-- 		SetEntityHealth(value.id,0)
											-- 		table.remove(AnimalsInSession, index)
											-- 		SlaughterAnimal(value.id)
											-- 		--print(value.id)
											
											-- 		TriggerServerEvent('pk_pig:giveItem')	   
													
											-- 		IsProcessing = false 
											-- 	else
											-- 		IsProcessing = false
											-- 	end	
											if DoesEntityExist(value.id) then
												SetEntityHealth(value.id, 0)
												table.remove(AnimalsInSession, index)
												SlaughterAnimal(value.id)
												TriggerServerEvent('pk_pig:giveItem')	
												
												IsProcessing = false
											end
										end
							end
					--end
				end

				Citizen.Wait(sleep)

			end
end)

function startminigame1(Zone)

	local Result = exports['xzero_skillcheck']:startGameSync({
		textTitle           = "มินิเกม", -- ข้อความที่แสดง
		speedMin            = 15,         -- ความเร็วสุ่มตั้งแต่เท่าไหร่  (ยิ่งน้อยยิ่งเร็ว)
		speedMax            = 20,         -- ความเร็วสุ่มถึงเท่าไหร่    (ยิ่งน้อยยิ่งเร็ว)
		countSuccessMax     = 4,          -- กำหนดจำนวนครั้งที่สำเร็จ (เมื่อถึงเป้าจะ success)
		countFailedMax      = 3,          -- กำหนดจำนวนครั้งที่ล้มเหลว (เมื่อถึงเป้าจะ failed)
		layOut              = 'bottom',   -- ตำแหน่งที่แสดง | center กลาง | bottom ล่าง | top บน
		freezePos           = true,       -- true = ล็อคตำแหน่งผู้เล่นไม่ให้ขยับ
		playScenario        = "",         -- เล่นอนิเมชั่นประเภท TaskStartScenarios
		playAnim            =  {          -- เล่นอนิเมชั่นประเภท TaskPlayAnim
			Dict = "",                -- Anim Dictionary
			Name ="",                    -- Anim Name
		}
	})
	if Result.status then
		return 100
	else
		return 0
	end

end

function SlaughterAnimal(AnimalId)
isPickingUp = true
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	--exports['progressBars']:startUI(12000, "Slice Making a Cow Beef")
	Citizen.CreateThread(function()
		while isPickingUp == true do
														Citizen.Wait(0)
												
														TriggerEvent("esx:openinventory2")
												
														end
														end)			
	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())
	AddAnimal()
	DeleteEntity(AnimalId)
	isPickingUp = false
end

function AddAnimal()
	local AnimalX = math.random(1, 5)
	local AnimalY = math.random(1, 5)
	
	local Animal = CreatePed(5, GetHashKey(animaltype), 2379.03+AnimalX, 5051.64+AnimalY, 46.44, 0.0, false, false)
	TaskWanderStandard(Animal, true, true)
	SetEntityAsMissionEntity(Animal, true, true)
	table.insert(AnimalsInSession, {id = Animal, x = 2378.98+AnimalX, y = 5052.6+AnimalY, z = 46.44, Blipid = AnimalBlip})
	
end


function Process(player)
	isProcessing = true
	
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	
	--exports['progressBars']:startUI(7000, "กำลังแร่เนื้อ...")
	Citizen.CreateThread(function()
	while isProcessing == true do
														Citizen.Wait(0)
												
														TriggerEvent("esx:openinventory2")
												
														end
														end)			
	TriggerServerEvent('pk_pig:process')
	local timeLeft = 7000 / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), config.processing.Slice.coords, false) > 3 then
			TriggerServerEvent('pk_pig:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

local isPacking = false


