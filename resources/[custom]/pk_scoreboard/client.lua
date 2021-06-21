-- Created By.xZero
ESX = nil
local display = false
local keys = 178
local IsPress = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if ( IsControlPressed(0, keys) and not (ESX == nil) and (IsPress == false) ) then
            IsPress = true

            ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
                if not (data == nil) then
                    data = data[1]

                    -- UpdateNUI
                    updatedata(data)

                    display = not display
                    TriggerEvent("xscoreboard:display", display)
                end
                IsPress = false
            end)

            Citizen.Wait(250)
        end

        Citizen.Wait(10)
    end
end)

AddEventHandler("xscoreboard:display", function(value) 
    SendNUIMessage({
        type = "ui",
        display = value
    })
end)

function updatedata(data)
    SendNUIMessage({
        type = "update",
        my_id = GetPlayerServerId(PlayerId()),
        my_phonenmumber = data.my_phonenmumber,
        my_fullname = data.my_fullname,
        my_job = data.my_job,
        my_ping = data.my_ping,
        players = data.players,
        police = data.police,
		ems = data.ems,
		img = data.img,
        mc = data.mc
    })
end
