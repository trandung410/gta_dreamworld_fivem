ESX = nil
TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterServerEvent("core_carsharing:unlockVehicle")
AddEventHandler(
    "core_carsharing:unlockVehicle",
    function(veh)
        TriggerClientEvent("core_carsharing:unlockVehicle", -1, veh)
    end
)

ESX.RegisterServerCallback(
    "core_carsharing:unlockFee",
    function(source, cb, unlockFee)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getMoney() >= unlockFee then
            if Config.licenseRequired ~= "" then
                TriggerEvent(
                    "esx_license:checkLicense",
                    source,
                    Config.licenseRequired,
                    function(hasIt)
                        if hasIt then
                            print("has")
                            xPlayer.removeMoney(unlockFee)
                            cb(true)
                        else
                            cb(false)
                        end
                    end
                )
            else
                xPlayer.removeMoney(unlockFee)
                cb(true)
            end
        else
            cb(false)
        end
    end
)

RegisterServerEvent("core_carsharing:pay")
AddEventHandler(
    "core_carsharing:pay",
    function(amount)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        xPlayer.removeMoney(amount)
    end
)
