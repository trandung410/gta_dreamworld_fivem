-- MADE BY KALU 
-- [ALL CITY]
-- version : 1.00
-- update : 
-- info: 

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
ESX                             = nil
local lastPull = 0

local keyParam = Keys["-"]
local isUiOpen = false 

-- local chanleloc = {
-- 	{ ['x'] = 1115.87, ['y'] = 228.72, ['z'] = -49.84 },
-- 	{ ['x'] = 1115.97, ['y'] = 230.45, ['z'] = -49.84 },
-- 	{ ['x'] = 1117.68, ['y'] = 230.89, ['z'] = -49.84 },
-- 	{ ['x'] = 1118.6, ['y'] = 229.4, ['z'] = -49.84 },
-- 	{ ['x'] = 1117.5, ['y'] = 228.07, ['z'] = -49.84 },
-- 	{ ['x'] = 1106.14, ['y'] = 230.97, ['z'] = -49.84 },
-- 	{ ['x'] = 1111.52, ['y'] = 237.38, ['z'] = -49.84 },
-- 	{ ['x'] = 1112.56, ['y'] = 237.67, ['z'] = -49.84 },
-- 	{ ['x'] = 1113.49, ['y'] = 238.21, ['z'] = -49.84 },
-- 	{ ['x'] = 1110.44, ['y'] = 237.41, ['z'] = -49.84 },
-- 	{ ['x'] = 1109.38, ['y'] = 237.68, ['z'] = -49.84 },
-- 	{ ['x'] = 1108.45, ['y'] = 238.22, ['z'] = -49.84 },
-- }

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- 	local sleepThread = 2000
--     while true do
--         Citizen.Wait(sleepThread)
-- 		local pos = GetEntityCoords(GetPlayerPed(-1), false)
-- 		local isNear = IsNearMarker()
-- 		if isNear ~= false then 
-- 			sleepThread = 1
-- 			DrawMarker(29, chanleloc[isNear].x, chanleloc[isNear].y, chanleloc[isNear].z + 0.4, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
--             if(Vdist(chanleloc[isNear].x, chanleloc[isNear].y, chanleloc[isNear].z, pos.x, pos.y, pos.z) < 2.0)then
--                 if IsControlJustPressed(1,Keys["E"]) and isUiOpen == false and not IsPlayerDead(PlayerId()) then
--                     SendNUIMessage({
--                         displayWindow = 'true'
--                         })
--                      isUiOpen = true
--                      TriggerEvent('chanle:enter')
--                      TransitionToBlurred(1000)
--                 end
--             else
--                 if IsControlJustPressed(1,322) and isUiOpen == true then
--                     isUiOpen = false
--                     closechanle()
--                 end
-- 			end
-- 		else 
-- 			sleepThread = 2000
-- 		end
-- 		if IsPlayerDead(PlayerId()) and isUiOpen == true then
--             SendNUIMessage({
--                     displayWindow = 'false'
--                })
--             isUiOpen = false

--         end   
--     end
-- end) 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(1, keyParam) then
			ESX.TriggerServerCallback('chanle:isopen', function(isOpen)
				if isOpen then
					-- do something
					if isUiOpen == false and not IsPlayerDead(PlayerId()) then
						SendNUIMessage({
						displayWindow = 'true'
						})
						isUiOpen = true
						TriggerEvent('chanle:enter')
						TransitionToBlurred(1000)
					else
					SendNUIMessage({
							displayWindow = 'false'
					})
					isUiOpen = false     
						TriggerEvent('chanle:exit')
					end
				else
					ESX.ShowNotification("~r~Không thể chơi lúc này")
				end

				-- SetNuiFocus(true, false);
			end)
          	
        end
    end

end)
-- function IsNearMarker()
-- 	local pos = GetEntityCoords(GetPlayerPed(-1), false)
-- 	for k,v in ipairs(chanleloc) do
-- 		if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
-- 			return k
-- 		end
-- 	end
-- 	return false
-- end

RegisterNetEvent("chanle:batdau")
AddEventHandler("chanle:batdau", function ()
    SendNUIMessage({
            	   type = 'gameStart'
            	   })
	
end)    

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closechanle()
    end
)

RegisterNUICallback(
    "datchan",
    function(dulieu)
        --TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.dice)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.money)
		if GetGameTimer() - lastPull >= 5000 then 
			lastPull = GetGameTimer()
			TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		else 
			ESX.ShowNotification("Bạn phải đợi 5 giây")
		end
    end
)

RegisterNUICallback(
    "datle",
    function(dulieu)
        --TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.dice)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.money)
		if GetGameTimer() - lastPull >= 5000 then 
			lastPull = GetGameTimer()
			TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		else 
			ESX.ShowNotification("Bạn phải đợi 5 giây")
		end
    end
)

RegisterNUICallback(
    "datbonden",
    function(dulieu)
        --TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.dice)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.money)
		if GetGameTimer() - lastPull >= 5000 then 
			lastPull = GetGameTimer()
			TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		else 
			ESX.ShowNotification("Bạn phải đợi 5 giây")
		end
    end
)

RegisterNUICallback(
    "datbontrang",
    function(dulieu)
        --TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.dice)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.money)
		if GetGameTimer() - lastPull >= 5000 then 
			lastPull = GetGameTimer()
			TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		else 
			ESX.ShowNotification("Bạn phải đợi 5 giây")
		end
    end
)

RegisterNUICallback(
    "datbaden",
    function(dulieu)
        --TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.dice)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.money)
		if GetGameTimer() - lastPull >= 5000 then 
			lastPull = GetGameTimer()
			TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		else 
			ESX.ShowNotification("Bạn phải đợi 5 giây")
		end
    end
)

RegisterNUICallback(
    "datbatrang",
    function(dulieu)
        --TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)

		--exports['mythic_notify']:DoLongHudText('error', dulieu.dice)
		--exports['mythic_notify']:DoLongHudText('error', dulieu.money)
		if GetGameTimer() - lastPull >= 5000 then 
			lastPull = GetGameTimer()
			TriggerServerEvent("chanle:checkmoney", dulieu.dice, dulieu.money)
		else 
			ESX.ShowNotification("Bạn phải đợi 5 giây")
		end
    end
)

function closechanle()
    isUiOpen = false  
    SendNUIMessage(
        {
            displayWindow = 'false'
        }
    )
    SetNuiFocus(false, false)
	
	TransitionFromBlurred(1000)
end

RegisterNetEvent("chanle:enter")
AddEventHandler("chanle:enter", function ()
    SetNuiFocus(true, true)
	
end)

RegisterNetEvent("chanle:exit")
AddEventHandler("chanle:exit", function ()
    SetNuiFocus(false, false)
	
end)


RegisterNetEvent("chanle:checkmoney")
AddEventHandler("chanle:checkmoney", function (id, dice, money)
	TriggerServerEvent('chanle:pull', id, dice, money);
end)

RegisterNetEvent("chanle:pull")
AddEventHandler("chanle:pull", function (msg)
	SendNUIMessage({
				type = "pull",
				tinnhan = msg.status,
			})
	TriggerServerEvent('chanle:checkthoigian', msg)
	--exports['mythic_notify']:DoLongHudText('error', msg.status)
end)

RegisterNUICallback(
	"ketQua",
	function()
		TriggerServerEvent("chanle:layketqua")
end)
-- RegisterNetEvent('chanle:traketqua')
-- AddEventHandler('chanle:traketqua', function(ketqua1, ketqua2, ketqua3)

			-- SendNUIMessage({
				-- type = "ketqua",
				 -- traketqua1 = ketqua1,
				 -- traketqua2 = ketqua2,
				 -- traketqua3 = ketqua3,
			-- })
			-- --exports['mythic_notify']:DoLongHudText('success', ketqua2)

-- end)
RegisterNetEvent('chanle:gameData')
AddEventHandler('chanle:gameData', function (dulieu2)
	if	isUiOpen == true then
		SendNUIMessage(
			{
				type = "gameData",
				id = dulieu2.idGame,
				chonchan = dulieu2.soNguoiChonChan,
				chonle = dulieu2.soNguoiChonLe,
				chonbonden = dulieu2.soNguoiChonBonden,
				chonbontrang = dulieu2.soNguoiChonBontrang,
				chonbaden = dulieu2.soNguoiChonBaden,
				chonbatrang = dulieu2.soNguoiChonBatrang,
				tienchan = dulieu2.tongTienDatChan,
				tienle = dulieu2.tongTienDatLe,
				tienbonden = dulieu2.tongTienDatBonden,
				tienbontrang = dulieu2.tongTienDatBontrang,
				tienbaden = dulieu2.tongTienDatBaden,
				tienbatrang = dulieu2.tongTienDatBatrang,
				t = dulieu2.time,
			}
		)
		--exports['mythic_notify']:DoLongHudText('success', "laydulieu"..dulieu2.time)
	end
end)

RegisterNUICallback(
	"nhankeo",
	function (nhankeo)
	SendNUIMessage(
        {
			type = "nhankeo",
			msg = nhankeo.msg,
		}
	)
	--exports['mythic_notify']:DoLongHudText('success', "thanhcoong"..nhankeo.msg)
	--exports['mythic_notify']:DoLongHudText('success', "thanhcoong")
end)

RegisterNetEvent('chanle:gameStart')
AddEventHandler('chanle:gameStart',function(ketQua)
	SendNUIMessage(
		{
			type = "gameStart",
			
		}
	)
	--exports['mythic_notify']:DoLongHudText('success', "batdau")
end)

RegisterNetEvent('chanle:gameOver')
AddEventHandler('chanle:gameOver', function(ketQua)
	SendNUIMessage(
		{
			type = "gameOver",
			dice1 = ketQua.dice1,
			dice2 = ketQua.dice2,
			dice3 = ketQua.dice3,
			dice4 = ketQua.dice4,
			result = ketQua.result,
			
		}
	)
	--exports['mythic_notify']:DoLongHudText('success', ketQua.dice1.." "..ketQua.dice2.." "..ketQua.dice3.." "..ketQua.result)
end)

RegisterNetEvent('chanle:winGame1')
AddEventHandler('chanle:winGame1', function(datatien)
	local money = datatien
		local player = GetPlayerFromServerId(id)		
		TriggerServerEvent("chanle:wingame1", money)
		local name = GetPlayerName(player)
end)

RegisterNetEvent('chanle:winGame2')
AddEventHandler('chanle:winGame2', function(datatien)
	--local id = datawin.id
	local money = datatien
	--exports['mythic_notify']:DoLongHudText('success', id.." đã thắng "..money)
	--if id == GetPlayerServerId(PlayerId()) then
		local player = GetPlayerFromServerId(id)
		
		TriggerServerEvent("chanle:wingame2", money)
		local name = GetPlayerName(player)
		--exports['mythic_notify']:DoLongHudText('success', name.." đã thắng "..money)
	--else
		--exports['mythic_notify']:DoLongHudText('error', "Bạn đã đã thua "..money)
	--end
end)

RegisterNetEvent('chanle:winGame3')
AddEventHandler('chanle:winGame3', function(datatien)
	--local id = datawin.id
	local money = datatien
	--exports['mythic_notify']:DoLongHudText('success', id.." đã thắng "..money)
	--if id == GetPlayerServerId(PlayerId()) then
		local player = GetPlayerFromServerId(id)
		
		TriggerServerEvent("chanle:wingame3", money)
		local name = GetPlayerName(player)
		--exports['mythic_notify']:DoLongHudText('success', name.." đã thắng "..money)
	--else
		--exports['mythic_notify']:DoLongHudText('error', "Bạn đã đã thua "..money)
	--end
end)



