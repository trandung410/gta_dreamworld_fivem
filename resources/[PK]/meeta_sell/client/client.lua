-- CREATE BY THANAWUT PROMRAUNGDET
local IsOpenMenu = false
local OpenSellMenu = false
local Npc = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
end)

-- Create Blips
Citizen.CreateThread(function()
	
	for k,v in pairs(Config.SellZone) do
		if v.Blips then
			local blip = AddBlipForCoord(v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z)
			SetBlipSprite (blip, v.Blips.Id)
			SetBlipDisplay(blip, 3)
			SetBlipScale  (blip, v.Blips.Size)
			SetBlipColour (blip, v.Blips.Color)
			SetBlipAsShortRange(blip, true)
			AddTextEntry('BLIP_SELL', v.Blips.Text)
			BeginTextCommandSetBlipName("BLIP_SELL")
			EndTextCommandSetBlipName(blip)
		end
	end

end)

-- Create NPC
Citizen.CreateThread(function()

	for k,v in pairs(Config.SellZone) do
		if v.NPC.Model then
			RequestModel(GetHashKey(v.NPC.Model))
			while not HasModelLoaded(GetHashKey(v.NPC.Model)) do
				Wait(1)
			end

			Npc[v] = CreatePed(4, v.NPC.Model, v.NPC.Pos.x, v.NPC.Pos.y, v.NPC.Pos.z-1.0, v.NPC.Pos.h, false, true)

			FreezeEntityPosition(Npc[v], true)
			SetEntityInvincible(Npc[v], true)
			SetBlockingOfNonTemporaryEvents(Npc[v], true)
		end

	end

end)

function IsRandomPrice(item)
	local result
	for k,v in pairs(Config.SellZone) do
		for i=1, #v.Item, 1 do
			if v.Item[i].ItemName == item then
				result = v.Item[i].RandomPrice
				break
			end
		end
	end

	return result
end

-- สร้างจุดขาย
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local IsInMarkerSelling  = false
		local CurrentZone = nil

		for k,v in pairs(Config.SellZone) do

			if(v.Marker.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < v.Marker.DrawDistance) then
				DrawMarker(v.Marker.Type, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, true, 2, false, false, false, false)
			end

			if(GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < v.Marker.Size.x) then
				IsInMarkerSelling = true
				CurrentZone = v
			end
		end
		if IsInMarkerSelling and not IsOpenMenu then
			ESX.ShowHelpNotification(CurrentZone.Text.TextHelper)
			if IsControlJustPressed(0, Config.Key['G']) then
				IsOpenMenu = true
				AddMenuSellFunction(CurrentZone)				
			end
		end

		if IsControlJustPressed(0, Config.Key['F5']) then
			if not OpenSellMenu then
				OpenSellMenu = true
				ESX.TriggerServerCallback("meeta_selling:getPriceItems", function(data)
					local elements = {}
					for k,v in pairs(data) do

						local TextPrice

						if IsRandomPrice(v.item) then
							if v.price <= 0 then
								TextPrice = ('%s <span class="red-text">%s</span> '):format(v.label, "Đóng bán")
							else
								TextPrice = ('%s <span class="green-text">$%s - $%s</span>'):format(v.label, ESX.Math.GroupDigits(v.price), ESX.Math.GroupDigits(v.price2))
							end
						else
							if v.price <= 0 then
								TextPrice = ('%s <span class="red-text">%s</span> '):format(v.label, "Đóng bán")
							else
								TextPrice = ('%s <span class="green-text">$%s</span>'):format(v.label, ESX.Math.GroupDigits(v.price))
							end
							
						end

						if v.difference == v.price then
							TextPrice = TextPrice .. ""
						elseif v.difference >= v.price then
							local difference = v.price-v.difference
							TextPrice = TextPrice .. ('<span class="right-label red-text"> ▼ %s</span> '):format(difference)
						else
							local difference = v.price-v.difference
							TextPrice = TextPrice .. ('<span class="right-label green-text"> ▲ +%s</span> '):format(difference)
						end

						

						table.insert(elements, {
							label = TextPrice,
							name = v.item,
							price = v.price,
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Economy', {
						title    = 'Giá thị trường',
						align    = 'top-left',
						elements = elements
					}, function(data, menu)
		
					end, function(data, menu)
						menu.close()
						OpenSellMenu = false
					end)
					
				end)
			else
				OpenSellMenu = false
				ESX.UI.Menu.CloseAll()
			end
			
		end

	end
end)

function AddMenuSellFunction(CurrentZone)

	local playerPed = PlayerPedId()

	ESX.TriggerServerCallback("meeta_selling:getPlayerInventory", function(data)
		local elements = {}
		inventory = data.inventory
		for i=1, #CurrentZone.Item, 1 do
			Count = 0
			if inventory ~= nil then
				for key, value in pairs(inventory) do
					if inventory[key].name == CurrentZone.Item[i].ItemName then
						Count = inventory[key].count
						break
					end
				end

				if Count > 0 then 

					local ListCount = {}
    
					for i = 1, Count do ListCount[i] = i end
					
					if CurrentZone.Item[i].ListItem then
						local data = {
							label     = CurrentZone.Item[i].Text_TH,
							name      = i,
							value     = Count,
							min       = 1,
							max       = Count,
							zone 	 = CurrentZone,
							type      = 'slider'
						}
						table.insert(elements, data)
					else

						local data = {
							label     = "Bán ".. CurrentZone.Item[i].Text_TH .." <strong class='blue-text'>số lượng 1 ".. CurrentZone.Item[i].Unit .. "</strong>",
							name      = i,
							value     = 1,
							zone 	 = CurrentZone,
						}
						table.insert(elements, data)
					end
				else
					table.insert(elements, {
						label = CurrentZone.Item[i].Text_NotHave
					})
				end
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_dialog', {
			title    = CurrentZone.Text.SubTitle,
			align    = 'top-left',
			elements = elements
		}, function(data, menu) -- OnEnter
			if data.current.zone then
				if data.current.type == "slider" then
					TriggerServerEvent('meeta_selling:sellFunction', data.current.name, data.current.zone, data.current.value)
					menu.close()
					IsOpenMenu = false
				else
					menu.close()
					if data.current.zone.Animation.Scenario then
						TaskStartScenarioInPlace(playerPed, data.current.zone.Animation.AnimationScene, 0, false)
					else
						ESX.Streaming.RequestAnimDict(data.current.zone.Animation.AnimationDirect, function()
							TaskPlayAnim(GetPlayerPed(-1), data.current.zone.Animation.AnimationDirect, data.current.zone.Animation.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)
						end)							
					end
					ESX.ShowHelpNotification(data.current.zone.Text.ProcessText)
					Wait(10000)
					TriggerServerEvent('meeta_selling:sellFunction', data.current.name, data.current.zone, 0)
					ClearPedTasks(playerPed)
				end
			else
				menu.close()
				IsOpenMenu = false
			end
		end, function(data, menu)
			menu.close()
			IsOpenMenu = false
		end, function(data, menu)

		end)

	end, GetPlayerServerId(PlayerId()))
end

function AddMenuConfirmSell(ItemName, ItemCount, ItemPrice)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_dialog_confirm', {
		title    = "Cửa hàng đã đưa ra giá cho bạn. <strong class='green-text'>giá $"..ItemPrice.."</strong>",
		align    = 'top-left',
		elements = {
			{
				label = "Đồng ý",
				value = "yes"
			},
			{
				label = "Huỷ",
				value = "no"
			}
		}
	}, function(data, menu)
		if data.current.value == "yes" then
			TriggerServerEvent('meeta_selling:confirmToSell', ItemName, ItemCount, ItemPrice)
			menu.close()
			IsOpenMenu = false
		else
			menu.close()
			IsOpenMenu = false
		end
	end, function(data, menu)
		menu.close()
		IsOpenMenu = false
	end, function(data, menu) 
		
	end)
end

RegisterNetEvent("meeta_selling:confirmToSell")
AddEventHandler("meeta_selling:confirmToSell", function(ItemName, ItemCount, ItemPrice)
	AddMenuConfirmSell(ItemName, ItemCount, ItemPrice)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k,v in pairs(Npc) do
			DeleteEntity(Npc[v])
		end
	end
end)