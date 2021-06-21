local truck,truck_blip,trailer,trailer_blip
menuactive = false
empresaAtual = nil
job_data = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------	

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	local timer = 1
	while true do
		timer = 3000
		for k,v in pairs(Config.gas_station_locations) do
			local x,y,z = table.unpack(v.coord)
			local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
			if not menuactive and distance <= 20.0 then
				timer = 1
				DrawMarker_blip(x,y,z)
				if distance <= 1.0 then
					DrawText3D2(x,y,z-0.6, Lang[Config.lang]['open'], 0.40)
					if IsControlJustPressed(0,38) then
						empresaAtual = k
						TriggerServerEvent("gas_station:getData",empresaAtual) 
					end
				end
			end

			local x,y,z = table.unpack(v.deliveryman_coord)
			local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
			if distance <= 20.0 then
				timer = 1
				DrawMarker_blip(x,y,z)
				if distance <= 1.0 then
					if job_data[k] == nil then
						DrawText3D2(x,y,z-0.6, Lang[Config.lang]['download_jobs'], 0.40)
						if IsControlJustPressed(0,38) then
							TriggerServerEvent('gas_station:getJob',k)
						end
					else
						DrawText3D2(x,y,z-0.6, Lang[Config.lang]['show_jobs']:format(job_data[k].name,job_data[k].reward), 0.40)
						if IsControlJustPressed(0,38) then
							if truck then
								TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['already_has_job'])
								break
							end
							local x2,y2,z2,h2 = table.unpack(Config.gas_station_locations[k]['truck_coord'])
							local checkPos = IsSpawnPointClear({['x']=x2,['y']=y2,['z']=z2},5.001)
							if checkPos == false then
								TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['occupied_places'])
								break
							end
							local x2,y2,z2,h2 = table.unpack(Config.gas_station_locations[k]['trailer_coord'])
							local checkPos = IsSpawnPointClear({['x']=x2,['y']=y2,['z']=z2},5.001)
							if checkPos == false then
								TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['occupied_places'])
								break
							end
							empresaAtual = k
							TriggerServerEvent('gas_station:startJob',k,job_data[k].id)
						end
					end
				else
					job_data[k] = nil
				end
			end
		end
		Citizen.Wait(timer)
	end
end)

RegisterNetEvent('gas_station:getJob')
AddEventHandler('gas_station:getJob', function(k,data)
	job_data[k] = data
end)

RegisterNetEvent('gas_station:open')
AddEventHandler('gas_station:open', function(dados,update,isMarket)
	-- Abre NUI
	SendNUIMessage({ 
		showmenu = true,
		update = update,
		isMarket = isMarket,
		dados = dados
	})
	if update == false then
		menuactive = true
		SetNuiFocus(true,true)
	end
end)

RegisterNetEvent('gas_station:openRequest')
AddEventHandler('gas_station:openRequest', function(price)
	-- Abre NUI para dar request na compra
	SendNUIMessage({ 
		showmenu = true,
		price = price,
		format = Config.format,
		lang = Config.lang
	})
	SetNuiFocus(true,true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
local cooldown0 = nil
RegisterNUICallback('startJob', function(data, cb)
	if cooldown0 == nil then
		cooldown0 = true

		if truck then
			TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['already_has_job'])
		else
			local x2,y2,z2,h2 = table.unpack(Config.gas_station_locations[empresaAtual]['truck_coord'])
			local checkPos = IsSpawnPointClear({['x']=x2,['y']=y2,['z']=z2},5.001)
			if checkPos == false then
				TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['occupied_places'])
			else
				local x2,y2,z2,h2 = table.unpack(Config.gas_station_locations[empresaAtual]['trailer_coord'])
				local checkPos = IsSpawnPointClear({['x']=x2,['y']=y2,['z']=z2},5.001)
				if checkPos == false then
					TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['occupied_places'])
				else
					TriggerServerEvent('gas_station:startContract',empresaAtual,data)
				end
			end
		end

		SetTimeout(500,function()
			cooldown0 = nil
		end)
	end
end)

RegisterNUICallback('createJob', function(data, cb)
	TriggerServerEvent('gas_station:createJob',empresaAtual,data)
end)

RegisterNUICallback('buyUpgrade', function(data, cb)
	TriggerServerEvent('gas_station:buyUpgrade',empresaAtual,data)
end)

local cooldown1 = nil
RegisterNUICallback('deleteJob', function(data, cb)
	if cooldown1 == nil then
		cooldown1 = true
		
		TriggerServerEvent('gas_station:deleteJob',empresaAtual,data)

		SetTimeout(500,function()
			cooldown1 = nil
		end)
	end
end)

RegisterNUICallback('depositMoney', function(data, cb)
	TriggerServerEvent('gas_station:depositMoney',empresaAtual,data)
end)

local cooldown2 = nil
RegisterNUICallback('withdrawMoney', function(data, cb)
	if cooldown2 == nil then
		cooldown2 = true
		
		TriggerServerEvent('gas_station:withdrawMoney',empresaAtual)

		SetTimeout(500,function()
			cooldown2 = nil
		end)
	end
end)

local cooldown3 = nil
RegisterNUICallback('sellMarket', function(data, cb)
	if cooldown3 == nil then
		cooldown3 = true

		local key = empresaAtual
		TriggerServerEvent('gas_station:sellMarket',key)
		closeUI()

		SetTimeout(500,function()
			cooldown3 = nil
		end)
	end
end)

local cooldown4 = nil
RegisterNUICallback('buyMarket', function(data, cb)
	if cooldown4 == nil then
		cooldown4 = true

		local key = empresaAtual
		closeUI()
		TriggerServerEvent('gas_station:buyMarket',key)

		SetTimeout(500,function()
			cooldown4 = nil
		end)
	end
end)

local cooldown5 = nil
RegisterNUICallback('applyPrice', function(data, cb)
	if cooldown5 == nil then
		cooldown5 = true

		local key = empresaAtual
		TriggerServerEvent('gas_station:applyPrice',key,data)

		SetTimeout(500,function()
			cooldown5 = nil
		end)
	end
end)

RegisterNUICallback('close', function(data, cb)
	closeUI()
end)

function closeUI()
	empresaAtual = nil
	menuactive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('gas_station:startContract')
AddEventHandler('gas_station:startContract', function(amount,truck_level,ressuply_id,type,query_delivery)
	local key = empresaAtual
	job_data[key] = nil

	local rand
	local x,y,z
	local cont = 0
	repeat
		rand = math.random(#Config.delivery_locations)
		x,y,z = table.unpack(Config.delivery_locations[rand])
		distance_traveled = (#(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))/1000)
		cont = cont + 1
		if cont >= (#Config.delivery_locations*2) then
			TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['not_found_location'])
			return
		end
	until IsInsideDistance(key,distance_traveled,ressuply_id)
	local route_blip = createBlip(x,y,z)
	distance_traveled = tonumber(string.format("%.2f",distance_traveled)) or 0

	local x2,y2,z2,h2 = table.unpack(Config.gas_station_locations[key]['truck_coord'])
	truck,truck_blip = spawnVehicle(Config.trucks[truck_level].truck,x2,y2,z2,h2)
	if Config.trucks[truck_level].trailer then
		local x_trailer,y_trailer,z_trailer,h_trailer = table.unpack(Config.gas_station_locations[key]['trailer_coord'])
		trailer,trailer_blip = spawnVehicle(Config.trucks[truck_level].trailer,x_trailer,y_trailer,z_trailer,h_trailer)
	end
	TriggerEvent("gas_station:Notify","sucesso",Lang[Config.lang]['already_is_in_garage'])
	
	closeUI()
	local fase_coleta = 1
	local timer = 2000
	while truck do
		timer = 2000
		local ped = PlayerPedId()
		veh = GetVehiclePedIsIn(ped,false)

		if fase_coleta == 1 then
			local distance = #(GetEntityCoords(ped) - vector3(x,y,z))
			if distance <= 50 and veh == truck and (IsEntityAVehicle(trailer) == false or IsEntityAttachedToEntity(truck,trailer)) then
				timer = 5
				DrawMarker_truck(x,y,z)
				if distance <= 2 then
					DrawText3D2(x,y,z-0.6, Lang[Config.lang]['objective_marker_3'], 0.70)
					if IsControlJustPressed(0,38) then
						BringVehicleToHalt(truck, 2.5, 1, false)
						Citizen.Wait(10)
						DoScreenFadeOut(500)
						Citizen.Wait(500)
						RemoveBlip(route_blip)
						route_blip = nil
						fase_coleta = 2
						PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
						Citizen.CreateThreadNow(function()
							showScaleform(Lang[Config.lang]['sucess_2'], Lang[Config.lang]['sucess_in_progess_2'], 3)
						end)
						route_blip = createBlip(x2,y2,z2)
					end
				end
			end
		elseif fase_coleta == 2 then
			local distance = #(GetEntityCoords(ped) - vector3(x2,y2,z2))
			if distance <= 50 and veh == truck and (IsEntityAVehicle(trailer) == false or IsEntityAttachedToEntity(truck,trailer)) then
				timer = 5
				DrawMarker_truck(x2,y2,z2)
				DrawText3D2(x2,y2,z2-0.6, Lang[Config.lang]['garage_marker'], 0.40)
				if distance <= 4 then
					BringVehicleToHalt(truck, 2.5, 1, false)
					Citizen.Wait(10)
					DoScreenFadeOut(500)
					Citizen.Wait(500)
					DeleteVehicle(truck)
					DeleteVehicle(trailer)
					RemoveBlip(truck_blip)
					RemoveBlip(trailer_blip)
					RemoveBlip(route_blip)
					PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
					Citizen.CreateThreadNow(function()
						showScaleform(Lang[Config.lang]['sucess_2'], Lang[Config.lang]['sucess_finished_2'], 3)
					end)
					truck = nil
					trailer = nil
					truck_blip = nil
					trailer_blip = nil
					route_blip = nil
					TriggerServerEvent("gas_station:finishContract",key,amount,ressuply_id,distance_traveled,type,query_delivery)
					return
				end
			end
		end

		if not IsEntityAVehicle(truck) then
			DeleteEntity(truck)
			DeleteEntity(trailer)
			RemoveBlip(truck_blip)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			truck = nil
			trailer = nil
			truck_blip = nil
			trailer_blip = nil
			route_blip = nil
			return
		end

		if IsEntityDead(ped) then
			SetVehicleEngineHealth(truck,-4000)
			SetVehicleUndriveable(truck,true)
			RemoveBlip(truck_blip)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			truck = nil
			trailer = nil
			truck_blip = nil
			trailer_blip = nil
			route_blip = nil
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
			TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['you_died'])
			return
		end

		engineH = GetVehicleEngineHealth(truck)
		if engineH <= 150 then
			SetVehicleEngineHealth(truck,-4000)
			SetVehicleUndriveable(truck,true)
			RemoveBlip(truck_blip)
			RemoveBlip(trailer_blip)
			RemoveBlip(route_blip)
			truck = nil
			trailer = nil
			truck_blip = nil
			trailer_blip = nil
			route_blip = nil
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
			TriggerEvent("gas_station:Notify","negado",Lang[Config.lang]['vehicle_destroyed'])
			return
		end
		
		Citizen.Wait(timer)
	end
end)

function IsInsideDistance(key,distance_traveled,ressuply_id)
	if Config.gas_station_types[Config.gas_station_locations[key].type].ressuply[ressuply_id-1] ~= nil then
		return distance_traveled <= Config.gas_station_types[Config.gas_station_locations[key].type].ressuply[ressuply_id].max_distance and distance_traveled >= Config.gas_station_types[Config.gas_station_locations[key].type].ressuply[ressuply_id-1].max_distance
	else
		return distance_traveled <= Config.gas_station_types[Config.gas_station_locations[key].type].ressuply[ressuply_id].max_distance
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- vehicleLock
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread( function()
	local timer = 2000
	while true do
		if truck then
			timer = 5
			if IsControlJustPressed(0,Config.keyToUnlockTruck) then
				TriggerServerEvent("gas_station:vehicleLock")
			end
		end
		Citizen.Wait(timer)
	end
end)

RegisterNetEvent('gas_station:vehicleClientLock')
AddEventHandler('gas_station:vehicleClientLock', function()
	print(truck)
	local v = truck
	if DoesEntityExist(v) and IsEntityAVehicle(v) then
		local lock = GetVehicleDoorLockStatus(v)
		playAnim(true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
		TriggerEvent("vrp_sound:source",'lock',0.5)
		if lock == 1 then
			SetVehicleDoorsLocked(v,2)
			TriggerEvent("gas_station:Notify","importante",Lang[Config.lang]['vehicle_locked'],8000)
		else
			SetVehicleDoorsLocked(v,1)
			TriggerEvent("gas_station:Notify","importante",Lang[Config.lang]['vehicle_unlocked'],8000)
		end
		SetVehicleLights(v,2)
		Wait(200)
		SetVehicleLights(v,0)
		Wait(200)
		SetVehicleLights(v,2)
		Wait(200)
		SetVehicleLights(v,0)
	end
end)

local anims = {}

function playAnim(upper, seq, looping)
    stopAnim(upper)

    local flags = 0
    if upper then flags = flags+48 end
    if looping then flags = flags+1 end

    Citizen.CreateThread(function()
      for k,v in pairs(seq) do
        local dict = v[1]
        local name = v[2]
        local loops = v[3] or 1

        for i=1,loops do
            local first = (k == 1 and i == 1)
            local last = (k == #seq and i == loops)

            -- request anim dict
            RequestAnimDict(dict)
            local i = 0
            while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
              Citizen.Wait(10)
              RequestAnimDict(dict)
              i = i+1
            end

            -- play anim
            if HasAnimDictLoaded(dict)then
              local inspeed = 8.0001
              local outspeed = -8.0001
              if not first then inspeed = 2.0001 end
              if not last then outspeed = 2.0001 end

              TaskPlayAnim(GetPlayerPed(-1),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
            end

            Citizen.Wait(0)
            while GetEntityAnimCurrentTime(GetPlayerPed(-1),dict,name) <= 0.95 and IsEntityPlayingAnim(GetPlayerPed(-1),dict,name,3) and anims[id] do
              Citizen.Wait(0)
            end
          end
      end
    end)
end
function stopAnim(upper)
	anims = {} -- stop all sequences
	if upper then
	  	ClearPedSecondaryTask(GetPlayerPed(-1))
	else
	  	ClearPedTasks(GetPlayerPed(-1))
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Debug
-----------------------------------------------------------------------------------------------------------------------------------------

function print_table(node)
	-- to make output beautiful
	local function tab(amt)
		local str = ""
		for i=1,amt do
			str = str .. "\t"
		end
		return str
	end

	local cache, stack, output = {},{},{}
	local depth = 1
	local output_str = "{\n"
	if type(node) == "table" then
		while true do
			local size = 0
			for k,v in pairs(node) do
				size = size + 1
			end

			local cur_index = 1
			for k,v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
				
					if (string.find(output_str,"}",output_str:len())) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str,"\n",output_str:len())) then
						output_str = output_str .. "\n"
					end

					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output,output_str)
					output_str = ""
				
					local key
					if (type(k) == "number" or type(k) == "boolean") then
						key = "["..tostring(k).."]"
					else
						key = "['"..tostring(k).."']"
					end

					if (type(v) == "number" or type(v) == "boolean") then
						output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
					elseif (type(v) == "table") then
						output_str = output_str .. tab(depth) .. key .. " = {\n"
						table.insert(stack,node)
						table.insert(stack,v)
						cache[node] = cur_index+1
						break
					else
						output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
					end

					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if (cur_index == size) then
						output_str = output_str .. "\n" .. tab(depth-1) .. "}"
					end
				end

				cur_index = cur_index + 1
			end

			if (#stack > 0) then
				node = stack[#stack]
				stack[#stack] = nil
				depth = cache[node] == nil and depth + 1 or depth - 1
			else
				break
			end
		end

		-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
		table.insert(output,output_str)
		output_str = table.concat(output)
	else
		output_str = node
	end

	print(output_str)
end