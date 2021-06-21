ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function randomchi()
    math.randomseed(GetGameTimer())
    return (math.random(1, 100) >= 76)
end
RegisterServerEvent('esx-qalle-hunting:reward')
AddEventHandler('esx-qalle-hunting:reward', function(Weight)
    local xPlayer = ESX.GetPlayerFromId(source)
    local MeatQuantity = xPlayer.getInventoryItem('meat').count
    local LeatherQuantity = xPlayer.getInventoryItem('leather').count

    if MeatQuantity < 50 or LeatherQuantity < 50 then

        if Weight >= 1 then
            xPlayer.addInventoryItem('meat', 1)
        elseif Weight >= 9 then
            xPlayer.addInventoryItem('meat', 1)
        elseif Weight >= 15 then
            xPlayer.addInventoryItem('meat', 1)
        end

        xPlayer.addInventoryItem('leather', 1)
        if randomchi() then
            xPlayer.addInventoryItem('daxin', 1)
            TriggerClientEvent('esx:showNotification', source, "<FONT FACE='Montserrat'>Bạn nhận được 1 ~r~da xịn")
        end
    end
end)

RegisterServerEvent('esx-qalle-hunting:sell')
AddEventHandler('esx-qalle-hunting:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local MeatPrice = 50
    local LeatherPrice = 50

    local MeatQuantity = xPlayer.getInventoryItem('meat').count
    local LeatherQuantity = xPlayer.getInventoryItem('leather').count

    if MeatQuantity > 0 or LeatherQuantity > 0 then
        xPlayer.addMoney(MeatQuantity * MeatPrice)
        xPlayer.addMoney(LeatherQuantity * LeatherPrice)

        xPlayer.removeInventoryItem('meat', MeatQuantity)
        xPlayer.removeInventoryItem('leather', LeatherQuantity)
        TriggerClientEvent('esx:showNotification', xPlayer.source, '<FONT FACE="Montserrat">Bạn đã bán ' .. LeatherQuantity + MeatQuantity .. ' và kiếm được $' .. LeatherPrice * LeatherQuantity + MeatPrice * MeatQuantity)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, '<FONT FACE="Montserrat">Bạn không có thịt hay da')
    end
        
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end


print('-------------------')