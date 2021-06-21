ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('PKDEV:removermoney')
AddEventHandler('PKDEV:removermoney', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local price = Config.RemoveMoneyBed
		xPlayer.removeMoney(price)
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
			account.addMoney(price)
		end)
end)
