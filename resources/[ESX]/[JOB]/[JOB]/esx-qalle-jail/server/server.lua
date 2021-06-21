ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = exports.RufiUniqueID:GetIDfromUID(tonumber(args[1]))
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)

				TriggerClientEvent("esx:showNotification", src, "".. GetPlayerName(jailPlayer) .. " bị giam " .. jailTime .. " phút!")
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
						TriggerClientEvent('chat:addMessage', -1, { args = { "TÒA ÁN",  GetPlayerName(jailPlayer) .. " hiện đang ở tù vì lý do : " .. args[3] .. "" }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Thời gian không hợp lệ!")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Người chơi này không online!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Bạn không phải là Cảnh Sát!")
	end
end)

RegisterCommand("unjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = exports.RufiUniqueID:GetIDfromUID(tonumber(args[1]))

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
			TriggerClientEvent('chat:addMessage', -1, { args = { "TÒA ÁN",  GetPlayerName(jailPlayer) .. " đã được trả về với xã hội  " }, color = { 249, 166, 0 } })

		else
			TriggerClientEvent("esx:showNotification", src, "Người chơi này không online!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Bạn không phải là Cảnh Sát!")
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer1")
AddEventHandler("esx-qalle-jail:jailPlayer1", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then
		JailPlayer(targetSrc, jailTime)

		GetRPName(targetSrc, function(Firstname, Lastname)
			TriggerClientEvent('chat:addMessage', -1, { args = { "TÒA ÁN", ""..GetPlayerName(targetSrc).." hiện đang ở tù vì lý do : " .. jailReason .."" }, color = { 249, 166, 0 } })
		end)

		TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " bị giam " .. jailTime .. " phút!")
	else
		notifMsg    = "[esx_qalle_jail] | " ..GetPlayerName(source).. " ["..xPlayer.identifier.. "] đã bị auto kick vì cố gắng đưa mọi người vào tù."
		print(notifMsg)
		--TriggerClientEvent('chatMessage', -1, '^3[AntiCheat]', {255, 0, 0}, "^3" ..xPlayer.name.. "^1 đã bị auto kick vì cố gắng đưa mọi người vào tù.")
		DropPlayer(source, 'Lua Execution')
	end
end)

RegisterServerEvent("esx-qalle-jail:logToDiscord")
AddEventHandler("esx-qalle-jail:logToDiscord", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	PerformHttpRequest('https://discord.com/api/webhooks/819217653762752542/dP57Yx3c-MxYaDPxp0uUPrroxIhJrOHugnIWdkuG8r5LaH3tWnvU9NOlezGYq_RmQ14b', function(err, text, headers) end, 'POST', json.encode({username = "Nhà tù", content = GetPlayerName(src).." - ".. xPlayer.identifier.." đã trốn khỏi nhà tù! Đã bị nhốt lại!"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)
	if xPlayer.job.name == "police" then
		if tPlayer ~= nil then
			UnJail(tPlayer.source)
		else
			MySQL.Async.execute(
				"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
				{
					['@identifier'] = targetIdentifier,
					['@newJailTime'] = 0
				}
			)
		end

		TriggerClientEvent("esx:showNotification", src,"".. tPlayer.name .. " đã được tự do!")
		TriggerClientEvent('chat:addMessage', -1, { args = { "TÒA ÁN", ""..tPlayer.name.." đã được thả tự do!" }, color = { 249, 166, 0 } })
	else
		notifMsg    = "[esx_qalle_jail] | " ..GetPlayerName(src).. " ["..xPlayer.identifier.. "] đã bị auto kick vì cố gắng đưa mọi người vào tù."
		print(notifMsg)
		--TriggerClientEvent('chatMessage', -1, '^3[AntiCheat]', {255, 0, 0}, "^3" ..xPlayer.name.. "^1 đã bị auto kick vì cố gắng đưa mọi người vào tù.")
		DropPlayer(source, 'Lua Execution')
	end
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addInventoryItem('bread', 1)
	xPlayer.addInventoryItem('water', 1)

	TriggerClientEvent("esx:showNotification", src, "Cám ơn, bạn hãy nhận một ít đồ ăn!")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer1", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)