ESX = nil 
local Ablip = {}
local blips = {}
local curArea = nil 
local curMarker = nil
local LocationArr = {}
local PlayerData = {}
local isCapturing = false
local captureBlip = {}
local first, second, third = {}, {}, {} 
local curCapture = nil
local deathCheck = false
local NotiBlip = false
Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent(config.ESXEvent, function(obj) ESX = obj end)
        Wait(1)
    end
    while PlayerData.job == nil do 
        Wait(1000)
        PlayerData = ESX.GetPlayerData()
    end
    TriggerServerEvent('lr_occupation:GetLocationOwner')
    local sleepThread = 1000
    while true do 
        Wait(sleepThread)
        local areaLoc = GetNearLoc()
        if areaLoc ~= false then 
            local blipLoc = IsNearMarker()
            local isDead = IsPlayerDead(PlayerId())
            if blipLoc ~= false then 
                sleepThread = 1
                local cacheMarker = config.Location[blipLoc[1]] 
                DrawMarker(1, cacheMarker.x, cacheMarker.y, cacheMarker.z - 1.100, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 40.0, 40.0, 2.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
                DrawMarker(1, cacheMarker.x, cacheMarker.y, cacheMarker.z - 1.100, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
                if isDead then 
                    if not deathCheck then
                        deathCheck = true
                    end
                elseif deathCheck == true then
                    deathCheck = false 
                end
                if blipLoc[2] <= 2.0 then 
                    --ESX.ShowHelpNotification(lang.HelpNotification)
					DrawHelpNotification(lang.HelpNotification, cacheMarker)
                    if IsControlJustReleased(0, 38) and not isDead then 
                        for i = 1, #LocationArr, 1 do 
                            if LocationArr[i].name == blipLoc[1] then 
                                if config.isUseJob2 then
                                    if config.job1[PlayerData.job.name] ~= nil or config.job2[PlayerData.job2.name] then
                                        if LocationArr[i].gang_name == PlayerData.job.name or LocationArr[i].gang_name == PlayerData.job2.name then
                                            ESX.ShowNotification(lang.occupated)
                                        else 
                                            StartCapture(blipLoc[1])
                                        end 
                                    else 
                                        ESX.ShowNotification(lang.InvalidJob)
                                    end
                                else
                                    if config.job1[PlayerData.job.name] ~= nil then
                                        if LocationArr[i].gang_name == PlayerData.job.name then 
                                            ESX.ShowNotification(lang.occupated)
                                        else 
                                            StartCapture(blipLoc[1])
                                        end 
                                    else 
                                        ESX.ShowNotification(lang.InvalidJob)
                                    end
                                end
                            end 
                        end 
                    end 
                end
            else 
                sleepThread = 1000
            end 
        end 
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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
    PlayerData.job2 = job
end)

RegisterNetEvent('lr_occupation:setCapturingBlip')
AddEventHandler('lr_occupation:setCapturingBlip', function(location, gangName)
    local coords = config.Location[location]
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(blip, 161)
	SetBlipScale(blip, 2.0)
	SetBlipColour(blip, 3)
    PulseBlip(blip)
    captureBlip[location] = blip
    NotiBlip = true
    print(gangName)
    local curBl = config.job2[gangName] or config.job1[gangName]
    local curLc = config.Location[location]
    NotificationArea(curLc.x, curLc.y, curLc.z, curLc.w, curLc.h, curLc.heading, curBl.color , 100, nil, 3, false, gangName)
end)

RegisterNetEvent('lr_occupation:removeBlip')
AddEventHandler('lr_occupation:removeBlip', function(location)
    if captureBlip[location] then 
        RemoveBlip(captureBlip[location]) 
        NotiBlip = false
    end
end)

StartCapture = function(location)
    ESX.TriggerServerCallback('lr_occupation:isCapturing', function(result)
        if result == false then 
            isCapturing = true
			curCapture = location
            TriggerServerEvent('lr_occupation:notify', location)
            local timer = config.TimeCapture/1000
            local player = PlayerId()
            Citizen.CreateThread(function()
                while isCapturing do 
                    Wait(1000)
                    timer = timer - 1                   
                end
            end)
            Citizen.CreateThread(function()
                while isCapturing do 
                    Wait(0)
                    if IsPlayerDead(player) then                       
                        TriggerServerEvent('lr_occupation:cancel', location)
                        isCapturing = false
                        curCapture = nil
                        ESX.ShowNotification("Đã hủy chiếm đóng")

                    end
                    if timer > 0 then 
                        drawTxt(0.75, 1.44, 1.0, 1.0, 0.4, "<FONT FACE='Montserrat'>Thời gian chiếm đóng: "..timer, 255, 255, 255, 255)
                    else
                        TriggerServerEvent('lr_occupation:captured', location)
                        isCapturing = false
                        curCapture = nil
                    end
                end
            end)
            --[[ TriggerEvent("mythic_progbar:client:progress", {
                name = "occupation",
                duration = config.TimeCapture,
                label = lang.CaptureLabel,
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = false,
                },
            }, function(status)
                if not status then 
                    TriggerServerEvent('lr_occupation:captured', location)
                    isCapturing = false
					curCapture = nil
                else 
                    TriggerServerEvent('lr_occupation:cancel', location)
                    isCapturing = false
					curCapture = nil
                end
            end) ]]
        else 
            --ESX.ShowNotification(lang.Busy)
        end
    end, location)
end

AreaBlip = function(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange, name)
    print(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange, name)
    if Ablip[name] then 
        RemoveBlip(Ablip[name])
    end
	if config.UseRadiusBlip then 
		local blip = AddBlipForRadius((x or 0.0),(y or 0.0),(z or 0.0),150.0)
		SetBlipColour(blip, (color or 1))
		SetBlipAlpha (blip, (alpha or 80))
		SetBlipHighDetail(blip, (highDetail or true))
		SetBlipRotation(blip, (heading or 0.0))
		SetBlipDisplay(blip, (display or 4))
		SetBlipAsShortRange(blip, (shortRange or true))
		Ablip[name] = blip
	else 
		local blip = AddBlipForArea((x or 0.0),(y or 0.0),(z or 0.0),(width or 100.0),(height or 100.0))
		SetBlipColour(blip, (color or 1))
		SetBlipAlpha (blip, (alpha or 80))
		SetBlipHighDetail(blip, (highDetail or true))
		SetBlipRotation(blip, (heading or 0.0))
		SetBlipDisplay(blip, (display or 4))
		SetBlipAsShortRange(blip, (shortRange or true))
		Ablip[name] = blip
	end
end

RegisterFontFile("font")
fontId = RegisterFontId("Montserrat")

Blip = function(x,y,z,sprite,color,text,scale,display,shortRange,highDetail, name)
    if blips[name] then 
        RemoveBlip(blips[name])
    end
    local blip = AddBlipForCoord((x or 0.0),(y or 0.0),(z or 0.0))
    local blipText = "<FONT FACE='Montserrat'>Khu chiếm đóng"
    if text ~= nil then 
        blipText= config.JobLabel[text]
    end
    SetBlipSprite               (blip, (sprite or 1))
    SetBlipDisplay              (blip, (display or 2))
    SetBlipScale                (blip, (scale or 1.0))
    SetBlipColour               (blip, (color or 4))
    SetBlipAsShortRange         (blip, (shortRange or false))
    SetBlipHighDetail           (blip, (highDetail or true))
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      (blipText)
    EndTextCommandSetBlipName   (blip)
    blips[name] = blip
end

GetNearLoc = function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for k, v in pairs(config.Location) do 
        local distance = GetDistanceBetweenCoords(pedCoords, v.x, v.y, v.z, false)
        if distance <= (v.w/2) then 
            return {k, distance}
        end 
    end 
    return false
end

IsNearMarker = function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped) 
    for k, v in pairs(config.Location) do 
        local distance = GetDistanceBetweenCoords(pedCoords, v.x, v.y, v.z, false)
        if distance <= config.DistanceDrawMarker then 
            return {k, distance}
        end 
    end 
    return false
end

IsNearMarker2 = function(coords)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped) 
    local distance = GetDistanceBetweenCoords(pedCoords, coords.x, coords.y, coords.z, false)
    if distance <= config.DistanceDrawMarker then 
        return true
    end 
    return false
end

RegisterNetEvent('lr_occupation:setBlip')
AddEventHandler('lr_occupation:setBlip', function(arr)
    LocationArr = arr
    for i = 1, #arr , 1 do 
        local curLc = config.Location[arr[i].name]
        if arr[i].gang_name ~= nil then 
            local curBl = config.job2[arr[i].gang_name] or config.job1[arr[i].gang_name]
            AreaBlip(curLc.x, curLc.y, curLc.z, curLc.w, curLc.h, curLc.heading, curBl.color , 100, nil, 3, false, arr[i].name)
            Blip(curLc.x, curLc.y, curLc.z, curBl.sprite, 0, arr[i].gang_name, 1.5, config.blipDisplay, false, false, arr[i].name)
        else 
            AreaBlip(curLc.x, curLc.y, curLc.z, curLc.w, curLc.h, curLc.heading, 1 , 100, nil, 3, false, arr[i].name)
            --          x,      y,       z,     width,    height,heading,     color,alpha,highDetail,display,shortRange, name
            Blip(curLc.x, curLc.y, curLc.z, 429, 1, nil, 1.0, config.blipDisplay, false, false, arr[i].name)
        --        x,       y,       z, sprite,color,text,             scale,display,shortRange,highDetail, name
        end
    end
end)

RegisterNetEvent('lr_occupation:updateCharts')
AddEventHandler('lr_occupation:updateCharts', function(pointArr)
    local firstPoint = {point = 0, name = nil}
    local secondPoint = {point = 0, name = nil}
    local thirdPoint = {point = 0, name = nil}
    if #pointArr > 0 then 
        for i = 1, #pointArr, 1 do 
            if pointArr[i].point > firstPoint.point then 
                firstPoint.point = pointArr[i].point
                firstPoint.name = pointArr[i].gang_name
            end
        end
    end
    if #pointArr > 1 then 
        for i = 1, #pointArr, 1 do 
            if pointArr[i].point > secondPoint.point and pointArr[i].gang_name ~= firstPoint.name then 
                secondPoint.point = pointArr[i].point
                secondPoint.name = pointArr[i].gang_name
            end
        end
    end
    if #pointArr > 2 then 
        for i = 1, #pointArr, 1 do 
            if pointArr[i].point > thirdPoint.point and pointArr[i].gang_name ~= firstPoint.name and pointArr[i].gang_name ~= secondPoint.name then 
                thirdPoint.point = pointArr[i].point
                thirdPoint.name = pointArr[i].gang_name
            end
        end
    end
    first, second, third = firstPoint, secondPoint, thirdPoint
end)

RegisterNetEvent('lr_occupation:notification')
AddEventHandler('lr_occupation:notification', function(name, LocName)
    print(name)
    SendNUIMessage({
        display = true,
        playerName = name,
        vitri = LocName
    })  
    Citizen.Wait(20000)
    SendNUIMessage({
        display = false,
    })
    --TriggerEvent("irs_hud:notification", 20000, "warning", "CHIẾM ĐÓNG", name..' Đang chiếm đóng khu vực '..LocName..'. Đề nghị mọi công dân không phận sự cẩn thận !')
end)


function drawCharts()
    local text1 = lang.ChartsTitle.."\n"
    local text2, text3, text4 = nil, nil, nil
    if first.name ~= nil then 
        text2 = "<FONT FACE='Montserrat'>Hạng 1: "..config.JobLabel[first.name].." |Điểm : "..first.point
    end
    if second.name ~= nil then 
        text3 = "<FONT FACE='Montserrat'>Hạng 2: "..config.JobLabel[second.name].." |Điểm : "..second.point
    end
    if third.name ~= nil then 
        text4 = "<FONT FACE='Montserrat'>Hạng 3: "..config.JobLabel[third.name].." |Điểm : "..third.point
    end
    local coordsCharts1 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z+0.4}
    local coordsCharts2 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z+0.2}
    local coordsCharts3 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z}
    local coordsCharts4 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z-0.2}
    ESX.Game.Utils.DrawText3D(coordsCharts1, text1)
    if text2 ~= nil then
        ESX.Game.Utils.DrawText3D(coordsCharts2, text2)
    end
    if text3 ~= nil then
        ESX.Game.Utils.DrawText3D(coordsCharts3, text3)
    end
    if text4 ~= nil then
        ESX.Game.Utils.DrawText3D(coordsCharts4, text4)
    end
end

function DrawHelpNotification(text, coords)
	ESX.Game.Utils.DrawText3D(coords, '<FONT FACE="Tahoma">'..text)
end

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(fontId)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('CUSTOM_TEXT')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

--drawTxt(0.75, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)

Citizen.CreateThread(function()
	local sleepThread2 = 2000
	while true do 
		Wait(sleepThread2)
		if isCapturing and curCapture~= nil then 
			sleepThread2 = 100
			local pedCoords = GetEntityCoords(PlayerPedId())
			local cacheLoc = config.Location[curCapture]
			local distanceC = GetDistanceBetweenCoords(pedCoords, cacheLoc.x, cacheLoc.y, cacheLoc.z, true)
			if distanceC > 20.0 then 
                TriggerServerEvent('lr_occupation:cancel', curCapture)
                isCapturing = false
                curCapture = nil
                ESX.ShowNotification("Đã hủy chiếm đóng")
			end 
		else  
			sleepThread2 = 2000
		end 
	end
end)

Citizen.CreateThread(function()
    local sleepThread3 = 2000
    while true do 
        Wait(sleepThread3)
        local charts = IsNearMarker2(config.ChartsLocation)
        if charts then 
            sleepThread3 = 1
            drawCharts()
        else 
            sleepThread3 = 2000
        end
    end
end)

NotificationArea = function(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange, name)
    Citizen.CreateThread(function()
        while NotiBlip do 
            local blip = AddBlipForArea((x or 0.0),(y or 0.0),(z or 0.0),(width or 100.0),(height or 100.0))
            SetBlipColour(blip, (color or 1))
            SetBlipAlpha (blip, (alpha or 80))
            SetBlipHighDetail(blip, (highDetail or true))
            SetBlipRotation(blip, (heading or 0.0))
            SetBlipDisplay(blip, (display or 4))
            SetBlipAsShortRange(blip, (shortRange or true))
            Wait(500)
            RemoveBlip(blip)
            Wait(500)
        end
    end)
end
    