local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local cuttingActive = false
local cratingActive = false
local firstspawn = false
local timer = 0
local impacts =0
local locations = {
    { ['x'] = 599.7890625,  ['y'] = 2892.0324707031,  ['z'] = 39.83638381958},
    -- { ['x'] = 590.93499755859,  ['y'] = 2894.1545410156,  ['z'] = 39.501026153564},
    -- { ['x'] = 586.50024414062,  ['y'] = 2899.4482421875,  ['z'] = 39.661346435547},
    -- { ['x'] = 582.89758300781,  ['y'] = 2906.8420410156,  ['z'] = 39.834892272949},
    -- { ['x'] = 590.21807861328,  ['y'] = 2910.2048339844,  ['z'] = 40.061939239502},
    -- { ['x'] = 603.14294433594,  ['y'] = 2909.4658203125,  ['z'] = 40.219398498535},
    -- { ['x'] = 611.54693603516,  ['y'] = 2906.4875488281,  ['z'] = 39.775157928467},
    -- { ['x'] = 607.84222412109,  ['y'] = 2892.8950195312,  ['z'] = 39.49348449707},    
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent("esx_oildrill:cutting")
AddEventHandler("esx_oildrill:cutting", function()
    cutting()
end)

RegisterNetEvent("esx_oildrill:crating")
AddEventHandler("esx_oildrill:crating", function()
    crating()
end)

RegisterNetEvent('esx_oildrill:timer')
AddEventHandler('esx_oildrill:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 

    -- Citizen.CreateThread(function()
    --     while true do
    --         Citizen.Wait(1)
    --         if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cuttingX, Config.cuttingY, Config.cuttingZ, true) < 5 then
    --             Draw3DText( Config.cuttingX, Config.cuttingY, Config.cuttingZ+0.5 -1.400, ("<FONT FACE='Montserrat'>Đang lọc dầu "  .. timer .. '%'), 4, 0.1, 0.1)
    --         end
    --         if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cratingX, Config.cratingY, Config.cratingZ, true) < 5 then
    --             Draw3DText( Config.cratingX, Config.cratingY, Config.cratingZ+0.5 -1.400, ("<FONT FACE='Montserrat'>Đang chế biến xăng " .. timer .. '%'), 4, 0.1, 0.1)
    --         end
    --         if timer == 100 then
    --             timer = 0
    --             break
    --         end
    --     end
    -- end)
end)

RegisterNetEvent('esx_oildrill:createblips')
AddEventHandler('esx_oildrill:createblips', function()
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
                if blips == true and blipActive == false then
                    blip1 = AddBlipForCoord(599.7890625, 2892.0324707031, 39.83638381958)
                    -- blip2 = AddBlipForCoord(Config.cuttingX, Config.cuttingY, Config.cuttingZ)
                    -- blip3 = AddBlipForCoord(Config.cratingX, Config.cratingY, Config.cratingZ)
                    blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
                    SetBlipSprite(blip1, 648)
                    SetBlipColour(blip1, 5)
                    SetBlipAsShortRange(blip1, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("<FONT FACE='Montserrat'>~y~[Dầu khí] Khu khai thác")
                    EndTextCommandSetBlipName(blip1)   
                    -- SetBlipSprite(blip2, 648)
                    -- SetBlipColour(blip2, 5)
                    -- SetBlipAsShortRange(blip2, true)
                    -- BeginTextCommandSetBlipName("STRING")
                    -- AddTextComponentString("<FONT FACE='Montserrat'>~y~[Dầu khí] Khu lọc dầu")
                    -- EndTextCommandSetBlipName(blip2)   
                    -- SetBlipSprite(blip3, 648)
                    -- SetBlipColour(blip3, 5)
                    -- SetBlipAsShortRange(blip3, true)
                    -- BeginTextCommandSetBlipName("STRING")
                    -- AddTextComponentString("<FONT FACE='Montserrat'>~y~[Dầu khí] Khu chế biến xăng")
                    -- EndTextCommandSetBlipName(blip3)
                    SetBlipSprite(blip4, 648)
                    SetBlipColour(blip4, 5)
                    SetBlipAsShortRange(blip4, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("<FONT FACE='Montserrat'>~y~[Dầu khí] Bán xăng")
                    EndTextCommandSetBlipName(blip4)    
                    blipActive = true
                elseif blips == false and blipActive == false then
                    RemoveBlip(blip1)
                    -- RemoveBlip(blip2)
                    -- RemoveBlip(blip3)
                end
        end
    end)
end)

Citizen.CreateThread(function()
    blip1 = AddBlipForCoord(Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ)
    SetBlipSprite(blip1, 648)
    SetBlipColour(blip1, 5)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("<FONT FACE='Montserrat'>[Dầu khí] Phòng thay đồ")
    EndTextCommandSetBlipName(blip1)   
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, true) < 25 then
                    DrawMarker(20, Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, true) < 1 then
                            ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để truy cập")
                                if IsControlJustReleased(1, 51) then
                                    Cloakroom() 
                                end
                            end
                        end
                    end
                end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                DrawMarker(1, locations[i].x, locations[i].y, locations[i].z - 1, 0, 0, 0, 0, 0, 100.0, 8.0, 8.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 4 then
                        ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để khai thác dầu")
                            if IsControlJustReleased(1, 51) then
                                mineActive = true
                                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CONST_DRILL', 0, false)
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "unique_action_name",
                                    duration = 15000,
                                    label = "Đang khoan dầu...",
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
                                Citizen.Wait(15000)
                                ClearPedTasks(ped)
                                ClearAreaOfObjects(GetEntityCoords(ped), 2.0, 0)
                                Citizen.Wait(1000)		
                                mineActive = false 
                                TriggerServerEvent("esx_oildrill:givewood")
                            end
                        end
            end
        end
    end
end)

-- Citizen.CreateThread(function()
--     while true do
-- 	local ped = PlayerPedId()
--         Citizen.Wait(1)
--         if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cuttingX, Config.cuttingY, Config.cuttingZ, true) < 25 and cuttingActive == false then
--             DrawMarker(20, Config.cuttingX, Config.cuttingY, Config.cuttingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cuttingX, Config.cuttingY, Config.cuttingZ, true) < 1 then
--                     ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để lọc dầu")
--                         if IsControlJustReleased(1, 51) then
--                             TriggerServerEvent("esx_oildrill:cutting")
--                 end
--             end
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
-- 	local ped = PlayerPedId()
--         Citizen.Wait(1)
--         if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cratingX, Config.cratingY, Config.cratingZ, true) < 25 and cratingActive == false then
--             DrawMarker(20, Config.cratingX, Config.cratingY, Config.cratingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cratingX, Config.cratingY, Config.cratingZ, true) < 1 then
--                     ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để chế xăng")
--                         if IsControlJustReleased(1, 51) then
--                           TriggerServerEvent("esx_oildrill:crating")  
--                     end
--                 end
--             end
--         end
--     end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            DrawMarker(20, Config.SellX, Config.SellY, Config.SellZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 1 then
                ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để bán ")
                    if IsControlJustReleased(1, 51) then
                        Jeweler()                          
            end
        end
    end
 end)
    

-- Citizen.CreateThread(function()
--     local hash = GetHashKey("ig_natalia")

--     if not HasModelLoaded(hash) then
--         RequestModel(hash)
--         Citizen.Wait(100)
--     end

--     while not HasModelLoaded(hash) do
--         Citizen.Wait(0)
--     end

--     if firstspawn == false then
--         local npc = CreatePed(6, hash, Config.SellX, Config.SellY, Config.SellZ, 129.0, false, false)
--         SetEntityInvincible(npc, true)
--         FreezeEntityPosition(npc, true)
--         SetPedDiesWhenInjured(npc, false)
--         SetPedCanRagdollFromPlayerImpact(npc, false)
--         SetPedCanRagdoll(npc, false)
--         SetEntityAsMissionEntity(npc, true, true)
--         SetEntityDynamic(npc, true)
--     end
-- end)

function Cloakroom()
    local elements = {
        --{label = 'Thường phục', value = 'cloakroom1'},
        {label = 'Nhận công việc khai thác dầu', value = 'cloakroomICT'},
        {label = 'Nhận xe (chọn 2 lần)', value = 'vehicle'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wood_actions', {
        title    = 'Khai thác dầu',
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'cloakroom1' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)  
            blips = false
            blipActive = false
            TriggerEvent("esx_oildrill:createblips")
        elseif data.current.value == 'cloakroomICT' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                -- if skin.sex == 0 then
                --     TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                -- else
                --     TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                -- end
                blips = true
                TriggerEvent("esx_oildrill:createblips")
            end)
        elseif data.current.value == 'vehicle' then
            menu.close()
            RequestModel("rumpo3")
            Citizen.Wait(100)
            CreateVehicle("rumpo3", -283.49, 2533.76, 72.67, 0.0, true, true)
            ESX.ShowNotification("Phương tiện đã được lấy ra khỏi garage")
        end
    end)
end

function Jeweler()
    local elements = {
        {label = 'Tính tiền bán xăng',   value = 'oildrill'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
        title    = 'Jubiler - sprzedaż',
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'oildrill' then
            menu.close()
            TriggerServerEvent("esx_oildrill:sellcratedwood")
        end
    end)
end

-- function Animation()
--     Citizen.CreateThread(function()
--         while true do
--             Citizen.Wait(1)
-- 		    local ped = PlayerPedId()	
--             TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CONST_DRILL', 0, false)
-- 			TriggerEvent("mythic_progbar:client:progress", {
-- 				name = "unique_action_name",
-- 				duration = 10000,
-- 				label = "Đang đào dầu...",
-- 				useWhileDead = false,
-- 				canCancel = false,
-- 				controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
-- 				    },			
--                 }, function(status)
--                 if not status then
--                     -- Do Something If Event Wasn't Cancelled
--                 end
-- 			end)
-- 			Citizen.Wait(10000)
-- 			ClearPedTasks(ped)
-- 			Citizen.Wait(1000)
--             mineActive = false
--             TriggerServerEvent("esx_oildrill:givewood") 
--         end
--     end)
-- end
function Animation()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
		        local ped = PlayerPedId()	
                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CONST_DRILL', 0, false)
				TriggerEvent("mythic_progbar:client:progress", {
					name = "unique_action_name",
					duration = 10000,
					label = "Đang đào đá...",
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
				Citizen.Wait(10000)
				ClearPedTasks(ped)
				Citizen.Wait(1000)		
                mineActive = false 
                TriggerServerEvent("esx_oildrill:givewood")
        end
    end)
end
function cutting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    cuttingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_oildrill:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    cuttingActive = false
end

function crating()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    cratingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_oildrill:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    cratingActive = false
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString("<FONT FACE='Montserrat'>"..textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end
