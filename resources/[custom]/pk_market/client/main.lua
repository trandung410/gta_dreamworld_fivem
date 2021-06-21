active_script = nil

RegisterNetEvent("pk_market:client:Verify") 
AddEventHandler("pk_market:client:Verify", function(state)
    active_script = state
end) 


ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local PlayerData              = {}
local blur = "MenuMGIn"


	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end

		Citizen.Wait(5000)
		PlayerData = ESX.GetPlayerData()

		ESX.TriggerServerCallback('esx_shops:requestDBItems', function(ShopItems)
			for k,v in pairs(ShopItems) do
				if (Config.Zones[k] ~= nil) then
					Config.Zones[k].Items = v
				end
			end
		end)
	end)


function OpenShopMenu(zone)
	PlayerData = ESX.GetPlayerData()
	SendNUIMessage({
		message		= "show",
		clear = true
	})
	
	local elements = {}
	for i=1, #Config.Zones[zone].Items, 1 do
		local item = Config.Zones[zone].Items[i]

		if item.limit == -1 then
			item.limit = 100
		end

		SendNUIMessage({
			message		= "add",
			item		= item.item,
			label      	= item.label,
			item       	= item.item,
			price      	= item.price,
			max        	= item.limit,
			loc			= zone
		})

	end
	
	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

end

AddEventHandler('esx_shops:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_shops:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	for i=1, #Config.Map, 1 do

		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipScale  (blip, 0.6)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end

end)

-- Create Blips
Citizen.CreateThread(function()
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if v.CustomBlip then
					local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					SetBlipSprite (blip, v.CustomBlip.Blip)
					SetBlipDisplay(blip, 4)
					SetBlipScale  (blip, v.CustomBlip.Size)
					SetBlipColour (blip, v.CustomBlip.Color)
					SetBlipAsShortRange(blip, true)
					AddTextComponentString(v.CustomBlip.Text)
					AddTextEntry('BLIP_SHOP_1', v.CustomBlip.Text)
					BeginTextCommandSetBlipName("BLIP_SHOP_1")
					EndTextCommandSetBlipName(blip)
				else
					if v.ShowBlip == true then
						local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
						SetBlipSprite (blip, 52)
						SetBlipDisplay(blip, 4)
						SetBlipScale  (blip, 0.5)
						SetBlipColour (blip, 2)
						SetBlipAsShortRange(blip, true)
						AddTextEntry('BLIP_SHOP', "Shops")
						BeginTextCommandSetBlipName("BLIP_SHOP")
						EndTextCommandSetBlipName(blip)
					end
				end	
			end
		end
end)

-- Display markers


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Config.Zones) do
				for i = 1, #v.Pos, 1 do
					if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
						DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, ('[E] Supermarket'))	
					
					end
				end
			end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
			for k,v in pairs(Config.Zones) do
				for i = 1, #v.Pos, 1 do
					if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) then
					
						isInMarker  = true
						ShopItems   = v.Items
						currentZone = k
						LastZone    = k
					end
				end
			end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_shops:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_shops:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'shop_menu' then
					OpenShopMenu(CurrentActionData.zone)
				end

				CurrentAction = nil
			elseif IsControlJustReleased (0, 44) then
				ESX.SetTimeout(200, function()
					SetNuiFocus(false, false)
				end)	
			end

		else
			Citizen.Wait(500)
		end
	end
end)

function closeGui()
  SetNuiFocus(false, false)
  SendNUIMessage({message = "hide"})
end

RegisterNUICallback('quit', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('purchase', function(data, cb)
	TriggerServerEvent('esx_shops:buyItem', data.item, data.count, data.loc)
	cb('ok')
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


