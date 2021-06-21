ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_barbershop:pay')
AddEventHandler('esx_barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config.Price)

	TriggerClientEvent("pNotify:SendNotification", _source,Config.Price, {
		text = '<strong class="white-text">Trả <strong class="green-text">'..Config.Price..'<strong class="green-text">$',
		type = "success",
		timeout = 3000,
		layout = "centerLeft",
		queue = "global"
	})

end)

ESX.RegisterServerCallback('esx_barbershop:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)
