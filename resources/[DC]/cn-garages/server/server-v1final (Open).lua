ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetOSSep()
	if os.getenv('HOME') then
		return '/'
	else
		return '\\'
	end
end

function ExecuteSql(wait, query, cb)
	local rtndata = {}
	local waiting = true
	MySQL.Async.fetchAll(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
    end
    
	return rtndata
end

serverConfig = GaragesConfig
serverConfig['garages'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
serverConfig['impounds'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'impounds.json'))
serverConfig['houses'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
local networkVehicles = {}
local isAuthorized = true
local coordsSaver = {}
local vehicles = {}

CreateThread(function()
    Wait(1000)
    TriggerEvent('cn-garages:server:setFirstData')

    --[[
    local resName = GetCurrentResourceName()
    if resName ~= "cn-garages" then
        print('^1[CN Shop Garages] ^7Not Authorized | Wrong Resource Name.')
        local embed = {
        {
                ["color"] = "65450",
                ["title"] = 'Product Started',
                ["description"] = '**Product Name:** cn-garages\n**Not Authorized** | Name failed ' .. resName,
                ["footer"] = {
                    ["text"] = "Made by CN Shop",
                },
            }
        }
        PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'CN Shop Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
        while true do end
        return
    end

    if GaragesConfig == nil or GaragesConfig['settings']['license'] == nil then
        print('^1[CN Shop Garages] ^7Unable to locate the Config File.')
        local embed = {
            {
                ["color"] = "65450",
                ["title"] = 'Product Started',
                ["description"] = '**Product Name:** ' .. resName .. '\n**Not Authorized** | Config failed',
                ["footer"] = {
                    ["text"] = "Made by CN Shop",
                },
            }
        }
        PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'CN Shop Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
        while true do end
        return
    end

    PerformHttpRequest("https://api.myip.com/", function(err, text, headers) 
        local ip = json.decode(text).ip
        PerformHttpRequest("http://barbaronn.xyz/api/licensingSystem.php/?api_key=A462D4A614E645267556B5870&license=" .. GaragesConfig['settings']['license'] .. "&ip=" .. ip, function(err, text, headers) 
            local data = json.decode(text)
            if data["Code"] ~= "200" then
                print('^6[CN Shop Garages] ^7Not ^1Authorized.')
                local embed = {
                {
                        ["color"] = "65450",
                        ["title"] = 'Product Started',
                        ["description"] = '**Product Name:** ' .. resName .. '\n**IP:** ' .. ip .. '\n**License:** ' .. GaragesConfig['settings']['license'] .. '\n**Not Authorized** | Triggered Server Crash',
                        ["footer"] = {
                            ["text"] = "Made by CN Shop",
                        },
                    }
                }
                PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'Babaron Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
                while true do end
            else
                local embed = {
                {
                        ["color"] = "65450",
                        ["title"] = 'Product Started',
                        ["description"] = '**Product Name:** ' .. resName .. '\n**IP:** ' .. ip .. '\n**License:** ' .. GaragesConfig['settings']['license'] .. '\n**Authorized** | ' .. data["Text"],
                        ["footer"] = {
                            ["text"] = "Made by CN Shop",
                        },
                    }
                }
                PerformHttpRequest("https://discordapp.com/api/webhooks/761083962189414410/Ahfu4NaHJRTMBToEQ4sBlG-vcqnmRdFJqHKoG5Vchi6V20MRh-AFACGCkbZbeL6ntHwp", function(err, text, headers) end, 'POST', json.encode({username = 'Babaron Products', embeds = embed}), { ['Content-Type'] = 'application/json' })
                print('^6[CN Shop Garages] ^7' .. data["Text"] .. ' ^2Authorized.')
                isAuthorized = true
                
            end
        end)
    end)]]
end)

RegisterServerEvent('cn-garages:server:setFirstData')
AddEventHandler('cn-garages:server:setFirstData', function()
    ExecuteSql(false, "SELECT * FROM `bbvehicles`", function(vehicles)
        if vehicles ~= nil then
            local counter, impound = 0, 0
            for _, vehicle in pairs(vehicles) do
                if vehicle.state == 'garages' then
                    counter = counter + 1
                    local data = json.decode(vehicle.parking)
                    serverConfig['garages'][data[2]]['slots'][data[1]][2] = false
                    serverConfig['garages'][data[2]]['slots'][data[1]][3] = {model = vehicle.model, props = json.decode(vehicle.props), plate = vehicle.plate}
                elseif vehicle.state == 'house' then
                    local data = json.decode(vehicle.parking)
                    serverConfig['houses'][data[2]]['slots'][data[1]][2] = false
                    serverConfig['houses'][data[2]]['slots'][data[1]][3] = {model = vehicle.model, props = json.decode(vehicle.props), plate = vehicle.plate}
                elseif vehicle.state == 'unknown' then
                    ExecuteSql(false, "UPDATE `bbvehicles` SET `state` = 'impound', `parking` = '' WHERE `plate` = '" .. vehicle.plate .. "' AND `citizenid` = '" .. vehicle.citizenid .. "' LIMIT 1")
                end

                if vehicle.fakeplate ~= nil and vehicle.fakeplate ~= '' then
                    ExecuteSql(false, "UPDATE `bbvehicles` SET `fakeplate` = '' WHERE `plate` = '" .. vehicle.plate .. "' AND `citizenid` = '" .. vehicle.citizenid .. "' LIMIT 1")
                end
            end
            
            print('^6[CN Shop Garages] ^7Loaded ' .. tostring(math.ceil(counter)) .. ' vehicles.')
        else
            print('^6[CN Shop Garages] ^7Could not find any vehicles.')
        end

       ExecuteSql(false, "SELECT * FROM `player_houses`", function(housing)
            local counter = 0
            if housing[1] ~= nil then
                for key, house in pairs(housing) do
                    if serverConfig['houses'][house.house] ~= nil then
                        serverConfig['houses'][house.house]['access'] = json.decode(house.keyholders)
                        counter = counter + 1
                    end
                end

                print('^6[CN Shop Garages] ^7Loaded ' .. tostring(counter) .. ' house garages.')
            else
                print('^6[CN Shop Garages] ^7Could not find any house garages.')
            end

            TriggerClientEvent('cn-garages:client:syncConfig', -1, 1, serverConfig)
            print('^6[CN Shop Garages] ^7Waiting for first player in order to create vehicles.')
            while #ESX.GetPlayers() <= 0 do Wait(0) end
            --local playerid = ESX.GetPlayerFromId()[1]
            TriggerClientEvent('cn-garages:client:createParkingVehicle', true)
        end)
    end)
end)

RegisterServerEvent('cn-garages:server:impoundVehicle')
AddEventHandler('cn-garages:server:impoundVehicle', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    ExecuteSql(false, "UPDATE `bbvehicles` SET `state` = 'impound', `parking` = '' WHERE `plate` = '" .. plate .. "' AND `citizenid` = '" .. xPlayer.identifier .. "' LIMIT 1")
end)
    
RegisterServerEvent('cn-garages:server:parkVehicle')
AddEventHandler('cn-garages:server:parkVehicle', function(garage, typ, slots, plate, stats)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local time = os.time()

    if typ == 'garages' then
        serverConfig['garages'][garage]['slots'][slots[1]][2] = false

        local jsonz = {slots[1], garage, plate, time}
        ExecuteSql(false, "SELECT `props` FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(props)
            if props[1] ~= nil then
                local vehicleprops = json.decode(props[1].props)
                serverConfig['garages'][garage]['slots'][slots[1]][3] = {model = vehicleprops.model, props = vehicleprops, plate = plate}

                ExecuteSql(false, "UPDATE `bbvehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "'")
                TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'garages', garage, 'slots', serverConfig['garages'][garage]['slots'])
                TriggerClientEvent('cn-garages:client:createParkingVehicle', src, false, serverConfig['garages'][garage]['slots'][slots[1]])
            else
                print('^1[cn-garages] ^7' .. GetPlayerName(src) .. ' just tried to expoilt the garages.')
            end
        end)
    elseif typ == 'houses' then
        serverConfig['houses'][garage]['slots'][slots[1]][2] = false
        local jsonz = {slots[1], garage, plate}
        ExecuteSql(false, "SELECT `props` FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(props)
            if props[1] ~= nil then
                local vehicleprops = json.decode(props[1].props)
                serverConfig['houses'][garage]['slots'][slots[1]][3] = {model = vehicleprops.model, props = vehicleprops, plate = plate}

                ExecuteSql(false, "UPDATE `bbvehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'house', `parking` = '" .. json.encode(jsonz) .. "' WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "'")
                TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'houses', garage, 'slots', serverConfig['houses'][garage]['slots'])
                TriggerClientEvent('cn-garages:client:createParkingVehicle', src, false, serverConfig['houses'][garage]['slots'][slots[1]])
            else
                print('^1[cn-garages] ^7' .. GetPlayerName(src) .. ' just tried to expoilt the garages.')
            end
        end)
    end
end)

RegisterServerEvent('cn-garages:server:setVehicleOwned')
AddEventHandler('cn-garages:server:setVehicleOwned', function(props, stats, model)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    ExecuteSql(false, "INSERT INTO `bbvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('" .. xPlayer.identifier .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RegisterServerEvent('cn-garages:server:updateProps')
AddEventHandler('cn-garages:server:updateProps', function(props)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    ExecuteSql(false, "UPDATE `bbvehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "'")
    ExecuteSql(false, "UPDATE `bbvehicles` (`props`) VALUES ('" .. xPlayer.identifier .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RegisterServerEvent('cn-garages:server:vehiclePayout')
AddEventHandler('cn-garages:server:vehiclePayout', function(garage, plate, price, typ)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    
    if typ ~= 'houses' then
		if xPlayer.getMoney() >= price then
            ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(vehicle)
                if vehicle[1] ~= nil then
                    local veh = vehicle[1]

                    local modelExists = IsModelExists(veh.model)
                    --if modelExists == true then
						if xPlayer.getMoney() >= price then
						    xPlayer.removeMoney(price)
                            ExecuteSql(false, "UPDATE `bbvehicles` SET `state` = 'unknown', `parking` = '' WHERE `id` = '" .. veh.id .. "'")
                            if typ == 'garages' then
                                serverConfig['garages'][garage]['slots'][json.decode(veh.parking)[1]][2] = true
                                serverConfig['garages'][garage]['slots'][json.decode(veh.parking)[1]][3] = nil
                                TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'garages', garage, 'slots', serverConfig['garages'][garage]['slots'])
                                print('^2[cn-garages] ^7Released ' .. plate .. ' from the garage')
                            else
                                print('^2[cn-garages] ^7Released ' .. plate .. ' from the impound')
                            end
                            
                            TriggerClientEvent('cn-garages:client:releaseVehicle', src, veh, typ, garage)
                        else
                            TriggerClientEvent('DoLongHudText', src, "Are you sure you got the money? :thinking:", 2)
                        end
                    --else
                        --TriggerClientEvent('DoLongHudText', src, "Error while fetching model, Please contact support [CODE " .. veh.id .. "]", 2)
                    --end
                else
                    TriggerClientEvent('DoLongHudText', src, "Couldnt find your vehicle, big OOF", 2)
                    cb(false)
                end
            end)
        else
            TriggerClientEvent('DoLongHudText', src, "You don\'t have enough money.", 2)
        end
    else
        ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(vehicle)
            local veh = vehicle[1]

            local modelExists = IsModelExists(veh.model)
            --if modelExists == true then
                ExecuteSql(false, "UPDATE `bbvehicles` SET `state` = 'unknown', `parking` = '' WHERE `id` = '" .. veh.id .. "'")
                
                serverConfig['houses'][garage]['slots'][json.decode(veh.parking)[1]][2] = true
                serverConfig['houses'][garage]['slots'][json.decode(veh.parking)[1]][3] = nil
                TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'houses', garage, 'slots', serverConfig['houses'][garage]['slots'])
                print('^2[cn-garages] ^7Released ' .. plate .. ' from the house garage')
                
                TriggerClientEvent('cn-garages:client:releaseVehicle', src, veh, typ, garage)
            --else
                --TriggerClientEvent('DoLongHudText', src, "Error while fetching model, Please contact support [CODE " .. veh.id .. "]", 2)
            --end
        end)
    end
end)

ESX.RegisterServerCallback('cn-garages:server:getConfig', function(source, cb)
    cb(serverConfig, isAuthorized, 'http://kostaprotection.xyz/files/garagesv0.0.8/')
end)

ESX.RegisterServerCallback('cn-garages:server:getOwnedVehicles', function(source, cb, nearbyVehicles, freeSlots, name, keys)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "'", function(vehicles)
        function nospaceButton(plate)
            return "<a id='button' btn-type='nospace' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-times-circle\"></i></span><span class=\"text\">No Space</span></a>"
        end

        function payButton(plate)
		    print(json.encode(data))
            return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\".payModal\" class=\"btn btn-primary btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Pay</span></a>"
        end

        function unknownButton(plate)
            return "<a id='button' btn-type='unknown' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\">    <i class=\"fas fa-search\"></i>  </span>  <span class=\"text\">Unknown</span></a>"
        end

        function garageButton(name, plate, typ)
            return "<a id='button' btn-type='" .. typ .. "' btn-plate='" .. plate .. "' btn-name='" .. name .. "' href=\"#\" class=\"btn btn-warning btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-exclamation-triangle\"></i>  </span>  <span class=\"text\">" .. name .. "</span></a>"
        end
        
        function houseButton(name, plate)
            return "<a id='button' btn-type='house' btn-plate='" .. plate .. "' btn-name='" .. name .. "' href=\"#\" class=\"btn btn-info btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-exclamation-triangle\"></i>  </span>  <span class=\"text\">" .. name .. "</span></a>"
        end
        
        function parkButton(plate)
            return "<a id='button' btn-type='park' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-success btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-charging-station\"></i>  </span>  <span class=\"text\">Park</span></a>"
        end
        
        local vehiclesTable = {}

        if vehicles ~= nil and isAuthorized == true then
            for _, vehicle in pairs(vehicles) do
                local stats = json.decode(vehicle.stats)
                local status = vehicle.state

                if status == 'unknown' then
                    local isNearby = IsNearby(vehicle.plate, nearbyVehicles)
                    if isNearby == true then
                        if freeSlots > 0 then
                            table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, parkButton(vehicle.plate), 'border-left-success'})
                        else
                            table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, nospaceButton(vehicle.plate), 'border-left-danger'})
                        end
                    else
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, unknownButton(vehicle.plate), 'border-left-danger'})
                    end
                elseif status == 'house' then
                    local parking = json.decode(vehicle.parking)
                    if parking[2] == name then
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, payButton(vehicle.plate), 'border-left-info', parking})
                    else
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, houseButton(parking[2], vehicle.plate), 'border-left-info'})
                    end
                elseif status == 'impound' then
                    local parking = json.decode(vehicle.parking)
                    table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, garageButton('Impounded', vehicle.plate, 'impound'), 'border-left-warning'})
                elseif status == 'garage' then
                    local parking = json.decode(vehicle.parking)
                    if parking[2] == name then
                        local parking = json.decode(vehicle.parking)
                        local time = os.time() - parking[4]
                        parking[4] = math.ceil((time / 60) / 60)
                        if serverConfig['garages'][name]['payment']['onetime'] == false then
                            parking[5] = math.ceil(serverConfig['garages'][name]['payment']['price'] * math.ceil(parking[4]))
                        else
                            parking[5] = serverConfig['garages'][name]['payment']['price']
                        end
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, payButton(vehicle.plate), 'border-left-primary', parking})
                    else
                        table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, garageButton(parking[2], vehicle.plate, 'garage'), 'border-left-danger'})
                    end
                end
            end
        end

        cb(vehiclesTable)
    end)
end)

ESX.RegisterServerCallback('cn-garages:server:getImpoundedVehicles', function(source, cb, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `state` = 'impound'", function(vehicles)
        function payButton(plate)
            return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\".payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">Pay</span></a>"
        end
        
        local vehiclesTable = {}
        if vehicles[1] ~= nil and isAuthorized == true then
            for _, vehicle in pairs(vehicles) do
                table.insert(vehiclesTable, {vehicle.model, vehicle.plate, payButton(vehicle.plate), serverConfig['impounds'][name]['price']})
            end
        end

        cb(vehiclesTable)
    end)
end)

ESX.RegisterServerCallback('cn-garages:server:isVehicleOwned', function(source, cb, plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.identifier .. "' AND `plate` = '" .. plate .. "' LIMIT 1", function(result)
        if result ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('cn-garages:server:hasFines', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '" .. xPlayer.identifier .. "'", function(result)
        if result ~= nil and #result > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

-- house garages

ESX.RegisterCommand('addhousegarage', 'user', function(xPlayer, args, showError)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == GaragesConfig['settings']['housing']['realestate-job'] then
		TriggerClientEvent(GaragesConfig['settings']['housing']['qb-houses:client:addGarage'], source, tonumber(args[1]))
	end
end, false, {help = "CN-Garages: Add garage to nearest house"})

ESX.RegisterCommand('setslot', 'user', function(xPlayer, args, showError)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == GaragesConfig['settings']['housing']['realestate-job'] then
        TriggerClientEvent('cn-garages:client:GetPlayerCoords', source, 'cn-garages:server:updateHouseSlot', args, true)
    end
end, false, {help = "CN-Garages: Set House Garage Slot"})

RegisterServerEvent('cn-garages:server:addHouseGarage')
AddEventHandler('cn-garages:server:addHouseGarage', function(house, coord, max)
    local src = source
	TriggerClientEvent('DoLongHudText', src, "You have added a garage to " .. house, 1)
    
    local houseGarages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
    if houseGarages[house] == nil then
        houseGarages[house] = {
            coords = coord,
            max = max,
            access = {},
            slots = {}
        }

        local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json', json.encode(houseGarages), -1)
        ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '" .. house .. "' LIMIT 1", function(housing)
            serverConfig['houses'][house] = {
                coords = coord,
                max = max,
                access = {},
                slots = {}
            }

            if housing[1] ~= nil then
                local houseData = housing[1]
                serverConfig['houses'][house]['access'] = json.decode(house.keyholders)
            end

            TriggerClientEvent('cn-garages:client:syncConfig', -1, 3, 'houses', house, serverConfig['houses'][house])
        end)
	end
end)

RegisterServerEvent('cn-garages:server:buyHouseGarage')
AddEventHandler('cn-garages:server:buyHouseGarage', function(house, citizenid, source)
    local src = source
    if serverConfig['houses'][house] ~= nil then
        table.insert(serverConfig['houses'][house]['access'], citizenid)
        TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'houses', house, 'access', serverConfig['houses'][house]['access'])
    end
end)

RegisterServerEvent('cn-garages:server:updateHouseAccess')
AddEventHandler('cn-garages:server:updateHouseAccess', function(data, house)
    local src = source
    if serverConfig['houses'][house] ~= nil then
        serverConfig['houses'][house]['access'] = data
        TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'houses', house, 'access', data)
    end
end)

RegisterServerEvent('cn-garages:server:updateHouseSlot')
AddEventHandler('cn-garages:server:updateHouseSlot', function(coords, heading, args, house)
    local src = source
    if #serverConfig['houses'][house]['slots'] <= serverConfig['houses'][house]['max'] then
        serverConfig['houses'][house]['slots'][tonumber(args[1])] = {{x = coords.x, y = coords.y, z = coords.z, h = heading}, true}

        local houseGarages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json'))
        houseGarages[house]['slots'] = serverConfig['houses'][house]['slots']
        local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'houses.json', json.encode(houseGarages), -1)
        TriggerClientEvent('cn-garages:client:syncConfig', -1, 2, 'houses', house, 'slots', serverConfig['houses'][house]['slots'])
		TriggerClientEvent('DoLongHudText', src, "Updated " .. house .. ' garage, slot ' .. args[1] .. '.', 1)
    else
		TriggerClientEvent('DoLongHudText', src, "You reached the max amount of garage slots, Try replacing old ones.", 2)
    end
end)

-- fakeplates

ESX.RegisterUsableItem('advancedscrewdriver', function(source)
    local src = source
    TriggerClientEvent('cn-garages:client:fakeplate:steal', src)
end)

ESX.RegisterUsableItem('licenseplate', function(source, info)
    local src = source
    TriggerClientEvent('cn-garages:client:fakeplate:usePlate', src, info)
end)

RegisterServerEvent('cn-garages:server:isPlayerVehicle')
AddEventHandler('cn-garages:server:isPlayerVehicle', function(typ, plate, vehicle)
    if typ == 'STEAL' then
        ExecuteSql(false, "SELECT `model` FROM `bbvehicles` WHERE `plate` = '" .. plate .. "' LIMIT 1", function(result)
            if result[1] ~= nil then
                ExecuteSql(false, "UPDATE `bbvehicles` SET `fakeplate` = '%' WHERE `plate` = '" .. plate .. "' AND `model` = '" .. result[1].model .. "' LIMIT 1")
                networkVehicles[vehicle] = {plate, '%'}
            end
        end)
    elseif typ == 'SET' then
        if networkVehicles[vehicle] ~= nil then
            if networkVehicles[vehicle][1] == plate then
                ExecuteSql(false, "UPDATE `bbvehicles` SET `fakeplate` = '' WHERE `plate` = '" .. plate .. "' LIMIT 1")
                networkVehicles[vehicle] = nil
            else
                ExecuteSql(false, "UPDATE `bbvehicles` SET `fakeplate` = '" .. plate .. "' WHERE `plate` = '" .. networkVehicles[vehicle][1] .. "' LIMIT 1")
                networkVehicles[vehicle][2] = plate
            end
        end
    end
end)

RegisterServerEvent('cn-garages:server:fakeplate:breakScrewdriver')
AddEventHandler('cn-garages:server:fakeplate:breakScrewdriver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem('advancedscrewdriver', 1)
	TriggerClientEvent('DoLongHudText', src, "Your Advanced Screwdriver went broken", 2)
end)

RegisterServerEvent('cn-garages:server:fakeplate:removeLicensePlate')
AddEventHandler('cn-garages:server:fakeplate:removeLicensePlate', function(slot)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem('licenseplate', 1, slot)
	TriggerClientEvent('DoLongHudText', src, "Success fully installed license plate", 1)
end)

RegisterServerEvent('cn-garages:server:fakeplate:createLicensePlate')
AddEventHandler('cn-garages:server:fakeplate:createLicensePlate', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addInventoryItem('licenseplate', 1, nil, {plate = plate})
	TriggerClientEvent('DoLongHudText', src, "You stole a license plate", 1)
end)

-- Dev

ESX.RegisterCommand('creategarage', 'admin', function(xPlayer, args, showError)
    TriggerClientEvent('cn-garages:client:GetPlayerCoords', source, 'cn-garages:server:dev:creategarage', args)
end, false, {help = "CN-Garages: Create New Garage"})

ESX.RegisterCommand('setinteract', 'admin', function(xPlayer, args, showError)
    TriggerClientEvent('cn-garages:client:GetPlayerCoords', source, 'cn-garages:server:dev:setinteract', args)
end, false, {help = "CN-Garages: Set Closest Garage Interact Location"})

ESX.RegisterCommand('setpayment', 'admin', function(xPlayer, args, showError)
    local price = args[1]
    local perhour = tonumber(args[2]) ~= nil and tonumber(args[2]) == 1 and true or false
    TriggerClientEvent('cn-garages:client:GetPlayerCoords', source, 'cn-garages:server:dev:setpayment', {price, perhour})
end, false, {help = "CN-Garages: Set the payment for the closest garage"})

ESX.RegisterCommand('setslots', 'admin', function(xPlayer, args, showError)
	local src = source
	TriggerClientEvent('cn-garages:client:coords:updateStatus', src)
end, false, {help = "CN-Garages: Toggle CN-Garages Slots Editor"})

RegisterServerEvent('cn-garages:server:dev:creategarage')
AddEventHandler('cn-garages:server:dev:creategarage', function(coords, heading, args)
    local src = source
    local name = args[1]

    if serverConfig['garages'][name] == nil then
        local newgarage = {}
        newgarage['blip'] = {
            ['enable'] = true,
            ['coords'] = coords,
            ['type'] = 'garage',
        }
        newgarage['slots'] = {}
        newgarage['payment'] = { ['price'] = 36, ['onetime'] = false}

        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
        garages[name] = newgarage
        local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)

        serverConfig['garages'][name] = newgarage
		TriggerClientEvent('DoLongHudText', src, "Created new garage! [" .. name .. "]", 1)
        TriggerClientEvent('cn-garages:client:syncConfig', -1, 1, serverConfig)
    else
		TriggerClientEvent('DoLongHudText', src, "A Garage with the same name already exists", 2)
    end
end)

RegisterServerEvent('cn-garages:server:dev:setinteract')
AddEventHandler('cn-garages:server:dev:setinteract', function(coords, heading, args)
    local src = source
    local enablePed = tonumber(args[1]) ~= nil and tonumber(args[1]) == 1 and true or false

    local closestGarage = GetClosestGarage(coords)
    if closestGarage ~= '' then
        local garagePed = {
            ['coords'] = coords,
            ['created'] = false,
            ['heading'] = heading,
            ['type'] = -567724045,
            ['enable'] = enablePed,
        }

        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
        if garages[closestGarage] ~= nil then
            garages[closestGarage]['ped'] = garagePed
            local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)

            serverConfig['garages'][closestGarage]['ped'] = garagePed
			TriggerClientEvent('DoLongHudText', src, "Updated " .. closestGarage .. " interact location.", 1)
            TriggerClientEvent('cn-garages:client:syncConfig', -1, 1, serverConfig)
        else
			TriggerClientEvent('DoLongHudText', src, "Error: Could not find the garage " .. closestGarage .. " on the Database", 2)
        end
    else
		TriggerClientEvent('DoLongHudText', src, "Error: Could not find closest garage.", 2)
    end
end)

RegisterServerEvent('cn-garages:server:dev:setpayment')
AddEventHandler('cn-garages:server:dev:setpayment', function(coords, heading, args)
    local src = source
    local price = tonumber(args[1])
    local perhour = args[2]

    local closestGarage = GetClosestGarage(coords)
    if closestGarage ~= '' then
        local garagePayment = {
            ['price'] = price,
            ['onetime'] = perhour,
        }

        local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
        if garages[closestGarage] ~= nil then
            garages[closestGarage]['payment'] = garagePayment
            local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)

            serverConfig['garages'][closestGarage]['payment'] = garagePayment
			TriggerClientEvent('DoLongHudText', src, "Updated " .. closestGarage .. " payment information.", 1)
            TriggerClientEvent('cn-garages:client:syncConfig', -1, 1, serverConfig)
        else
			TriggerClientEvent('DoLongHudText', src, "Error: Could not find the garage " .. closestGarage .. " on the Database", 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, "Error: Could not find closest garage.", 2)
    end
end)

RegisterServerEvent('cn-garages:server:dev:saveCoords')
AddEventHandler('cn-garages:server:dev:saveCoords', function(name, index)
    local src = source

    local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json'))
    if garages[name] ~= nil then
        local slots = garages[name]['slots']
        local newslots = {}
        for k, v in pairs(slots) do
            newslots[#newslots+1] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[1].h,
            }, true}
        end

        for k, v in pairs(index) do
            newslots[#newslots+1] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[2],
            }, true}

            serverConfig['garages'][name]['slots'][k] = {{
                x = v[1].x,
                y = v[1].y,
                z = v[1].z,
                h = v[2],
            }, true}
        end

        garages[name]['slotsbackup'] = garages[name]['slots']
        garages[name]['slots'] = newslots
        SaveResourceFile(GetCurrentResourceName(), 'database' .. GetOSSep() .. 'garages.json', json.encode(garages), -1)
        TriggerClientEvent('cn-garages:client:syncConfig', -1, 1, serverConfig)
    end
end)

function IsModelExists(model)
    for key, value in pairs(RLCore.Shared.Vehicles) do
        if value['model'] == model then
            return true
        end
    end
    return false
end

function GetClosestGarage(coords)
    local closestName, closestDst = '', 99999.9
    for k, v in pairs(serverConfig['garages']) do
        local dst = #(vector3(v['blip']['coords'].x, v['blip']['coords'].y, v['blip']['coords'].z) - coords)
        if dst < closestDst then
            closestDst = dst
            closestName = k
        end
    end
    return closestName
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function stringsplit(Input, Seperator)
	if Seperator == nil then
		Seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(Input, '([^'..Seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

-- functions
function IsNearby(plate, vehicles)
    for _, vehicle in pairs(vehicles) do
        if plate == vehicle then
            return true
        end
    end
    return false
end

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

function randString(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end