local rob = false
local lockdown = 0
local teamrob = 0
ESX = nil
local DataTeam = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_holdupbank:tooFar_sv')
AddEventHandler('esx_holdupbank:tooFar_sv', function(aa)
	local _source = source
	rob = false
	teamrob = 0 
	--print('Kill Blips Server Side' , aa)
	TriggerClientEvent('esx_holdupbank:killBlip', -1)
	TriggerClientEvent('esx_holdupbank:removeall', -1)
	TriggerClientEvent('esx_holdupbank:tooFar', _source)
	lockdown = os.time()
end)

RegisterServerEvent('esx_holdupbank:addteamrob')
AddEventHandler('esx_holdupbank:addteamrob', function()
	local _source = source
	teamrob = teamrob + 1
	-- local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'Bạn đã được thêm vào nhóm cướp')
	TriggerClientEvent('esx_holdupbank:checkteamrob', -1, teamrob)
	table.insert(DataTeam, _source)
	print(json.encode(DataTeam))
	-- xPlayer.SetWanted(true)
	print(teamrob)
end)

RegisterServerEvent('esx_holdupbank:removeall_sv')
AddEventHandler('esx_holdupbank:removeall_sv', function()
	-- local xPlayer = ESX.GetPlayerFromId(source)
	-- xPlayer.SetWanted(false)
	DataTeam = {}
	teamrob = 0
end)

RegisterServerEvent('esx_holdupbank:SendCoordRob')
AddEventHandler('esx_holdupbank:SendCoordRob', function(coords, reg)
	if (((lockdown + Config.TimerBeforeNewRob) - os.time()) > 0) and (lockdown ~= 0) then
		TriggerClientEvent('esx:showNotification', source,'Bạn có thể cướp sau: ' .. ((lockdown + Config.TimerBeforeNewRob) - os.time()) .. ' giây')
		return
	end
	TriggerClientEvent('esx_holdupbank:SetCoordRob', -1, coords, reg)
	if not reg then
		TriggerClientEvent('esx_holdupbank:removeall', -1)
	end
end)



RegisterServerEvent('esx_holdupbank:removeteamrob')
AddEventHandler('esx_holdupbank:removeteamrob', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	if teamrob >=1 then
		teamrob = teamrob - 1
		TriggerClientEvent('esx:showNotification', source, 'Bạn đã rời nhóm cướp')
		TriggerClientEvent('esx_holdupbank:checkteamrob', -1, teamrob)
		-- xPlayer.SetWanted(false)
		for k,v in pairs(DataTeam) do 
			if tonumber(v) == _source then 
				table.remove(DataTeam, k)
			end
		end
	end
end)

RegisterServerEvent('esx_holdupbank:robberyStarted')
AddEventHandler('esx_holdupbank:robberyStarted', function(RobPosition)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	print("aaaaaaaaaaa",teamrob)
	if (((lockdown + Config.TimerBeforeNewRob) - os.time()) > 0) and (lockdown ~= 0) then
		TriggerClientEvent('esx:showNotification', _source,'Bạn có thể cướp sau: ' .. ((lockdown + Config.TimerBeforeNewRob) - os.time()) .. ' giây')
		return
	end
	if teamrob < 8 then 
		TriggerClientEvent('esx:showNotification',  _source, 'Cần có ít nhất 8 người trong tổ đội để bắt đầu cướp')
		return
	end 

	if not rob then
		if cops >= Config.PoliceNumberRequired then
			rob = true

			TriggerClientEvent('esx:showNotification', -1,'~r~Có ~g~' ..teamrob .. ' ~r~người đang thực hiện cướp')
			TriggerClientEvent('esx_holdupbank:setBlip', -1, RobPosition)
			TriggerClientEvent('esx:showNotification', _source, _U('started_to_rob'))
			TriggerClientEvent('esx:showNotification', _source, _U('alarm_triggered'))
			TriggerClientEvent('esx_holdupbank:currentlyRobbing', _source, RobPosition)
			TriggerClientEvent('esx_holdupbank:startTimer', _source)
			SetTimeout(Config.TimeRob * 1000, function()
				if rob then
					rob = false
					teamrob = 0
					if xPlayer then
						local Reward = Config.Reward
						TriggerClientEvent('esx_holdupbank:robberyComplete', _source, Reward)
					
						if Config.GiveBlackMoney then
							xPlayer.addAccountMoney('black_money', Reward)
						else
							xPlayer.addMoney(Reward)
						end
						
						TriggerClientEvent('esx:showNotification', -1, _U('robbery_complete_at'))
						TriggerClientEvent('esx_holdupbank:killBlip', -1)
						TriggerClientEvent('esx_holdupbank:removeall', -1)

						lockdown = os.time()
						
					end
				end
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('min_police', Config.PoliceNumberRequired))
		end
	else
		TriggerClientEvent('esx:showNotification', _source, _U('robbery_already'))
	end
end)
