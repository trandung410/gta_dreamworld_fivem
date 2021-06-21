ESX = nil

local showBankBlips = true
local atBank = false
local bankMenu = true
local inMenu = false
local atATM = false
local bankColor = "green"

local bankLocations = {
    {name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=314.187, y=-278.621, z=54.170},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=-351.534, y=-49.529, z=49.042},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=241.727, y=220.706, z=106.286},
	{name="<FONT FACE='Montserrat'>Ngân hàng", id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
}

-- ATM Object Models
local atms = {
	{name="ATM", id=277, x=-37.93, y=-1115.18, z=26.43},
	{name="ATM", id=277, x=659.93, y=593.0770, z=129.0509},
	{name="ATM", id=277, x=-37.93, y=-1115.18, z=26.43},
	{name="ATM", id=277, x=-301.02, y=-924.85, z=31.08},
	--{name="ATM", id=277, x=954.1121, y=-3175.251, z=5.768485},
	{name="ATM", id=277, x=241.75, y=-813.4, z=30.4},
	{name="ATM", id=277, x=-386.733, y=6045.953, z=31.501},
	--{name="ATM", id=277, x=-32.2268, y=-1111.417, z=25.44965},
	{name="ATM", id=277, x=-1483.54, y=154.96, z=54.48},
	{name="ATM", id=277, x=444.63, y=-974.91, z=30.68},
	{name="ATM", id=277, x=-303.5, y=-598.66, z=42.35},
	{name="ATM", id=277, x=-437.63, y=-979.0, z=30.68},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-135.165, y=6365.738, z=31.101},
	{name="ATM", id=277, x=-110.753, y=6467.703, z=31.784},
	{name="ATM", id=277, x=-94.9690, y=6455.301, z=31.784},
	{name="ATM", id=277, x=155.4300, y=6641.991, z=31.784},
	{name="ATM", id=277, x=174.6720, y=6637.218, z=31.784},
	{name="ATM", id=277, x=1703.138, y=6426.783, z=32.730},
	{name="ATM", id=277, x=1735.114, y=6411.035, z=35.164},
	{name="ATM", id=277, x=1702.842, y=4933.593, z=42.051},
	{name="ATM", id=277, x=1967.333, y=3744.293, z=32.272},
	{name="ATM", id=277, x=1821.917, y=3683.483, z=34.244},
	{name="ATM", id=277, x=1174.532, y=2705.278, z=38.027},
	{name="ATM", id=277, x=540.0420, y=2671.007, z=42.177},
	{name="ATM", id=277, x=2564.399, y=2585.100, z=38.016},
	{name="ATM", id=277, x=2558.683, y=349.6010, z=108.050},
	{name="ATM", id=277, x=2558.051, y=389.4817, z=108.660},
	{name="ATM", id=277, x=1077.692, y=-775.796, z=58.218},
	{name="ATM", id=277, x=1139.018, y=-469.886, z=66.789},
	{name="ATM", id=277, x=1168.975, y=-457.241, z=66.641},
	{name="ATM", id=277, x=1153.884, y=-326.540, z=69.245},
	{name="ATM", id=277, x=381.2827, y=323.2518, z=103.270},
	{name="ATM", id=277, x=236.4638, y=217.4718, z=106.840},
	{name="ATM", id=277, x=265.0043, y=212.1717, z=106.780},
	{name="ATM", id=277, x=285.2029, y=143.5690, z=104.970},
	{name="ATM", id=277, x=157.7698, y=233.5450, z=106.450},
	{name="ATM", id=277, x=-164.568, y=233.5066, z=94.919},
	{name="ATM", id=277, x=-1827.04, y=785.5159, z=138.020},
	{name="ATM", id=277, x=-1409.39, y=-99.2603, z=52.473},
	{name="ATM", id=277, x=-1205.35, y=-325.579, z=37.870},
	{name="ATM", id=277, x=-1215.64, y=-332.231, z=37.881},
	{name="ATM", id=277, x=-2072.41, y=-316.959, z=13.345},
	{name="ATM", id=277, x=-2975.72, y=379.7737, z=14.992},
	{name="ATM", id=277, x=-2962.60, y=482.1914, z=15.762},
	{name="ATM", id=277, x=-2955.70, y=488.7218, z=15.486},
	{name="ATM", id=277, x=-3044.22, y=595.2429, z=7.595},
	{name="ATM", id=277, x=-3144.13, y=1127.415, z=20.868},
	{name="ATM", id=277, x=-3241.10, y=996.6881, z=12.500},
	{name="ATM", id=277, x=-3241.11, y=1009.152, z=12.877},
	{name="ATM", id=277, x=-1305.40, y=-706.240, z=25.352},
	{name="ATM", id=277, x=-538.225, y=-854.423, z=29.234},
	{name="ATM", id=277, x=-711.156, y=-818.958, z=23.768},
	{name="ATM", id=277, x=-717.614, y=-915.880, z=19.268},
	{name="ATM", id=277, x=-526.566, y=-1222.90, z=18.434},
	{name="ATM", id=277, x=-256.831, y=-719.646, z=33.444},
	{name="ATM", id=277, x=-203.548, y=-861.588, z=30.205},
	{name="ATM", id=277, x=112.4102, y=-776.162, z=31.427},
	{name="ATM", id=277, x=112.9290, y=-818.710, z=31.386},
	{name="ATM", id=277, x=119.9000, y=-883.826, z=31.191},
	{name="ATM", id=277, x=149.4551, y=-1038.95, z=29.366},
	{name="ATM", id=277, x=-846.304, y=-340.402, z=38.687},
	{name="ATM", id=277, x=-1204.35, y=-324.391, z=37.877},
	{name="ATM", id=277, x=-1216.27, y=-331.461, z=37.773},
	{name="ATM", id=277, x=-56.1935, y=-1752.53, z=29.452},
	{name="ATM", id=277, x=-261.692, y=-2012.64, z=30.121},
	{name="ATM", id=277, x=-273.001, y=-2025.60, z=30.197},
	{name="ATM", id=277, x=314.187, y=-278.621, z=54.170},
	{name="ATM", id=277, x=-351.534, y=-49.529, z=49.042},
	{name="ATM", id=277, x=24.589, y=-946.056, z=29.357},
	{name="ATM", id=277, x=-254.112, y=-692.483, z=33.616},
	{name="ATM", id=277, x=-1570.197, y=-546.651, z=34.955},
	{name="ATM", id=277, x=-1415.909, y=-211.825, z=46.500},
	{name="ATM", id=277, x=-1430.112, y=-211.014, z=46.500},
	{name="ATM", id=277, x=33.232, y=-1347.849, z=29.497},
	{name="ATM", id=277, x=129.216, y=-1292.347, z=29.269},
	{name="ATM", id=277, x=287.645, y=-1282.646, z=29.659},
	{name="ATM", id=277, x=289.012, y=-1256.545, z=29.440},
	{name="ATM", id=277, x=295.839, y=-895.640, z=29.217},
	{name="ATM", id=277, x=1686.753, y=4815.809, z=42.008},
	{name="ATM", id=277, x=-302.408, y=-829.945, z=32.417},
	{name="ATM", id=277, x=5.134, y=-919.949, z=29.557},
	{name="ATM", id=277, x=-1132.024, y=-1704.055, z=3.44},
	{name="ATM", id=277, x=-572.796, y=-397.908, z=33.9},
	{name="ATM", id=277, x=293.89, y = -597.78, z = 43.29},

}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(2000)
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if playerNearBank() or playerNearATM() then
            DisplayHelpText("<FONT FACE='Montserrat'>Nhấn ~g~[E]~s~ để mở.")
            if IsControlJustPressed(0, 38) then
                openPlayersBank('bank')
                local ped = GetPlayerPed(-1)
            end
        end
        if IsControlJustPressed(0, 322) then
            inMenu = false
            SetNuiFocus(false, false)
            SendNUIMessage({type = 'close'})
        end
    end
end)


function openPlayersBank(type, color)
    local dict = 'anim@amb@prop_human_atm@interior@male@enter'
    local anim = 'enter'
    local ped = GetPlayerPed(-1)
    local time = 2500

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    TriggerEvent("mythic_progbar:client:progress", {
						 
        name = "unique_action_name",
        duration = time,
        label = "Đang quét thẻ...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
            disableCombat = true,
            },
                        
         }, function(status)
            if not status then
            -- Do Something If Event Wasn't Cancelled
            end
    end)
    Citizen.Wait(time)
    TriggerEvent("pNotify:SendNotification",  {
        text =  "Wellcome",
        type = "info",
        timeout = 3500,
        layout = "topRight",
        -- sounds = {
        --     volume = 0.8,
        --     conditions = {"docVisible"},
        --     sources = {"wel.wav"}
        -- }
    })
    ClearPedTasks(ped)
    SetTimecycleModifier('hud_def_blur')
    if type == 'bank' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('Pk:bank:balance')
        atATM = false
    elseif type == 'atm' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('Pk:bank:balance')
        atATM = true
    end
end

function playerNearATM() -- Check if a player is near ATM when they use command /atm
	local playerloc = GetEntityCoords(GetPlayerPed(-1), 0)
	
	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 2 then
			return true
		end
	end
end

function playerNearBank() -- Checks if a player is near a bank
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for _, search in pairs(bankLocations) do
        local dist = GetDistanceBetweenCoords(search.x, search.y, search.z, pos.x, pos.y, pos.z, true)

        if dist <= 1.0 then
            color = "green"
            return true
        end
    end
end

local blipsLoaded = false

Citizen.CreateThread(function() -- Add bank blips
    while true do
        Citizen.Wait(20000)
        if not blipsLoaded then
            for k, v in ipairs(bankLocations) do
                local blip = AddBlipForCoord(v.x, v.y, v.z)
		        SetBlipSprite(blip, v.id)
		        SetBlipScale(blip, 0.7)
		        SetBlipAsShortRange(blip, true)
		        BeginTextCommandSetBlipName("STRING")
		        AddTextComponentString(tostring(v.name))
		        EndTextCommandSetBlipName(blip)
            end
            blipsLoaded = true
        end
    end
end)

RegisterNetEvent('Pk:bank:info')
AddEventHandler('Pk:bank:info', function(balance)
    local playerName = GetPlayerName(PlayerId())

    SendNUIMessage({
		type = "updateBalance",
		balance = balance,
        player = playerName,
		})
end)

RegisterNUICallback('deposit', function(data)
    if not atATM then
        TriggerServerEvent('Pk:bank:deposit', tonumber(data.amount))
        TriggerServerEvent('Pk:bank:balance')
    else
        TriggerEvent("pNotify:SendNotification",  {
            text =  "<FONT FACE='Montserrat'>Bạn không thể gửi tiền vào ngân hàng.",
            type = "info",
            timeout = 3500,
            layout = "topRight",
        })
    end
end)

RegisterNUICallback('withdrawl', function(data)
    TriggerServerEvent('Pk:bank:withdraw', tonumber(data.amountw))
    TriggerServerEvent('Pk:bank:balance')
end)

RegisterNUICallback('balance', function()
    TriggerServerEvent('Pk:bank:balance')
end)

RegisterNetEvent('Pk:balance:back')
AddEventHandler('Pk:balance:back', function(balance)
    SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

function closePlayersBank()
    local dict = 'anim@amb@prop_human_atm@interior@male@exit'
    local anim = 'exit'
    local ped = GetPlayerPed(-1)
    local time = 1800

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    TriggerEvent("mythic_progbar:client:progress", {
						 
        name = "unique_action_name",
        duration = time,
        label = "Lấy lại thẻ...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
            disableCombat = true,
        },
                        
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
    Citizen.Wait(time)
    TriggerEvent("pNotify:SendNotification",  {
        text =  "<FONT FACE='Montserrat'>Cảm ơn bạn đã sử dụng dịch vụ.",
        type = "info",
        timeout = 3500,
        layout = "topRight",
        -- sounds = {
        --     volume = 0.8,
        --     conditions = {"docVisible"},
        --     sources = {"thx.wav"}
        -- }
    })
    ClearPedTasks(ped)
    SetTimecycleModifier('default')
    inMenu = false
end

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent('Pk:bank:transfer', data.to, data.amountt)
    TriggerServerEvent('Pk:bank:balance')
end)

RegisterNetEvent('Pk:bank:notify')
AddEventHandler('Pk:bank:notify', function(type, message)
    exports['mythic_notify']:DoHudText(type, message)
end)

AddEventHandler('onResourceStop', function(resource)
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('NUIFocusOff', function()
    closePlayersBank()
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
