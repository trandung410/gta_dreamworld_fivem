local open = false


Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  end)

-- Open ID card
RegisterNetEvent('teamDvm_idcard:open')
AddEventHandler('teamDvm_idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

RegisterNetEvent('teamDvm_idcard:dv_license')
AddEventHandler('teamDvm_idcard:dv_license', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	TriggerServerEvent('teamDvm_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
	
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('teamDvm_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
	else
		ESX.ShowNotification('No players nearby')
	end
end)

RegisterNetEvent('teamDvm_idcard:id_card')
AddEventHandler('teamDvm_idcard:id_card', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	TriggerServerEvent('teamDvm_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
	
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('teamDvm_idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
	else
		ESX.ShowNotification('No players nearby')
	end
end)
