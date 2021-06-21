local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX								= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local isDead					= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('caruby_accessories:SetUnsetAccessory')
AddEventHandler('caruby_accessories:SetUnsetAccessory', function(accessory)
	local _accessory = string.lower(accessory)
	ESX.TriggerServerCallback('caruby_accessories:get', function(hasAccessory, accessorySkins)
		if hasAccessory then
			local elements = {}
			if accessory == 'TShirt' or accessory == 'Torso' or accessory == 'Pants' or accessory == 'Chain' or accessory == 'Shoes' or accessory == 'Arms' then
				
			else
				table.insert(elements, {label = _U('unset', _U(string.lower(accessory))), value = 'unset'}) 
			end

			
			for i=1, #accessorySkins, 1 do
				table.insert(elements, {label = accessorySkins[i].label, value = accessorySkins[i]}) 
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
			{
				title = _U(string.lower(accessory)),
				align = 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()
				if data.current.value == 'unset' then
					UnsetAccessory(_accessory)
				else
					SetAccessory(_accessory, data.current.value)
				end
			end, function(data, menu)
				menu.close()
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end, function(data, menu)
				SetAccessory(_accessory, data.current.value)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end
	end, accessory)
end)

function SetAccessory(_accessory, accessorySkin)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if Config.AnimationSet[_accessory] then
			local player = GetPlayerPed(-1)
			local dict = Config.AnimationSet[_accessory].dict
			local anim = Config.AnimationSet[_accessory].anim

			RequestAnimDict(dict)
			--while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
			
			TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
			Citizen.Wait(1000)
		end

		local newAccessorySkin = {}

		if _accessory == 'arms' or _accessory == 'Arms' then
			newAccessorySkin[_accessory] = accessorySkin[_accessory]
		else
			newAccessorySkin[_accessory .. '_1'] = accessorySkin[_accessory .. '_1']
		end
		newAccessorySkin[_accessory .. '_2'] = accessorySkin[_accessory .. '_2']
		TriggerEvent('skinchanger:loadClothes', skin, newAccessorySkin)
	end)
end

function UnsetAccessory( _accessory )
	TriggerEvent('skinchanger:getSkin', function(skin)
		if Config.AnimationUnset[_accessory] then
			local player = GetPlayerPed(-1)

			if IsPedInAnyVehicle(PlayerPedId(), true) == false then
				local dict = Config.AnimationUnset[_accessory].dict
				local anim = Config.AnimationUnset[_accessory].anim

				RequestAnimDict(dict)
				--while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
				
				TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
	
				Citizen.Wait(1000)
			end
		end

		local mAccessory = -1
		local mColor = 0

		if _accessory == "mask" then
			mAccessory = 0
		end

		local accessorySkin = {}
		if _accessory == 'arms' or _accessory == 'Arms' then
			accessorySkin[_accessory] = mAccessory
		else
			accessorySkin[_accessory .. '_1'] = mAccessory
		end
		accessorySkin[_accessory .. '_2'] = mColor
		TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
	end)
end

function OpenClothShopMenu(accessory)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloth',
	{
		title = _U('shop', accessory),
		align = 'top-left',
		elements = {
			{label = _U('tshirt'), value = 'TShirt'},
			{label = _U('torso'), value = 'Torso'},
			{label = _U('pants'), value = 'Pants'},
			{label = _U('shoes'), value = 'Shoes'},
			{label = _U('chain'), value = 'Chain'},
			{label = _U('arms'), value = 'Arms'}
		}
	}, function(data, menu)
		menu.close()

		-- local _accessory = string.lower(data.current.value)
		-- local price = Config.Price[data.current.value]
		-- local restrict = {}
		-- restrict = { _accessory .. '_1', _accessory .. '_2' }
		OpenShopMenu(data.current.value)
	end)

end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local price = Config.Price[accessory]
	local restrict = {}

	if accessory == 'arms' or accessory == 'Arms' then
		restrict = { _accessory, _accessory .. '_2' }
	else
		restrict = { _accessory .. '_1', _accessory .. '_2' }
	end

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gang_house_stocks_menu_get_item_count', {
			title = 'Nhập tên [4-30 ký tự] giá '..ESX.Math.GroupDigits(price)
		}, function(data2, menu2)
			menu.close()
			local label = data2.value

			if label == nil then
				ESX.ShowNotification('Invalid Label')
			else
				menu2.close()
				ESX.TriggerServerCallback('caruby_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('caruby_accessories:save', skin, accessory, label, price)
						end)
					else
						TriggerEvent('esx_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, price)
			end
			if accessory == 'TShirt' or accessory == 'Torso' or accessory == 'Pants' or accessory == 'Chain' or accessory == 'Shoes' or accessory == 'Arms' then
				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', 'Cloth')
				CurrentActionData = { accessory = 'Cloth' }
			else
				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', accessory)
				CurrentActionData = { accessory = accessory }
			end
		end, function(data2, menu2)
				menu2.close()
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			if accessory == 'TShirt' or accessory == 'Torso' or accessory == 'Pants' or accessory == 'Chain' or accessory == 'Shoes' or accessory == 'Arms' then
				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', 'Cloth')
				CurrentActionData = { accessory = 'Cloth' }
			else
				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', accessory)
				CurrentActionData = { accessory = accessory }
			end
		end)

	end, function(data, menu)
		menu.close()
		if accessory == 'TShirt' or accessory == 'Torso' or accessory == 'Pants' or accessory == 'Chain' or accessory == 'Shoes' or accessory == 'Arms' then
				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', 'Cloth')
				CurrentActionData = { accessory = 'Cloth' }
			else
				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', accessory)
				CurrentActionData = { accessory = accessory }
			end
	end, restrict)
end

function RemoveAccessoryMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_accessory',
	{
		title = _U('remove'),
		align = 'center',
		elements = {
			{label = _U('helmet'), value = 'Helmet'},
			{label = _U('ears'), value = 'Ears'},
			{label = _U('mask'), value = 'Mask'},
			{label = _U('glasses'), value = 'Glasses'},
			{label = _U('tshirt'), value = 'TShirt'},
			{label = _U('torso'), value = 'Torso'},
			{label = _U('pants'), value = 'Pants'},
			{label = _U('shoes'), value = 'Shoes'},
			{label = _U('chain'), value = 'Chain'},
			{label = _U('arms'), value = 'Arms'}
		}
	}, function(data, menu)
		menu.close()
		RemoveAccessory(data.current.value)

	end, function(data, menu)
		menu.close()
	end)

end

function RemoveAccessory( accessory )

	ESX.TriggerServerCallback('caruby_accessories:get', function(hasAccessory, accessorySkins)
		if hasAccessory then
			local elements = {}
			
			for i=1, #accessorySkins, 1 do
				table.insert(elements, {label = accessorySkins[i].label, value = i}) 
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_select_accessory',
			{
				title = _U(string.lower(accessory)),
				align = 'center',
				elements = elements
			}, function(data, menu)
				menu.close()
				local index = data.current.value
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
				{
					title = _U('remove'),
					align = 'center',
					elements = {
						{label = _U('no'), value = 'no'},
						{label = _U('yes'), value = 'yes'}
					}
				}, function(data2, menu2)
					menu2.close()
					if data2.current.value == 'yes' then
						ESX.TriggerServerCallback('caruby_accessories:checkMoney', function(hasEnoughMoney)
							if hasEnoughMoney then
								UnsetAccessory( string.lower(accessory) )
								TriggerServerEvent('caruby_accessories:remove', accessory, index )
							else
								ESX.ShowNotification(_U('not_enough_money'))
							end
						end, Config.RemovePrice)
					end

					CurrentAction     = 'shop_menu'
					CurrentActionMsg  = _U('press_access', accessory)
					CurrentActionData = { accessory = 'Remove' }
				end, function(data2, menu2)
					menu2.close()
					CurrentAction     = 'shop_menu'
					CurrentActionMsg  = _U('press_access', accessory)
					CurrentActionData = { accessory = 'Remove' }

				end)

				CurrentAction     = 'shop_menu'
					CurrentActionMsg  = _U('press_access', accessory)
					CurrentActionData = { accessory = 'Remove' }
			end, function(data, menu)
				menu.close()

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access', accessory)
				CurrentActionData = { accessory = 'Remove' }
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end
	end, accessory)
end

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('caruby_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access', zone)
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('caruby_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', k))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x then
					isInMarker  = true
					currentZone = k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('caruby_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('caruby_accessories:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and CurrentActionData.accessory then
				if CurrentActionData.accessory == 'Remove' then
					RemoveAccessoryMenu()
				elseif CurrentActionData.accessory == 'Cloth' then
					OpenClothShopMenu(CurrentActionData.accessory)
				else
					OpenShopMenu(CurrentActionData.accessory)
				end
				CurrentAction = nil
			end
		elseif CurrentAction == nil and not Config.EnableControls then
			Citizen.Wait(500)
		end
	end
end)