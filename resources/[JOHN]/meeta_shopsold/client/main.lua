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

ESX                           = nil
local PlayerData                = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Category = "Normal"
local IsOpenStore = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


function OpenShopMenu(category)
	--CurrentAction = "open_store"
	IsOpenStore = true
	loadShop(category)
    SendNUIMessage(
		{
			action = "display"
		}
	)
    SetNuiFocus(true, true)
end

function closeHUD()
	IsOpenStore = false
	CurrentAction = nil
    SendNUIMessage(
        {
            action = "hide"
        }
	)
    SetNuiFocus(false, false)
end

function loadShop(category)
	ESX.TriggerServerCallback(
		"meeta_shops:requestDBItems",
		function(ShopItems)
			items = {}
			
			for i=1, #ShopItems, 1 do
				--print(('meeta_shops: "%s"'):format(ShopItems[i].name))
				if ShopItems[i].name then
					if ShopItems[i].id ~= nil then
						if ShopItems[i].limit == -1 then
							ShopItems[i].limit = 30
						end
						if ShopItems[i].category == category then
							table.insert(items, {
								label = ShopItems[i].label,
								item  = ShopItems[i].item,
								black = ShopItems[i].black,
								price = ShopItems[i].price,
								limit = ShopItems[i].limit
							})
						end
					else
						print(('meeta_shops: invalid item "%s" found!'):format(ShopItems[i].item))
					end
				end 
			end

            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items
                }
            )
        end,
        GetPlayerServerId(PlayerId())
    )
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeHUD()
    end
)

RegisterNUICallback(
    "CBuyItem",
    function(data, cb)
		TriggerServerEvent('meeta_shops:buyItem', data.itemName, data.amount, data.index)
    end
)

AddEventHandler('meeta_shops:hasEnteredMarker', function()
	CurrentAction     = 'in_mark'
	CurrentActionMsg  = _U('press_menu')
end)

AddEventHandler('meeta_shops:hasExitedMarker', function()
	CurrentAction = nil
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
					SetBlipScale  (blip, 1.0)
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
	-- สร้างจุดขาย
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) and PlayerData.job.name == v.Job then
					if v.Marker == true then
						DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 50, false, true, 2, false, false, false, false)
					end
				elseif (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) and not v.Job then
					if v.Marker == true then
						DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 50, false, true, 2, false, false, false, false)
					end
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
				if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) and PlayerData.job.name == v.Job then
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
					Category = v.Category
				end

				if (GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) and not v.Job then
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
					Category = v.Category
				end
			end
		end
		if isInMarker and not IsOpenStore then
			ESX.ShowHelpNotification('Nhấn ~g~[E]~s~ để mở cửa hàng.')
			if IsControlJustPressed(0, Keys['E']) then
				OpenShopMenu(Category)
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		closeHUD()
	end
end)