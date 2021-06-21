local PlayerData = {}
local society_money
local society2_money
ESX = nil
local isLoadscreenStop = false

AddEventHandler("esx:loadingScreenOff", function()
	Wait(5000)
	isLoadscreenStop = true
	local accounts = PlayerData.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				bank = 	account.money
			})
		elseif account.name == "black_money" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				black_money = 	account.money
			})
		elseif account.name == "vcoin" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				vcoin = 	account.money
			})
		elseif account.name == "money" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				cash = 	account.money
			})
		end
	end
	
	-- Job
	local job = PlayerData.job
	SendNUIMessage({
		show 		= 	IsPauseMenuActive(),	
		loaded = isLoadscreenStop,	
		--cash		=	data.money,
		job 		= 	job.label,
		job2 		=	job.grade_label,
		society		=	society_money,
	})
	if PlayerData.job.grade_name == "boss" then 
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(a)
			society_money = a
		end, job.name)	
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Wait(2000)
	if ESX.IsPlayerLoaded() then 
		TriggerEvent('esx_status:setDisplay', 0.0)
		-- PlayerData = ESX.GetPlayerData()
		local data = ESX.GetPlayerData()
		local accounts = data.accounts
		for k,v in pairs(accounts) do
			local account = v
			if account.name == "bank" then
				SendNUIMessage({
					show 		= 	IsPauseMenuActive(),	
					loaded = isLoadscreenStop,	
					bank = 	account.money
				})
			elseif account.name == "black_money" then
				SendNUIMessage({
					show 		= 	IsPauseMenuActive(),	
					loaded = isLoadscreenStop,	
					black_money = 	account.money
				})
			elseif account.name == "vcoin" then
				SendNUIMessage({
					show 		= 	IsPauseMenuActive(),	
					loaded = isLoadscreenStop,	
					vcoin = 	account.money
				})
			elseif account.name == "money" then
				SendNUIMessage({
					show 		= 	IsPauseMenuActive(),	
					loaded = isLoadscreenStop,	
					cash = 	account.money
				})
			end
		end
	
		-- Job
		local job = data.job
		SendNUIMessage({
			show 		= 	IsPauseMenuActive(),	
			loaded = isLoadscreenStop,	
			--cash		=	data.money,
			job 		= 	job.label,
			job2 		=	job.grade_label,
			society		=	society_money,
		})
		if data.job.grade_name == "boss" then 
			ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(a)
				society_money = a
			end, job.name)	
		end
	end
end)

-- Citizen.CreateThread(function() 
-- 	while true do
-- 		Citizen.Wait(1000)
-- 		local hour = GetClockHours()
-- 		local minutes = GetClockMinutes()
        
-- 		local hunger, thirst
-- 		TriggerEvent('esx_status:getStatus', 'hunger',function(status)
-- 			hunger = round(status.val/status.default*100)
-- 		end)
-- 		TriggerEvent('esx_status:getStatus', 'thirst',function(status)
-- 			thirst = round(status.val/status.default*100)
-- 		end)
-- 		SendNUIMessage({
-- 			show = 		IsPauseMenuActive(),	
-- 			loaded = isLoadscreenStop,	
-- 			hora = 		hour.. ":" ..minutes,	
-- 			hunger = 	hunger,	
-- 			thirst = 	thirst,
-- 			society		=	society_money,
-- 		})	
-- 	end
-- end)

-- function round(number)
--   if (number - (number % 0.1)) - (number - (number % 1)) < 0.5 then
--     number = number - (number % 1)
--   else
--     number = (number - (number % 1)) + 1
--   end
--  return number
-- end


-- AddEventHandler("esx_ladderhud:updateBasics", function(basics)
--     SendNUIMessage({
--     	show = 	IsPauseMenuActive(),	
--     	hunger = 	round(basics[1].percent),	
--     	thirst = 	round(basics[2].percent)
--     })	
-- end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(name, money)
	print(name, money)
	if "society_"..PlayerData.job.name == name and PlayerData.job.grade_name == "boss" then 
		society_money = money
	end
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	SendNUIMessage({
		show = 	IsPauseMenuActive(),	
		job = 	job.label,	
		job2 = 	job.grade_label
	})	
	if job.grade_name ~= "boss" then 
		society_money = nil
	else
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(a)
			society_money = a
		end, job.name)
	end
end)


RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({
			show = 	IsPauseMenuActive(),	
			bank = 	account.money
		})	
	elseif account.name == "black_money" then
		SendNUIMessage({
			show 		= 	IsPauseMenuActive(),	
			loaded = isLoadscreenStop,	
			black_money = 	account.money
		})	
	elseif account.name == "vcoin" then
		SendNUIMessage({
			show 		= 	IsPauseMenuActive(),	
			loaded = isLoadscreenStop,	
			vcoin = 	account.money
		})
	elseif account.name == "money" then
		SendNUIMessage({
			show 		= 	IsPauseMenuActive(),	
			loaded = isLoadscreenStop,	
			cash = 	account.money
		})
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	TriggerEvent('esx_status:setDisplay', 0.0)
	PlayerData = xPlayer
	local data = xPlayer
	local accounts = data.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				bank = 	account.money
			})
		elseif account.name == "black_money" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				black_money = 	account.money
			})
		elseif account.name == "vcoin" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				vcoin = 	account.money
			})
		elseif account.name == "money" then
			SendNUIMessage({
				show 		= 	IsPauseMenuActive(),	
				loaded = isLoadscreenStop,	
				cash = 	account.money
			})
		end
	end
	
	-- Job
	local job = data.job
	local gang = data.gang
	SendNUIMessage({
		show 		= 	IsPauseMenuActive(),	
		loaded = isLoadscreenStop,	
		--cash		=	data.money,
		job 		= 	job.label,
		job2 		=	job.grade_label,
		society		=	society_money,
	})
end)


RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({
		show 		= 	IsPauseMenuActive(),	
		loaded = isLoadscreenStop,	
		cash		=	e
	})
end)

RegisterCommand("tatui", function(source, args, rawCommand)
  
  TriggerEvent('ui:tatui', true)
end)

RegisterCommand("hienui", function(source, args, rawCommand)
  
  TriggerEvent('ui:tatui', false)
  isLoadscreenStop = true
end)

AddEventHandler('ui:tatui', function(toggle)
	if toggle == false then 
		
		SendNUIMessage({
			type = 'show_ui',
		})
		DisplayRadar(true)
	else
		SendNUIMessage({
			type = 'hide_ui',
		})
		DisplayRadar(false)
	end
end)