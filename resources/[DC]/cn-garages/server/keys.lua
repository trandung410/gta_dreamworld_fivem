local VehicleList = {}

ESX.RegisterServerCallback('vehiclekeys:CheckHasKey', function(source, cb, plate, vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(CheckOwner(plate, xPlayer.identifier, vehicle))
end)

RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate, vehicle)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if VehicleList ~= nil then
        if DoesPlateExist(plate, vehicle) then
            for k, val in pairs(VehicleList) do
                if val.plate == plate then
                    table.insert(VehicleList[k].owners, xPlayer.identifier)
                end
            end
        else
            local vehicleId = #VehicleList+1
            VehicleList[vehicleId] = {
                plate = plate, 
                vehicle = vehicle,
                owners = {},
            }
            VehicleList[vehicleId].owners[1] = xPlayer.identifier
        end
    else
        local vehicleId = #VehicleList+1
        VehicleList[vehicleId] = {
            plate = plate, 
            vehicle = vehicle,
            owners = {},
        }
        VehicleList[vehicleId].owners[1] = xPlayer.identifier
    end
end)

RegisterServerEvent('vehiclekeys:server:GiveVehicleKeys')
AddEventHandler('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if CheckOwner(plate, xPlayer.identifier) then
        if ESX.GetPlayerFromId(target) ~= nil then
            TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
			TriggerClientEvent('DoLongHudText', src, "You just gave keys to your vehicles!", 1)
			TriggerClientEvent('DoLongHudText', targer, "You just received keys to a vehicle!", 1)
        else
			TriggerClientEvent('DoLongHudText', src, "Player is not online!", 2)
        end
    else
		TriggerClientEvent('DoLongHudText', src, "You have no keys to this vehicle!", 2)
    end
end)

RegisterCommand("motor", function(source, args)
    local src = source
	TriggerClientEvent('vehiclekeys:client:ToggleEngine', src)
end)

RegisterCommand("givekeys", function(source, args)
	local src = source
    TriggerClientEvent('vehiclekeys:client:GiveKeys', src)
end)

function DoesPlateExist(plate, vehicle)
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.vehicle == vehicle then
                return true
            end
        end
    end
    return false
end

function CheckOwner(plate, identifier, vehicle)
    local retval = false
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if (val.vehicle ~= nil and val.vehicle == vehicle) or val.plate == plate then
                for key, owner in pairs(VehicleList[k].owners) do
                    if owner == identifier then
                        retval = true
                    end
                end
            end
        end
    end
    return retval
end

ESX.RegisterUsableItem("lockpick", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, false)
end)

ESX.RegisterUsableItem("advancedlockpick", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, true)
end)