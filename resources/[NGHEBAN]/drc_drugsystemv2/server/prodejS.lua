ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


if Config.dealerCommand then
RegisterCommand('dealer', function(source, args, rawcommand)
    xPlayer = ESX.GetPlayerFromId(source)
    drugToSell = {
        type = '',
        label = '',
        count = 0,
        i = 0,
        price = 0,
    }
    for k, v in pairs(Config.drugs) do
        item = xPlayer.getInventoryItem(k)
            
        if item == nil then
            return        
        end
            
        count = item.count
        drugToSell.i = drugToSell.i + 1
        drugToSell.type = k
        drugToSell.label = item.label
        
        if count >= 5 then
            drugToSell.count = math.random(1, 5)
        elseif count > 0 then
            drugToSell.count = math.random(1, count)
        end

        if drugToSell.count ~= 0 then
            drugToSell.price = drugToSell.count * v + math.random(1, 300)
            TriggerClientEvent('drc_drugsystem:findClient', source, drugToSell)
            break
        end
        
        if ESX.Table.SizeOf(Config.drugs) == drugToSell.i and drugToSell.count == 0 then
            xPlayer.showNotification(_U("nodrgusonplayer"), 6)
        end
    end
end, false)
end

if Config.sellbyusingitem then
    ESX.RegisterUsableItem("fish", function(source)
   -- RegisterCommand('dealer', function(source, args, rawcommand)
   local _source = source
        xPlayer = ESX.GetPlayerFromId(source)
        local xPlayer = ESX.GetPlayerFromId(_source)
        if Config.deleteitemafteruse then
        xPlayer.removeInventoryItem(Config.item, 1)
        end
        drugToSell = {
            type = '',
            label = '',
            count = 0,
            i = 0,
            price = 0,
        }
        for k, v in pairs(Config.drugs) do
            item = xPlayer.getInventoryItem(k)
                
            if item == nil then
                return        
            end
                
            count = item.count
            drugToSell.i = drugToSell.i + 1
            drugToSell.type = k
            drugToSell.label = item.label
            
            if count >= 5 then
                drugToSell.count = math.random(1, 5)
            elseif count > 0 then
                drugToSell.count = math.random(1, count)
            end
    
            if drugToSell.count ~= 0 then
                drugToSell.price = drugToSell.count * v + math.random(1, 300)
                TriggerClientEvent('drc_drugsystem:findClient', source, drugToSell)
                break
            end
            
            if ESX.Table.SizeOf(Config.drugs) == drugToSell.i and drugToSell.count == 0 then
                xPlayer.showNotification(_U("nodrgusonplayer"), 6)
            end
        end
    end, false)
    end

RegisterServerEvent('drc_drugsystem:pay')
AddEventHandler('drc_drugsystem:pay', function(drugToSell)
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(drugToSell.type, drugToSell.count)
    if Config.account == 'money' then
        xPlayer.addMoney(drugToSell.price)
        local connect = {
            {
                ["color"] = "140",
                ["title"] = "Hráč: " ..GetPlayerName(source).." (".. xPlayer.identifier ..") ( DROGA: " .. drugToSell.type ..") POČET: " ..drugToSell.count.." ZA: " .. drugToSell.price .."",
                ["description"] = "**prodal  drogy**",
                ["footer"] = {
                ["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
                ["icon_url"] = "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/271/alien_1f47d.png",
                },
            }
        }
        
        PerformHttpRequest("https://discord.com/api/webhooks/781773978816741386/wF6XOlZ7TUyvt-qy3CuTZjiR4ZsEe2e9uB7ZDdwlJNc-HdHmvx-MWI-YL77s_7npFHpu", function(err, text, headers) end, 'POST', json.encode({username = "PRODEJ DROG", embeds = connect}), { ['Content-Type'] = 'application/json' })
    else
        xPlayer.addAccountMoney(Config.account, drugToSell.price)
    end
end)


