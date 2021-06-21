ESX = nil
InBank = false
playerData, playerLoaded = nil, false
local banks
blips = {}
local showing = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if ESX == nil then
            
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(500)
            ESX.TriggerServerCallback('rl-banking:server:requestBanks', function(banksdata)
                banks = banksdata
                playerLoaded = true
                createBlips()
                if showing then
                    showing = false
                end
        
                TriggerEvent("debug", 'Banking: Refresh Banks', 'success')
            end)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if ESX ~= nil then
            if NetworkIsSessionStarted() then
                TriggerServerEvent('rl-banking:createNewAccount')
                return
            end
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(data)
    ESX.TriggerServerCallback('rl-banking:server:requestBanks', function(banksdata)
        banks = banksdata
        playerData = data
        playerLoaded = true
        createBlips()
        if showing then
            showing = false
        end

        TriggerEvent("debug", 'Banking: Refresh Banks', 'success')
    end)
end)

RegisterCommand('refreshBanks', function()
    ESX.TriggerServerCallback('rl-banking:server:requestBanks', function(banksdata)
        banks = banksdata
        playerLoaded = true
        createBlips()
        if showing then
            showing = false
        end

        TriggerEvent("debug", 'Banking: Refresh Banks', 'success')
    end)
end)

RegisterCommand('rb', function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent('rl-banking:client:syncBanks')
AddEventHandler('rl-banking:client:syncBanks', function(data)
    banks = data
    if showing then
        showing = false
    end
end)

RegisterNetEvent('rl-banking:updateCash')
AddEventHandler('rl-banking:updateCash', function(data)
    if playerLoaded and playerData then
        playerData.cash = data
        currentCash = playerData.cash
    end
end)

function createBlips()
    for k, v in pairs(banks) do
        blips[k] = AddBlipForCoord(tonumber(v.x), tonumber(v.y), tonumber(v.z))
        SetBlipSprite(blips[k], Config.Blip.blipType)
        SetBlipDisplay(blips[k], 4)
        SetBlipScale  (blips[k], 0.8)
        SetBlipColour (blips[k], Config.Blip.blipColor)
        SetBlipAsShortRange(blips[k], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(Config.Blip.blipName))
        EndTextCommandSetBlipName(blips[k])
    end
end

function removeBlips()
    for k, v in pairs(blips) do
        RemoveBlip(v)
    end
    blips = {}
end

function openAccountScreen()
    ESX.TriggerServerCallback('rl-banking:getBankingInformation', function(banking)
        if banking ~= nil then
            InBank = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                status = "openbank",
                information = banking
            })

            TriggerEvent("debug", 'Banking: Open UI', 'success')
        end        
    end)
end

function atmRefresh()
    ESX.TriggerServerCallback('rl-banking:getBankingInformation', function(infor)
        InBank = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            status = "refreshatm",
            information = infor
        })
    end)
end

RegisterNetEvent('rl-banking:openBankScreen')
AddEventHandler('rl-banking:openBankScreen', function()
    openAccountScreen()
end)

RegisterNetEvent('rl-banking:client:usedMoneyBag')
AddEventHandler('rl-banking:client:usedMoneyBag', function(item)
    local playerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(banks) do 
        if v.bankType == "Paleto" and v.moneyBags ~= nil and v.bankOpen then
            local moneyBagDist = #(playerCoords - vector3(v.moneyBags.x, v.moneyBags.y, v.moneyBags.z))
            if moneyBagDist < 1.0 then
                QBCore.Functions.Progressbar("accessing_atm", "Cashier Counting Bag..", 60000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('rl-banking:server:unpackMoneyBag', item)
                end, function()
                    QBCore.Functions.Notify("Failed!", "error")
                end)
            end
        end
    end
end)

local letSleep = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        letSleep = true
        if playerLoaded and ESX ~= nil and not InBank then 
            local playerPed = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(playerPed, true)
            if banks ~= nil then
                for k, v in pairs(banks) do 
                    local bankDist = #(playerCoords - vector3(v.x, v.y, v.z))
                    if bankDist < 3.0 then
                        letSleep = false

                        DrawMarker(27, v.x, v.y, v.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false) 

                        if v.bankType == "Paleto" and v.moneyBags ~= nil then
                            local moneyBagDist = #(playerCoords - vector3(v.moneyBags.x, v.moneyBags.y, v.moneyBags.z))
                            if v.bankOpen then
                                DrawMarker(27, v.moneyBags.x, v.moneyBags.y, v.moneyBags.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 138, 87, 165, 100, false, true, 2, true, nil, nil, false)
                            else
                                DrawMarker(27, v.moneyBags.x, v.moneyBags.y, v.moneyBags.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, nil, nil, false)
                            end
                        end
                        if bankDist < 1.0 then
                            DrawText3Ds(v.x, v.y, v.z-0.25, v.bankOpen and '[E] - Bank' or 'The bank is currently closed')

                            if v.bankOpen and IsControlJustPressed(0, 38) then
                                openAccountScreen()
                            end
                        end
                    end
                end
            end
        elseif InBank then
            letSleep = false
            DisablePlayerFiring(PlayerId(), true)
        end

        if letSleep then
            Citizen.Wait(100)
        end
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('rl-banking:transferError')
AddEventHandler('rl-banking:transferError', function(msg)
    SendNUIMessage({
        status = "transferError",
        error = msg
    })
end)

RegisterNetEvent('rl-banking:successAlert')
AddEventHandler('rl-banking:successAlert', function(msg)
    SendNUIMessage({
        status = "successMessage",
        message = msg
    })
end)
