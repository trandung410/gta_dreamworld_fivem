ESX = nil
pk = GetCurrentResourceName()
cops = 0
Pricea = 0
Priceb = 0
UseCopsToSell = nil



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('seller', function(source)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	TriggerClientEvent(pk..'select',source)	

end)

for _,v in pairs (Config.ItemSell) do

	ESX.RegisterUsableItem(v.name, function(source)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local Label = ESX.GetItemLabel(v.name)
		
		if v.Usecops then
				if cops >= Config.CopsRequiredToSell then
					Pricea = v.PriceA
					Priceb = v.PriceB
					UseCopsToSell = v.Usecops
					
					--print (Pricea,Priceb,UseCopsToSell)
					TriggerClientEvent(pk..'Selltrue',source,v.name,Label)	
					
				else
					TriggerClientEvent("pNotify:SendNotification",source,
					{text = "Cần có <font color = 'yellow'>"..Config.CopsRequiredToSell.." cảnh sát trong thành phố</font> ",
					type = "info", timeout = 5000, 
					layout = "topRight"})

				end
		
			else
					Pricea = v.PriceA
					Priceb = v.PriceB
					UseCopsToSell = v.Usecops
					print (Pricea,Priceb,UseCopsToSell)
					TriggerClientEvent("pNotify:SendNotification",source,
					{text = "<span style='font-size:14;font-weight: 900'>SellDrug</span><br>Bạn đã bắt đầu bán hàng <font color = 'yellow'>"..ESX.GetItemLabel(v.name).."</font> ",
					type = "info", timeout = 5000, 
					layout = "topRight"})
					TriggerClientEvent(pk..'Selltrue',source,v.name)	
				
					

		end
	
	
	end)

end


local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local selling = false
local success = false
local copscalled = false
local notintrested = false



AddEventHandler('esx:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' then
		cops = cops +1
		print ('Police Connect Now Cop Online '..cops)
	end

end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    cops = 0
    Wait(1000)
    CheckPolice()
    print ('SET JOB')
end)

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer.job.name == "police" then
	   cops = cops -1 
	   print ('Police Disconnect Now Cop Online '..cops) 
    end
end)


RegisterNetEvent(pk..'Set')
AddEventHandler(pk..'Set', function(Id)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent(pk..'Welcome',-1,Id)
	print('Reject Server ID: '..Id)

end)

RegisterNetEvent(pk..'checkItem')
AddEventHandler(pk..'checkItem', function(Items)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then

		local found = false
		for k,v in pairs(Items) do
			local xItem = xPlayer.getInventoryItem(v.ItemName).count
            if xItem >= 1 then
				found = true
            end
		end
		
		if found then
			TriggerClientEvent(pk.."UpdateHas", source, true)
		else
			TriggerClientEvent(pk.."UpdateHas", source, false)
		end
	end
end)

RegisterNetEvent(pk..'CheckCop')
AddEventHandler(pk..'CheckCop', function(text)
	local xPlayer = ESX.GetPlayerFromId(source)
	if cops >= Config.CopsRequiredToSell then
	
		TriggerClientEvent("pNotify:SendNotification",source,
		{text = "<span style='font-size:14;font-weight: 900'>SellDrug</span><br>Bạn đã bắt đầu bán hàng <font color = 'yellow'>"..text.."</font> ",
		type = "info", timeout = 5000, 
		layout = "topRight"})
	
	else
		TriggerClientEvent("pNotify:SendNotification",source,
		{text = "<span style='font-size:14;font-weight: 900'>SellDrug</span><br>Cần có <font color = 'yellow'>"..Config.CopsRequiredToSell.."</font> cảnh sát trong thành phố",
		type = "error", timeout = 5000, 
		layout = "topRight"})
		TriggerClientEvent(pk..'NoCops',source)
	end
end)



function CheckPolice() --- เช็คตำรวจ
	
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
            CheckPolice()
            Citizen.Wait(1000)
            print("Now Cops Online "..cops)
		end)
	end
end)
  
RegisterNetEvent(pk..'startrandom')
AddEventHandler(pk..'startrandom', function(Item)

	selling = true
	if selling == true then
		TriggerEvent(pk..'pass_or_fail')
		TriggerClientEvent("pNotify:SendNotification",source,
		{text = "<span style='font-size:14;font-weight: 900'>SellDrug</span><br>Hiện đang cung cấp <font color = 'yellow'>"..ESX.GetItemLabel(Item).."</font>",
		type = "info", timeout = 5000, 
		layout = "topRight"})	
		
 	end
	
end)


RegisterNetEvent(pk..'sell')
AddEventHandler(pk..'sell', function(Item,ped)

	

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Item).count
	local payment_price = math.random(Pricea,Priceb)
	local bonus = payment_price + (cops * (payment_price/100 * Config.Percent))

	local canSell = false
		if UseCopsToSell then
				if xItem < 1 then
					TriggerClientEvent('esx:showNotification', source, 'You not have '..Item)
					TriggerClientEvent(pk..'NoItem',source)	
				elseif not notintrested and not success then
				
					TriggerClientEvent(pk.."setNpcCallPolice", source, ped)
					
				else
						
						xPlayer.addAccountMoney('black_money',math.ceil(bonus))
						xPlayer.removeInventoryItem(Item, 1)
						TriggerClientEvent('esx:showNotification', source, "You got ~r~Dirty Money ~g~x" .. math.ceil(bonus) )
						TriggerClientEvent(pk..'HaveItem',source)
				end

		else
			if xItem < 1 then
					TriggerClientEvent('esx:showNotification', source, 'You not have '..Item)
					TriggerClientEvent(pk..'NoItem',source)
				elseif not notintrested and not success then
					TriggerClientEvent("pNotify:SendNotification",source,
					{text = "<span style='font-size:14;font-weight: 900'>SellDrug</span><br>Khách hàng không quan tâm <font color = 'yellow'>"..ESX.GetItemLabel(Item).." của bạn.</font>",
					type = "error", timeout = 5000, 
					layout = "topRight"})
					TriggerClientEvent(pk..'FoodReject',source)
				else

					xPlayer.addMoney(payment_price)
					xPlayer.removeInventoryItem(Item, 1)
					TriggerClientEvent('esx:showNotification', source, "You got ~g~ Money ~g~x" .. payment_price)
					TriggerClientEvent(pk..'HaveItem',source)
			end	
		end
	
end)





RegisterNetEvent(pk..'callPolice')
AddEventHandler(pk..'callPolice', function(face, hair, sex)
	TriggerClientEvent(pk.."notifyPolice", -1, face, source, hair, sex)
	TriggerClientEvent(pk.."notifyPoliceMsg", source, hair, sex)
	
end)

RegisterNetEvent(pk..'pass_or_fail')
AddEventHandler(pk..'pass_or_fail', function(ped)

	local random = math.random(1, Config.PedRejectPercent)
	print (random)
	if random == Config.PedRejectPercent then
		
		notintrested = false
		success = false
		copscalled = true
	
		
		print('Reject')


	else

		success = true
		notintrested = true		
		print('True')

end

end)

RegisterNetEvent(pk..'sell_dis')
AddEventHandler(pk..'sell_dis', function()
 	TriggerClientEvent('esx:showNotification', source, "You are far.")
end)

