ESX = nil
local logs2 = "https://discord.com/api/webhooks/855253641837543434/w9BuEZERHMYqX_Blj6KWVbYgrKmopbyUPuHLkrQNw2735SwmmOmwm495Dl6-xpJ0IrUq"

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_clothes:sellVehicle')
AddEventHandler('esx_clothes:sellVehicle', function(target, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate
		})
	if result[1] ~= nil then
		MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@target'] = tPlayer.identifier
		}, function (rowsChanged)
			if rowsChanged ~= 0 then
				TriggerClientEvent('esx_contract:showAnim', _source)
				Wait(22000)
				TriggerClientEvent('esx_contract:showAnim', _target)
				Wait(22000)
				TriggerClientEvent('esx:showNotification', _source, _U('soldvehicle', plate))
				TriggerClientEvent('esx:showNotification', _target, _U('boughtvehicle', plate))
				xPlayer.removeInventoryItem('contract', 1)
				local connect = {
					{
						["color"] = "8663711",
						["title"] = "Giao dịch xe",
						["description"] = "**Người Chuyển:** "..xPlayer.name.."**\n Người Nhận: **"..tPlayer.name.."**\n Biển số: **"..plate.."**",
						["footer"] = {
							["text"] = communityname,
							["icon_url"] = communtiylogo,
						},
					}
				}
				PerformHttpRequest(logs2, function(err, text, headers) end, 'POST', json.encode({username = "car", embeds = connect}), { ['Content-Type'] = 'application/json' })

			end
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('notyourcar'))
	end
end)

ESX.RegisterUsableItem('contract', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_contract:getVehicle', _source)
end)