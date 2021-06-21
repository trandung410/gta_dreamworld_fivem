RegisterNetEvent('admin:kill')
AddEventHandler('admin:kill', function()
    SetEntityHealth(PlayerPedId(), 0)
end)