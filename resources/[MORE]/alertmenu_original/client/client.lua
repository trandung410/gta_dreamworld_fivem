ESX          = nil
local PlayerData = nil;
local menuIsOpen = false
local Auth = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    
    PlayerData = ESX.GetPlayerData()
    while PlayerData.job == nil do
        PlayerData = ESX.GetPlayerData()
        Wait(1)
    end
end)

RegisterNetEvent('AlertMenu:Refresh')
AddEventHandler('AlertMenu:Refresh', function()
    refreshmenutask()
end)

RegisterNetEvent('AlertMenu:Notification')
AddEventHandler('AlertMenu:Notification', function(type,name)
    if type == 'mechanic' or type == 'taxi' then
        if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'taxi' then
            ESX.ShowNotification(_U('New_Alert',name))
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
            Citizen.Wait(500)
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
            Citizen.Wait(500)
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        end
    else
        if PlayerData.job.name == type then
            ESX.ShowNotification(_U('New_Alert',name))
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
            Citizen.Wait(500)
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
            Citizen.Wait(500)
            PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        end
    end
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    Wait(1000)
	while true do
        Citizen.Wait(1)
        
        if Citizen.InvokeNative(0x580417101DDB492F, 0, Config.KeyOpenMenu, Citizen.ReturnResultAnyway()) then
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'taxi' then
                openmenutask(1)
            else
                openmenutask(0)
            end
        end
	end
end)

function OpenMenuUi(job)
    SetNuiFocus(true, true)
    local data ={
        action = 'open', 
        type = 'main',
        enermy = job,
        form ='none'
    }
	SendNuiMessage(json.encode(data))
end

function closemenu ()
	menuIsOpen = false
    SetNuiFocus(false)
    local data ={
        action = 'close', 
        form ='none'
    }
	SendNuiMessage(json.encode(data))
end

function openmenutask(enermy)
	ESX.TriggerServerCallback('AlertMenu:GetAlert', function(alertcb)
		menuIsOpen = true
		SetNuiFocus(true, true)
		local data = {}
		for i = 1, #alertcb, 1 do
			local mycoords = GetEntityCoords(GetPlayerPed( -1))
			local coords = vector3(alertcb[i].x, alertcb[i].y, alertcb[i].z)
			local distance1 = math.floor(GetDistanceBetweenCoords(coords, mycoords, true))
			alertcb[i]['distance'] = distance1
			alertcb[i]['coords'] = json.encode({x= alertcb[i].x,y= alertcb[i].y, z=alertcb[i].z})
			if alertcb[i].recivedid == GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed( -1))) then
				alertcb[i]['mytask'] = 1
			else
				alertcb[i]['mytask'] = 0
			end
		end
        if #alertcb ~= 0 then
            data = {
                action = 'open',
                job = PlayerData.job.name,
                enermy = enermy,
                alert = alertcb
            }
        else
            data = {
                action = 'open',
                job = PlayerData.job.name,
                enermy = enermy,
                alert = alertcb
            }
        end
		
		SendNuiMessage(json.encode(data))
	end, PlayerData.job.name)
end


function refreshmenutask()
    if menuIsOpen then
        ESX.TriggerServerCallback('AlertMenu:GetAlert', function(alertcb)
            local data = {}
            for i = 1, #alertcb, 1 do
                local mycoords = GetEntityCoords(GetPlayerPed( -1))
                local coords = vector3(alertcb[i].x, alertcb[i].y, alertcb[i].z)
                local distance1 = math.floor(GetDistanceBetweenCoords(coords, mycoords, true))
                alertcb[i]['distance'] = distance1
                alertcb[i]['coords'] = json.encode({x= alertcb[i].x,y= alertcb[i].y, z=alertcb[i].z})
                if alertcb[i].recivedid == GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed( -1))) then
                    alertcb[i]['mytask'] = 1
                else
                    alertcb[i]['mytask'] = 0
                end
            end

            data = {
                action = 'refresh',
                job = PlayerData.job.name,
                alert = alertcb
            }
            
            SendNuiMessage(json.encode(data))
        end, PlayerData.job.name)
    end
end

RegisterNUICallback('ping', function(data, cb)
	local tab = json.decode(data)
	SetNewWaypoint(tab.x,tab.y,tab.z)
    TriggerServerEvent('AlertMenu:RefreshMenu')
    ESX.ShowNotification(_U('Alert_Set_Coords'))
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
end)

RegisterNUICallback('success', function(data, cb)
	local data = json.decode(data)
	TriggerServerEvent('AlertMenu:DoneTask', data.steamid, data.type)
    ESX.ShowNotification(_U('Alert_Done_Task'))
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

end)

RegisterNUICallback('accept', function(data, cb)
    local data = json.decode(data)
	local coords = json.decode(data.coords)
	SetNewWaypoint(coords.x,coords.y,coords.z)
	ESX.ShowNotification(_U('Alert_Set_Coords'))
    TriggerServerEvent('AlertMenu:AcceptTask', data.steamid, data.type)
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
end)

RegisterNUICallback('cancel', function(data, cb)
	local data = json.decode(data)
	ESX.ShowNotification(_U('Alert_Cancel_Task'))
    TriggerServerEvent('AlertMenu:CancelTask', data.steamid, data.type)
    PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)					

end)

RegisterNUICallback('escape', function(data, cb)
    PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)					
	closemenu()
end)


RegisterNUICallback('OpenMenu', function(data, cb)
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    closemenu()
    Wait(100)
	openmenutask()
end)

RegisterNUICallback('PingAlert', function(data)
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    ESX.TriggerServerCallback('AlertMenu:CheckTask', function(checktask)
        if checktask == true then
            if not IsEntityDead(PlayerPedId()) then
                if data == 'ambulance' then
                    ESX.ShowNotification(_U('No_Dead'))
                else
                    ESX.ShowNotification(_U('Alert_Ping'))
                    TriggerServerEvent('AlertMenu:SendAlert',data, GetEntityCoords(GetPlayerPed( -1)))
                end
            else
                if data == 'ambulance' or data == 'police' then
                    ESX.ShowNotification(_U('Alert_Ping'))
                    TriggerServerEvent('AlertMenu:SendAlert',data, GetEntityCoords(GetPlayerPed( -1)))
                else
                    ESX.ShowNotification(_U('Alert_In_Dead'))
                end
            end
        elseif checktask == 'not_online' then
            ESX.ShowNotification(_U('server_not_available'))
        elseif not checktask then
            ESX.ShowNotification(_U('Alert_Ping_Already'))
        end
    end, data)
end)

RegisterNetEvent('AlertMenu:PingMed')
AddEventHandler('AlertMenu:PingMed', function(data)
    ESX.TriggerServerCallback('AlertMenu:CheckTask', function(checktask)
        if checktask == true then
            if not IsEntityDead(PlayerPedId()) then
                if data == 'ambulance' then
                    ESX.ShowNotification(_U('No_Dead'))
                else
                    ESX.ShowNotification(_U('Alert_Ping'))
                    TriggerServerEvent('AlertMenu:SendAlert',data, GetEntityCoords(GetPlayerPed(-1)))
                end
            else
                if data == 'ambulance' or data == 'police' then
                    ESX.ShowNotification(_U('Alert_Ping'))
                    TriggerServerEvent('AlertMenu:SendAlert',data, GetEntityCoords(GetPlayerPed(-1)))
                else
                    ESX.ShowNotification(_U('Alert_In_Dead'))
                end
            end
        elseif checktask == 'not_online' then
            ESX.ShowNotification(_U('server_not_available'))
        elseif not checktask then
            ESX.ShowNotification(_U('Alert_Ping_Already'))
        end
    end, data)
end)