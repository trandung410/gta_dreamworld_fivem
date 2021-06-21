-- DEV by Lorraxsssss---

ESX = nil
local isOpen = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

			
AddEventHandler('onResourceStart', function(resource)
	TriggerClientEvent("chanle:batdau",-1)
	print('The resource ' .. resource .. ' has been started.')
end)


RegisterServerEvent("chanle:checkmoney")
AddEventHandler("chanle:checkmoney", function(dice, tien)
	local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
	local money = math.floor(tien)
	
	if money > 0 and money < 10001 then
		if xPlayer.getMoney() >= money then
			TriggerClientEvent('chanle:checkmoney',source,_source, dice, money)
			
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Bạn không có đủ tiền"})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Số tiền nhập vào phải lớn hơn 0 và nhỏ hơn 10000 ?"})
	end
end)

RegisterServerEvent('chanle:checkthoigian')
AddEventHandler('chanle:checkthoigian', function(msg)
	if msg.status == 'success' then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeMoney(msg.tiendat)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ("Đã đặt "..msg.tiendat.." $ cho "..msg.caudat)})
	elseif msg.status == 'error' then 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = ("Chưa đến phiên tiếp theo, vui lòng chờ giây lát!")})
	end
end)

-- RegisterServerEvent("chanle:layketqua")
-- AddEventHandler("chanle:layketqua", function()
	-- seed1 = math.random(1, 6)
	-- seed2 = math.random(1, 6)
	-- seed3 = math.random(1, 6)
	-- dice1 = seed1
	-- dice2 = seed2
	-- dice3 = seed3


	-- TriggerClientEvent('chanle:traketqua', -1, dice1, dice2, dice3)
	-- Citizen.Wait(30000)
-- end)

RegisterServerEvent("chanle:wingame1")
AddEventHandler("chanle:wingame1", function(money)

	if GetPlayerName(source) ~= nil then
		local xPlayer1 = ESX.GetPlayerFromId(source)
		local name = GetPlayerName(source)
		xPlayer1.addMoney(math.floor(money * 1.8))
		local thang = money * 0.8
		TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = name..' chơi xóc đĩa và đã thắng được '..thang..'$' })		
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Người chơi không tồn tại' })
	end

end)
RegisterServerEvent("chanle:wingame2")
AddEventHandler("chanle:wingame2", function(money)

	if GetPlayerName(source) ~= nil then
		local xPlayer1 = ESX.GetPlayerFromId(source)
		local name = GetPlayerName(source)
		xPlayer1.addMoney(math.floor(money * 6))
		local thang = money * 5
		TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = name..' chơi xóc đĩa và đã thắng được '..thang..'$' })		
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Người chơi không tồn tại' })
	end

end)
RegisterServerEvent("chanle:wingame3")
AddEventHandler("chanle:wingame3", function(money)

	if GetPlayerName(source) ~= nil then
		local xPlayer1 = ESX.GetPlayerFromId(source)
		local name = GetPlayerName(source)
		xPlayer1.addMoney(math.floor(money * 3.5))
		local thang = money * 2.5
		TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = name..' chơi xóc đĩa và đã thắng được '..thang..'$' })		
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Người chơi không tồn tại' })
	end

end)

TriggerEvent('es:addGroupCommand', 'batchanle', 'superadmin', function(source, args, user)
	isOpen = true
	TriggerEvent('lorraxsnotify:thongbao', "Thông báo MỞ chẵn lẻ")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Không đủ quyền hạn.' } })
end, { help = 'Bật Chiếm Đóng'})
	
TriggerEvent('es:addGroupCommand', 'tatchanle', 'superadmin', function(source, args, user)
	isOpen = false
	TriggerEvent('lorraxsnotify:thongbao', "Thông báo ĐÓNG chẵn lẻ")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Không đủ quyền hạn.' } })
end, { help = 'Tắt Chiếm Đóng'})

ESX.RegisterServerCallback('chanle:isopen', function (source, cb)
	if isOpen then
		cb(true)
	else
		cb(false)
	end
end)