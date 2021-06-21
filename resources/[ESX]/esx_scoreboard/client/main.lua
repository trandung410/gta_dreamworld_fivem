local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local idVisable = true
local jobLabelcheck = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',
		myid = 'unknown',
		myname= 'unknown',
		maxPlayers = GetConvarInt('sv_maxclients', 128),
		uptime = 'unknown',
		playTime = '00h 00m'
	})
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',
		myid = GetPlayerServerId(PlayerId()),
		
	})
end)



RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('esx_scoreboard:updatePing')
AddEventHandler('esx_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('esx_scoreboard:toggleID')
AddEventHandler('esx_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, police, taxi, mechanic, miner,slaughterer,tailor,lumberjack,fisherman,fueler,unemployed,cartel,biker,gang,mafia, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do	
	
		if v.name ~= nil then	
			players = players + 1

			if v.job == 'ambulance' then
				jobLabelcheck = '<a style="color:red;">Cứu thương</a>'
				
				ems = ems + 1
			elseif v.job == 'police' then
				jobLabelcheck = '<a style="color:blue;">Cảnh Sát</a>'

				police = police + 1
			elseif v.job == 'mechanic' then
				jobLabelcheck = '<a style="color:orange;">Cứu hộ</a>'

				mechanic = mechanic + 1
			-- elseif v.job == 'mafia' then
			-- 	jobLabelcheck = v.jobLabel

			-- 	mafia = mafia + 1
			-- elseif v.job == 'biker' then
			-- 	jobLabelcheck = v.jobLabel

			-- 	biker = biker + 1
			-- elseif v.job == 'cartel' then
			-- 	jobLabelcheck = v.jobLabel

			-- 	cartel = cartel + 1
			-- elseif v.job == 'gang' then
			-- 	jobLabelcheck = v.jobLabel

			-- 	gang = gang + 1
			else
				jobLabelcheck = v.jobLabel

			end

			--if num == 1 then
				table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td></tr>'):format("<a style='color:orange;'>"..v.id .. "</a>", v.name, jobLabelcheck, v.phonenumber))
			
				--[[num = 2
		 	elseif num == 2 then
				table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td><td>|</td>'):format(v.name, v.id, jobLabelcheck))
				num = 3
			elseif num == 3 then
				table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, jobLabelcheck))
				num = 1
			end ]]
		end
	end

	--[[ if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end
 ]]
	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, mechanic = mechanic, miner = miner, slaughterer = slaughterer, tailor = tailor, lumberjack = lumberjack, fueler = fueler, cartel = cartel, biker = biker, gang = gang, mafia = mafia, player_count = players}
	})
end
local menuOpen = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		if IsControlJustReleased(0, Keys['F10']) then
			if not menuOpen then 
				menuOpen = true
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'open'
				})	
			end	
		end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)


RegisterNUICallback("NUIFocusOff",function()
	if menuOpen then
		menuOpen = false
		SetNuiFocus(false, false)
		SendNUIMessage({
			action = 'close'
		})
	end
end)
Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60) -- every minute 
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)
