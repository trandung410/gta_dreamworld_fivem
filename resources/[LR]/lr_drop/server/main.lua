ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local isLooting = false

AddEventHandler('onResourceStart', function(name)
	if name ~= 'lr_drop' then
		CancelEvent()
	else
		--toaDo = getRandom()
		--SetTimeout(Config.ThoiGianDrop, GuiToaDo(toaDo))
		SetTimeout(10000,GuiToaDo)

	end
end)

AddEventHandler('es:playerLoaded', function(source, user) 
	if daLoot == false then
		TriggerClientEvent('lr_drop:toaDo', source, posX, posY)
	end
end)

RegisterServerEvent('lr_drop:daLoot')
AddEventHandler('lr_drop:daLoot', function()
	isLooting = false
	daLoot = true
	local ranDom = getRandomPhanthuong()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers
	if ranDom.type == 'error' then
		TriggerClientEvent('esx:showNotification', source, ranDom.msg)
	elseif ranDom.type == 'weapon' then
		--TriggerClientEvent('lr_drop:addWeapon', source, ranDom.phanthuong)
		xPlayer.addWeapon(ranDom.phanthuong)
		print(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerEvent('Lorraxs:drop', GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu"})
	elseif ranDom.type == 'item' then
		xPlayer.addInventoryItem(ranDom.phanthuong, 1)
		print(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerEvent('Lorraxs:drop', GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu"})
	elseif ranDom.type == 'money' then
		xPlayer.addMoney(ranDom.phanthuong)
		print(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu"})
	end
	TriggerClientEvent('lr_drop:deleteDrop', -1)
	SetTimeout(5400000, GuiToaDo)
	ESX.ClearTimeout(deleteTimeout)
	print('lr_drop: Looted by '..GetPlayerName(source))
end)

RegisterServerEvent('lr_drop:syncDrop')
AddEventHandler('lr_drop:syncDrop', function()
	if daLoot == false then
		TriggerClientEvent('lr_drop:toaDo', source, posX, posY)
	end
end)

ESX.RegisterServerCallback('lr_drop:isLooting', function(source, cb)
	if isLooting == false then
		cb(false)
		isLooting = true
		lootingTimeout = ESX.SetTimeout(120000, clearLooting)
		print('false')
	else
		cb(true)
		print('true')
	end
end)

RegisterServerEvent('lr_drop:stopLoot')
AddEventHandler('lr_drop:stopLoot', function()
	if isLooting == true then
		isLooting = false
		ESX.ClearTimeout(lootingTimeout)
		print('false')
	end
end)
		
function clearLooting()
	if isLooting == true then
		isLooting = false
	end
end		
		
	