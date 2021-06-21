ESX = nil
local logsbank = "https://discord.com/api/webhooks/855652862545362954/FU7R-phstw8OYd7crog-jZrcY3rk9f0Dt2v6zHGbArZPO4PYTbvbx1Eysnr_kCrqfDjC"
local logswithdraw = "https://discord.com/api/webhooks/855654230773071894/Uwkko6QGg4EUuot0E0Yes6HcLjq3mIG6qPPNWJHC6Puc-1vg18BeokhW40VUy3qMAVzh"
local logsdepos = "https://discord.com/api/webhooks/855654937409093652/_INhPlKp5T-ApfIQbTcNC0JcUN60RzLpmJiXFZ_oPbmyYEY1oVXhaPPjshms2olRIcbP"
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('vb-banking:server:GetPlayerName', function(source, cb)
	local _char = ESX.GetPlayerFromId(source)
	local _charname = _char.getName()
	cb(_charname)
end)

RegisterServerEvent('vb-banking:server:depositvb')
AddEventHandler('vb-banking:server:depositvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	amount = tonumber(amount)
	Citizen.Wait(50)
	if amount == nil or amount <= 0 or amount > _char.getMoney() then
		TriggerClientEvent('chatMessage', _src, "Số lượng không hợp lệ")
	else
		_char.removeMoney(amount)
		_char.addAccountMoney('bank', tonumber(amount))
		_char.showNotification("Bạn đã gửi tiền $"..amount)
	end
	local connect = {
		{
			["color"] = "8663711",
			["title"] = "Banking",
			["description"] = "**Người Chuyển:** ".._char.name.."**\n Số tiền: **"..amount.."*$*",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = communtiylogo,
			},
		}
	}
	PerformHttpRequest(logsdepos, function(err, text, headers) end, 'POST', json.encode({username = "banking", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('vb-banking:server:withdrawvb')
AddEventHandler('vb-banking:server:withdrawvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local _base = 0
	amount = tonumber(amount)
	_base = _char.getAccount('bank').money
	Citizen.Wait(100)
	if amount == nil or amount <= 0 or amount > _base then
		TriggerClientEvent('chatMessage', _src, "Số lượng không hợp lệ")
	else
		_char.removeAccountMoney('bank', amount)
		_char.addMoney(amount)
		_char.showNotification("Bạn đã rút tiền $"..amount)
		
	end
	local connect = {
		{
			["color"] = "8663711",
			["title"] = "Banking",
			["description"] = "**Người rút:** ".._char.name.."**\n Số tiền: **"..amount.."*$*",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = communtiylogo,
			},
		}
	}
	PerformHttpRequest(logswithdraw, function(err, text, headers) end, 'POST', json.encode({username = "banking", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('vb-banking:server:balance')
AddEventHandler('vb-banking:server:balance', function(inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local balance = _char.getAccount('bank').money
	TriggerClientEvent('vb-banking:client:refreshbalance', _src, balance)
end)

RegisterServerEvent('vb-banking:server:transfervb')
AddEventHandler('vb-banking:server:transfervb', function(to, amountt, inMenu)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(exports.RufiUniqueID:GetIDfromUID(tonumber(to)))
	local balance = 0
	if zPlayer ~= nil then
		balance = xPlayer.getAccount('bank').money
		if tonumber(_source) == exports.RufiUniqueID:GetIDfromUID(tonumber(to)) then
			TriggerClientEvent('chatMessage', _source, "Bạn không thể chuyển tiền cho chính mình")	
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('chatMessage', _source, "Bạn không có đủ tiền trong tài khoản ngân hàng của mình")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				zPlayer.showNotification("Bạn đã nhận được "..amountt.."$ từ ID: "..exports.RufiUniqueID:GetUIDfromID(_source))
				xPlayer.showNotification("Bạn đã gửi "..amountt.."$ cho ID: "..to)
			end
			local connect = {
				{
					["color"] = "8663711",
					["title"] = "Banking",
					["description"] = "**Người Chuyển:** "..xPlayer.name.."**\n Người Nhận: **"..zPlayer.name.."**\n Số tiền: **"..amountt.."*$*",
					["footer"] = {
						["text"] = communityname,
						["icon_url"] = communtiylogo,
					},
				}
			}
			PerformHttpRequest(logsbank, function(err, text, headers) end, 'POST', json.encode({username = "banking", embeds = connect}), { ['Content-Type'] = 'application/json' })
		end
	else
		TriggerClientEvent('chatMessage', _source, "ID đó không hợp lệ hoặc không tồn tại")
	end
end)