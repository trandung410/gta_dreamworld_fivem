ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("wanted", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local wantedPlayer = exports.RufiUniqueID:GetIDfromUID(tonumber(args[1]))
		local wantedTime = tonumber(args[2])
        local wantedReason = args[3]
		local name = GetPlayerName(wantedPlayer)
		
		local name2 = getIdentity(wantedPlayer)
		fal = name2.name

		if GetPlayerName(wantedPlayer) ~= nil then

			if wantedTime ~= nil then
				WantedPlayer(wantedPlayer, wantedTime)

				TriggerClientEvent("esx:showNotification", src,_U('police_message', fal, wantedTime))
				if args[3] ~= nil then
					--TriggerClientEvent('chat:addMessage', -1, { args = { _U('add_chat'), _('add_chat_message', name, args[3]) }, color = { 249, 166, 0 } })
					
					TriggerClientEvent('chat:addMessage', -1, { template = '<div class="chat-message emergency"><b>Police : {0}  </b> {1}</div>', args = { fal, "Wanted for Charges : "..args[3]  } })
                end
			else
				TriggerClientEvent("esx:showNotification", src,_U('time_error'))
			end
		else
			TriggerClientEvent("esx:showNotification", src,_U('id_not_online'))
		end
	else
		TriggerClientEvent("esx:showNotification", src,_U('not_cops'))
	end
end)

function getIdentity(source)
	local steam = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM players_uid WHERE steam = @steam", {['@steam'] = steam})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			steam = identity['steam'],
			name = identity['name'],
			
		}
	else
		return nil
	end
end

RegisterCommand("unwanted", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local wantedPlayer = exports.RufiUniqueID:GetIDfromUID(tonumber(args[1]))

		if GetPlayerName(wantedPlayer) ~= nil then
			UnWanted(wantedPlayer)
		else
			TriggerClientEvent("esx:showNotification", src,_U('id_not_online'))
		end
	else
		TriggerClientEvent("esx:showNotification", src,_U('not_cops'))
	end
end)

ESX.RegisterServerCallback('esx_wanted:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
            name       = xPlayer.name,
			job        = xPlayer.job
		})
	end

	cb(players)
end)

RegisterServerEvent("esx_wanted:wantedPlayer")
AddEventHandler("esx_wanted:wantedPlayer", function(PlayerId,name, wantedTime, wantedReason)
    local src = source
    local PlayerId = tonumber(PlayerId)
    local xPlayer = ESX.GetPlayerFromId(exports.RufiUniqueID:GetIDfromUID(tonumber(args[1])))
	WantedPlayer(PlayerId, wantedTime)
	
	local name2 = getIdentity(PlayerId)
	fal = name2.name

	--TriggerClientEvent('chat:addMessage', -1, { args = { _U('add_chat'), _('add_chat_message', name, wantedReason) }, color = { 249, 166, 0 } })

	TriggerClientEvent('chat:addMessage', -1, { template = '<div class="chat-message emergency" style="color:red"><b>Cục cảnh sát thông báo :  Truy nã đối tượng {0}  </b> {1}</div>', args = { name, "với lí do : "..wantedReason  }, color = { 249, 166, 0 } })

    TriggerClientEvent("esx:showNotification", PlayerId,_U('player_wanted', wantedReason, wantedTime))
    if Config.Discord then
        policeToDiscord(_U('discord_head'), _U('discord_message',GetPlayerName(src),name,wantedReason,wantedTime), 56108)
    end
end)

function WantedPlayer(wantedPlayer, wantedTime)
    TriggerClientEvent("esx_wanted:wantedPlayer",wantedPlayer, wantedTime)

	EditWantedTime(wantedPlayer, wantedTime)
end

function EditWantedTime(wantedPlayer, wantedTime)

    local xPlayer = ESX.GetPlayerFromId(wantedPlayer)
	local Identifier = xPlayer.identifier
	MySQL.Async.execute(
       "UPDATE users SET wanted = @newWantedTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newWantedTime'] = tonumber(wantedTime)
		}
	)
end

ESX.RegisterServerCallback("esx_wanted:retrieveWantedPlayers", function(source, cb)
	
	local wantedPersons = {}

    MySQL.Async.fetchAll("SELECT firstname, lastname, wanted, identifier FROM users WHERE wanted > @wanted", { ["@wanted"] = 0 }, function(result)


        for i = 1, #result, 1 do
            table.insert(wantedPersons, { 
                name = result[i].firstname .. " " .. result[i].lastname,
                wantedTime = result[i].wanted,
                identifier = result[i].identifier,
            })
		end

		cb(wantedPersons)
	end)
end)

function UnWanted(wantedPlayer)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(wantedPlayer)
    TriggerClientEvent("esx_wanted:unWantedPlayer", wantedPlayer)

    TriggerClientEvent("esx:showNotification", wantedPlayer,  _U('player_unwanted'))

	EditWantedTime(wantedPlayer, 0)
end

ESX.RegisterServerCallback("esx_wanted:retrieveWantedTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT wanted FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

        local WantedTime = tonumber(result[1].wanted)

		if WantedTime > 0 then

            cb(true, WantedTime, src)
		else
			cb(false, 0)
		end

	end)
end)

RegisterServerEvent("esx_wanted:updateWantedTime")
AddEventHandler("esx_wanted:updateWantedTime", function(newWantedTime)
    local src = source
    EditWantedTime(src, newWantedTime)
    if Config.WantedBlip then
        TriggerClientEvent('esx_wanted:setBlip', -1, src)
    end
end)

RegisterServerEvent("esx_wanted:unWantedPlayer")
AddEventHandler("esx_wanted:unWantedPlayer", function(playername,Player)
	local src = source
    local xPlayer = ESX.GetPlayerFromIdentifier(Player)
    if xPlayer ~= nil then
		UnWanted(xPlayer.source)
	else
        TriggerClientEvent("esx:showNotification", src,_U('police_unwanted', playername))
	    MySQL.Async.execute(
			"UPDATE users SET wanted = @newWantedTime WHERE identifier = @identifier",
			{
				['@identifier'] = Player,
				['@newWantedTime'] = 0
			}
        )
    end
    if Config.Discord then
        policeToDiscord(_U('discord_head_unwanted'), _U('discord_message_unwanted',GetPlayerName(src),playername), 16711680)
    end
end)

function policeToDiscord (name,message,color)
    local DiscordWebHook = Config.DiscordWebHook

    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= os.date("%Y/%m/%d\nGiờ: %X"),
            },
        }
    }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
