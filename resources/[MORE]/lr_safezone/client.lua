ESX = nil
PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    if ESX.IsPlayerLoaded() then 
        PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsPedArmed(ped, 6) then
       		DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			if IsPedInAnyVehicle(ped, true) then
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"),true)
			end
		else
			Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
	for k,v in pairs(Config.Blips) do
		local blip = AddBlipForRadius(v.x, v.y, v.z, v.Size)
	
		SetBlipColour(blip, v.Color)
		SetBlipAlpha(blip, v.Alpha)
	end
end)

for k, v in pairs(Config.Blips) do
    Citizen.CreateThread(function ()
        while true do
            Citizen.Wait(1000)
            local player = PlayerPedId()
            local dist = GetDistanceBetweenCoords(GetEntityCoords(player), vector3(v.x,v.y,v.z), true)
            if dist <= v.Size then
                if not v.notifIn then
                    SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
                    TriggerEvent("pNotify:SendNotification",{
                        text = Config.ShowNotifyInSafeZone,
                        type = "success",
                        timeout = 3000,
                        layout = "bottomcenter",
                        queue = "global"
                    })
                    v.notifIn = true
                    v.notifOut = false
                    Citizen.CreateThread(function ()
                        while v.notifIn do
                            Citizen.Wait(5)
                            DrawText3D(Config.PositionX, Config.PositionY, 1.0,1.0,0.55,"Khu vực ~r~:~g~ An toàn", 255,255,255,255)
                            if PlayerData.job.name ~= "police" then
                                DisableControlAction(2, 37, true)
                                DisablePlayerFiring(player,true)
                                DisableControlAction(0, 106, true)
                                DisableControlAction(0, 80, true)
                                DisableControlAction(2, 37, true)
                                DisablePlayerFiring(player,true)
                                DisableControlAction(0, 106, true)
                                DisableControlAction(0, 140, true)
                                IsDisabledControlJustPressed(2, 37)
                                IsDisabledControlJustPressed(0, 106)
                                IsDisabledControlJustPressed(0, 140)
                                IsDisabledControlJustPressed(0, 45)
                                IsDisabledControlJustPressed(0, 80)
                                if IsDisabledControlJustPressed(2, 37) or IsDisabledControlJustPressed(0, 106) or IsDisabledControlJustPressed(0, 140) or IsDisabledControlJustPressed(2, 141) then --if Tab is pressed, send error message
                                    SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
                                end
                            end
                        end
                    end)
                end
            else
                if not v.notifOut then
                    NetworkSetFriendlyFireOption(true)
                    TriggerEvent("pNotify:SendNotification",{
                        text = Config.ShowNotifyOutSafeZone,
                        type = "error",
                        timeout = 3000,
                        layout = "bottomcenter",
                        queue = "global"
                    })
                    v.notifOut = true
                    v.notifIn = false
                end
            end    
        end
    end)
end

RegisterFontFile(Config.Font)
fontId = RegisterFontId(Config.Font)

function DrawText3D(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
