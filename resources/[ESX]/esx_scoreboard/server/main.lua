ESX = nil
local connectedPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name
	connectedPlayers[playerId].jobLabel = job.label


	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	AddPlayerToScoreboard(xPlayer, true)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		UpdatePing()
		Updatejobs()
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
-- local phone_number
-- function NumberPhone(source)
--  	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source) 
-- 	phone_number = MySQL.Sync.fetchAll('SELECT `phone_number` FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier}, function(result)
-- 	end)
-- 	return phone_number[1].phone_number
-- end
function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source
	local xPlayer = ESX.GetPlayerFromId(playerId) 
  
	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].ping = GetPlayerPing(playerId)
	connectedPlayers[playerId].id = exports.RufiUniqueID:GetUIDfromID(playerId)
	connectedPlayers[playerId].name = xPlayer.getName()
	connectedPlayers[playerId].job = xPlayer.job.name
	connectedPlayers[playerId].jobLabel = xPlayer.job.label
	-- connectedPlayers[playerId].phonenumber = NumberPhone(playerId)


	if update then
		TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	end

	if xPlayer.player.getGroup() == 'user' then
		Citizen.CreateThread(function()
			Citizen.Wait(3000)
			TriggerClientEvent('esx_scoreboard:toggleID', playerId, false)
		end)
	end
end

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end

function UpdatePing()
	for k,v in pairs(connectedPlayers) do
		v.ping = GetPlayerPing(k)
	end

	TriggerClientEvent('esx_scoreboard:updatePing', -1, connectedPlayers)
end
function Updatejobs()
	local jobs = {
		ambulance = 0,
		police = 0,
		mechanic = 0
	}
	for k,v in pairs(connectedPlayers) do
		if v.job == 'ambulance' then
			jobs.ambulance = jobs.ambulance + 1
		elseif v.job == 'police' then
			jobs.police = jobs.police + 1
		elseif v.job == 'mechanic' then
			jobs.mechanic = jobs.mechanic + 1
		end
	end
	TriggerEvent("jobs:info", jobs)
	-- SetConvarServerInfo('Công việc', '👨‍⚕️: '..jobs.ambulance..', 👮🏻: '..jobs.police..', 🔧: '..jobs.mechanic)
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
