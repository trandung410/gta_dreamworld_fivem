local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 8
local displayIDHeight = 1 --Height of ID above players head(starts at center body mass)
local displayJobHeight = 1.15
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
local idVisable = true
local connectedPlayerss = {}
local test = 95
local wantedCount = 0
local isWanted = false
local timeWanted = 20
ESX = nil

RegisterFontFile("out")
fontId = RegisterFontId('Montserrat')

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
    end
    Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
        --UpdatePlayerTable(connectedPlayers)
        connectedPlayerss = connectedPlayers
		local dumped = ESX.DumpTable(connectedPlayers)
		print(dumped)
		--print(connectedPlayers[test].job2)
	end)
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	connectedPlayerss = connectedPlayers
end)

function DrawText3D(x,y,z, text, name) 
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
        AddTextComponentString("["..job.."] ")
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

checkMask = {}

Citizen.CreateThread(function()
	-- if not HasStreamedTextureDictLoaded("logo") then
	-- 	RequestStreamedTextureDict("logo", true)
	-- 	while not HasStreamedTextureDictLoaded("logo") do
	-- 		Wait(1)
	-- 		print("not load")
	-- 	end
	-- end
	-- Citizen.Wait(10000)
    while true do
		--DrawMarker(9, 215.61, -815.81, 30.57, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, true, 2, false, "h2r", "ghl", false)
        -- for i=0,255 do
        --     N_0x31698aa80e0223f8(i)
        -- end
        for _, id in ipairs(GetActivePlayers()) do
			ped = GetPlayerPed( id )
            if  ((NetworkIsPlayerActive( id )) and ped ~= GetPlayerPed( -1 )) then
                blip = GetBlipFromEntity( ped ) 
				serverId = tonumber(GetPlayerServerId(id))
				--print(connectedPlayers[serverId].job2)
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( ped, true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					if checkMask[id] == 0 then
						if NetworkIsPlayerTalking(id) then
							red = 1
							green = 1
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
							if connectedPlayerss[GetPlayerServerId(id)].job == 'police' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
							elseif connectedPlayerss[GetPlayerServerId(id)].job == 'ambulance' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
							elseif connectedPlayerss[GetPlayerServerId(id)].job == 'mechanic' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
							end
						else
							red = 255
							green = 255
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
							if connectedPlayerss[GetPlayerServerId(id)].job == 'police' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
							elseif connectedPlayerss[GetPlayerServerId(id)].job == 'ambulance' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
							elseif connectedPlayerss[GetPlayerServerId(id)].job == 'mechanic' then
								DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
							end
						end
					end
                end

                if ((distance < playerNamesDist)) then
					if not (ignorePlayerNameDistance) then
						if checkMask[id] == 0 then
							if NetworkIsPlayerTalking(id) then
								red = 1
								green = 1
								blue = 255
								DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
								if connectedPlayerss[GetPlayerServerId(id)].job == 'police' then
									DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
								elseif connectedPlayerss[GetPlayerServerId(id)].job == 'ambulance' then
									DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
								elseif connectedPlayerss[GetPlayerServerId(id)].job == 'mechanic' then
									DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
								end
							else
								red = 255
								green = 255
								blue = 255
								DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
								if connectedPlayerss[GetPlayerServerId(id)].job == 'police' then
									DrawJob3D(x2,y2,z2 + displayJobHeight,"L.S.P.D",1,1,255)
								elseif connectedPlayerss[GetPlayerServerId(id)].job == 'ambulance' then
									DrawJob3D(x2,y2,z2 + displayJobHeight,"E.M.S",255, 0, 102)
								elseif connectedPlayerss[GetPlayerServerId(id)].job == 'mechanic' then
									DrawJob3D(x2,y2,z2 + displayJobHeight,"M.E.C",255, 51, 0)
								end
							end
						end
					end
                end
            end  
        end
        Citizen.Wait(0)
    end
end)   

Citizen.CreateThread(function()
    while true do
		for _, id in ipairs(GetActivePlayers()) do
            if GetPlayerPed(id) ~= GetPlayerPed(-1) then
				checkMask[id] = GetPedDrawableVariation(GetPlayerPed(id), 1)
           end
        end
        Citizen.Wait(1000)
    end
end) 
-- AddEventHandler("gameEventTriggered", function(name, args)
-- 	-- exports['mythic_notify']:DoLongHudText('error',name)
--    if name == "CEventNetworkVehicleUndrivable" then
--   -- --exports['mythic_notify']:DoLongHudText('error','Đã hoạt động')
--      local entity, destoyer, weapon = table.unpack(args)
-- 	-- local serverid = dump(args)
-- 	-- exports['mythic_notify']:DoLongHudText('error',entity.." "..serverid.." "..weapon)
-- 	 SetEntityAsMissionEntity(entity, false, false)
-- 	 DeleteEntity(entity)
--      print( entity, destoyer, weapon)
--     -- -- etc
--    end
--  end)
 