local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 10
local displayIDHeight = 1 --Height of ID above players head(starts at center body mass)
local displayJobHeight = 1.15

--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
local idVisable = true
local Players = {}
local test = 95
local screenX, screenY = GetScreenResolution()
local resolution = screenX/screenY
local connectedPlayerss = {}

ESX = nil
RegisterFontFile("out")
fontId = RegisterFontId('Montserrat')

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
    Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
        Players = connectedPlayers
	end)
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	Players = connectedPlayers
end)

-- function CountStar(level)
--     level = tonumber(level)
--     local str = ""
--     for i = 1, level, 1 do
--         str = str .. "⭐"
--     end
--     return str
-- end

function DrawText3D(x,y,z, text, name) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(ESX.FontId)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("["..text.."] "..name)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

-- function DrawStar(rx,ry,rz, star) 
--     local x,y,z = rx,ry,rz+0.2
--     local onScreen,_x,_y=World3dToScreen2d(x,y,z)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())
--     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

--     local scale = (1/dist)*2
--     local fov = (1/GetGameplayCamFov())*100
--     local scale = scale*fov
--     local text = CountStar(star)
--     if onScreen then
--         SetTextScale(0.0*scale, 0.55*scale)
--         SetTextFont(ESX.FontId)
--         SetTextProportional(1)
--         SetTextColour(red, green, blue, 255)
--         SetTextDropshadow(0, 0, 0, 0, 255)
--         SetTextEdge(2, 0, 0, 0, 150)
--         SetTextDropShadow()
--         SetTextOutline()
--         SetTextEntry("STRING")
--         SetTextCentre(1)
--         AddTextComponentString("["..text.."] "..name)
-- 		World3dToScreen2d(x,y,z, 0) --Added Here
--         DrawText(_x,_y)
--     end
-- end

function hasLogo(Id)
	if Players[Id] ~= nil and Players[Id].job2 ~= 'unemployed2' then 
		for k, v  in  ipairs(Config.logo.job2) do 
			if Players[Id].job2 == v.name then 
				return v.logoName 
			end 
		end 
	elseif  Players[Id] ~= nil then
		for k, v  in  ipairs(Config.logo.job) do 
			if Players[Id].job == v.name then 
				return v.logoName 
			end 
		end 
	end 
	return false 
end

Citizen.CreateThread(function()
	if not HasStreamedTextureDictLoaded('star') then
        RequestStreamedTextureDict('star', true)
        while not HasStreamedTextureDictLoaded('star') do
            Wait(1)
        end
	end
	while ESX == nil or not ESX.IsPlayerLoaded() do Wait(1) end
    while true do
        for k, id in ipairs(GetActivePlayers()) do
            if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
				serverId = tonumber(GetPlayerServerId(id))
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					if NetworkIsPlayerTalking(id) then
						red = 0
						green = 0
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), Players[serverId].name)
                        if Players[GetPlayerServerId(id)].job == 'police' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
						elseif Players[GetPlayerServerId(id)].job == 'ambulance' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
						elseif Players[GetPlayerServerId(id)].job == 'mechanic' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
						end
                    else
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), Players[serverId].name)
					end
                end

                if ((distance < playerNamesDist)) and Players[serverId] ~= nil and Players[serverId].name ~= nil and HasEntityClearLosToEntity(PlayerPedId(), ped, 17) then
                    if not (ignorePlayerNameDistance) then
                        if NetworkIsPlayerTalking(id) then
                            red = 0
                            green = 0
                            blue = 255
                            DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), Players[serverId].name)
                            if Players[GetPlayerServerId(id)].job == 'police' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
							elseif Players[GetPlayerServerId(id)].job == 'ambulance' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
							elseif Players[GetPlayerServerId(id)].job == 'mechanic' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
							end
						else
							red = 255
                            green = 255
                            blue = 255
                            DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), Players[serverId].name)
                            if Players[GetPlayerServerId(id)].job == 'police' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
							elseif Players[GetPlayerServerId(id)].job == 'ambulance' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
							elseif Players[GetPlayerServerId(id)].job == 'mechanic' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
							end
						end
                    end
                end  
            end
        end
        Citizen.Wait(0)
    end
end)
 
-- function DrawS(x, y, z, starNum)
--     x, y, z = x, y, z+0.2
--     local onScreen,_x,_y=World3dToScreen2d(x,y,z)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())
--     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
--     local scale = (1/dist)*2
--     local fov = (1/GetGameplayCamFov())*100
--     local scale = scale*fov/35
--     _x = _x - ((starNum/2 ) * 1/45*scale*45)
--     for i = 1, starNum, 1 do 
--         local fixedX = _x + i/45*scale*45
--         DrawSprite("star", "star", fixedX, _y, scale, resolution*scale, 0.0, 255, 255, 255, 255)
--     end
-- end
function DrawJob3D(x,y,z, job,r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(job)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end