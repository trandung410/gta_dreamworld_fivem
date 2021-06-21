ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function randomchi()
    math.randomseed(GetGameTimer())
    return (math.random(1, 100) >= 96)
end
RegisterNetEvent("esx_miner:givestone")
AddEventHandler("esx_miner:givestone", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('stone').count < 50 then
                xPlayer.addInventoryItem('stone', 1)
                TriggerClientEvent('esx:showNotification', source, "Bạn đã nhận được ~b~đá thô.")
                if randomchi() then
                    xPlayer.addInventoryItem('chi', 1)
                    TriggerClientEvent('esx:showNotification', source, "Bạn nhận được 1 ~r~Chì")
                end
            else
                TriggerClientEvent('esx:showNotification', source, "Bạn không thể lấy thêm ~b~đá thô.")
            end
        end
    end)

    
RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('stone').count > 4 then
                TriggerClientEvent("esx_miner:washing", source)
                Citizen.Wait(15900)
                xPlayer.addInventoryItem('washed_stone', 5)
                xPlayer.removeInventoryItem("stone", 5)
            elseif xPlayer.getInventoryItem('stone').count < 5 then
                TriggerClientEvent('esx:showNotification', source, "Bạn cần ít nhất ~b~5 đá thô để rửa.")
            end
        end
    end)

RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('washed_stone').count > 4 then
                TriggerClientEvent("esx_miner:remelting", source)
                Citizen.Wait(15900)
                if randomChance > 0 and randomChance < 15 then -- 15%
                    xPlayer.addInventoryItem("diamond", 1)
                    xPlayer.removeInventoryItem("washed_stone", 5)
                    TriggerClientEvent('esx:showNotification', _source, "Bạn đã nhận được ~b~1 kim cương ~w~")
                elseif randomChance > 0 and randomChance < 20 then -- 20#
                    xPlayer.addInventoryItem("gold", 3)
                    xPlayer.removeInventoryItem("washed_stone", 5)
                    TriggerClientEvent('esx:showNotification', _source, "Bạn đã nhận được ~y~3 vàng ~w~")
                elseif randomChance > 0 and randomChance < 30 then -- 30%
                    xPlayer.addInventoryItem("iron", 5)
                    xPlayer.removeInventoryItem("washed_stone", 5)
                    TriggerClientEvent('esx:showNotification', _source, "Bạn đã nhận được ~w~5 sắt ~w~")
                elseif randomChance < 35 then
                    xPlayer.addInventoryItem("copper", 10) -- 35%
                    xPlayer.removeInventoryItem("washed_stone", 5)
                    TriggerClientEvent('esx:showNotification', _source, "Bạn đã nhận được ~o~10 đồng ~w~")
                end
            elseif xPlayer.getInventoryItem('stone').count < 5 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~đá thô.")
            end
        end
    end)

RegisterNetEvent("esx_miner:selldiamond")
AddEventHandler("esx_miner:selldiamond", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('diamond').count > 0 then
                local pieniadze = Config.DiamondPrice
                xPlayer.removeInventoryItem('diamond', 1)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, "Bán ~b~1 kim cương.")
            elseif xPlayer.getInventoryItem('diamond').count < 1 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~kim cương.")
            end
        end
    end)

RegisterNetEvent("esx_miner:sellgold")
AddEventHandler("esx_miner:sellgold", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('gold').count > 2 then
                local pieniadze = Config.GoldPrice
                xPlayer.removeInventoryItem('gold', 3)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, "Bán ~b~3 vàng.")
            elseif xPlayer.getInventoryItem('gold').count < 3 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~vàng.")
            end
        end
    end)

RegisterNetEvent("esx_miner:selliron")
AddEventHandler("esx_miner:selliron", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('iron').count > 4 then
                local pieniadze = Config.IronPrice
                xPlayer.removeInventoryItem('iron', 5)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, "Bán ~b~5 sắt.")
            elseif xPlayer.getInventoryItem('iron').count < 5 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~ sắt.")
            end
        end
    end)

RegisterNetEvent("esx_miner:sellcopper")
AddEventHandler("esx_miner:sellcopper", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('copper').count > 9 then
                local pieniadze = Config.CopperPrice
                xPlayer.removeInventoryItem('copper', 10)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, "Bán ~b~10 đồng.")
            elseif xPlayer.getInventoryItem('copper').count < 10 then
                TriggerClientEvent('esx:showNotification', source, "Bạn không còn đủ ~b~ đồng.")
            end
        end
    end)
