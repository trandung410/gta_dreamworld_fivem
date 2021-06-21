ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

SocietyData = {}

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM jobs", {}, function(result)
        for i = 1, #result, 1 do 
            print(result[i].name)
            SocietyData[result[i].name] = Society:Init(json.decode(result[i].society_data), result[i].name)
        end
    end)
end)

AddEventHandler("lr_societydata:server:registerSociety", function(name)
    if not SocietyData[name] then 
        SocietyData[name] = Society:Init()
    end
end)

AddEventHandler("lr_societydata:server:getSociety", function(name, cb)
    cb(SocietyData[name])
end)

ESX.RegisterServerCallback("lr_societydata:callback:getData", function(source, cb)
    print(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = {}
    print(SocietyData[xPlayer.job.name])
    data.weapons = SocietyData[xPlayer.job.name].weapons
    data.items = SocietyData[xPlayer.job.name].items
    data.ammos = SocietyData[xPlayer.job.name].ammos
    data.accounts = SocietyData[xPlayer.job.name].accounts
    cb(data)
end)

ESX.RegisterServerCallback("lr_societydata:callback:getData2", function(source, cb)
    print(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = {}
    print(SocietyData[xPlayer.job2.name])
    data.weapons = SocietyData[xPlayer.job2.name].weapons
    data.items = SocietyData[xPlayer.job2.name].items
    data.ammos = SocietyData[xPlayer.job2.name].ammos
    data.accounts = SocietyData[xPlayer.job2.name].accounts
    cb(data)
end)

RegisterNetEvent("lr_societydata:server:putItem")
AddEventHandler("lr_societydata:server:putItem", function(data, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if data.type == "item_account" then 
        if xPlayer.getAccount(data.name).money >= count then 
            xPlayer.removeAccountMoney(data.name, count)
            SocietyData[xPlayer.job.name]:AddAccountMoney(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    elseif data.type == "item_standard" then 
        local xItem = xPlayer.getInventoryItem(data.name)
        if xItem.count >= count then 
            xPlayer.removeInventoryItem(data.name, count)
            SocietyData[xPlayer.job.name]:AddItem(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end 
    elseif data.type == "item_weapon" then 
        --[[ TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
            if weaponData.getWeapon(data.weaponId) then
                weaponData.removeWeapon(data.weaponId)
                SocietyData[xPlayer.job.name]:AddWeapon(data)
            else
                xPlayer.showNotification("Vũ khí này không tồn tại trong hệ thống")
            end
        end) ]]
        xPlayer.removeWeapon(data.name)
        SocietyData[xPlayer.job.name]:AddWeapon(data)
   --[[  elseif data.type == "item_ammo" then 
        TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
            if weaponData.getAmmo(data.name) >= count then 
                weaponData.removeAmmo(data.name, count)
                SocietyData[xPlayer.job.name]:AddAmmo(data.name, count)
            else
                xPlayer.showNotification("Số lượng không hợp lệ")
            end
        end) ]]
    else 
        xPlayer.showNotification("Vật phẩn này không hỗ trợ")
    end
end)

RegisterNetEvent("lr_societydata:server:putItem2")
AddEventHandler("lr_societydata:server:putItem2", function(data, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if data.type == "item_account" then 
        if xPlayer.getAccount(data.name).money >= count then 
            xPlayer.removeAccountMoney(data.name, count)
            SocietyData[xPlayer.job2.name]:AddAccountMoney(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    elseif data.type == "item_standard" then 
        local xItem = xPlayer.getInventoryItem(data.name)
        if xItem.count >= count then 
            xPlayer.removeInventoryItem(data.name, count)
            SocietyData[xPlayer.job2.name]:AddItem(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end 
    elseif data.type == "item_weapon" then 
        TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
            if weaponData.getWeapon(data.weaponId) then
                weaponData.removeWeapon(data.weaponId)
                SocietyData[xPlayer.job2.name]:AddWeapon(data)
            else
                xPlayer.showNotification("Vũ khí này không tồn tại trong hệ thống")
            end
        end)
    elseif data.type == "item_ammo" then 
        TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
            if weaponData.getAmmo(data.name) >= count then 
                weaponData.removeAmmo(data.name, count)
                SocietyData[xPlayer.job2.name]:AddAmmo(data.name, count)
            else
                xPlayer.showNotification("Số lượng không hợp lệ")
            end
        end)
    else 
        xPlayer.showNotification("Vật phẩn này không hỗ trợ")
    end
end)

RegisterNetEvent("lr_societydata:server:getItem")
AddEventHandler("lr_societydata:server:getItem", function(data, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(json.encode(data))
    if data.type == "item_account" then 
        print(SocietyData[xPlayer.job.name]:GetAccount(data.name))
        if SocietyData[xPlayer.job.name]:GetAccount(data.name) >= count then 
            SocietyData[xPlayer.job.name]:RemoveAccountMoney(data.name, count)
            xPlayer.addAccountMoney(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    elseif data.type == "item_standard" then 
        if SocietyData[xPlayer.job.name]:GetItem(data.name).count >= count then 
            SocietyData[xPlayer.job.name]:RemoveItem(data.name, count)
            xPlayer.addInventoryItem(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end 
    elseif data.type == "item_weapon" then 
        if SocietyData[xPlayer.job.name]:HasWeapon(data.name) then 
            SocietyData[xPlayer.job.name]:RemoveWeapon(data.name)
            --[[ TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
                weaponData.giveWeapon(data.weaponId, data.name, data.reliability)
            end) ]]
            xPlayer.addWeapon(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    --[[ elseif data.type == "item_ammo" then 
        if SocietyData[xPlayer.job.name]:GetAmmo(data.name) >= count then 
            SocietyData[xPlayer.job.name]:RemoveAmmo(data.name, count)
            TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
                weaponData.addAmmo(data.name, count)
            end)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end ]]
    else 
        xPlayer.showNotification("Vật phẩn này không hỗ trợ")
    end
end)

RegisterNetEvent("lr_societydata:server:getItem2")
AddEventHandler("lr_societydata:server:getItem2", function(data, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(json.encode(data))
    if data.type == "item_account" then 
        print(SocietyData[xPlayer.job2.name]:GetAccount(data.name))
        if SocietyData[xPlayer.job2.name]:GetAccount(data.name) >= count then 
            SocietyData[xPlayer.job2.name]:RemoveAccountMoney(data.name, count)
            xPlayer.addAccountMoney(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    elseif data.type == "item_standard" then 
        if SocietyData[xPlayer.job2.name]:GetItem(data.name).count >= count then 
            SocietyData[xPlayer.job2.name]:RemoveItem(data.name, count)
            xPlayer.addInventoryItem(data.name, count)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end 
    elseif data.type == "item_weapon" then 
        if SocietyData[xPlayer.job2.name]:HasWeapon(data.weaponId) then 
            SocietyData[xPlayer.job2.name]:RemoveWeapon(data.weaponId)
            TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
                weaponData.giveWeapon(data.weaponId, data.name, data.reliability)
            end)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    elseif data.type == "item_ammo" then 
        if SocietyData[xPlayer.job2.name]:GetAmmo(data.name) >= count then 
            SocietyData[xPlayer.job2.name]:RemoveAmmo(data.name, count)
            TriggerEvent("weapon_system:server:getPlayerData", source, function(weaponData)
                weaponData.addAmmo(data.name, count)
            end)
        else
            xPlayer.showNotification("Số lượng không hợp lệ")
        end
    else 
        xPlayer.showNotification("Vật phẩn này không hỗ trợ")
    end
end)