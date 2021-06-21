ESX = nil 
local LocationArr = {}
local isCapturing = {}
local GangPoint = {}
TriggerEvent(config.ESXEvent, function(obj) ESX = obj end)
local isOpen = false
local isBusy = false
local recently = 0

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k ,v in pairs(config.Location) do 
        isCapturing[k] = false
    end
end)

AddEventHandler('esx:playerDropped', function(playerId)
    for k, v in pairs(isCapturing) do 
        if v == playerId then 
            isCapturing[k] = false
        end
    end
end)

IsInTable = function(element, table)
    for k, v in ipairs(table) do 
        if v.name == element then 
            return true 
        end 
    end 
    return false
end

IsInTable2 = function(element, table)
    for k, v in ipairs(table) do 
        if v.gang_name == element then 
            return true 
        end 
    end 
    return false
end

MySQL.ready(function ()
    MySQL.Async.fetchAll('SELECT * FROM occupation', {}, function(result)
        LocationArr = result
        for k, v in pairs(config.Location) do 
            if not IsInTable(k, LocationArr) then 
                MySQL.Async.execute('INSERT INTO occupation (name, gang_name) VALUES (@name, NULL)', {["@name"] = k}, function(rowsChanged)
                    print(rowsChanged)
                end)
                MySQL.Async.fetchAll('SELECT * FROM occupation', {}, function(result)
                    LocationArr = result
                end)
            end 
        end
			print(ESX.DumpTable(LocationArr))

    end)
    MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
        GangPoint = result
        for k, v in pairs(config.job2) do 
            if not IsInTable2(k, GangPoint) then 
                MySQL.Async.execute('INSERT INTO occupation_point (gang_name, point) VALUES (@name, 0)', {["@name"] = k}, function(rowsChanged)
                    print(rowsChanged)
                end)
                MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
                    GangPoint = result
                end)
            end 
        end
        for k, v in pairs(config.job1) do 
            if not IsInTable2(k, GangPoint) then 
                MySQL.Async.execute('INSERT INTO occupation_point (gang_name, point) VALUES (@name, 0)', {["@name"] = k}, function(rowsChanged)
                    print(rowsChanged)
                end)
                MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
                    GangPoint = result
                end)
            end 
        end
        TriggerClientEvent('lr_occupation:updateCharts', -1, GangPoint)
    end)
    PointCount()
end)

RegisterNetEvent('lr_occupation:GetLocationOwner')
AddEventHandler('lr_occupation:GetLocationOwner', function()
    if #LocationArr == 0 then 
        Wait(1000)
    end
    TriggerClientEvent('lr_occupation:setBlip', source, LocationArr)
end)

RegisterNetEvent('lr_occupation:notify')
AddEventHandler('lr_occupation:notify', function(loc)
    for i = 1, #LocationArr, 1 do 
        if LocationArr[i].name == loc then 
            CaptureNotify(LocationArr[i].gang_name, lang.CaptureNotify)
        end 
    end 
end)

ESX.RegisterServerCallback('lr_occupation:isCapturing', function(source, cb, loc)
    if isOpen and not isBusy then
    -- if isOpen and isBusy == false then        
        isBusy = true
        local LocData = GetLocationData(loc)
        if isCapturing[loc] ~= nil then 
            if isCapturing[loc] == false then 
                if (os.time()-recently) > 300 then
                    if (os.time() - LocData.lastcapture) > config.SafeTime then 
                        cb(false)
                        recently = os.time()
                        LocData.lastcapture = os.time() - 3080
                        isCapturing[loc] = source 
                        local xPlayer = ESX.GetPlayerFromId(source)
                       
                        if xPlayer.job.name == "police" then 
                            TriggerClientEvent('lr_occupation:notification', -1, "Police", loc)
                            TriggerClientEvent('lr_occupation:setCapturingBlip', -1, loc,xPlayer.job.name)
                        else
                            TriggerClientEvent('lr_occupation:setCapturingBlip', -1, loc,xPlayer.job.name)
                            TriggerClientEvent('lr_occupation:notification', -1, config.JobLabel[xPlayer.job.name], loc)
                        end
                    else
                        cb(true)
                        TriggerClientEvent('esx:showNotification', source, lang.SafeTime..((config.SafeTime - (os.time() - LocData.lastcapture))).." giây" )
                        isBusy = false 
                    end
                else
                    cb(true)
                    TriggerClientEvent('esx:showNotification', source, "<FONT FACE='arial font'>Bạn phải đợi 15 phút để bắt đầu chiếm đóng")
                    isBusy = false
                end
            else 
                cb(true)
                TriggerClientEvent('esx:showNotification', source, lang.Busy)
            end
        end
    else
        TriggerClientEvent('esx:showNotification', source, "<FONT FACE='arial font'>Chưa tới thời điểm chiếm đóng")
    end
end)

RegisterNetEvent('lr_occupation:captured')
AddEventHandler('lr_occupation:captured', function(loc)
    local LocData = GetLocationData(loc)
    for i = 1, #LocationArr, 1 do 
        if LocationArr[i].name == loc then 
            LocData.lastcapture = os.time()
            CaptureNotify(LocationArr[i].gang_name, lang.Captured)
            local xPlayer = ESX.GetPlayerFromId(source)
            local curTime = os.time()
            if config.isUseJob2 then 
                if xPlayer.job.name == 'police' then 
                    LocationArr[i].gang_name = xPlayer.job.name
                    MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = xPlayer.job.name, ['@lastcapture'] = curTime, ['@name'] = loc})
                elseif config.JobLabel[xPlayer.gang.name] ~= nil then
                    LocationArr[i].gang_name = xPlayer.gang.name
                    MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = xPlayer.gang.name, ['@lastcapture'] = curTime, ['@name'] = loc})
                end           
            else 
                LocationArr[i].gang_name = xPlayer.job.name
                MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = xPlayer.job.name, ['@lastcapture'] = curTime, ['@name'] = loc})
            end
            recently = os.time()
            isCapturing[loc] = false 
            isBusy = false
        end 
    end
	TriggerClientEvent('lr_occupation:removeBlip', -1, loc)
    TriggerClientEvent('lr_occupation:setBlip', -1, LocationArr)
end)

RegisterNetEvent('lr_occupation:cancel')
AddEventHandler('lr_occupation:cancel', function(loc)
    if isCapturing[loc] then 
        isCapturing[loc] = false 
        TriggerClientEvent('lr_occupation:removeBlip', -1, loc)
        isBusy = false
        recently = os.time()
    end
end)

CaptureNotify = function(gangName, text)
    local xPlayers = ESX.GetPlayers()
    if config.isUserJob2 then 
        for i = 1, #xPlayers, 1 do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == gangName or xPlayer.gang.name == gangName then 
                TriggerClientEvent('esx:showNotification', xPlayers[i], text)
            end 
        end
    else 
        for i = 1, #xPlayers, 1 do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == gangName  then 
                TriggerClientEvent('esx:showNotification', xPlayers[i], text)
            end 
        end
    end
end

PointCount = function()
    for i = 1, #LocationArr, 1 do 
        if LocationArr[i].gang_name ~= nil then 
            MySQL.Sync.execute("UPDATE occupation_point SET point=point+1 WHERE gang_name=@gang_name", {['@gang_name'] = LocationArr[i].gang_name})
        end
    end 
    MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
        GangPoint = result
    end)
    TriggerClientEvent('lr_occupation:updateCharts', -1, GangPoint)
    Citizen.SetTimeout(config.UpdateTime, function()
        PointCount()
    end)
end

GetLocationData = function(locName)
	for i = 1, #LocationArr, 1 do 
		if LocationArr[i].name == locName then 
			return LocationArr[i]
		end
	end 
	return false
end

-- TriggerEvent("cron:runAt",22,15,function()
--     isOpen = true
-- end)

-- TriggerEvent("cron:runAt",22,30,function()
--     isOpen = false
-- end)

--[[ TriggerEvent("cron:runAt",18,05,function()
    isOpen = true
end)

TriggerEvent("cron:runAt",22,05,function()
    isOpen = false
end) ]]

-- function GetTime() 
--     local timestamp = os.time()
-- 	local d         = os.date('*t', timestamp).wday
-- 	local h         = tonumber(os.date('%H', timestamp))
-- 	local m         = tonumber(os.date('%M', timestamp))

-- 	return {d = d, h = h, m = m}
-- end

-- Trong tuần
-- function Tick()
--     local time = GetTime()
--     if (time.h == 20) and (time.m == 0 or time.m == 10 or time.m == 20 or time.m == 30 or time.m == 40 or time.m == 50) then
--         isOpen = true 
--     end 
--     if (time.h == 21) and (time.m == 0 or time.m == 10 or time.m == 20 or time.m == 30 or time.m == 40 or time.m == 50) then
--         isOpen = true 
--     end 
--     -- if (time.h == 22) and (time.m == 0 or time.m == 10 or time.m == 20 or time.m == 30 or time.m == 40 or time.m == 50) then
--     --     isOpen = true 
--     -- end 
--     if (time.h == 22) and (time.m == 0 or time.m == 30) then
--         isOpen = false 
--     end
--     SetTimeout(60000, Tick)
-- end

-- Cuối tuần

-- function Tick()
--     local time = GetTime()
--     if (time.h == 2) and (time.m == 0 or time.m == 30) then -- h la gio m la phut
--         isOpen = true 
--     end 
--     if (time.h == 1) and (time.m == 59 or time.m == 30) then 
--         isOpen = false 
--     end 
--     SetTimeout(60000, Tick)
-- end

-- Tick()