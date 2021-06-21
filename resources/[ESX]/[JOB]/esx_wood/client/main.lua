local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local cuttingActive = false
local cratingActive = false
local firstspawn = false
local impacts = 0
local timer = 0
local locations = {
    { ['x'] = -644.16,  ['y'] = 5460.69,  ['z'] = 53.09},
    { ['x'] = -632.42,  ['y'] = 5466.42,  ['z'] = 53.64},
    { ['x'] = -629.73,  ['y'] = 5470.82,  ['z'] = 53.48},
    { ['x'] = -653.29,  ['y'] = 5456.47,  ['z'] = 51.84},
    { ['x'] = -639.57,  ['y'] = 5504.25,  ['z'] = 51.3},
    { ['x'] = -635.01,  ['y'] = 5505.58,  ['z'] = 51.21},
    { ['x'] = -619.9,  ['y'] = 5487.71,  ['z'] = 51.53},
    { ['x'] = -638.89,  ['y'] = 5440.16,  ['z'] = 52.92},    
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

RegisterNetEvent("esx_wood:cutting")
AddEventHandler("esx_wood:cutting", function()
    cutting()
end)

RegisterNetEvent("esx_wood:crating")
AddEventHandler("esx_wood:crating", function()
    crating()
end)

RegisterNetEvent('esx_wood:timer')
AddEventHandler('esx_wood:timer', function()
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

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cuttingX, Config.cuttingY, Config.cuttingZ, true) < 5 then
                Draw3DText( Config.cuttingX, Config.cuttingY, Config.cuttingZ+0.5 -1.400, ("<FONT FACE='Montserrat'>Đang cắt gỗ "  .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cratingX, Config.cratingY, Config.cratingZ, true) < 5 then
                Draw3DText( Config.cratingX, Config.cratingY, Config.cratingZ+0.5 -1.400, ("<FONT FACE='Montserrat'>Đang đóng thùng " .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
end)

RegisterNetEvent('esx_wood:createblips')
AddEventHandler('esx_wood:createblips', function()
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
                if blips == true and blipActive == false then
                    blip1 = AddBlipForCoord(-643.5, 5465.51, 53.15)
                    blip2 = AddBlipForCoord(Config.cuttingX, Config.cuttingY, Config.cuttingZ)
                    blip3 = AddBlipForCoord(Config.cratingX, Config.cratingY, Config.cratingZ)
                    blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
                    SetBlipSprite(blip1, 237)
                    SetBlipColour(blip1, 5)
                    SetBlipAsShortRange(blip1, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("<FONT FACE='Montserrat'>[Làm gỗ] Khu khai thác")
                    EndTextCommandSetBlipName(blip1)   
                    SetBlipSprite(blip2, 237)
                    SetBlipColour(blip2, 5)
                    SetBlipAsShortRange(blip2, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("<FONT FACE='Montserrat'>[Làm gỗ] Cắt gỗ")
                    EndTextCommandSetBlipName(blip2)   
                    SetBlipSprite(blip3, 237)
                    SetBlipColour(blip3, 5)
                    SetBlipAsShortRange(blip3, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("<FONT FACE='Montserrat'>[Làm gỗ] Đóng thùng gỗ")
                    EndTextCommandSetBlipName(blip3)
                    SetBlipSprite(blip4, 238)
                    SetBlipColour(blip4, 5)
                    SetBlipAsShortRange(blip4, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("<FONT FACE='Montserrat'>[Làm gỗ] Bán gỗ")
                    EndTextCommandSetBlipName(blip4)    
                    blipActive = true
                elseif blips == false and blipActive == false then
                    RemoveBlip(blip1)
                    RemoveBlip(blip2)
                    RemoveBlip(blip3)
                end
        end
    end)
end)

Citizen.CreateThread(function()
    blip1 = AddBlipForCoord(Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ)
    SetBlipSprite(blip1, 237)
    SetBlipColour(blip1, 5)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("<FONT FACE='Montserrat'>[Làm gỗ] Phòng thay đồ")
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
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để khai thác gỗ")
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                mineActive = true
                            end
                        end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cuttingX, Config.cuttingY, Config.cuttingZ, true) < 25 and cuttingActive == false then
            DrawMarker(20, Config.cuttingX, Config.cuttingY, Config.cuttingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cuttingX, Config.cuttingY, Config.cuttingZ, true) < 1 then
                    ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để cắt gỗ")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_wood:cutting")
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cratingX, Config.cratingY, Config.cratingZ, true) < 25 and cratingActive == false then
            DrawMarker(20, Config.cratingX, Config.cratingY, Config.cratingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.cratingX, Config.cratingY, Config.cratingZ, true) < 1 then
                    ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để đóng thùng")
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("esx_wood:crating")  
                    end
                end
            end
        end
    end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            DrawMarker(20, Config.SellX, Config.SellY, Config.SellZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 1 then
                ESX.ShowHelpNotification("~w~Nhấn ~r~[E] ~w~ để bán thùng gỗ")
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
        {label = 'Nhận công việc khai thác gỗ', value = 'cloakroomICT'},
        {label = 'Nhận xe (chọn 2 lần)', value = 'vehicle'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wood_actions', {
        title    = 'Khai thác gỗ',
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
            TriggerEvent("esx_wood:createblips")
        elseif data.current.value == 'cloakroomICT' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                -- if skin.sex == 0 then
                --     TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                -- else
                --     TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                -- end
                blips = true
                TriggerEvent("esx_wood:createblips")
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
        {label = 'Tính tiền bán thùng gỗ',   value = 'cratedwood'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
        title    = 'Jubiler - sprzedaż',
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'cratedwood' then
            menu.close()
            TriggerServerEvent("esx_wood:sellcratedwood")
        end
    end)
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("melee@hatchet@streamed_core")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'melee@hatchet@streamed_core', 'plyr_rear_takedown_b', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey("prop_w_me_hatchet"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("esx_wood:givewood")
                    break
                end        
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
    TriggerEvent("esx_wood:timer")
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
    TriggerEvent("esx_wood:timer")
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
