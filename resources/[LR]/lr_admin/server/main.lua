ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local PlayersData = {}

ESX.RegisterServerCallback("lr_admin:callback:getPlayersData", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.AuthorizeGroup[xPlayer.getGroup()] then 
        for k, v in pairs(PlayersData) do 
            PlayersData[k].isOnline = false
        end
        local xPlayers = ESX.GetPlayers()
        for k, v in pairs(xPlayers) do 
            local founded = false
            local zPlayer = ESX.GetPlayerFromId(v)
            for k, v in pairs(PlayersData) do 
                if v.identifier == zPlayer.identifier then 
                    PlayersData[k].name = zPlayer.name
                    PlayersData[k].money = zPlayer.getMoney()
                    PlayersData[k].bank = zPlayer.getAccount('bank').money
                    PlayersData[k].black_money = zPlayer.getAccount('black_money').money
                    PlayersData[k].job = zPlayer.job.name
                    -- PlayersData[k].job2 = zPlayer.job2.name
                    PlayersData[k].id = exports.RufiUniqueID:GetUIDfromID(zPlayer.source)
                    PlayersData[k].isOnline = true
                    founded = true
                end
            end
            if not founded then 
                table.insert(PlayersData, {
                    name = zPlayer.name,
                    money =  zPlayer.getMoney(),
                    bank = zPlayer.getAccount('bank').money,
                    black_money = zPlayer.getAccount('black_money').money,
                    job = zPlayer.job.name,
                    -- job2 = zPlayer.job2.name,
                    coin = zPlayer.getAccount('vcoin').money,
                    id = exports.RufiUniqueID:GetUIDfromID(zPlayer.source),
                    identifier = zPlayer.identifier,
                    isOnline = true,
                    vehicles = {}
                })
            end
        end
        cb(PlayersData)
    end
end)

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM users", {}, function(users)
        for k, v in pairs(users) do 
            -- local accounts = json.decode(v.accounts)
            MySQL.Async.fetchAll("SELECT vehicle FROM owned_vehicles WHERE owner = @owner", {
                ['@owner'] = v.identifier
            }, function(vehicles)
                if #vehicles > 0 then 
                    local vehs = {}
                    for _, v2 in pairs(vehicles) do 
                        local c = json.decode(v2.vehicle)
                        table.insert(vehs, c)
                    end
                    table.insert(PlayersData, {
                        name = v.name,
                        job = v.job,
                        -- id = 0,
                        identifier = v.identifier,
                        isOnline = false,
                        vehicles = vehs
                    })
                else
                    table.insert(PlayersData, {
                        name = v.name,
                        job = v.job,
                        -- job2 = v.job2,
                        -- id = 0,
                        identifier = v.identifier,
                        isOnline = false,
                        vehicles = {}
                    })
                end
            end)
        end
    end)
end)

function GetIndex(identifier)
    for i = 1, #PlayersData, 1 do 
        if PlayersData[i].identifier == identifier then 
            return i
        end
    end
    return nil
end

ESX.RegisterServerCallback("lr_admin:callback:ChangeValue", function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.AuthorizeGroup[xPlayer.getGroup()] then 
        local playerIdx = GetIndex(data.identifier)
        local tPlayer = ESX.GetPlayerFromIdentifier(data.identifier)
        if playerIdx ~= nil then
            if tPlayer == nil then
                if data.name == "name" then 
                    MySQL.Async.execute("UPDATE users SET name = @name WHERE identifier = @identifier", {
                        ['@name'] = data.value,
                        ['@identifier'] = data.identifier
                    }, function(rowChanged)
                        print(rowChanged)
                        TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tên của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                        PlayersData[playerIdx].name = data.value
                        cb(PlayersData)
                    end)
                elseif data.name == "job" then 
                    MySQL.Async.execute("UPDATE users SET job = @job, job_grade = 0 WHERE identifier = @identifier", {
                        ['@job'] = data.value,
                        ['@identifier'] = data.identifier
                    }, function(rowChanged)
                        print(rowChanged)
                        TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi công việc của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                        PlayersData[playerIdx].job = data.value
                        cb(PlayersData)
                    end)
                elseif data.name == "money" then 
                    local cacheAccounts = {
                        ['black_money'] = PlayersData[playerIdx].black_money,
                        ['money'] = tonumber(data.value),
                        ['bank'] = PlayersData[playerIdx].bank
                    }
                    MySQL.Async.execute("UPDATE users SET accounts = @accounts WHERE identifier = @identifier", {
                        ['@identifier'] = data.identifier,
                        ['@accounts'] = json.encode(cacheAccounts)
                    }, function(rowChanged)
                        TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền mặt của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                        PlayersData[playerIdx].money = tonumber(data.value)
                        cb(PlayersData)
                    end)
                elseif data.name == "black_money" then 
                    local cacheAccounts = {
                        ['black_money'] = tonumber(data.value),
                        ['money'] = PlayersData[playerIdx].money,
                        ['bank'] = PlayersData[playerIdx].bank
                    }
                    MySQL.Async.execute("UPDATE users SET accounts = @accounts WHERE identifier = @identifier", {
                        ['@identifier'] = data.identifier,
                        ['@accounts'] = json.encode(cacheAccounts)
                    }, function(rowChanged)
                        TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền bẩn của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                        PlayersData[playerIdx].black_money = tonumber(data.value)
                        cb(PlayersData)
                    end)
                elseif data.name == "bank" then 
                    local cacheAccounts = {
                        ['black_money'] = PlayersData[playerIdx].black_money,
                        ['money'] = PlayersData[playerIdx].money,
                        ['bank'] = tonumber(data.value)
                    }
                    MySQL.Async.execute("UPDATE users SET accounts = @accounts WHERE identifier = @identifier", {
                        ['@identifier'] = data.identifier,
                        ['@accounts'] = json.encode(cacheAccounts)
                    }, function(rowChanged)
                        TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền ngân hàng của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                        PlayersData[playerIdx].bank = tonumber(data.value)
                        cb(PlayersData)
                    end)
                end
            else
                if data.name == "name" then 
                    tPlayer.setName(data.value)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tên của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                    PlayersData[playerIdx].name = data.value
                    cb(PlayersData)
                elseif data.name == "job" then 
                    tPlayer.setJob(data.value, 0)
                    PlayersData[playerIdx].job = data.value
                    cb(PlayersData)
                -- elseif data.name == "job2" then 
                --     tPlayer.setJob2(data.value, 0)
                --     PlayersData[playerIdx].job2 = data.value
                --     cb(PlayersData)
                elseif data.name == "money" then 
                    tPlayer.setMoney(tonumber(data.value))
                    TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền mặt của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                    PlayersData[playerIdx].money = tonumber(data.value)
                    cb(PlayersData)
                elseif data.name == "black_money" then 
                    tPlayer.setAccountMoney("black_money", tonumber(data.value))
                    TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền bẩn của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                    PlayersData[playerIdx].black_money = tonumber(data.value)
                    cb(PlayersData)
                elseif data.name == "bank" then 
                    tPlayer.setAccountMoney("bank", tonumber(data.value))
                    TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền ngân hàng của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                    PlayersData[playerIdx].bank = tonumber(data.value)
                    cb(PlayersData)
                elseif data.name == "coin" then 
                    tPlayer.setAccountMoney("coin", tonumber(data.value))
                    TriggerClientEvent("esx:showNotification", xPlayer.source, ("Bạn đã đổi tiền ngân hàng của %s thành %s"):format(PlayersData[playerIdx].name, data.value))
                    PlayersData[playerIdx].coin = tonumber(data.value)
                    cb(PlayersData)
                end
            end
        end
    end
end)

RegisterNetEvent("lr_admin:server:Action")
AddEventHandler("lr_admin:server:Action", function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.AuthorizeGroup[xPlayer.getGroup()] then 
        local tPlayer = ESX.GetPlayerFromIdentifier(data.identifier)
        if tPlayer ~= nil then
            if data.type == "goto" then 
                local ped = GetPlayerPed(tPlayer.source)
                local tCoords = GetEntityCoords(ped)
                print(tCoords)
                TriggerClientEvent("lr_admin:client:goto", xPlayer.source, tCoords, tPlayer.name)
            elseif data.type == "bring" then 
                local ped = GetPlayerPed(xPlayer.source)
                local xCoords = GetEntityCoords(ped)
                TriggerClientEvent("lr_admin:client:bring", tPlayer.source, xCoords)
            elseif data.type == "freeze" then 
                TriggerClientEvent("lr_admin:client:freeze", tPlayer.source)
            elseif data.type == "kill" then
                TriggerClientEvent("lr_admin:client:kill", tPlayer.source)
            elseif data.type == "inventory" then 
                TriggerClientEvent("esx_inventoryhud:openOtherInventory", xPlayer.source, tPlayer.source, tPlayer.name, "", tPlayer.loadout, {vehicle = true, house = true})
            end
        else
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Người chơi này không tồn tại")
        end
    end
end)

RegisterNetEvent("lr_admin:server:AddItem")
AddEventHandler("lr_admin:server:AddItem", function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.AuthorizeGroup[xPlayer.getGroup()] then 
        local itemName = data.name
        local itemValue = tonumber(data.value)
        local tPlayer = ESX.GetPlayerFromIdentifier(data.identifier)
        if tPlayer ~= nil then 
            tPlayer.addInventoryItem(itemName, itemValue)
        end
    end
end)

RegisterCommand("admin2", function()
    local peds = GetAllPeds()
    local ob = GetAllObjects()
    local ve = GetAllVehicles()
    for k, v in pairs(peds) do 
        local ownerNet = NetworkGetEntityOwner(v)
        
        print(k, v, ownerNet)
        DeleteEntity(v)
    end
    for k, v in pairs(ob) do 
        local ownerNet = NetworkGetEntityOwner(v)

        print(k, v, ownerNet)
        DeleteEntity(v)
    end
    for k, v in pairs(ve) do 
        local ownerNet = NetworkGetEntityOwner(v)
        local ped = GetPedInVehicleSeat(v, -1)
        local lastPed = GetLastPedInVehicleSeat(v, -1)
        if ped == 0 and lastPed == 0 then 
            print(k, v, ownerNet, ped, lastPed)
            DeleteEntity(v)
        end
    end
end, true)

RegisterCommand("object", function()
    local peds = GetAllPeds()
    local ob = GetAllObjects()
    for k, v in pairs(peds) do 
        local ownerNet = NetworkGetEntityOwner(v)
        
        print(k, v, ownerNet)
        DeleteEntity(v)
    end
    for k, v in pairs(ob) do 
        local ownerNet = NetworkGetEntityOwner(v)

        print(k, v, ownerNet)
        DeleteEntity(v)
    end
end, true)

RegisterNetEvent("test", function(s)
    print(s)
end)

function DeleteObjAndVeh()
    local peds = GetAllPeds()
    local ob = GetAllObjects()
    local ve = GetAllVehicles()
    for k, v in pairs(peds) do 
        local ownerNet = NetworkGetEntityOwner(v)
        
        print(k, v, ownerNet)
        DeleteEntity(v)
    end
    for k, v in pairs(ob) do 
        local ownerNet = NetworkGetEntityOwner(v)

        print(k, v, ownerNet)
        DeleteEntity(v)
    end
    for k, v in pairs(ve) do 
        local ownerNet = NetworkGetEntityOwner(v)
        local ped = GetPedInVehicleSeat(v, -1)
        local lastPed = GetLastPedInVehicleSeat(v, -1)
        if ped == 0 and lastPed == 0 then 
            print(k, v, ownerNet, ped, lastPed)
            DeleteEntity(v)
        end
    end
end

Citizen.CreateThread(function()
    while true do 
        Wait(1740000)
        TriggerClientEvent("esx:showNotification", -1, "Tất cả phương tiện không có người sẽ bị xóa sau 1 phút nữa")
        Wait(60000)
        DeleteObjAndVeh()
    end
end)