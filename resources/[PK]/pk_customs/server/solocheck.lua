ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[
AddEventHandler('playerConnecting', function()
	local identifier = GetPlayerIdentifiers(source)[1]
	if identifier then
		ESX.TriggerServerCallback('5736b3c4-69a8-4cd4-b5bb-19dbc95b6cd7', function (rest)
			if rest[1] ~= nil then
				sPlayers = GetPlayers()
				maxSlots = GetConvarInt('sv_maxclients', 256) - 1
				if (#sPlayers >= maxSlots) then
					DropPlayer(sPlayers[math.random(1,maxSlots)], "คุณถูกตัดออกจากเซิร์ฟเวอร์เพื่ออำนวยความสะดวกในการเข้าของ แอดมิน/สมาชิกวีไอพี | โปรดเลือกเข้า Channelอื่นหรือลองเข้าใหม่อีกครั้ง ขอบคุณค่ะ...")
				end
			end
		end, identifier)
	end
end)

RegisterServerEvent('84dc50ad-ec36-4199-bc7a-d65d2dfefdfa')
AddEventHandler('84dc50ad-ec36-4199-bc7a-d65d2dfefdfa', function(clientPlayerNumber)
	local _source = source
	if _source then
		serverPlayerNumber = GetPlayers()
		if clientPlayerNumber == 1 then
			if #serverPlayerNumber-clientPlayerNumber > 6 then 
				print(('[#] kicked %s for session'):format(source))
				DropPlayer(_source, 'ถูกตัดออกจากเซิร์ฟเวอร์เนื่องจากติดอยู่ในโลกคู่ขนาน... กรุณาเข้าใหม่อีกครั้ง!')
			end
		end
	end
end)
]]--