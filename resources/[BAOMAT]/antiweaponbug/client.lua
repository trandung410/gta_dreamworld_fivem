ESX = nil
local ownedWeapon = nil
local loaded = false

local WEAPON_HASHES_STRINGS = {
[-1569615261]="TAYKHÔNG",
[-102973651]="WEAPON_STONE_HATCHET",
[-1716189206]="WEAPON_KNIFE",
[1737195953]="WEAPON_NIGHTSTICK",
[1317494643]="WEAPON_HAMMER",
[2508868239]="WEAPON_BAT",
[1141786504]="WEAPON_GOLFCLUB",
[2227010557]="WEAPON_CROWBAR",
[4192643659]="WEAPON_BOTTLE",
[3756226112]="WEAPON_SWITCHBLADE",
[453432689]="WEAPON_PISTOL",
[1593441988]="WEAPON_COMBATPISTOL",
[-1716589765]="WEAPON_PISTOL50",
[-1076751822]="WEAPON_SNSPISTOL",
[-771403250]="WEAPON_HEAVYPISTOL",
[584646201]="WEAPON_APPISTOL",
[2578377531]="WEAPON_PISTOL50",
[1198879012]="WEAPON_FLAREGUN",
[3696079510]="WEAPON_MARKSMANPISTOL",
[3249783761]="WEAPON_REVOLVER",
[324215364]="WEAPON_MICROSMG",
[-619010992]="WEAPON_MACHINEPISTOL",
[736523883]="WEAPON_SMG",
[4024951519]="WEAPON_ASSAULTSMG",
[171789620]="WEAPON_COMBATPDW",
[-1660422300]="WEAPON_MG",
[-1074790547]="WEAPON_ASSAULTRIFLE",
[2210333304]="WEAPON_CARBINERIFLE",
[2937143193]="WEAPON_ADVANCEDRIFLE",
[1649403952]="WEAPON_COMPACTRIFLE",
[2634544996]="MG",
[2144741730]="WEAPON_COMBATMG",
[487013001]="WEAPON_PUMPSHOTGUN",
[-1312131151]="WEAPON_RPG",
[2017895192]="WEAPON_SAWNOFFSHOTGUN",
[3800352039]="WEAPON_ASSAULTSHOTGUN",
[2640438543]="WEAPON_BULLPUPSHOTGUN",
[4019527611]="WEAPON_DBSHOTGUN",
[911657153]="WEAPON_STUNGUN",
[100416529]="WEAPON_SNIPERRIFLE",
[205991906]="WEAPON_HEAVYSNIPER",
[2726580491]="WEAPON_GRENADELAUNCHER",
[1305664598]="WEAPON_GRENADELAUNCHER_SMOKE",
[2982836145]="WEAPON_RPG",
[1119849093]="WEAPON_MINIGUN",
[2481070269]="WEAPON_GRENADE",
[741814745]="WEAPON_STICKYBOMB",
[4256991824]="WEAPON_SMOKEGRENADE",
[2694266206]="WEAPON_BZGAS",
[615608432]="WEAPON_MOLOTOV",
[101631238]="WEAPON_FIREEXTINGUISHER",
[883325847]="WEAPON_PETROLCAN",
[3218215474]="WEAPON_SNSPISTOL",
[-1063057011]="WEAPON_SPECIALCARBINE",
[3523564046]="WEAPON_HEAVYPISTOL",
[2132975508]="WEAPON_BULLPUPRIFLE",
[2228681469]="WEAPON_BULLPUPRIFLE",
[1672152130]="WEAPON_HOMINGLAUNCHER",
[2874559379]="WEAPON_PROXMINE",
[126349499]="WEAPON_SNOWBALL",
[137902532]="WEAPON_VINTAGEPISTOL",
[-598887786]="WEAPON_MARKSMANPISTOL",
[-1045183535]="WEAPON_REVOLVER",
[2460120199]="WEAPON_DAGGER",
[2138347493]="WEAPON_FIREWORK",
[2828843422]="WEAPON_MUSKET",
[3342088282]="WEAPON_MARKSMANRIFLE",
[984333226]="WEAPON_HEAVYSHOTGUN",
[1627465347]="WEAPON_GUSENBERG",
[4191993645]="WEAPON_STONE_HATCHET",
[1834241177]="WEAPON_RAILGUN",
[2725352035]="FISTS",
[3638508604]="WEAPON_KNUCKLE",
[3713923289]="WEAPON_MACHETE",
[3675956304]="WEAPON_MACHINEPISTOL",
[2343591895]="WEAPON_FLASHLIGHT",
[600439132]="WEAPON_BALL",
[1233104067]="WEAPON_FLARE",
[2803906140]="NIGHTVISION",
[4222310262]="GADGET_PARACHUTE",
[317205821]="WEAPON_AUTOSHOTGUN",
[3441901897]="WEAPON_BATTLEAXE",
[125959754]="WEAPON_COMPACTLAUNCHER",
[-1813897027]="WEAPON_GRENADE",
[-37975472]="WEAPON_SMOKEGRENADE",
[-1121678507]="WEAPON_MINISMG",
[3125143736]="WEAPON_PIPEBOMB",
[2484171525]="WEAPON_POOLCUE",
[419712736]="WEAPON_WRENCH",
[4208062921]="WEAPON_CARBINERIFLE_MK2",
[-1357824103]="WEAPON_ADVANCEDRIFLE",
[3219281620]="WEAPON_PISTOL_MK2",
[3686625920]="WEAPON_COMBATMG_MK2",
[961495388]="WEAPON_ASSAULTRIFLE_MK2",
[-2084633992]="WEAPON_CARBINERIFLE",
[177293209]="WEAPON_HEAVYSNIPER_MK2",
[-952879014]="WEAPON_MARKSMANRIFLE",
[2024373456]="WEAPON_SMG_MK2",
[-270015777]="WEAPON_ASSAULTSMG",
[-335430670]="AKGOLD",
[-335430670] = "WEAPON_AKB",
[1084920949] = "WEAPON_BF3",
[1595201550] = "WEAPON_XR2",
[-1171598465] = "WEAPON_XM25",
[-303983872] = "WEAPON_BUSTERSWORD",
[1495124272] = "WEAPON_GUNBLADE",
[-484865036] = "WEAPON_RUNESCAPE1",
[-261839222] = "WEAPON_RUNESCAPE2",
[1529117720] = "WEAPON_RUNESCAPE3",
[693999755] = "WEAPON_RUNESCAPE4",
[1034162531] = "WEAPON_XBOW",
[1438000445] = "WEAPON_MAGIKSWORD",
[1217255841] = "WEAPON_MSR",
[1276725267] = "WEAPON_F4MINI",
[757043420] = "WEAPON_CHEYTAC",
[-851966428] = "WEAPON_AWPH",
[1994451307] = "WEAPON_TOMAHAWK",
[812656550] = "WEAPON_UV",
[1198256469] = "WEAPON_RAYCARBINE",
[-1238556825] = "WEAPON_RAYMINIGUN"
    
    
}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	--print('asdasd')
	-- Citizen.Wait(120000)
	-- ESX.TriggerServerCallback('weaponcheck:getOwnedweapon', function(resuft)
		-- if resuft then
			-- ownedWeapon = resuft
			-- loaded = true
		-- end
	-- end)
	--command = GetRegisteredCommands()
	--local dumped = ESX.DumpTable(command)
	--print(dumped)TriggerServerEvent('serverlog:weaponBug', dumped)
end)


RegisterNetEvent('weaponcheck:update')
AddEventHandler('weaponcheck:update', function()
	ESX.TriggerServerCallback('weaponcheck:getOwnedweapon', function(resuft)
		if resuft then
			ownedWeapon = resuft
		end
	end)
end)

RegisterNetEvent('weaponcheck:getweapon')
AddEventHandler('weaponcheck:getweapon', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local weapon = GetSelectedPedWeapon(playerPed)
		if weapon then
			ESX.ShowNotification('Đang chuyển quyền sở hữu súng')
			TriggerServerEvent('weaponcheck:sellWeapon', GetPlayerServerId(closestPlayer), WEAPON_HASHES_STRINGS[weapon])
		else
			ESX.ShowNotification('Bạn phải cầm súng ra')
		end
	else
		ESX.ShowNotification('Không có người chơi gần đây')
	end

end)

Citizen.CreateThread(function()
	Citizen.Wait(125000)
	while not ESX.IsPlayerLoaded() do
		Wait(10000)
	end
	while loaded == false do
		Citizen.Wait(2000)
		ESX.TriggerServerCallback('weaponcheck:getOwnedweapon', function(resuft)
			--if resuft then
				ownedWeapon = resuft
				loaded = true
			--end
		end)
	end
	local ped = PlayerPedId()

	while true do
		Citizen.Wait(1000)
		local curWeapon = GetSelectedPedWeapon(ped)
		if curWeapon ~= -1569615261 and curWeapon ~= 0 and curWeapon ~= 883325847 then	
			if ownedWeapon[1] == nil then
				--RemoveAllPedWeapons(ped, true)
			else
				local checkResult = table.contains(ownedWeapon, curWeapon)
				if checkResult == false then
					--bugWeapon = getbugName(ownedWeapon, curWeapon)
					--print(curWeapon)
					--print(WEAPON_HASHES_STRINGS[curWeapon])
					--RemoveWeaponFromPed(ped, curWeapon)
					if WEAPON_HASHES_STRINGS[curWeapon] then
						TriggerServerEvent('weaponcheck:removeWeapon', WEAPON_HASHES_STRINGS[curWeapon])
					end
				end
			end
			
		end
	end
end)	


function table.contains(table, element)
  for k, value in pairs(table) do
    if GetHashKey(value.name) == element then
		return true
	end
	end
	return false
end


function table.contains2(table, element)
  for k, value in pairs(table) do
    if value == element then
		return true
	end
	end
	return false
end

-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 900

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

-- CODE --
--[[ 
Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1Zostaniesz wyrzucony za " .. time .. " sekund jeżeli się nie poruszysz!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickBOTAFK")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)
 ]]


