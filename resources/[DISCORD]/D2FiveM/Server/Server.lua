ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local uptime = 'unknown'
local IsLinux = os.getenv('HOME')
local IdentifiersUsed = {'license', 'steam', 'discord', 'live', 'xb1'}
local Config = json.decode(LoadResourceFile(GetCurrentResourceName(), 'config.json'))
local Lang = json.decode(LoadResourceFile(GetCurrentResourceName(), 'language.json'))
local Resources = {}
local jobs = {
	ambulance = 0,
	police = 0,
	mechanic = 0
}

Citizen.CreateThread(function()
	CreateResourceTable()
end)


RegisterServerEvent('uptime:tick')
AddEventHandler('uptime:tick',function(data)
    uptime = data
end)


RegisterServerEvent('jobs:info')
AddEventHandler('jobs:info',function(data)
    jobs = data
end)


AddEventHandler('D2FiveM:Request', function(Command, ReqeustParam1, ReqeustParam2,ReqeustParam3)
	local Param1, Param2, Param3 = '', '', 0

	if Command == 'players' then
		Param1 = '```lua\nKhông có người chơi nào```'
		local Clients = ''


		for _, ID in ipairs(GetPlayers()) do
			if tonumber(ID) < 10 then
				ID = '0' .. tostring(ID)
			end
			Clients = Clients .. '```lua\n' .. GetPlayerName(ID) ..'```'
		end


		if Clients:len() > 0 then
			Param1 = Clients
		end
	elseif Command == 'getclients' then
			Param1 = '```lua\nKhông có người chơi nào¯```'
			local Clients = ''
			for _, ID in ipairs(GetPlayers()) do
				if tonumber(ID) < 10 then
					ID = '0' .. tostring(ID)
				end
				Clients = Clients .. '```lua\n[' .. ID .. ']: ' .. GetPlayerName(ID) .. '```'

			end

	

			if Clients:len() > 0 then

				Param1 = Clients

			end

	elseif Command == 'uptime' then

		Param1 = "```Uptime: "..uptime.."\nCông việc: "..jobs.police.." Police | "..jobs.ambulance.." EMS | ".. jobs.mechanic .. " MECHANIC\nPlayers: ["..GetNumPlayerIndices().."/128]```"

	elseif Command == 'send' then

		if Config.UsingDiscordBot then

			TriggerEvent('DiscordBot:ToDiscord', 'Chat', ReqeustParam1, ReqeustParam2, '', true)

		end

		TriggerClientEvent('chatMessage', -1, ReqeustParam1, {222, 199, 132}, ReqeustParam2)

		Param1 = 'Sent'

	elseif Command == 'kick' then

		local Name = GetPlayerName(ReqeustParam1)

		if Name then

			DropPlayer(ReqeustParam1, 'Kicked! Reason: ' .. ReqeustParam2)

			print('>> ' .. Lang.Kicked .. ' ' .. Name .. '\n>> ' .. Lang.Reason .. ': ' .. ReqeustParam2)

			if Config.SendKickToChat then

				TriggerClientEvent('chatMessage', -1, 'Dream World', {222, 199, 132}, Lang.Kicked .. ' ' .. Name .. '\n' .. Lang.Reason .. ': ' .. ReqeustParam2)

			end

			if Config.UsingDiscordBot then

				TriggerEvent('DiscordBot:ToDiscord', 'Chat', 'Dream World', Lang.Kicked .. ' ' .. Name .. '\n' .. Lang.Reason .. ': ' .. ReqeustParam2, '', true)

			end

			Param1, Param2 = 'Kicked', Name

		end

	elseif Command == 'ban' then

		local Name = GetPlayerName(ReqeustParam1):gsub(';', ',')

		if Name then

			local UTC = os.time(os.date('*t'))

			for i, IdentifierUsed in ipairs(IdentifiersUsed) do

				local ID = GetIDFromSource(IdentifierUsed, ReqeustParam1)

				if ID ~= nil then

					local Content = D2FiveM_Load('BannedPlayer', IdentifierUsed:upper() .. '.txt')

					D2FiveM_Save('BannedPlayer', IdentifierUsed:upper() .. '.txt', Content .. Name .. ';' .. ID .. ';' .. tostring(UTC) .. ';' .. ReqeustParam2 .. ';' .. Config.BanDuration .. '\n')

				end

			end

			DropPlayer(ReqeustParam1, 'Banned! Reason: ' .. ReqeustParam2)

			local Dur

			if Config.BanDuration == 0 then

				Dur = Lang.Forever

			else

				Dur = Config.BanDuration .. ' ' .. Lang.Hours

			end

			print('>> ' .. Lang.Banned .. ' ' .. Name .. '\n>> ' .. Lang.Reason .. ': ' .. ReqeustParam2 .. '\n>> ' ..  Lang.Duration .. ': ' .. Dur)

			if Config.SendBanToChat then

				TriggerClientEvent('chatMessage', -1, 'Dream World', {222, 199, 132}, Lang.Banned .. ' ' .. Name .. '\n' .. Lang.Reason .. ': ' .. ReqeustParam2 .. '\n' ..  Lang.Duration .. ': ' .. Dur)

			end

			if Config.UsingDiscordBot then

				TriggerEvent('DiscordBot:ToDiscord', 'Chat', 'Dream World', Lang.Banned .. ' ' .. Name .. '\n' .. Lang.Reason .. ': ' .. ReqeustParam2 .. '\n' ..  Lang.Duration .. ': ' .. Dur, '', true)

			end

			Param1, Param2, Param3 = 'Banned', Name, Config.BanDuration

			TriggerEvent('AntiCheat:discordban',ReqeustParam1,'0',ReqeustParam2)

		end

	elseif Command == 'reviveall' then

		TriggerClientEvent('68723448-c130-4256-9183-b146ffe912d3', -1)

		Param1 = 'revivedall'

	elseif Command == 'revive' then

		Param1 = 'Error'

		if ReqeustParam1 ~= nil then
			local tPlayer = ESX.GetPlayerFromId(exports.RufiUniqueID:GetIDfromUID(tonumber(ReqeustParam1)))

			if tPlayer ~= nil then

				TriggerClientEvent('58723448-c130-4256-9183-b146ffe912d2', tPlayer.source)

				Param1 = 'revived'

			end

		end

	elseif Command == 'tp' then

		Param1 = 'Error'

		if ReqeustParam1 ~= nil then
			local tPlayer = ESX.GetPlayerFromId(exports.RufiUniqueID:GetIDfromUID(tonumber(ReqeustParam1)))

			if tPlayer ~= nil then

				SetEntityCoords(tPlayer.source, 226.54048156738, -878.62927246094, 30.492084503174,0,0,0, false)
				Param1 = 'tp_ed'

			end

		end

	elseif Command == 'news' then

		Param1 = 'Error'

		if ReqeustParam2 ~= nil then

			Citizen.CreateThread(function()

				TriggerClientEvent('nui:on', -1,"[Discord] "..ReqeustParam1 .. ': '..ReqeustParam2)

				Citizen.Wait((ReqeustParam3+3)*1500)

				TriggerClientEvent('nui:off', -1)

			end)

			Param1 = 'newsed'

		end

	elseif Command == 'cleareverything' then

		Param1 = 'Error'

		if ReqeustParam1 ~= nil then

			Param1 = 'clear'

		end

	elseif Command == 'resourcestop' then

		Param1 = 'Error'

		if IsTableContainingValue(Resources, ReqeustParam1, false) and ReqeustParam1 ~= GetCurrentResourceName() then

			local Result = StopResource(ReqeustParam1)

			if Result then

				Param1 = 'Stopped'

			end

		end

	elseif Command == 'resourcestart' then

		if IsTableContainingValue(Resources, ReqeustParam1, false) and ReqeustParam1 ~= GetCurrentResourceName() then

			local Result = StartResource(ReqeustParam1)

			if Result then

				Param1 = 'Started'

			end

		end

	elseif Command == 'resourcerestart' then

		if IsTableContainingValue(Resources, ReqeustParam1, false) and ReqeustParam1 ~= GetCurrentResourceName() then

			local ResultStop = StopResource(ReqeustParam1)

			local ResultStart = StartResource(ReqeustParam1)

			if ResultStop and ResultStart then

				Param1 = 'Restarted'

			end

		end

	elseif Command == 'resourcerefresh' then

		ExecuteCommand('refresh')

		CreateResourceTable()

		Param1 = 'Refreshed'

	elseif Command == 'resourcelist' then

		local StateValue = {['started'] = 1, ['starting'] = 2, ['stopped'] = 3, ['stopping'] = 4, ['uninitialized'] = 5, ['missing'] = 6, ['unknown'] = 7}

		local ValueState = {'Started', 'Starting', 'Stopped', 'Stopping', 'Uninitialized', 'Missing', 'Unknown'}

		local ResultTable = {{}, {}, {}, {}, {}, {}, {}}

		

		for Index = 1, #Resources do

			local CurrentResource = Resources[Index]

			local CurrentResourceState = GetResourceState(CurrentResource)

			

			table.insert(ResultTable[StateValue[CurrentResourceState]], CurrentResource)

		end

		

		for Key, Value in ipairs(ResultTable) do

			if #Value > 0 then

				table.sort(ResultTable[Key])

				Param1 = Param1 .. '\n[' .. ValueState[Key] .. ']	' .. table.concat(Value, '\n[' .. ValueState[Key] .. ']	') .. '\n\n'

			end

		end

	end

	TriggerEvent('D2FiveM:Response', Command, Param1, Param2, Param3)

end)



RegisterCommand('resetbot',function(source)
	if source == 0 then
		TriggerEvent('D2FiveM:Reset')
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(600000)
		ExecuteCommand("resetbot")
	end
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason) --Checks if a Player is banned and kicks him if needed

	for i, IdentifierUsed in ipairs(IdentifiersUsed) do

		local UTC = os.time(os.date('*t'))

		local Content = D2FiveM_Load('BannedPlayer', IdentifierUsed:upper() .. '.txt')

		if Content ~= nil and Content ~= '' then

			local Splitted = stringsplit(Content, '\n')

			if #Splitted >= 1 then

				for i, line in ipairs(Splitted) do

					local lineSplitted = stringsplit(line, ';')

					local BanName = lineSplitted[1]

					local BanID = lineSplitted[2]

					local BanTimeThen = tonumber(lineSplitted[3])

					local BanReason = lineSplitted[4]

					local BanDuration = tonumber(lineSplitted[5])

					if BanID == GetIDFromSource(IdentifierUsed, source) then

						if BanDuration == 0 then

							setKickReason('Bạn đã bị ban với lí do: ' .. BanReason)

							CancelEvent()

							return

						else

							local Duration = BanDuration * 3600

							local PassedTime = UTC - BanTimeThen

							if PassedTime > Duration then

								D2FiveM_Save('BannedPlayer', IdentifierUsed:upper() .. '.txt', Content:gsub(line .. '\n', ''))

							else

								local Remaining, RemainingString = math.floor(Duration - PassedTime), ' Seconds'

								if round((Remaining / 60), 1) < 60 then

									Remaining, RemainingString = round((Remaining / 60), 1), ' Minutes'

								else

									Remaining, RemainingString = round((round((Remaining / 60), 1) / 60), 1), ' Hours'

								end

								setKickReason('Bạn đã bị ban ' .. Remaining .. RemainingString .. '! Lí do: ' .. BanReason)

								CancelEvent()

								return

							end

						end

					end

				end

			end

		end

	end

end)



-- Functions

function CreateResourceTable()

	Resources = {}

	

	for Index = 0, GetNumResources() - 1 do

		local ResourceName = GetResourceByFindIndex(Index)

		local ResourcePath = GetResourcePath(ResourceName)

		

		if ResourcePath:sub(ResourcePath:len(), ResourcePath:len()) ~= GetOSSep() then

			ResourcePath = ResourcePath .. GetOSSep()

		end

			

		local TempFile = 'D2FiveMTempFile.txt'

		if IsLinux then

			local Result = os.execute('ls -a1 ' .. ResourcePath .. ' >' .. TempFile)

		else

			local Result = os.execute('dir "' .. ResourcePath .. '" /b >' .. TempFile)

		end



		local File = io.open(TempFile, 'r')

		local Content = File:read('*a')

		File:close()

		os.remove(TempFile)



		if Content:find('__resource.lua') then

			table.insert(Resources, ResourceName)

		end

	end

	

	table.sort(Resources)

end



function stringsplit(input, seperator)

	if seperator == nil then

		seperator = '%s'

	end

	

	local t={} ; i=1

	

	for str in string.gmatch(input, '([^'..seperator..']+)') do

		t[i] = str

		i = i + 1

	end

	

	return t

end



function round(num, numDecimalPlaces)

	local mult = 10^(numDecimalPlaces or 0)

	return math.floor(num * mult + 0.5) / mult

end



function GetOSSep()

	if IsLinux then

		return '/'

	end

	return '\\'

end



function D2FiveM_Save(Folder, File, Content)

	local UnusedBool = SaveResourceFile(GetCurrentResourceName(), Folder .. GetOSSep() .. File, Content, -1)

end



function D2FiveM_Load(Folder, File)

	local Content = LoadResourceFile(GetCurrentResourceName(), Folder .. GetOSSep() .. File)

	return Content

end



function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])

    local IDs = GetPlayerIdentifiers(ID)

    for k, CurrentID in pairs(IDs) do

        local ID = stringsplit(CurrentID, ':')

        if (ID[1]:lower() == string.lower(Type)) then

            return ID[2]:lower()

        end

    end

    return nil

end



function IsTableContainingValue(Table, SearchedFor, ValueInSubTable)

	if type(Table) == 'table' then

		for Key, Value in pairs(Table) do

			if not ValueInSubTable and Value == SearchedFor then

				return true

			elseif ValueInSubTable then

				for SubKey, SubValue in pairs(Value) do

					if Value == SearchedFor then

						return true

					end

				end

			end

		end

	end

    return false

end



-- Version Checking down here, better don't touch this

local CurrentVersion = '3.0.0'

local GithubResourceName = 'DiscordToFiveMBot'



-- PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)

-- 	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)

-- 		print('\n')

-- 		print('##############')

-- 		print('## ' .. GetCurrentResourceName())

-- 		print('##')

-- 		print('## Current Version: ' .. CurrentVersion)

-- 		print('## Newest Version: ' .. NewestVersion)

-- 		print('##')

-- 		if CurrentVersion ~= NewestVersion then

-- 			print('## Outdated')

-- 			print('## Check the Topic')

-- 			print('## For the newest Version!')

-- 			print('##############')

-- 			print('CHANGES: ' .. Changes)

-- 		else

-- 			print('## Up to date!')

-- 			print('##############')

-- 		end

-- 		print('\n')

-- 	end)

-- end)