ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('ears', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Ears')
end)

ESX.RegisterUsableItem('mask', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Mask')
end)

ESX.RegisterUsableItem('helmet', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Helmet')
end)
	
ESX.RegisterUsableItem('glasses', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Glasses')
end)

ESX.RegisterUsableItem('tshirt', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'TShirt')
end)

ESX.RegisterUsableItem('torso', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Torso')
end)

ESX.RegisterUsableItem('pants', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Pants')
end)
	
ESX.RegisterUsableItem('shoes', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Shoes')
end)

ESX.RegisterUsableItem('chain', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Chain')
end)

ESX.RegisterUsableItem('arms', function(source)
	local _source = source
	TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, 'Arms')
end)

-- RegisterCommand("setacc", function(source, args, rawCommand)
-- 	local _source = source
-- 	local accessory
-- 	if args[1] ~= nil then
-- 		if tonumber(args[1]) == 1 then
-- 			accessory = 'Mask'
-- 		elseif tonumber(args[1]) == 2 then
-- 			accessory = 'Glasses'
-- 		elseif tonumber(args[1]) == 3 then
-- 			accessory = 'Ears'
-- 		elseif tonumber(args[1]) == 4 then
-- 			accessory = 'Helmet'
-- 		end
-- 	-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	-- TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
-- 	-- 	-- local accessories = store.get(string.lower(accessory)) or {}
-- 	-- 	-- accessories = {}
-- 	-- 	store.set(string.lower(accessory), {})
-- 	-- 	store.save()
-- 	-- end)
-- 		TriggerClientEvent('caruby_accessories:SetUnsetAccessory', _source, accessory)
-- 	end
-- end)

RegisterServerEvent('caruby_accessories:save')
AddEventHandler('caruby_accessories:save', function(skin, accessory, label, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem(string.lower(accessory))

	TriggerEvent('esx_datastore:getDataStore',  'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local accessories = store.get(string.lower(accessory))
		store.set('has' .. accessory, true)
		if accessories == nil then
			accessories = {}
		end

		local count = store.count(string.lower(accessory))
		if count < Config.Maximum[accessory] then

			xPlayer.removeMoney(price)

			local itemSkin = {}
			local item1 = string.lower(accessory) .. '_1'
			if accessory == 'arms' or accessory == 'Arms' then
				item1 = string.lower(accessory)
			end
			local item2 = string.lower(accessory) .. '_2'
			itemSkin['label'] = label
			itemSkin[item1] = skin[item1]
			itemSkin[item2] = skin[item2]
			table.insert(accessories, itemSkin)

			store.set(string.lower(accessory), accessories)
			-- ADDED ON 11/7/2019
			if xItem.count == 0 then
				xPlayer.addInventoryItem(xItem.name, 1)
			end
			store.save()
			
			TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(price)))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('limit', accessory, Config.Maximum[accessory]))
		end
	end)
end)

ESX.RegisterServerCallback('caruby_accessories:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get(string.lower(accessory)) and store.get(string.lower(accessory)) or {})

		cb(hasAccessory, skin)
	end)

end)

ESX.RegisterServerCallback('caruby_accessories:checkMoney', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.get('money') >= price)
end)


RegisterServerEvent('caruby_accessories:remove')
AddEventHandler('caruby_accessories:remove', function(accessory, index)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem(string.lower(accessory))


	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local skin = store.get(string.lower(accessory)) or {}
		local skinName = skin[index].label
		table.remove(skin, index)
		store.set(string.lower(accessory), skin)

		xPlayer.removeMoney(Config.RemovePrice)

		local count = store.count(string.lower(accessory))
		if count <= 0 then
			if xItem.count > 0 then
				xPlayer.removeInventoryItem(xItem.name, 1)
				store.set('has' .. accessory, false)
			end
		end
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(price)))

		TriggerClientEvent('esx:showNotification', _source, _U('you_remove', accessory, skinName))
	end)
end)