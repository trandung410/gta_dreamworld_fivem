local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 10
local displayIDHeight = 1 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
local idVisable = true
local connectedPlayerss = {}
local test = 95
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
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
        SetTextFont(ESX.FontId)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString('<FONT FACE = "Montserrat">['..text..'] '..name)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

function hasLogo(Id)
    local cachelogo = false
    if connectedPlayerss[Id] ~= nil then 
        if connectedPlayerss[Id].job2 ~= 'unemployed2' and connectedPlayerss[Id].job2 ~= 'unemployed' then 
            for k, v  in  ipairs(Config.logo.job2) do 
                if connectedPlayerss[Id].job2 == v.name then 
                    return v.logoName 
                end 
            end 
        else 
            for k, v  in  ipairs(Config.logo.job) do 
                if connectedPlayerss[Id].job == v.name then 
                    return v.logoName 
                end 
            end 
        end 
    end
    return false
end

function getJobTag(Id)
    if connectedPlayerss[Id] ~= nil then 
        if connectedPlayerss[Id].job2 ~= 'unemployed2' and connectedPlayerss[Id].job2 ~= 'unemployed' then 
            for k, v  in  ipairs(Config.logo.job2) do 
                if connectedPlayerss[Id].job2 == v.name then 
                    return ""..string.upper(v.tag).." | "
                end 
            end 
        else 
            for k, v  in  ipairs(Config.logo.job) do 
                if connectedPlayerss[Id].job == v.name then 
                    return ""..string.upper(v.tag).." | "
                end 
            end 
        end 
        return "" 
    else
        return "" 
    end
end

Citizen.CreateThread(function()
	if not HasStreamedTextureDictLoaded(Config.dic) then
        RequestStreamedTextureDict(Config.dic, true)
        while not HasStreamedTextureDictLoaded(Config.dic) do
            Wait(1)
            print("not load")
        end
	end
	Citizen.Wait(4000)
	print(ESX.DumpTable(Config.logo))
    while true do
		--DrawMarker(9, 215.61, -815.81, 30.57, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, true, 2, false, Config.dic, logoName, false)
		-- for k, v in ipairs(GetActivePlayers()) do
			-- N_0x31698aa80e0223f8(v)
		-- end
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
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), connectedPlayerss[serverId].name)
					else
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), connectedPlayerss[serverId].name)
					end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) and connectedPlayerss[serverId] ~= nil then
                        local logoName = hasLogo(serverId)
						--print(logoName)
                        if NetworkIsPlayerTalking(id) then
                            if logoName ~= false then                                 
                                DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 255,false, true, 2, false, Config.dic, logoName, false)                               
                                red = 255
                                green = 87
                                blue = 51
                                DrawText3D(x2, y2, z2 + displayIDHeight, serverId, getJobTag(serverId)..connectedPlayerss[serverId].name)
                            else
                                red = 255
                                green = 87
                                blue = 51
                                DrawText3D(x2, y2, z2 + displayIDHeight, serverId,getJobTag(serverId)..connectedPlayerss[serverId].name)
                            end
						else
							if logoName ~= false then    
                                DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 255,false, true, 2, false, Config.dic, logoName, false)
                                red = 0
								green = 255
								blue = 0
                                DrawText3D(x2, y2, z2 + displayIDHeight, serverId, getJobTag(serverId)..connectedPlayerss[serverId].name)
                            else
                                red = 0
								green = 255
								blue = 0
                                DrawText3D(x2, y2, z2 + displayIDHeight, serverId, getJobTag(serverId)..connectedPlayerss[serverId].name)
                            end
							
							--DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), "a")
						end
                    end
                end  
            end
        end
        Citizen.Wait(0)
    end
end)
AddEventHandler("gameEventTriggered", function(name, args)
	-- exports['mythic_notify']:DoLongHudText('error',name)
   if name == "CEventNetworkVehicleUndrivable" then
  -- --exports['mythic_notify']:DoLongHudText('error','Đã hoạt động')
     local entity, destoyer, weapon = table.unpack(args)
	-- local serverid = dump(args)
	-- exports['mythic_notify']:DoLongHudText('error',entity.." "..serverid.." "..weapon)
	 SetEntityAsMissionEntity(entity, false, false)
	 DeleteEntity(entity)
     print( entity, destoyer, weapon)
    -- -- etc
   end
 end)
 