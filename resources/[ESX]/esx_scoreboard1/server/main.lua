ESX = nil
local connectedPlayers = {}
local starsArr = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name
	
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	TriggerClientEvent('IDsAboveHead:updateJob', -1, connectedPlayers)
	TriggerClientEvent('DiscordBot:updateJob', -1, connectedPlayers)
	AddPlayersToScoreboard()
end)


--[[RegisterNetEvent('esx_joblisting:setJob')
AddEventHandler('esx_joblisting:setJob', function (playerId, job)
	connectedPlayers[playerId].job = job.name

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)]]

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	AddPlayerToScoreboard(xPlayer, true)
end)

--[[RegisterServerEvent('esx_scoreboard:getstars')
AddEventHandler('esx_scoreboard:getstars', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local stars = 0
	local retData = MySQL.Sync.fetchAll('SELECT stars FROM users WHERE identifier=@identifier',{['@identifier'] = xPlayer.identifier})
	while not retData do Citizen.Wait(0); end
	
	if retData[1].stars ~= nil then
		stars = retData[1].stars
		
		TriggerClientEvent('IDsAboveHead:loadStars', -1, _source, stars)
		TriggerClientEvent('DiscordBot:updateKillCount', _source, stars)
	end
end)]]


AddEventHandler('esx:playerDropped', function(playerId)
	
	--TriggerClientEvent('IDsAboveHead:updateStars', -1, nil, playerId, nil)
	

	--local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		--while not starsArr[playerId].stars do Citizen.Wait(0); end
		MySQL.Async.execute(
			"UPDATE users SET stars = @stars WHERE identifier = @identifier",
			{
				['@identifier'] = xPlayer.identifier,
				['@stars'] = connectedPlayers[playerId].stars,
			}
		)
		
		--starsArr[playerId] = nil
	end
	
	connectedPlayers[playerId] = nil
	
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	TriggerClientEvent('IDsAboveHead:updateJob', -1, connectedPlayers)
	TriggerClientEvent('DiscordBot:updateJob', -1, connectedPlayers)

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		UpdatePing()
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
	end
end)

RegisterServerEvent('esx_scoreboard:updatestars')
AddEventHandler('esx_scoreboard:updatestars', function(_stars)
	starsArr = _stars
	local _source = source
	if connectedPlayers[_source] ~= nil then
		--connectedPlayers[playerId] = {}
		connectedPlayers[_source].stars = _stars[_source].stars
		connectedPlayers[_source].starsSymbol = _stars[_source].starsSymbol
	else
		connectedPlayers[_source] = {}
		connectedPlayers[_source].stars = _stars[_source].stars
		connectedPlayers[_source].starsSymbol = _stars[_source].starsSymbol
	end
end)


function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source
	
	
	connectedPlayers[playerId] = {}
	connectedPlayersconnectedPlayersping = GetPlayerPing(playerId)
	connectedPlayers[playerId].id = playerId
	connectedPlayers[playerId].name = xPlayer.getName()
	connectedPlayers[playerId].job = xPlayer.job.name
	connectedPlayers[playerId].jobLabel = xPlayer.job.label
	connectedPlayers[playerId].steamid = GetPlayerIdentifiers(playerId)[1]

	if starsArr[playerId] ~= nil then
		local tstars1 = starsArr[playerId].stars
		tstars1 = tonumber(tstars1)
		if tstars1 == nil then
			starsArr[playerId].stars = 0
			tstars1 = 0
		end
		
		if tstars1 == 0 then
			starsSymbol = ''
		elseif tstars1 == 1 then
			starsSymbol = '⭐'
		elseif tstars1 == 2 then
			starsSymbol = '⭐⭐'
		elseif tstars1 == 3 then
			starsSymbol = '⭐⭐⭐'
		elseif tstars1 == 4 then
			starsSymbol = '⭐⭐⭐⭐'
		elseif tstars1 >= 5 then
			starsSymbol = '⭐⭐⭐⭐⭐'
		end

		connectedPlayers[playerId].stars = tstars1
		connectedPlayers[playerId].starsSymbol = starsSymbol
	else
		local tstars = 0
		local starsSymbol = ''
		local retData = MySQL.Sync.fetchAll('SELECT stars FROM users WHERE identifier=@identifier',{['@identifier'] = xPlayer.identifier})
		while not retData do Citizen.Wait(0); end

		if retData[1].stars ~= nil then
			tstars = retData[1].stars
			connectedPlayers[playerId].stars = tstars
			if tstars == 0 then
				starsSymbol = ''
			elseif tstars == 1 then
				starsSymbol = '⭐'
			elseif tstars == 2 then
				starsSymbol = '⭐⭐'
			elseif tstars == 3 then
				starsSymbol = '⭐⭐⭐'
			elseif tstars == 4 then
				starsSymbol = '⭐⭐⭐⭐'
			elseif tstars >= 5 then
				starsSymbol = '⭐⭐⭐⭐⭐'
			end

			connectedPlayers[playerId].starsSymbol = starsSymbol

		end
	end
	
	
	if update then
		
		TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
		TriggerClientEvent('IDsAboveHead:updateJob', -1, connectedPlayers)
		TriggerClientEvent('DiscordBot:updateJob', -1, connectedPlayers)
	end
	
	TriggerClientEvent('DiscordBot:updateJob', -1, connectedPlayers)

	if xPlayer.player.getGroup() == 'user' then
		Citizen.CreateThread(function()
			Citizen.Wait(3000)
			TriggerClientEvent('esx_scoreboard:toggleID', playerId, false)
		end)
	end
end

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()
	local ems, police, taxi, mechanic, slaughterer, trucker, fisherman, mafia, gang, biker = 0, 0, 0, 0, 0, 0, 0, 0, 0
	local miner, lumberjack, tailor, thany = 0, 0, 0, 0
	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		
		if xPlayer.job.name == 'ambulance' then
			ems = ems + 1
		elseif xPlayer.job.name == 'police' then
			police = police + 1
		elseif xPlayer.job.name == 'mechanic' then
			mechanic = mechanic + 1
		end
		
		
		AddPlayerToScoreboard(xPlayer, false)
	end
	--SetConvarServerInfo("Nghề nghiệp", "👨‍⚕️ Bác sĩ: "..ems.." - 👮 Cảnh sát: "..police.." - 🚕 Taxi: "..taxi.." - 🔧 Cứu hộ: "..mechanic.." - 💎 Thợ mỏ: "..miner.." - 🐟 Câu cá: "..fisherman.." - ✂️ Thợ may: "..tailor.." - ⚒ Chặt gỗ: "..lumberjack.." - 💉 Thần Y 4.0: "..thany)
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	TriggerClientEvent('IDsAboveHead:updateJob', -1, connectedPlayers)
	TriggerClientEvent('DiscordBot:updateJob', -1, connectedPlayers)
end

function UpdatePing()
	for k,v in pairs(connectedPlayers) do
		v.ping = GetPlayerPing(k)
	end

	TriggerClientEvent('esx_scoreboard:updatePing', -1, connectedPlayers)
end

TriggerEvent('es:addGroupCommand', 'screfresh', 'admin', function(source, args, user)
	AddPlayersToScoreboard()
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Refresh esx_scoreboard names!"})

TriggerEvent('es:addGroupCommand', 'sctoggle', 'admin', function(source, args, user)
	TriggerClientEvent('esx_scoreboard:toggleID', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Toggle ID column on the scoreboard!"})
