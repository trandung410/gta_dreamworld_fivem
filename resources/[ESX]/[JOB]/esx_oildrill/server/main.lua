ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function randomrevive()
    math.randomseed(GetGameTimer())
    return (math.random(1, 100) >= 96)
end
RegisterNetEvent("esx_oildrill:givewood")
AddEventHandler("esx_oildrill:givewood", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('xang').count < 200 then
                xPlayer.addInventoryItem('xang', 1)
                TriggerClientEvent('esx:showNotification', source, "Bạn đã nhận được 1 ~b~Xăng.")
                if randomrevive() then
                    xPlayer.addInventoryItem('carbon', 1)
                    TriggerClientEvent('esx:showNotification', source, "Bạn nhận được 1 ~r~Carbon")
                end
            else
                TriggerClientEvent('esx:showNotification', source, "Bạn không thể lấy thêm ~b~Xăng")
            end
        end
    end)
RegisterNetEvent("esx_oildrill:cutting")
AddEventHandler("esx_oildrill:cutting", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('oil_raw').count > 0 then
                TriggerClientEvent("esx_oildrill:cutting", source)
                Citizen.Wait(15900)
                xPlayer.addInventoryItem('oil', 1)
                xPlayer.removeInventoryItem("oil_raw", 1)
            elseif xPlayer.getInventoryItem('oil_raw').count < 1 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không đủ ~b~Dầu thô")
            end
        end
    end)

RegisterNetEvent("esx_oildrill:crating")
AddEventHandler("esx_oildrill:crating", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('oil').count > 0 then
                TriggerClientEvent("esx_oildrill:crating", source)
                Citizen.Wait(15900)
                xPlayer.addInventoryItem('xang', 2)
                xPlayer.removeInventoryItem("oil", 1)
                
            elseif xPlayer.getInventoryItem('oil').count < 2 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không đủ ~b~Dầu đã lọc")
            end
        end
    end)

RegisterNetEvent("esx_oildrill:sellcratedwood")
AddEventHandler("esx_oildrill:sellcratedwood", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('xang').count > 0 then
                soluong = xPlayer.getInventoryItem('xang').count
                local pieniadze = Config.cratedwoodPrice
                xPlayer.removeInventoryItem('xang', soluong)
                xPlayer.addMoney(pieniadze*soluong)
                TriggerClientEvent('esx:showNotification', source, "Bán ~b~"..soluong.." Xăng")
            elseif xPlayer.getInventoryItem('xang').count < 1 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~ Xăng")
            end
        end
    end)