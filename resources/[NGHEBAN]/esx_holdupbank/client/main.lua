local holdingUp = false
local store = ""
local blipRobbery = nil
local teamrob = 0
local inteam = false
local robstart = 0
local RobPositon = 0
local storePos, registerholdup, kstore = 0, false, nil

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	while PlayerData.job == nil do
		PlayerData = ESX.GetPlayerData()

		Citizen.Wait(10)
	end

end)
RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData["job"] = job
end)
function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName("<FONT FACE='Montserrat'>"..text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_holdupbank:currentlyRobbing')
AddEventHandler('esx_holdupbank:currentlyRobbing', function(currentStore)
	holdingUp = true
end)

RegisterNetEvent('esx_holdupbank:killBlip')
AddEventHandler('esx_holdupbank:killBlip', function()
	registerholdup = false
	RemoveBlip(blipRobbery)
	ClearPedTasks(GetPlayerPed( -1))
	--Citizen.Wait(5 * 60 * 1000)
	--RemoveBlip(blip)
	robstart = 0
	teamrob = 0
	RobPositon = 0
end)
RegisterNetEvent('esx_holdupbank:setBlip')
AddEventHandler('esx_holdupbank:setBlip', function(position)
	RobPositon = position
	robstart = 1


	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 2.0)
	SetBlipColour(blipRobbery, 3)

	PulseBlip(blipRobbery)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if RobPositon ~= 0 then
			local playerPos = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z, true)
			if distance < 150 then
				if not inteam then
					local playerPos = GetEntityCoords(GetPlayerPed( -1), true)
					local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, RobPositon.x, RobPositon.y, RobPositon.z)
					if IsPedArmed(PlayerPedId(), 4)  then
						if robstart == 1 then
							if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance'  then
								ESX.ShowNotification('~y~Bạn không trong team cướp nên không thể cầm súng')		
								SetCurrentPedWeapon(GetPlayerPed( -1),GetHashKey("WEAPON_UNARMED"),true)
							end																							
						end
					end					
				end
			else
				if inteam then 
					inteam = false
					TriggerServerEvent('esx_holdupbank:removeteamrob')
					ESX.ShowNotification('Bạn đã rời khỏi nhóm cướp vì đi ra khỏi vùng cấm')		
				end
			end
		else
			Wait(1000)
		end
	end
end)

RegisterNetEvent('esx_holdupbank:tooFar')
AddEventHandler('esx_holdupbank:tooFar', function()
	holdingUp = false
	ESX.ShowNotification(_U('robbery_cancelled'))
end)

RegisterNetEvent('esx_holdupbank:robberyComplete')
AddEventHandler('esx_holdupbank:robberyComplete', function(award)
	holdingUp = false
	ESX.ShowNotification(_U('robbery_complete', award))
end)

RegisterNetEvent('esx_holdupbank:startTimer')
AddEventHandler('esx_holdupbank:startTimer', function()
	local timer = Config.TimeRob

	Citizen.CreateThread(function()
		while timer > 0 and holdingUp do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while holdingUp do
			Citizen.Wait(0)
			--print(holdingUp)
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)
		end
	end)
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.Position) do
		local blip1 = AddBlipForRadius(v.x, v.y, v.z , 150.0) -- you can use a higher number for a bigger zone
		SetBlipDisplay(blip1, 3)
		SetBlipHighDetail(blip1, true)
		SetBlipColour(blip1, 1)
		SetBlipAlpha (blip1, 128)
	
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 156)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)
 
RegisterNetEvent('esx_holdupbank:checkteamrob')
AddEventHandler('esx_holdupbank:checkteamrob', function(count)
	teamrob = count 

end)

RegisterNetEvent('esx_holdupbank:removeall')
AddEventHandler('esx_holdupbank:removeall', function()
	teamrob = 0 
	inteam = false
	TriggerServerEvent('esx_holdupbank:removeall_sv')

end)

RegisterNetEvent('esx_holdupbank:SetCoordRob')
AddEventHandler('esx_holdupbank:SetCoordRob', function(coords, reg)
	storePos = coords
	registerholdup = reg
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not registerholdup and not holdingUp then
			local playerPos = GetEntityCoords(PlayerPedId(), true)

			for k,storePosi in pairs(Config.Position) do
				local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, storePosi.x, storePosi.y, storePosi.z, true)
			
				if distance < 5 then 
					DisplayHelpText(storePosi.x, storePosi.y, storePosi.z + 0.1, 'Nhấn ~g~[F]~w~ để đăng kí vào nhóm cướp')
					DrawMarker(Config.Marker.Type, storePosi.x, storePosi.y, storePosi.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)

					if IsControlJustReleased(0, 23) then
						TriggerServerEvent('esx_holdupbank:SendCoordRob', playerPos, true)
					end
				end
			end
		else
			Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if storePos ~= 0 and registerholdup then
			local playerPos = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z, true)
			if distance < Config.Marker.DrawDistance then
				if not holdingUp and robstart == 0 then
					if distance < 5 then
						DrawMarker(Config.Marker.Type, storePos.x, storePos.y, storePos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)
						
						if distance < 0.5 then
							
							DisplayText(0.5, 0.86 , 'Nhấn ~g~[F]~w~ để hủy nhóm cướp')
							DisplayText(0.5, 0.89 , 'Nhấn ~g~[G]~w~ để vào nhóm cướp')
							DisplayText(0.5, 0.92, '~r~Nhấn ~g~[X]~r~ rời nhóm cướp')
							DisplayText(0.5, 0.95, 'Nhấn ~g~[E]~s~ để bắt đầu ~r~cướp')
							if IsControlJustReleased(0, 47) then -- key G
								if not inteam then										
									TriggerServerEvent('esx_holdupbank:addteamrob')
									inteam = true
								else
									ESX.ShowNotification('Bạn đang trong team cướp')
								end							
							elseif IsControlJustReleased(0, 73) then 
								if inteam then
									TriggerServerEvent('esx_holdupbank:removeteamrob')
									inteam = false						
								else
									ESX.ShowNotification('Bạn không có trong team cướp')
								end
							elseif IsControlJustReleased(0, 23) then 
								TriggerServerEvent('esx_holdupbank:SendCoordRob', 0, false)
							end					
							if IsControlJustReleased(0, 38) then
								if IsPedArmed(PlayerPedId(), 4) then
									if inteam then
										-- TaskStartScenarioInPlace(GetPlayerPed( -1), 'world_human_const_drill', 0, false)
										TriggerServerEvent('esx_holdupbank:robberyStarted', storePos)
									else
										ESX.ShowNotification('Bạn không có trong team cướp')
									end
								else
									ESX.ShowNotification(_U('no_threat'))
								end
							end	
						end
					end
				end
			end				
		else
			Wait(1000)
		end
	 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if holdingUp then
				local playerPos = GetEntityCoords(PlayerPedId())
				local distancerb = GetDistanceBetweenCoords(playerPos, storePos, true)
				if (distancerb > Config.MaxDistance) then
					TriggerServerEvent('esx_holdupbank:tooFar_sv', storePos .. distancerb)
				end	
			
			end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inteam then 
			if holdingUp then 
				-- DisableAllControlActions(2)
				DisplayText(0.5, 0.0, 'Số người còn sống: ~b~' .. teamrob .. '~s~ người')
				if IsEntityDead(GetPlayerPed(-1)) then
					TriggerServerEvent('esx_holdupbank:tooFar_sv', '')
				end
			else
				DisplayText(0.5, 0.0, 'Số người trong nhóm: ~b~' .. teamrob .. '~s~ người')
			end
		else
			Wait(1000)
		end
	end
end)

function DisplayText(x, y, text)
	SetTextScale(0.4, 0.4)
	SetTextFont(ESX.FontId)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextOutline()
	AddTextComponentString(text)
	DrawText(x,y)

end

function DisplayHelpText(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x,y,z)
	if onScreen then
		SetTextScale(0.4, 0.4)
		SetTextFont(ESX.FontId)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		SetTextOutline()
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end