ESX = nil

local code = "";
local PlayerData              = {}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
  PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('fd_frakmenu:menu')
AddEventHandler('fd_frakmenu:menu', function(title, message, b)
    Wait(200)
    SendNUIMessage({
		title = title,
        message = message
    })

    
    code = b
    SetNuiFocus(true, true)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

end)

RegisterNUICallback('fd_frakmenu:ja', function(data, cb)
  local ped = GetPlayerPed(-1)
	TriggerServerEvent('fd_frakmenu:jaserver', GetPlayerServerId(PlayerId()))
    SetNuiFocus(false, false)
    exports['dr_notify']:sendMessage('success', 5000, 'Chúc mừng bạn Đã là một chiến sĩ Cảnh sát!')

    cb('ok')
end)

RegisterNUICallback('fd_frakmenu:fade', function(data, cb)
    SetNuiFocus(false, false)
    load(code)()

    cb('ok')
end)

RegisterNUICallback('fd_frakmenu:ciao', function(data, cb)
    SetNuiFocus(false, false)
    exports['dr_notify']:sendMessage('success', 5000, 'Thật Đáng tiếc yêu cầu đã bị từ chối')
    code = ""

    cb('ok')
end)