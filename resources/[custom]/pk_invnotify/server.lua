ESX = nil
local playerUseItem = {}
local playerDropItem = {}
local playerDirtyMoney = {}

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

RegisterServerEvent('esx:onRemoveInventoryItem')
AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	print('onRemoveInventoryItem')
	local _source = source
	SetTimeout(100, function()
		if not playerUseItem[_source] and not playerDropItem[_source] then
			TriggerClientEvent('_esx:removeInventoryItem', _source, item, count)
		end
	end)
end)

RegisterServerEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	print('removeInventoryItem')
	local _source = source
	local _itemName = itemName
	local xPlayer    = ESX.GetPlayerFromId(_source)
	local item 
	if type == 'item_account' then
		item = {name = _itemName, label = itemCount}
	elseif type == 'item_money' then
		item = {name = _itemName, label = itemCount}
	elseif type == 'item_standard' then
		item = xPlayer.getInventoryItem(_itemName)
	elseif type == 'item_weapon' then
		item = {name = _itemName, label = ESX.GetWeaponLabel(_itemName)}
		TriggerClientEvent('_esx:dropWeapon', _source, _itemName)
	end
	
	playerDropItem[_source] = {}
	playerDropItem[_source][_itemName] = true

	TriggerClientEvent('_esx:dropItem', _source, item)
	SetTimeout(500, function()
			playerDropItem[_source] = nil	
	end)
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	print('useItem')
	local _source = source
	local _itemName = itemName
	local xPlayer    = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem(_itemName)

	playerUseItem[_source] = {} 
	playerUseItem[_source][_itemName] = true

	TriggerClientEvent('_esx:useItem', _source, item)
	SetTimeout(500, function()
			playerUseItem[_source] = nil
	end)
	
end)
