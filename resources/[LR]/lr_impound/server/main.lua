ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterServerCallback("lr_impound:callback:getVehicleOwner", function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = {}
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles LEFT JOIN users ON owned_vehicles.owner = users.identifier WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(result)
        if #result > 0 then
            vehicleData = json.decode(result[1].vehicle)
            data["plate"] = plate
            data["onwer"] = result[1].name
            data["color"] = {vehicleData.customPrimaryColor and vehicleData.customPrimaryColor.r or 0, vehicleData.customPrimaryColor and vehicleData.customPrimaryColor.g or 0, vehicleData.customPrimaryColor and vehicleData.customPrimaryColor.b or 0}
            data["body"] = (vehicleData.bodyHealth or 0) / 1000 * 100
            data["engine"] = (vehicleData.engineHealth or 0) / 1000 * 100
            data["fuel"] = vehicleData.fuelLevel or 0
            print(json.encode(data))
            cb(data)
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent("lr_impound:server:impound", function(data)
    local plate = ESX.Math.Trim(data.plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "army" then 
        local vehicles = GetAllVehicles()
        for k, v in pairs(vehicles) do 
            if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == plate then 
                DeleteEntity(v)
            end
        end
        MySQL.Async.execute("INSERT INTO lr_impound (officer, identifier, plate, fine, reason) VALUES (@officer, @identifier, @plate, @fine, @reason)", {
            ['@officer'] = xPlayer.name,
            ['@identifier'] = xPlayer.identifier,
            ['@plate'] = plate,
            ['@fine'] = data.fine,
            ['@reason'] = data.reason
        }, function(rowChanged)
            MySQL.Async.execute("UPDATE owned_vehicles SET impound = 1 WHERE plate = @plate", {
                ['@plate'] = plate
            })
        end)
    end
end)