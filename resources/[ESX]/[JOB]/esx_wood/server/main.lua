ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function randompro()
    math.randomseed(GetGameTimer())
    return (math.random(1, 100) >= 96)
end
RegisterNetEvent("esx_wood:givewood")
AddEventHandler("esx_wood:givewood", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('wood').count < 50 then
                xPlayer.addInventoryItem('wood', 1)
                TriggerClientEvent('esx:showNotification', source, "Bạn đã nhận được ~b~cây gỗ.")
                if randompro() then
                    xPlayer.addInventoryItem('wood_pro', 1)
                    TriggerClientEvent('esx:showNotification', source, "Bạn nhận được 1 ~r~gỗ hiếm")
                end
            else
                TriggerClientEvent('esx:showNotification', source, "Bạn không thể lấy thêm ~b~cây gỗ.")
            end
        end
    end)
RegisterNetEvent("esx_wood:cutting")
AddEventHandler("esx_wood:cutting", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('wood').count > 0 then
                TriggerClientEvent("esx_wood:cutting", source)
                Citizen.Wait(15900)
                xPlayer.addInventoryItem('cutedwood', 1)
                xPlayer.removeInventoryItem("wood", 1)
            elseif xPlayer.getInventoryItem('wood').count < 1 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không đủ ~b~cây gỗ.")
            end
        end
    end)

RegisterNetEvent("esx_wood:crating")
AddEventHandler("esx_wood:crating", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('cutedwood').count > 0 then
                TriggerClientEvent("esx_wood:crating", source)
                Citizen.Wait(15900)
                xPlayer.addInventoryItem('cratedwood', 2)
                xPlayer.removeInventoryItem("cutedwood", 1)
                
            elseif xPlayer.getInventoryItem('wood').count < 2 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không đủ ~b~khúc gỗ.")
            end
        end
    end)

RegisterNetEvent("esx_wood:sellcratedwood")
AddEventHandler("esx_wood:sellcratedwood", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('cratedwood').count > 0 then
                local pieniadze = Config.cratedwoodPrice
                soluong = xPlayer.getInventoryItem('cratedwood').count
                xPlayer.removeInventoryItem('cratedwood', soluong)
                xPlayer.addMoney(pieniadze*soluong)
                TriggerClientEvent('esx:showNotification', source, "Bán ~b~"..soluong.." thùng gỗ.")
            elseif xPlayer.getInventoryItem('cratedwood').count < 1 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~thùng gỗ.")
            end
        end
    end)