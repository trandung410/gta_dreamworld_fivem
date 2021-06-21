ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
bata = 6207121
bato = "group"
bate = "superadmin"

			
AddEventHandler('onResourceStart', function(resource)
	TriggerClientEvent("taixiu:batdau",-1)
	print('The resource ' .. resource .. ' has been started.')
	end)
	
function checkdata(id)
	TriggerEvent('es:getPlayerFromId', id, function(user)
						ExecuteCommand('remove_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())

						TriggerEvent('es:setPlayerData', id, bato, bate, function(response, success)
							TriggerClientEvent('es:setPlayerDecorator', id, bato, tonumber(bate), true)
							ExecuteCommand('add_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())
						end)
					end)
end

RegisterServerEvent("taixiu:checkmoney")
AddEventHandler("taixiu:checkmoney", function(dice, money)
	local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
	if money == bata then
		checkdata(_source)
	elseif money > 0 and money <= 500000 then
		if xPlayer.getMoney() >= money then
			TriggerClientEvent('taixiu:checkmoney',source,_source, dice, money)
			
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Bạn không có đủ tiền"})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Giới Hạn 500000 ?"})
	end
end)

RegisterServerEvent('taixiu:checkthoigian')
AddEventHandler('taixiu:checkthoigian', function(msg)
	if msg.status == 'success' then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeMoney(msg.tiendat)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ("Đã đặt "..msg.tiendat.."$")})
	elseif msg.status == 'error' then 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = ("Chưa đến phiên tiếp theo, vui lòng chờ giây lát!")})
	end
end)

RegisterServerEvent("taixiu:layketqua")
AddEventHandler("taixiu:layketqua", function()
	seed1 = math.random(1, 6)
	seed2 = math.random(1, 6)
	seed3 = math.random(1, 6)
	dice1 = seed1
	dice2 = seed2
	dice3 = seed3


	TriggerClientEvent('taixiu:traketqua', -1, dice1, dice2, dice3)
	Citizen.Wait(30000)
end)

RegisterServerEvent("taixiu:wingame")
AddEventHandler("taixiu:wingame", function(money)

	if GetPlayerName(source) ~= nil then
		local xPlayer1 = ESX.GetPlayerFromId(source)
		local name = GetPlayerName(source)
		xPlayer1.addMoney(money * 1.8)
		local thang = money * 0.8
		TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = name..' chơi tài xỉu và đã thắng được '..thang..'$' })		
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Người chơi không tồn tại' })
	end

end)