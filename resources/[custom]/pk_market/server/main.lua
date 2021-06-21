local key = nil
key = Config.Key
local URL = "http://127.0.0.1//fivem-shop"
local rsname = GetCurrentResourceName()
local active_script = nil
if key == "" or key == " " or key == nil then
    key = ""
else
    key = key
end
Citizen.CreateThread(function()
        PerformHttpRequest(URL.."/scriptserver.php?script="..rsname.."&license="..key, function(error,status,header)
			if status then 
				if tonumber(status) == tonumber(1) then
					active_script = true
					print(("^0Verify Success^7"):format())
				elseif tonumber(status) == tonumber(2) then
					print('You cant use this scripts.Contact Hien#2010')
					active_script = false
				elseif tonumber(status) == tonumber(3) then
					print('You cant use this scripts.Contact Hien#2010')
					active_script = false
				elseif tonumber(status) == tonumber(4) then
					print('You cant use this scripts.Contact Hien#2010')
					active_script = false
				end
			else
				print('You cant use this scripts.Contact Hien#2010')
				while true do
					print('You cant use this scripts.Contact Hien#2010')
				end
				StopResource(rsname)
				active_script = false
			end
		end,
			"POST",
			json.encode(status),
			{["Content-Type"] = "application/json"})
    end
)

RegisterServerEvent("pk_market:server:OnRequestVerify")
AddEventHandler("pk_market:server:OnRequestVerify",function() 
	TriggerClientEvent("pk_market:client:Verify", source, active_script)
end)

ESX             = nil
local ShopItems = {}
local hasSqlRun = false



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Load items
AddEventHandler('onMySQLReady', function()
	hasSqlRun = true
	LoadShop()
end)

-- extremely useful when restarting script mid-game
Citizen.CreateThread(function()
	Citizen.Wait(2000) -- hopefully enough for connection to the SQL server

	if not hasSqlRun then
		LoadShop()
		hasSqlRun = true
	end
end)

function LoadShop()
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local shopResult = MySQL.Sync.fetchAll('SELECT * FROM shops')

	local itemInformation = {}
	for i=1, #itemResult, 1 do

		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end

		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].limit = itemResult[i].limit
	end

	for i=1, #shopResult, 1 do
		if ShopItems[shopResult[i].store] == nil then
			ShopItems[shopResult[i].store] = {}
		end

		if itemInformation[shopResult[i].item].limit == -1 then
			itemInformation[shopResult[i].item].limit = 30
		end

		table.insert(ShopItems[shopResult[i].store], {
			label = itemInformation[shopResult[i].item].label,
			item  = shopResult[i].item,
			price = shopResult[i].price,
			limit = itemInformation[shopResult[i].item].limit
		})
	end
end

ESX.RegisterServerCallback('esx_shops:requestDBItems', function(source, cb)
	if not hasSqlRun then
		TriggerClientEvent('esx:showNotification', source, 'The shop database has not been loaded yet, try again in a few moments.')
	end

	cb(ShopItems)
end)

RegisterServerEvent('esx_shops:buyItem')
AddEventHandler('esx_shops:buyItem', function(itemName, amount, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	-- amount = ESX.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	price = price * amount

	-- can the player afford this item?
	if xPlayer.getMoney() >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
		else
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(itemName, amount)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', amount, itemLabel, price))
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough', missingMoney))
	end
end)