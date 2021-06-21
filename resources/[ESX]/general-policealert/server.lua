ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local queue = {}

local function CopAlert(text, pos)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				TriggerClientEvent("pNotify:SendNotification", xPlayers[i], {
				text = text,
				layout = Config["alert_position"],
				queue = "police_alert", 
				type = alert,
				themes = "gta",
				timeout = Config["duration"] * 800,
			})
			TriggerClientEvent("general-policealert:alertArea", xPlayers[i], pos)
		
		end
	end
end

local function InsertQueue(pos)
	local num
	for i=1, 9 do
		local v = queue[i]
		if v == nil then
			num = i
			queue[i] = {
				time = GetGameTimer() + (Config["duration"] * 800),
				pos = pos
			}
			break
		end
	end
	return num
end

local function accept(name)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local textaccept = 'หมอ' , name ,'รับเคสแล้ว'
 		if xPlayer.job.name == 'ambulance' then
				TriggerClientEvent("pNotify:SendNotification", xPlayers[i], {
				text = textaccept,
				layout = Config["alert_position"],
				queue = "police_alert", 
				type = "alert",
				theme = "gta",
				timeout = Config["duration"] * 800,
			})
		
		end
	end
end

RegisterServerEvent("general-policealert:accept")
AddEventHandler("general-policealert:accept", function(name)
	local xPlayers = ESX.GetPlayers()
	local name2 = GetPlayerName(source)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local textaccept = '<span style=\"font-size:18px;color:white;\">นายตำรวจ </span><span style=\"font-size:18px;color:orange;\">' ..name2.. ' </span><span style=\"font-size:18px;color:white;\">รับเคสแล้ว</span>'
 		if xPlayer.job.name == 'police' then
				TriggerClientEvent("pNotify:SendNotification", xPlayers[i], {
				text = textaccept,
				layout = Config["alert_position"],
				queue = "police_alert", 
				type = "alert",
				theme = "gta",
				timeout = Config["duration"] * 800,
			})
			
		
		end
	end
end)

RegisterServerEvent("general-policealert:getLocation")
AddEventHandler("general-policealert:getLocation", function(num)
	local data = queue[num]
	if data then
		TriggerClientEvent("general-policealert:sendLocation", source, data.pos)
	end
end)

local player_report = {}
RegisterServerEvent("general-policealert:defaultAlert")
AddEventHandler("general-policealert:defaultAlert", function(type, gender, location, pos)
	if player_report[source] and player_report[source] > GetGameTimer() then	
		return
	end
	--print(type, gender, location, pos)
	local num = InsertQueue(pos)
	if not num then return end
	
	local action
	if type == "carjacking" then
		action = Config["translate"]["action_carjacking"]
		alert = "info"
	elseif type == "melee" then
		action = Config["translate"]["action_melee"]
		alert = "info"
	elseif type == "gunshot" then
		action = Config["translate"]["action_gunshot"]
		alert = "info"
	elseif type == "drug" then
		action = Config["translate"]["action_drug"]
		alert = "info"
	elseif type == "cement" then
		action = Config["translate"]["action_cement"]
		alert = "info"
	elseif type == "thief" then
		action = Config["translate"]["action_thief"]
		alert = "info"
	elseif type == "fishing" then
		action = Config["translate"]["action_fishing"]
		alert = "info"
	elseif type == "burglary" then
		action = Config["translate"]["action_burglary"]
		alert = "info"
	else
		return
	end
	
	player_report[source] = GetGameTimer() + (Config["duration"] * 800)
	
	local text = '<span style="font-size:14;font-weight: 900">'..action..'</span><br><i class="fas fa-location-arrow"></i> '..location..'<br> Press  <b style="text-align:right;font-size:0.8em;border-radius: 2px; font-family: Lato,Athiti;color:black; background:white; padding:1%;">'..Config["base_key_text"]..'</b> + <b style="font-size:0.8em;border-radius: 2px;  font-family: Lato,Athiti;color:black; background:white; padding:1% 2%">'..num..'</b><br>'
	--local text = '<span style="font-size:14;font-weight: 900">'..action..'</span><br>'..location..'<br>Press  <b style="font-size:0.7em;border-radius: 2px;font-family: Raleway;color:black; background:white; padding:1%;">'..Config["base_key_text"]..'</b> + <b style="font-size:0.7em;border-radius: 2px;font-family: Raleway;color:black; background:white; padding:1% 2%">'..num..'</b><br>'
	
	CopAlert(text, pos)
end)

Citizen.CreateThread(function()
	while true do
		for i=1, 9 do
			local v = queue[i]
			if v and v.time < GetGameTimer() then
				queue[i] = nil
			end
		end
		Citizen.Wait(500)
	end
end)