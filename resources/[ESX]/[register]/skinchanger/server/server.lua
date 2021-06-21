ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('sc', function(source)
    local source = PlayerId()
    local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('skinchanger:modelLoaded')
    end
end)




































--[[ESX.RegisterUsableItem('abc', function(source)
    local source = PlayerId()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.jobname == 'police' then
        ESX.ShowNotification('Test1 job police')
        TriggerEvent("pNotify:SendNotification",  {
            text =  "คุณเป็น ตำรวจ ไม่สามารถใช้ยาฆ่าตัวตายได้",
            type = "info",
            timeout = 3500,
            layout = "topRight",
        })
    elseif xPlayer.jobname == 'ambulance' then
       -- ESX.ShowNotification('Test1 job ambulance')
        TriggerEvent("pNotify:SendNotification",  {
            text =  "คุณเป็น หมอ ไม่สามารถใช้ยาฆ่าตัวตายได้",
            type = "info",
            timeout = 3500,
            layout = "topRight",
        })
    else
        TriggerClinetEvent('test:dead', source)
    end
end)]]