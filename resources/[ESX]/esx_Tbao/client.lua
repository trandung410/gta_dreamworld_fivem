local display = false

RegisterNetEvent('nui:on')
AddEventHandler('nui:on', function(msgt)
  SendNUIMessage({
    type = "ui",
    display = true,
    msg = msgt
  })
end)

RegisterNetEvent('nui:off')
AddEventHandler('nui:off', function()
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)
 