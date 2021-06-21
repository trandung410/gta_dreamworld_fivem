RegisterNetEvent('minigame:startMinigame')
AddEventHandler('minigame:startMinigame', function(cb)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'show'
    })
    RegisterNUICallback('minigameFinished', function(data)
        SetNuiFocus(false, false)
        cb(data.isSuccess)
    end)
end)

RegisterCommand('minigame', function()
    TriggerEvent('minigame:startMinigame', function(data)
        
    end)
end, false)

]]
--[[

Cách Chạy nó Trong script (Thêm vào client):

RegisterCommand('minigame', function()
    TriggerEvent('minigame:startMinigame', function(data)
        -- Code ở đây
    end)
end, false)

]]