ESX                           = nil
pk = GetCurrentResourceName()
local CachedWire = {}
local stolen = nil
local PlayerData		= {}



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent(pk..'StartWork')
AddEventHandler(pk..'StartWork', function ()

	if not Working then
		Working = true
		print ('Working True')
		TriggerEvent("pNotify:SendNotification", {
			text = "<span style='font-size:14;font-weight: 900'>Cemect</span><br>ใช้อุปกรณ์การจกปูน",
			type = "info",
			timeout = 5000,
			layout = "topRight"
		})

	Citizen.CreateThread(function()
		Citizen.Wait(100)

		while Working do
			local Wait = 1000

			local entity, entityDst = ESX.Game.GetClosestObject(Config.ElectronicAvailable)


			if DoesEntityExist(entity) and entityDst <= 1.5 then
				Wait = 5

				local binCoords = GetEntityCoords(entity)
				DisplayHelpText('Press ~INPUT_TALK~ to ~g~ steal~y~ pickup cement ')

			
						local coords = GetEntityCoords(PlayerPedId())
						local playerPed = GetPlayerPed(-1)
						
						if IsControlJustReleased(0, 38) and IsPedOnFoot(playerPed) then     
							local minigame1 = startminigame1(Zone)    
							if minigame1 == 100 then 
								if (GetDistanceBetweenCoords(coords, -259.9,-975.1,31.2, false) < Config.FarfromCity) then
								TriggerServerEvent(pk..'Checkpolice') 
									else
										TriggerEvent(pk.."Toofar")
								end   
								IsProcessing = false 
							else
								IsProcessing = false
							end	    
					end
				end
			Citizen.Wait(Wait)
		end
	end)
else

end

end)

function startminigame1(Zone)

	local Result = exports['xzero_skillcheck']:startGameSync({
		textTitle           = "Skill", -- ข้อความที่แสดง
		speedMin            = 10,         -- ความเร็วสุ่มตั้งแต่เท่าไหร่  (ยิ่งน้อยยิ่งเร็ว)
		speedMax            = 15,         -- ความเร็วสุ่มถึงเท่าไหร่    (ยิ่งน้อยยิ่งเร็ว)
		countSuccessMax     = 4,          -- กำหนดจำนวนครั้งที่สำเร็จ (เมื่อถึงเป้าจะ success)
		countFailedMax      = 1,          -- กำหนดจำนวนครั้งที่ล้มเหลว (เมื่อถึงเป้าจะ failed)
		layOut              = 'bottom',   -- ตำแหน่งที่แสดง | center กลาง | bottom ล่าง | top บน
		freezePos           = true,       -- true = ล็อคตำแหน่งผู้เล่นไม่ให้ขยับ
	})
	if Result.status then
		return 100
	else
		return 0
	end

end

RegisterNetEvent(pk..'Toofar')
AddEventHandler(pk..'Toofar', function()

     ESX.ShowNotification("~y~To far from city")  
    
end)

RegisterNetEvent(pk..'OK')
AddEventHandler(pk..'OK', function(xPlayer)
    local entity, entityDst = ESX.Game.GetClosestObject(Config.ElectronicAvailable)
	
    if not CachedWire[entity] then
        CachedWire[entity] = true

       TriggerEvent(pk..'StartProcess')
    else
        ESX.ShowNotification("You've already stolen this electronic!")
    end

end)


RegisterNetEvent(pk..'NO')
AddEventHandler(pk..'NO', function(xPlayer)
    
     ESX.ShowNotification("Need~r~ "..Config.Needcop.." Cop ~w~in town")
   
    
end)

RegisterNetEvent(pk..'StartProcess')
AddEventHandler(pk..'StartProcess', function() -- กรณีใช้แจ้งเตือนตำรวจ ALT +1 ให้ใส่ใต้บรรทัดนี้ จะรีเจคทันที

	Working = false
	print ('Working False')
	TriggerEvent("pNotify:SendNotification", {
		text = "<span style='font-size:14;font-weight: 900'>Cemect</span><br>เก็บอุปกรณ์การจกปูน",
		type = "error",
		timeout = 5000,
		layout = "topRight"
	})
	TriggerEvent("general-policealert:alertNet", "cement")
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 7000,
        label = "กำลังขโมยปูน",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
        },
        
    }, function(status) -- กรณีใช้แจ้งเตือนตำรวจ ALT +1 ให้ใส่ใต้บรรทัดนี้ จะเก็บเสร็จสิ้นแล้วรีเจค
        if not status then
           
    		TriggerServerEvent(pk.."retrieveelectronic")
			ClearPedTasks(PlayerPedId())			
			

        end
    end)
    

end)


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end