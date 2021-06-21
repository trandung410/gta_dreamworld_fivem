ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Pk:bank:deposit')
AddEventHandler('Pk:bank:deposit', function(amount)
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('Pk:bank:notify', _source, "error", "Số tiền không hợp lệ")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('Pk:bank:notify', _source, "success", "<FONT FACE='Montserrat'>Bạn gửi tiền thành công $" .. amount)
	end
end)

RegisterServerEvent('Pk:bank:withdraw')
AddEventHandler('Pk:bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local min = 0
	amount = tonumber(amount)
	min = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > min then
		TriggerClientEvent('Pk:bank:notify', _source, "error", "<FONT FACE='Montserrat'>Số tiền không hợp lệ")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('Pk:bank:notify', _source, "success", "<FONT FACE='Montserrat'>Bạn rút tiền thành công $" .. amount)
	end
end)

RegisterServerEvent('Pk:bank:balance')
AddEventHandler('Pk:bank:balance', function()
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('Pk:bank:info', _source, balance)
end)

RegisterServerEvent('Pk:bank:transfer')
AddEventHandler('Pk:bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(exports.RufiUniqueID:GetIDfromUID(tonumber(to)))
	local amount = amountt
	local balance = 0

	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('Pk:bank:notify', _source, "error", "<FONT FACE='Montserrat'>Không tìm thấy người nhận")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money
		
		if tonumber(_source) == exports.RufiUniqueID:GetIDfromUID(tonumber(to)) then
			TriggerClientEvent('Pk:bank:notify', _source, "error", "<FONT FACE='Montserrat'>Bạn không thể chuyển tiền cho chính mình")
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('Pk:bank:notify', _source, "error", "<FONT FACE='Montserrat'>Bạn không có đủ tiền để chuyển khoản này")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
				TriggerClientEvent('Pk:bank:notify', _source, "success", "<FONT FACE='Montserrat'>Bạn chuyển khoản thành công $" .. amount)
				TriggerClientEvent('Pk:bank:notify', exports.RufiUniqueID:GetIDfromUID(tonumber(to)), "success", "<FONT FACE='Montserrat'>Bạn vừa nhận được $" .. amount .. ' qua chuyển khoản')
			end
		end
	end
end)