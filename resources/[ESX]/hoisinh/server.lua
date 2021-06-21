Config = {}
Config.Ucret = 800

local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(10 * 1000, CountCops)
end

CountCops()


ESX.RegisterServerCallback('ai_mechanic:doktor', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(CopsConnected)
end)

RegisterServerEvent('ai_mechanic:odeme')
AddEventHandler('ai_mechanic:odeme', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	--if xPlayer.getBank() >= Config.Ucret and CopsConnected < 1 then
		--if CopsConnected < 1 then
			-- xPlayer.removeBank(1000)
			-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Không có bác sĩ Online phí hồi sinh là 1000$, vui lòng chờ 20 giây.' })
			-- Citizen.Wait(20000)
			-- TriggerClientEvent('esx_ambulancejob:revive', source)
		-- elseif CopsConnected == 1 then
		-- 	if xPlayer.job.name == 'ambulance' then
		-- 		xPlayer.removeBank(1000)
		-- 		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bạn đã trả 1000$ tiền ngân hàng để hồi sinh, vui lòng chờ 20 giây.' })
		-- 		Citizen.Wait(10000)
		-- 		TriggerClientEvent('esx_ambulancejob:revive', source)
		-- 	end
		--end
	if CopsConnected < 1 then
		if CopsConnected < 1 then
		xPlayer.removeMoney(1500)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Không có bác sĩ Online phí hồi sinh là 1500$, vui lòng chờ 10 giây.' })
		Citizen.Wait(10000)
		TriggerClientEvent('58723448-c130-4256-9183-b146ffe912d2', source)
		-- elseif CopsConnected == 1 then
		-- 	if xPlayer.job.name == 'ambulance' then
		-- 		xPlayer.removeMoney(1000)
		-- 		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bạn đã trả 1000$ tiền túi để hồi sinh, vui lòng chờ 20 giây.' })
		-- 		Citizen.Wait(20000)
		-- 		TriggerClientEvent('esx_ambulancejob:revive', source)
		-- 	end
		end
		--ShowAdvancedNotification("CHAR_CALL911", "NITRO", "<FONT FACE = 'Montserrat'>Bác sĩ thông báo", "Hãy hạn chế chết khi không có bác sĩ. ~y~")
		--TriggerClientEvent('knb:mech', source)
	elseif xPlayer.getBank() < Config.Ucret and xPlayer.getMoney() < Config.Ucret then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Không có đủ tiền trong ngân hàng hoặc túi.' })
	elseif CopsConnected > 0 then
		if xPlayer.job.name == 'ambulance' then
			xPlayer.removeMoney(1500)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bạn đã trả 1500$ tiền túi để hồi sinh, vui lòng chờ 10 giây.' })
			Citizen.Wait(10000)
			TriggerClientEvent('58723448-c130-4256-9183-b146ffe912d2', source)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Đã có bác sĩ online. Không thể hồi sinh' })
		end
	end
end)

TriggerEvent('es:addCommand', 'hoisinh', function(source)
	TriggerEvent('ai_mechanic:odeme', source)
	--TriggerEvent('esx_ambulancejob:revive', source)
    end)