ESX = nil
PlayerData = {}
npc = {}
cooldown = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(5000)
	end

	PlayerData = ESX.GetPlayerData()
	ESX.Streaming.RequestStreamedTextureDict('DIA_CLIFFORD')

	ESX.PlayAnim = function(dict, anim, speed, time, flag)
		ESX.Streaming.RequestAnimDict(dict, function()
			TaskPlayAnim(PlayerPedId(), dict, anim, speed, speed, time, flag, 1, false, false, false)
		end)
	end

	ESX.PlayAnimOnPed = function(ped, dict, anim, speed, time, flag)
		ESX.Streaming.RequestAnimDict(dict, function()
			TaskPlayAnim(ped, dict, anim, speed, speed, time, flag, 1, false, false, false)
		end)
	end

	ESX.Game.MakeEntityFaceEntity = function(entity1, entity2)
		local p1 = GetEntityCoords(entity1, true)
		local p2 = GetEntityCoords(entity2, true)
	
		local dx = p2.x - p1.x
		local dy = p2.y - p1.y
	
		local heading = GetHeadingFromVector_2d(dx, dy)
		SetEntityHeading( entity1, heading )
	end
end)

next_ped = function(drugToSell)
	--for k,v in pairs(Config.Clients) do
	if cooldown then
		ESX.ShowNotification(_U('alreadyhave'))
		
		return
	end

	cooldown = true

	

	if npc ~= nil and npc.ped ~= nil then
		SetPedAsNoLongerNeeded(npc.ped)
	end



	Wait(500)


	local v = Config.Clients[math.random(1, #Config.Clients)]--name it like you want

	if not IsPedInAnyVehicle(PlayerPedId(), true) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
	end
--	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
	ESX.ShowNotification(_U('findingclient'))
	Wait(5000)
	npc.hash = GetHashKey(Config.pedlist[math.random(1, #Config.pedlist)])
	ESX.Streaming.RequestModel(npc.hash)
	npc.coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 200.0, 5.0)

	retval, npc.z = GetGroundZFor_3dCoord(v.x, v.y, v.z, 0)
	local v = Config.Clients[math.random(1, #Config.Clients)]--name it like you want


	npc.zone = GetLabelText(GetNameOfZone(npc.coords))
	drugToSell.zone = npc.zone

--	npc.ped = CreatePed(5, npc.hash, v.x, v.y, v.z, 0.0, true, true)
	

	PlaceObjectOnGroundProperly(npc.ped)
	SetEntityAsMissionEntity(npc.ped)
	
	if IsEntityDead(npc.ped) or GetEntityCoords(npc.ped) == vector3(0.0, 0.0, 0.0) then
	--	ESX.ShowNotification(_U('notfound'))
	--	npc.ped = CreatePed(5, npc.hash, v.x, v.y, v.z, 0.0, true, true)
	end
	ESX.ShowNotification(_U('GPS'))
	ClearPedTasks(PlayerPedId())
	SetNewWaypoint(v.x, v.y)
	CreateThread(function()
		canSell = true
	bruh = true
		while bruh do
			Wait(0)
		--	npc.coords = GetEntityCoords(npc.ped)
			distance = Vdist2(GetEntityCoords(PlayerPedId()), npc.coords)
			--if distance < 30.0 then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, playerCoords, true)
			if dist <= 50 then
				if DoesEntityExist(npc.ped) then
				--if DoesEntityExist(npc.ped) then
			DrawText3Ds(v.x, v.y, v.z + 0.4, _U('client'))
			
			else 
				npc.ped = CreatePed(5, npc.hash, v.x, v.y, v.z, 0.0, true, true)
			end
		end
		if dist <= 5 then
			FreezeEntityPosition(npc.ped, true)
		end
			if dist < 2.0 then
				DrawText3Ds(v.x, v.y, v.z + 0.0, _U('sell'))
			--	ESX.ShowHelpNotification(Config.notify.press)
				if IsControlJustPressed(0, 38) and canSell then
							ESX.UI.Menu.Open(
								'default', GetCurrentResourceName(), 'sell',
								{
									  title    = _U("Clientoffer")..drugToSell.price..  " USD" .._U("for").. ""  ..drugToSell.count.."x " ..drugToSell.label.."",
									  align    = 'top-left',
									  elements = {
													{label = _U('Sell'), value = 'sell'},
													{label = _U('CancelSell'), value = 'cancel'},
												  }
												},
													function(data, menu)
												if data.current.value == 'sell' then
													sell()
													menu.close()
												end
												if data.current.value == 'cancel' then
													cancel()
													menu.close()
												end
											end,
									  function(data, menu)
									menu.close()
			 					 end
								)
					canSell = false
					reject = math.random(1, 10)
                   function cancel()
				
					--if reject <= 3 then
						ESX.ShowNotification(_U('Declined'))
						PlayAmbientSpeech1(npc.ped, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
						drugToSell.coords = GetEntityCoords(PlayerPedId())
						FreezeEntityPosition(npc.ped, false)
					--	SetPedAsNoLongerNeeded(npc.ped)
						
						npc = {}
						return
					end

				
					function sell()
					ESX.Game.MakeEntityFaceEntity(PlayerPedId(), npc.ped)
					ESX.Game.MakeEntityFaceEntity(npc.ped, PlayerPedId())
					
					PlayAmbientSpeech1(npc.ped, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
					obj = CreateObject(GetHashKey('prop_weed_bottle'), 0, 0, 0, true)
					AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
					obj2 = CreateObject(GetHashKey('hei_prop_heist_cash_pile'), 0, 0, 0, true)
					AttachEntityToEntity(obj2, npc.ped, GetPedBoneIndex(npc.ped,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
					ESX.PlayAnim('mp_common', 'givetake1_a', 8.0, -1, 0)
					ESX.PlayAnimOnPed(npc.ped, 'mp_common', 'givetake1_a', 8.0, -1, 0)
					Wait(1000)
					AttachEntityToEntity(obj2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
					AttachEntityToEntity(obj, npc.ped, GetPedBoneIndex(npc.ped,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
					Wait(1000)
					DeleteEntity(obj)
					DeleteEntity(obj2)
					PlayAmbientSpeech1(npc.ped, 'GENERIC_THANKS', 'SPEECH_PARAMS_STANDARD')
					FreezeEntityPosition(npc.ped, false)
					SetPedAsNoLongerNeeded(npc.ped)
					TriggerServerEvent('drc_drugsystem:pay', drugToSell)
					ESX.ShowNotification(_U("sold"):format(drugToSell.count, drugToSell.label, drugToSell.price))
				--	ESX.ShowAdvancedNotification(Config.notify.title, '', (Config.notify.sold):format(drugToSell.count, drugToSell.label, drugToSell.price), 'DIA_CLIFFORD', 1)
					npc = {}
				end
			end
		end
		end
--	end
	end)
--end
--end
end

CreateThread(function()
	while true do
		Wait(20000)
		if cooldown then
			cooldown = false
		end
	end
end)

RegisterNetEvent('drc_drugsystem:findClient')
AddEventHandler('drc_drugsystem:findClient', next_ped)



Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
if IsControlJustReleased(1, 168) then --F7
local h = GetClockHours()
if h > 19 then
	ESX.ShowNotification('je tma')
else 
	ESX.ShowNotification('není tma')
end
end
end
end)
