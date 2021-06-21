ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = "<span style='font-size:14;font-weight: 900'>Food</span><br>Ăn một miếng bánh mì",
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

ESX.RegisterUsableItem('hamburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_hamburger'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = "<span style='font-size:14;font-weight: 900'>Food</span><br>Ăn 1 bánh hamburger",
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_water'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = "<span style='font-size:14;font-weight: 900'>Food</span><br>Uống nước",
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

--[[ Bar stuff
ESX.RegisterUsableItem('wine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('wine', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_wine'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have eaten 1x Wine ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_beer'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have eaten 1x Beer ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_vodka'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have eaten 1x Vodka ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have eaten 1x Whisky ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_tequila'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have eaten 1x Tequila ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
	
end)

ESX.RegisterUsableItem('boxmilk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('boxmilk', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', -150000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_milk'))
	TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have eaten 1x Milk ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
end)
]]--

--[[ marijuana cigarett
ESX.RegisterUsableItem('marijuana_cigarette', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('marijuana_cigarette', 1)
			TriggerClientEvent('esx_status:add', source, 'drunk', 500000)
			TriggerClientEvent('esx_cigarett:startmarijuana', source)
			TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have used 1x Marijuana Ciggarette ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
		else
			TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have not a lighter',
		    type = "error",
		    timeout = 5000,
		    layout = "topRight"
		})
		end
end)

-- marijuana weed_pooch
ESX.RegisterUsableItem('weed_pooch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	local bong = xPlayer.getInventoryItem('bong')
	
		if lighter.count > 0 and bong.count > 0then
			xPlayer.removeInventoryItem('weed_pooch', 1)
			TriggerClientEvent('esx_status:add', source, 'drunk', 800000)
			TriggerClientEvent('esx_weedpooch:Onbong', source)
			TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have used 1x Weed Pooch ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
		else
			TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have not a lighter ',
		    type = "error",
		    timeout = 5000,
		    layout = "topRight"
		})
		end
end)

-- Cigarett
ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
			TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have used 1x lighter ',
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
		else
			TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'You have a lighter',
		    type = "success",
		    timeout = 5000,
		    layout = "topRight"
		})
		end
end)
]]--

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = exports.RufiUniqueID:GetIDfromUID(tonumber(args[1]))
		
		-- is the argument a number?
		if target ~= nil then
			
			-- is the number a valid player?
			if GetPlayerName(target) then
				print('BasicNeeds: ' .. GetPlayerName(target) .. ' is healed')
				TriggerClientEvent('esx_basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "System heal", {223, 66, 244}, "Bạn đã được bổ sung máu")
			else
				TriggerClientEvent('chatMessage', source, "System heal", {255, 0, 0}, "ID này không tồn tại")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		--print('Systemheal: ' .. GetPlayerName(source) .. ' is healed')
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = "<span style='font-size:14;font-weight: 900'>Health</span><br>Bạn đã được chữa khỏi",
		    type = "info",
		    timeout = 5000,
		    layout = "topRight"
		})
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
		
	end
end, function(source, args, user)
	--TriggerClientEvent('chatMessage', source, "System heal", {255, 0, 0}, "มึงจะทำเหี้ยไรไอสัด")
end, {help = "Heal a player, or yourself - restores thirst, hunger and health."})