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
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
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

		maxPlayers = GetConvarInt('sv_maxclients', 128),
		uptime = 'unknown',
		playTime = '00h 00m'
	})
end)


--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	TriggerServerEvent('esx_scoreboard:getstars')
end)]]


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

function DrawText3D(x, y, z, text) 
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
	local ped_l = PlayerPedId()

	local scale = (4.00001/dist) * 0.3
	if scale > 0.2 then
		scale = 0.2
	elseif scale < 0.15 then
		scale = 0.15
	end

	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov

	if onScreen then
		SetTextFont(4)
		SetTextScale(scale, scale)
		SetTextProportional(true)
		SetTextColour(210, 210, 210, 180)
		SetTextCentre(true)
		SetTextDropshadow(50, 210, 210, 210, 255)
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString('<FONT FACE="VNF-ComicSans">'.. text .. '</FONT>')
		DrawText(_x,_y - 0.025)
  	end
end

local disPlayerNames = 15

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, police, mechanic, taxi, slaughterer, trucker, fisherman, mafia, gang, biker, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	local miner, lumberjack, tailor, thany = 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do
		if num == 1 then
			table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping, v.jobLabel))
			num = 2
		elseif num == 2 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping, v.jobLabel))
			num = 1
		end

		players = players + 1

		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1		
		elseif v.job == 'mafia' then
			mafia = mafia + 1
		elseif v.job == 'gang' then
			gang = gang + 1
		elseif v.job == 'biker' then
			biker = biker + 1
		end

	end
	

	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, taxi = taxi, mechanic = mechanic, slaughterer = slaughterer, trucker = trucker, fisherman = fisherman, miner = miner, lumberjack = lumberjack, tailor = tailor, thany = thany, player_count = players}
	})
	
	
	
end

local isScoreboardActive = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['DELETE']) and IsInputDisabled(0) then
			isScoreboardActive = true
			SetNuiFocus(true, true)
			SendNUIMessage({action = 'enable'})
			Citizen.Wait(1000)

		-- D-pad up on controllers works, too!
		elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)
		end
	end
end)

RegisterNUICallback('onCloseMenu', function()
	isScoreboardActive = false
	SetNuiFocus(false, false)
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

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end

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
			playTime = string.format("%02d giờ %02d phút", playHour, playMinute)
		})
	end
end)