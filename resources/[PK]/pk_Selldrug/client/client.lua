ESX                 = nil
pk = GetCurrentResourceName()
local myJob     = nil
local selling       = false
local has       = false
local copsc     = false
local PlayerData = {}
local CurrentIndex = 1
local SellsNpc = {}
coordsset = {}

freeze = false
zone = false

Itemsell = false
ItemName = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent(pk..'Selltrue')
AddEventHandler(pk..'Selltrue', function (Label,message)	

	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -258.0,-978.2,31.2, true) < Config.FarFromCity then
			Itemsell = true
			ItemName = Label
			-- TriggerEvent("pNotify:SendNotification",
			-- {text = "คุณได้เริ่มทำการขาย <font color = 'yellow'>"..message.."</font> ",
			-- type = "info", timeout = 5000, 
			-- layout = "topRight"})
			--print (Itemsell,ItemName)
	else
		TooFar()
	end
end)




currentped = nil
Citizen.CreateThread(function()
	while true do
	Wait(7)
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local handle, ped = FindFirstPed()
	
	repeat
		success, ped = FindNextPed(handle)
		local pos = GetEntityCoords(ped)
		local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		local currentVehicle = GetVehiclePedIsIn(ped, true)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			if DoesEntityExist(ped) and NetworkGetEntityIsNetworked(ped) == 1 then
				if IsPedDeadOrDying(ped) == false then
					if IsPedInAnyVehicle(ped) == false then
						local pedType = GetPedType(ped)
						if pedType ~= 28 and IsPedAPlayer(ped) == false then
							currentped = pos
							canselloldnpc = CheckNPC(ped)
							if distance <= 2 and ped  ~= GetPlayerPed(-1) and ped ~= oldped and not canselloldnpc and not  DoesEntityExist(currentVehicle) then


									if Itemsell then
										Draw3DText(pos.x,pos.y,pos.z-0.65,"~w~Nhấn [~g~E~s~] ~w~để bán")
										--Draw3DText(pos.x,pos.y,pos.z-0.75, ItemName)
										-- Draw3DText(pos.x,pos.y,pos.z-0.85,"กด [~p~Q~w~] ~w~เปลี่ยนไอเทม")
									end
									
									if IsControlJustPressed(1, Config.Key["E"]) then
										coordsset = GetEntityCoords(PlayerPedId())
										if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -258.0,-978.2,31.2, true) < Config.FarFromCity then                --------------- ศูนย์กลางของเมือง Job Center
											local Item = Config.DrugSell
											if Itemsell then
												freeze = true												
												Freeze()
												
											
												TriggerServerEvent(pk..'startrandom',ItemName)																			
												table.insert(SellsNpc, ped)
												oldped = ped
												SetEntityAsMissionEntity(ped)
												Wait(3000)	
												TriggerServerEvent(pk..'sell',ItemName,ped)												
												pos1 = GetEntityCoords(ped)
												SetPedAsNoLongerNeeded(ped)
										
												Itemsell = false
								
									else
										print('False to sell')
										oldped = ped
									end
									else
										TooFar()
												
									end
							
								end

							end
						end
					end
				end
			end
		end
	until not success
	EndFindPed(handle)
	end
end)


function Test()
	Citizen.CreateThread(function()
		repeat
		Citizen.Wait(7)
		
			local PlayerCoords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(PlayerCoords,coordsset.x,coordsset.y,coordsset.z) <= 5 then
				
				
			else
				
				local ped = GetPlayerPed(-1)
				local PedPos = GetEntityCoords(ped)  				
				AddExplosion(PedPos.x, PedPos.y, PedPos.z+1.00, 34, 1.00, true, false, 5.00)
				Wait(2000)
				SetEntityCoords(PlayerPedId(), coordsset.x,coordsset.y,coordsset.z-0.97)
			end
		
				
		until reject == false
	end)
end


function Freeze()
Citizen.CreateThread(function()
repeat
	Citizen.Wait(7)
	DisableAllControlActions(0)
until freeze == false
end)
end


function TooFar()
	weed_pooch = false
	coke_pooch = false
	meth_pooch = false
	freeze = false

	TriggerEvent("pNotify:SendNotification",
	{text = " <center><b style ='color:yellow'>Bạn ở xa thành phố.</b><center>",
	type = "info", timeout = 5000, 
	layout = "bottomCenter"})

end




function ArrayCount(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function CheckNPC(npc)
	for k,v in pairs(SellsNpc) do
		if v == npc then
			return true
		end
	end
	return false
end

RegisterNetEvent(pk..'FoodReject')  -- ใส่อีเว้นแจ้งเตือน
AddEventHandler(pk..'FoodReject', function(npc)

	reject = false
	freeze = false

end)

RegisterNetEvent(pk..'setNpcCallPolice') 
AddEventHandler(pk..'setNpcCallPolice', function(npc)
	
	local player = GetPlayerPed(-1)
	local percent = math.random(1, 100)
	local dict = "cellphone@"
	local phoneModel = "prop_amb_phone"
	local Current_Sex = 0
	local Current_Hair = 0

	
	if Config.Notify then
	TriggerEvent(Config.Event,Config.Type)  
	end

	
	TriggerEvent('skinchanger:getSkin', function(skin)
		Current_Hair = skin["hair_1"]
		Current_Sex = skin["sex"]
	end)
	
	Wait(2000)

	if IsPedDeadOrDying(npc, 1) == false then

		RequestAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end

		if percent <= 100 then

			local coords = GetEntityCoords(player)
			local ped = PlayerId()

			TaskGoStraightToCoord(npc, coords.x, coords.y, coords.z, 1.0, 1000, GetEntityHeading(npc), 10)
			
			Reject()
			SetEntityAsMissionEntity(npc)
			TaskStandStill(npc, 9.0)
			TaskStartScenarioInPlace(npc, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, false)
			Citizen.Wait(Config.Timetofreeze)
			reject = false			
			Test()		
			ClearPedTasks(npc)
			SetPedAsNoLongerNeeded(npc)
			
		else
			
			Reject()			
			TaskPlayAnim(npc, dict, "cellphone_call_listen_base", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
			Wait(Config.Timetofreeze)
			reject = false
			Test()			
			TaskPlayAnim(npc, dict, "cellphone_call_out", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
		end
	end

end)


function Reject()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	reject =true

	TriggerEvent("pNotify:SendNotification",
	{text = "Khách hàng từ chối sản phẩm của bạn, <font color = 'red'>chạy !!</font>",
	type = "info", timeout = 5000, 
	layout = "topRight"})
	freeze = false

	Citizen.CreateThread(function()
		repeat
		FreezeEntityPosition(PlayerPedId(), true)		
		Citizen.Wait(7)
		FreezeEntityPosition(PlayerPedId(), false)
		until reject == false
		end)
	

end

RegisterNetEvent(pk..'NoItem')
AddEventHandler(pk..'NoItem', function()

	freeze = false
	weed_pooch = false
	coke_pooch = false
	meth_pooch = false
	
    
end)

RegisterNetEvent(pk..'NoCops')
AddEventHandler(pk..'NoCops', function()

	freeze = false
	weed_pooch = false
	coke_pooch = false
	meth_pooch = false

    
end)

RegisterNetEvent(pk..'HaveItem')
AddEventHandler(pk..'HaveItem', function()

	freeze = false
    
end)


local ConfigHair_M = {
	{
		Hair = 1,
		Name = "Shaving"
	},
	{
		Hair = 2,
		Name = "Short Hair"
	},
	{
		Hair = 3,
		Name = "Short Hair"
	},
	{
		Hair = 4,
		Name = "Short Hair"
	},
	{
		Hair = 5,
		Name = "Short Hair"
	},
	{
		Hair = 6,
		Name = "Short Hair"
	},
	{
		Hair = 7,
		Name = "Short Hair"
	},
	{
		Hair = 8,
		Name = "Dreadlock"
	},
	{
		Hair = 9,
		Name = "Medium Hair"
	},
	{
		Hair = 10,
		Name = "Short Hair"
	},
	{
		Hair = 11,
		Name = "Short Hair"
	},
	{
		Hair = 12,
		Name = "Short Hair"
	},
	{
		Hair = 13,
		Name = "Medium Hair"
	},
	{
		Hair = 14,
		Name = "Dreadlock"
	},
	{
		Hair = 15,
		Name = "Long Hair"
	},
	{
		Hair = 16,
		Name = "Curly Hair"
	},
	{
		Hair = 17,
		Name = "Long Hair"
	},
	{
		Hair = 18,
		Name = "Short Hair"
	},
	{
		Hair = 19,
		Name = "Short Hair"
	},
	{
		Hair = 20,
		Name = "Long Hair"
	},
	{
		Hair = 21,
		Name = "Short Hair"
	},
	{
		Hair = 22,
		Name = "Long Hair"
	},
	{
		Hair = 24,
		Name = "Dreadlock"
	},
	{
		Hair = 25,
		Name = "Dreadlock"
	},
	{
		Hair = 26,
		Name = "Dreadlock"
	},
	{
		Hair = 27,
		Name = "Dreadlock"
	},
	{
		Hair = 28,
		Name = "Dreadlock"
	},
	{
		Hair = 29,
		Name = "Dreadlock"
	},
	{
		Hair = 30,
		Name = "Short Hair"
	},
	{
		Hair = 31,
		Name = "Long Hair"
	},
	{
		Hair = 32,
		Name = "Short Hair"
	},
	{
		Hair = 33,
		Name = "Short Hair"
	},
	{
		Hair = 34,
		Name = "Short Hair"
	},
	{
		Hair = 35,
		Name = "Medium Hair"
	},
	{
		Hair = 36,
		Name = "Medium Hair"
	},
	{
		Hair = 37,
		Name = "Shaving Hair"
	},
	{
		Hair = 38,
		Name = "Short Hair"
	},
	{
		Hair = 39,
		Name = "Short Hair"
	},
	{
		Hair = 40,
		Name = "Short Hair"
	},
	{
		Hair = 41,
		Name = "Short Hair"
	},
	{
		Hair = 42,
		Name = "Short Hair"
	},
	{
		Hair = 43,
		Name = "Medium Hair"
	},
	{
		Hair = 44,
		Name = "Dreadlock"
	},
	{
		Hair = 45,
		Name = "Medium Hair"
	},
	{
		Hair = 46,
		Name = "Short Hair"
	},
	{
		Hair = 47,
		Name = "Short Hair"
	},
	{
		Hair = 48,
		Name = "Short Hair"
	},
	{
		Hair = 49,
		Name = "Medium Hair"
	},
	{
		Hair = 50,
		Name = "Dreadlock"
	},
	{
		Hair = 51,
		Name = "Long Hair"
	},
	{
		Hair = 52,
		Name = "Curly Hair"
	},
	{
		Hair = 53,
		Name = "Long Hair"
	},
	{
		Hair = 54,
		Name = "Short Hair"
	},
	{
		Hair = 55,
		Name = "Short Hair"
	},
	{
		Hair = 56,
		Name = "Long Hair"
	},
	{
		Hair = 57,
		Name = "Short Hair"
	},
	{
		Hair = 58,
		Name = "Long Hair"
	},
	{
		Hair = 59,
		Name = "Dreadlock"
	},
	{
		Hair = 60,
		Name = "Dreadlock"
	},
	{
		Hair = 61,
		Name = "Dreadlock"
	},
	{
		Hair = 62,
		Name = "Dreadlock"
	},
	{
		Hair = 63,
		Name = "Dreadlock"
	},
	{
		Hair = 64,
		Name = "Dreadlock"
	},
	{
		Hair = 65,
		Name = "Short Hair"
	},
	{
		Hair = 66,
		Name = "Long Hair"
	},
	{
		Hair = 67,
		Name = "Short Hair"
	},
	{
		Hair = 68,
		Name = "Short Hair"
	},
	{
		Hair = 69,
		Name = "Short Hair"
	},
	{
		Hair = 70,
		Name = "Medium Hair"
	},
	{
		Hair = 71,
		Name = "Medium Hair"
	},
	{
		Hair = 72,
		Name = "Short Hair"
	},
	{
		Hair = 73,
		Name = "Short Hair"
	},
}

local ConfigHair_Color = {
	{
		Hair = 0,
		Name = "Black"
	},
	{
		Hair = 1,
		Name = "Black"
	},
	{
		Hair = 2,
		Name = "Black"
	},
	{
		Hair = 3,
		Name = "Brown"
	},
	{
		Hair = 4,
		Name = "Brown"
	},
	{
		Hair = 5,
		Name = "Brown"
	},
	{
		Hair = 6,
		Name = "Brown"
	},
	{
		Hair = 7,
		Name = "Brown"
	},
	{
		Hair = 8,
		Name = "Brown"
	},
	{
		Hair = 9,
		Name = "Brown"
	},
	{
		Hair = 10,
		Name = "Brown"
	},
	{
		Hair = 11,
		Name = "~y~Blonde"
	},
	{
		Hair = 12,
		Name = "~y~Blonde"
	},
	{
		Hair = 13,
		Name = "~y~Blonde"
	},
	{
		Hair = 14,
		Name = "~y~Blonde"
	},
	{
		Hair = 15,
		Name = "~y~Blonde"
	},
	{
		Hair = 16,
		Name = "~y~Blonde"
	},
	{
		Hair = 17,
		Name = "~r~Red"
	},
	{
		Hair = 18,
		Name = "~r~Red"
	},
	{
		Hair = 19,
		Name = "~r~Red"
	},
	{
		Hair = 20,
		Name = "~r~Red"
	},
	{
		Hair = 21,
		Name = "~r~Red"
	},
	{
		Hair = 22,
		Name = "~r~Red"
	},
	{
		Hair = 23,
		Name = "~r~Red"
	},
	{
		Hair = 24,
		Name = "~r~Red"
	},
	{
		Hair = 25,
		Name = "~o~Orange"
	},
	{
		Hair = 26,
		Name = "Silver"
	},
	{
		Hair = 27,
		Name = "Silver"
	},
	{
		Hair = 28,
		Name = "Silver"
	},
	{
		Hair = 29,
		Name = "Silver"
	},
	{
		Hair = 30,
		Name = "~p~Purple"
	},
	{
		Hair = 31,
		Name = "~p~Purple"
	},
	{
		Hair = 32,
		Name = "~p~Purple"
	},
	{
		Hair = 33,
		Name = "~p~Pink"
	},
	{
		Hair = 34,
		Name = "~p~Pink"
	},
	{
		Hair = 35,
		Name = "~p~Pink"
	},
	{
		Hair = 36,
		Name = "~g~Teal"
	},
	{
		Hair = 37,
		Name = "~g~Teal"
	},
	{
		Hair = 38,
		Name = "~b~Blue"
	},
	{
		Hair = 39,
		Name = "~g~Green"
	},
	{
		Hair = 40,
		Name = "~g~Green"
	},
	{
		Hair = 41,
		Name = "~g~Teal"
	},
	{
		Hair = 42,
		Name = "~g~Green"
	},
	{
		Hair = 43,
		Name = "~g~Green"
	},
	{
		Hair = 44,
		Name = "~g~Green"
	},
	{
		Hair = 45,
		Name = "~y~Yellow"
	},
	{
		Hair = 46,
		Name = "~y~Yellow"
	},
	{
		Hair = 47,
		Name = "~y~Yellow"
	},
	{
		Hair = 48,
		Name = "~o~Orange"
	},
	{
		Hair = 49,
		Name = "~o~Orange"
	},
	{
		Hair = 50,
		Name = "~o~Orange"
	},
	{
		Hair = 51,
		Name = "~o~Orange"
	},
	{
		Hair = 52,
		Name = "~o~Orange"
	},
	{
		Hair = 53,
		Name = "~r~Dark Red"
	},
	{
		Hair = 54,
		Name = "~r~Dark Red"
	},
	{
		Hair = 54,
		Name = "~r~Dark Red"
	},
	{
		Hair = 55,
		Name = "Brown"
	},
	{
		Hair = 56,
		Name = "Brown"
	},
	{
		Hair = 57,
		Name = "Brown"
	},
	{
		Hair = 58,
		Name = "Brown"
	},
	{
		Hair = 59,
		Name = "Brown"
	},
	{
		Hair = 60,
		Name = "Brown"
	},
	{
		Hair = 61,
		Name = "Black"
	},
	{
		Hair = 62,
		Name = "~y~Blonde"
	},
	{
		Hair = 63,
		Name = "~y~Blonde"
	}
}


RegisterNetEvent(pk..'notifyPoliceMsg')
AddEventHandler(pk..'notifyPoliceMsg', function(hairIndex, IsSex)
	

	local targetPlayer = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(targetPlayer,  true)
	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street1 = GetStreetNameFromHashKey(s1)
	local hairColor = GetPedHairColor(targetPlayer)

	local propIndex = GetPedPropIndex(targetPlayer, 2)
	local PedPosition	= GetEntityCoords(targetPlayer)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	
	TriggerServerEvent('esx_addons_gcphone:startCall', 'police', "Mọi người đã thông báo rằng thuốc đang được bán tại", PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end)

RegisterNetEvent(pk..'notifyPolice')
AddEventHandler(pk..'notifyPolice', function(face, target, hairIndex, IsSex)



	--if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	if ESX.GetPlayerData().job.name == 'police' then
		local NumofNpc = math.random(1,100)
		local targetPlayer = GetPlayerPed(GetPlayerFromServerId(target))
		local plyPos = GetEntityCoords(targetPlayer,  true)
		local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local street1 = GetStreetNameFromHashKey(s1)
		local sex = "~g~Male"
		local hairColor = GetPedHairColor(targetPlayer)
		local PedPosition	= GetEntityCoords(targetPlayer)
		local propIndex = GetPedPropIndex(targetPlayer, 2)
		local hairString = "Hair : Unknow"
		local hairColorString = "Hair Color : Unknow"

		if IsSex == 0 then

			sex = "~g~Male"
			
			for k,v in pairs(ConfigHair_M) do
		
				if v.Hair == hairIndex then
					hairString = v.Name
					break
				end
			end

			for k,v in pairs(ConfigHair_Color) do
		
				if v.Hair == hairColor then
					hairColorString = v.Name
					break
				end
			end

		else
			sex = "~p~Female"
			hairString = "Long Hair"

			for k,v in pairs(ConfigHair_Color) do
		
				if v.Hair == hairColor then
					hairColorString = v.Name
					break
				end
			end

		end

		local Message = "Someone is selling me ~r~drug ~w~by a "..sex.." ~b~"..hairString.." ~w~Hair Color: ".. hairColorString.." ~w~at ~y~"..street1


		if face then
			local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPlayer)

			ESX.ShowAdvancedNotification("#"..NumofNpc, "Someone is selling me ~r~drug", "~w~by a "..sex.." ~b~"..hairString.." ~w~Hair Color: ".. hairColorString.." ~w~at ~y~"..street1, mugshotStr, 4)
			TriggerServerEvent('esx_addons_gcphone:startCall', 'police', "Someone is selling me drug by a "..sex.." "..hairString.." Hair Color: ".. hairColorString.." at "..street1, PlayerCoords, {
				PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
			})
		else
		end

	end

end)

RegisterNetEvent(pk..'animation')
AddEventHandler(pk..'animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(750)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

fontId = RegisterFontId('athiti')
RegisterFontId('athiti')
function Draw3DText(x, y, z, textInput)
		local fontId = RegisterFontId('athiti')
		local px, py, pz = table.unpack(GetGameplayCamCoords())
		local dist       = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)    
		local scale      = (1 / dist) * 20
		local fov        = (1 / GetGameplayCamFov()) * 100
		local scale      = scale * fov   
		SetTextScale(0.05 * scale, 0.05 * scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(250, 250, 250, 255)
		SetTextDropshadow(1, 1, 1, 1, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(textInput)
		SetDrawOrigin(x, y, z + 2, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
end