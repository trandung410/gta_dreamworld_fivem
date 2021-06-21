local playerNamesDist = 8

playerDistances = {}
playerJob = {}
playerJob1 = {}
checkMask = {}
stars = {}
local displayIDHeight = 1 --Height of ID above players head(starts at center body mass)
local ignorePlayerNameDistance = false
local red = 255
local green = 255
local blue = 255
local starsSymbol = nil



RegisterNetEvent('IDsAboveHead:updateJob')
AddEventHandler('IDsAboveHead:updateJob', function(job)
	playerJob1 = job
	--stars = job
	stars = job
	for _, id in ipairs(GetActivePlayers()) do
		if stars[GetPlayerServerId(id)] == nil then
			stars[GetPlayerServerId(id)] = {}
			stars[GetPlayerServerId(id)].stars = job[GetPlayerServerId(id)].stars
			stars[GetPlayerServerId(id)].starsSymbol = job[GetPlayerServerId(id)].starsSymbol
		end
	end
	
end)

RegisterNetEvent('IDsAboveHead:updateStarsHead')
AddEventHandler('IDsAboveHead:updateStarsHead', function(idKiller, totalstars, idPlayer, info)

		if idPlayer == nil and info == nil then
			
				if stars[idKiller] ~= nil then
					local newStars = stars[idKiller].stars + 1
					local starsSymbol = ''

					if newStars == 1 then
						starsSymbol = '⭐'
					elseif newStars == 2 then
						starsSymbol = '⭐⭐'
					elseif newStars == 3 then
						starsSymbol = '⭐⭐⭐'
					elseif newStars == 4 then
						starsSymbol = '⭐⭐⭐⭐'
					elseif newStars >= 5 then
						starsSymbol = '⭐⭐⭐⭐⭐'
					end
			
					stars[idKiller].stars = newStars
					stars[idKiller].starsSymbol = starsSymbol
				end			

		elseif stars[idKiller] ~= nil then
			stars[idKiller].stars = info[idKiller].stars
			stars[idKiller].starsSymbol = info[idKiller].starsSymbol
			
			stars[idPlayer].stars = info[idPlayer].stars
			stars[idPlayer].starsSymbol = info[idPlayer].starsSymbol
		end
		
	TriggerServerEvent('DiscordBot:updateStarsFromHeadsSV', stars)
	TriggerServerEvent('esx_scoreboard:updatestars', stars)
end)

RegisterNetEvent('IDsAboveHead:updateStarsHeadClear')
AddEventHandler('IDsAboveHead:updateStarsHeadClear', function(idKiller)		
					
	stars[idKiller].stars = 0
	stars[idKiller].starsSymbol = ''			
	
	TriggerServerEvent('DiscordBot:updateStarsFromHeadsSV', stars)
	TriggerServerEvent('esx_scoreboard:updatestars', stars)
end)

RegisterNetEvent('IDsAboveHead:ReductionStar')
AddEventHandler('IDsAboveHead:ReductionStar', function(idKiller)		
			
	if stars[idKiller] ~= nil then
		local newStars = stars[idKiller].stars - 1
		local starsSymbol = ''

		if newStars <= 0 then
			newStars = 0
			starsSymbol = ''
		elseif newStars == 1 then
			starsSymbol = '⭐'
		elseif newStars == 2 then
			starsSymbol = '⭐⭐'
		elseif newStars == 3 then
			starsSymbol = '⭐⭐⭐'
		elseif newStars == 4 then
			starsSymbol = '⭐⭐⭐⭐'
		elseif newStars >= 5 then
			starsSymbol = '⭐⭐⭐⭐⭐'
		end
			
		stars[idKiller].stars = newStars
		stars[idKiller].starsSymbol = starsSymbol
	end	
				
	TriggerServerEvent('DiscordBot:updateStarsFromHeadsSV', stars)
	TriggerServerEvent('esx_scoreboard:updatestars', stars)
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(-1) --Gets the local player
        if playerPed and playerPed ~= -1 then -- Checks if the player exists
			if stars[GetPlayerServerId(PlayerId())] ~= nil then
				--TriggerServerEvent('esx_scoreboard:updatestars', stars)
			end
        end
        Citizen.Wait(5000)
    end
end)



RegisterNetEvent('IDsAboveHead:loadStars')
AddEventHandler('IDsAboveHead:loadStars', function(id, _stars)

	if _stars == 0 then
		starsSymbol = ''
	elseif _stars == 1 then
		starsSymbol = '⭐'
	elseif _stars == 2 then
		starsSymbol = '⭐⭐'
	elseif _stars == 3 then
		starsSymbol = '⭐⭐⭐'
	elseif _stars == 4 then
		starsSymbol = '⭐⭐⭐⭐'
	elseif _stars >= 5 then
		starsSymbol = '⭐⭐⭐⭐⭐'
	end
	

	if stars[id] ~= nil then
		stars[id].starsSymbol = starsSymbol
		stars[id].stars = _stars
	else
		stars[id] = {}
		stars[id].starsSymbol = starsSymbol
		stars[id].stars = _stars
		
	end
	
	
end)


Citizen.CreateThread(function()
    Wait(50)
    while true do
		for _, id in ipairs(GetActivePlayers()) do
			----View start----
			x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
			if checkMask[id] == 0 then	
				if (playerDistances[id] < playerNamesDist) then
					if not playerJob1[GetPlayerServerId(id)] then
						if stars[GetPlayerServerId(id)] ~= nil then
							DrawStars3D(x2, y2, z2+1.15, stars[GetPlayerServerId(id)].starsSymbol, 255,255,255)
						end
					else					
						if stars[GetPlayerServerId(id)] ~= nil then
							DrawStars3D(x2, y2, z2+1.15, stars[GetPlayerServerId(id)].starsSymbol, 255,255,255)
						end
					end
				end
			end
			------------------
			ped = GetPlayerPed(id)
            if  ((NetworkIsPlayerActive(id)) and ped ~= GetPlayerPed(-1)) then
                blip = GetBlipFromEntity(ped) 
				serverId = tonumber(GetPlayerServerId(id))
				--print(connectedPlayers[serverId].job2)
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
                x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					if checkMask[id] == 0 then
						if NetworkIsPlayerTalking(id) then
							red = 1
							green = 1
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
						else
							red = 255
							green = 255
							blue = 255
							DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
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
							else
								red = 255
								green = 255
								blue = 255
								DrawText3D(x2, y2, z2 + displayIDHeight, exports.RufiUniqueID:GetUIDfromID(GetPlayerServerId(id)), GetPlayerName(id))
							end
							if isWanted == true then
								DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.01, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.45, 0.45, 0.2, 255, 255, 255, 255,false, true, 2, false, "logo", wantedCount, false)
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
			--if GetPlayerPed(id) ~= GetPlayerPed(-1) then
				checkMask[id] = GetPedDrawableVariation(GetPlayerPed(id), 1)
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				playerDistances[id] = distance
           --end
        end
        Citizen.Wait(1000)
    end
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

function DrawStars3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale*0.7, 0.55*scale*0.7)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
		if text == nil then
			text = ''
		end
        AddTextComponentString('<FONT FACE="Montserrat">'.. text .. '</FONT>')
        DrawText(_x,_y)
    end
end

-- function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha) 
--     local onScreen,_x,_y=World3dToScreen2d(x,y,z)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())
--     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, true)
	
--     if onScreen then
-- 		local width = (1/dist)*width
-- 		local height = (1/dist)*height
-- 		local fov = (1/GetGameplayCamFov())*100
-- 		local width = width*fov
-- 		local height = height*fov
-- 		DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
-- 	end
-- end