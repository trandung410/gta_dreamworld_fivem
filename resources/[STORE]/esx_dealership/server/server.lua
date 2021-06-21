ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vehicleshop.requestInfo')
AddEventHandler('vehicleshop.requestInfo', function()
    local src = source
    local rows    

    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = GetPlayerIdentifiers(src)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })

    local firstname = result[1].name 

    local resultVehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles1')

    TriggerClientEvent('vehicleshop.receiveInfo', src, xPlayer.getAccount('bank').money, firstname)    

    TriggerClientEvent("vehicleshop.vehiclesInfos", src , resultVehicles)

    TriggerClientEvent("vehicleshop.notify", src, 'error', _U('rotate_keys'))
end)



ESX.RegisterServerCallback('vehicleshop.isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('vehicleshop.CheckMoneyForVeh')
AddEventHandler('vehicleshop.CheckMoneyForVeh', function(veh, price, name, vehicleProps)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM vehicles1 WHERE model = @model LIMIT 1', {
		['@model'] = veh
    }, function (result)
        if #result > 0 then
            local veiculo = result[1]
            local vehicleModel = veh
            local vehiclePrice = price
            local stockQtd = result[1].stock       
            if stockQtd > 0 then           
                if xPlayer.getAccount('bank').money >= tonumber(vehiclePrice) then
                    xPlayer.removeAccountMoney('bank', tonumber(vehiclePrice))
                    stockQtd = stockQtd - 1	                    
                    local vehiclePropsjson = json.encode(vehicleProps)
                    
                    local stateVehicle = 0 

                    if Config.SpawnVehicle then
                        stateVehicle = 0
                    else
                        stateVehicle = 1
                    end
                    
                    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)',
                    {
                        ['@owner']   = xPlayer.identifier,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = vehiclePropsjson,
                        ['@stored'] = stateVehicle,
                    },
                    
                    function (rowsChanged)                     
                        MySQL.Sync.execute('UPDATE vehicles1 SET stock = @stock WHERE model = @model',
                        {
                            ['@stock'] = stockQtd,
                            ['@model'] = vehicleModel
                        })

                        TriggerClientEvent("vehicleshop.sussessbuy", source, name, vehicleProps.plate, vehiclePrice)
                        TriggerClientEvent('vehicleshop.receiveInfo', source, xPlayer.getAccount('bank').money)    
                        TriggerClientEvent('vehicleshop.spawnVehicle', source, vehicleModel, vehicleProps.plate)                       
                    end)
                else
                    TriggerClientEvent("vehicleshop.notify", source, 'error', _U('enough_money'))
                end
            else
                TriggerClientEvent("vehicleshop.notify", source, 'error', _U('we_dont_vehicle'))
            end  
        end
	end)
end)