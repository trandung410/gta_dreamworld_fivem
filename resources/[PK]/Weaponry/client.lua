-- Script by Lyrad for LEFR
local shootMul = 60
local weaponList = {
	[-1569615261]=0,--"TAYKHÔNG",
	[-102973651]=0,--"WEAPON_STONE_HATCHET",
	[-1716189206]=0,--"WEAPON_KNIFE",
	[1737195953]=0,--"WEAPON_NIGHTSTICK",
	[1317494643]=0,--"WEAPON_HAMMER",
	[2508868239]=0,--"WEAPON_BAT",
	[1141786504]=0,--"WEAPON_GOLFCLUB",
	[2227010557]=0,--"WEAPON_CROWBAR",
	[4192643659]=0,--"WEAPON_BOTTLE",
	[3756226112]=0,--"WEAPON_SWITCHBLADE",
	[453432689]=0.001,
	[1593441988]=0.001,
	[-1716589765]=0.001,
	[-1076751822]=0.001,
	[-771403250]=0.0015,
	[584646201]=0.001,
	[2578377531]=0.001,
	[1198879012]=0.001,
	[3696079510]=0.0015,
	[3249783761]=0.0015,
	[324215364]=0.0001,--micro smg
	[-619010992]=0.0001,--machine pistol
	[736523883]=0.0005,--smg
	[4024951519]=0.0008,
	[171789620]=0.0006,
	[-1660422300]=0.0008,
	[-1074790547]=0.0012,--ak
	[2210333304]=0.0008,
	[2937143193]=0.0008,
	[1649403952]=0.0008,--"WEAPON_COMPACTRIFLE",
	[2634544996]=0.0008,--"MG",
	[2144741730]=0.0008,--"WEAPON_COMBATMG",
	[487013001]=0.0058,--"WEAPON_PUMPSHOTGUN",
	[-1312131151]=0.001,--"WEAPON_RPG",
	[2017895192]=0.003,--"WEAPON_SAWNOFFSHOTGUN",
	[3800352039]=0.001,--"WEAPON_ASSAULTSHOTGUN",
	[2640438543]=0.001,--"WEAPON_BULLPUPSHOTGUN",
	[4019527611]=0.001,--"WEAPON_DBSHOTGUN",
	[911657153]=0.001,--"WEAPON_STUNGUN",
	[100416529]=0.001,--"WEAPON_SNIPERRIFLE",
	[205991906]=0.001,--"WEAPON_HEAVYSNIPER",
	[2726580491]=0.001,--"WEAPON_GRENADELAUNCHER",
	[1305664598]=0.001,--"WEAPON_GRENADELAUNCHER_SMOKE",
	[2982836145]=0.001,--"WEAPON_RPG",
	[1119849093]=0.011,--"WEAPON_MINIGUN",
	[2481070269]=0.001,--"WEAPON_GRENADE",
	[741814745]=0.001,--"WEAPON_STICKYBOMB",
	[4256991824]=0.001,--"WEAPON_SMOKEGRENADE",
	[2694266206]=0.001,--"WEAPON_BZGAS",
	[615608432]=0.001,--"WEAPON_MOLOTOV",
	[101631238]=0.001,--"WEAPON_FIREEXTINGUISHER",
	[883325847]=0.001,--"WEAPON_PETROLCAN",
	[3218215474]=0.001,--"WEAPON_SNSPISTOL",
	[-1063057011]=0.001,--"WEAPON_SPECIALCARBINE",
	[3523564046]=0.001,--"WEAPON_HEAVYPISTOL",
	[2132975508]=0.001,--"WEAPON_BULLPUPRIFLE",
	[2228681469]=0.001,--"WEAPON_BULLPUPRIFLE",
	[1672152130]=0.001,--"WEAPON_HOMINGLAUNCHER",
	[2874559379]=0.001,--"WEAPON_PROXMINE",
	[126349499]=0.001,--"WEAPON_SNOWBALL",
	[137902532]=0.001,--"WEAPON_VINTAGEPISTOL",
	[-598887786]=0.001,--"WEAPON_MARKSMANPISTOL",
	[-1045183535]=0.001,--"WEAPON_REVOLVER",
	[2460120199]=0.001,--"WEAPON_DAGGER",
	[2138347493]=0.001,--"WEAPON_FIREWORK",
	[2828843422]=0.001,--"WEAPON_MUSKET",
	[3342088282]=0.001,--"WEAPON_MARKSMANRIFLE",
	[984333226]=0.001,--"WEAPON_HEAVYSHOTGUN",
	[1627465347]=0.001,--"WEAPON_GUSENBERG",
	[4191993645]=0.001,--"WEAPON_STONE_HATCHET",
	[1834241177]=0.001,--"WEAPON_RAILGUN",
	[2725352035]=0.001,--"FISTS",
	[3638508604]=0.001,--"WEAPON_KNUCKLE",
	[3713923289]=0.001,--"WEAPON_MACHETE",
	[3675956304]=0.001,--"WEAPON_MACHINEPISTOL",
	[2343591895]=0.001,--"WEAPON_FLASHLIGHT",
	[600439132]=0.001,--"WEAPON_BALL",
	[1233104067]=0.001,--"WEAPON_FLARE",
	[2803906140]=0.001,--"NIGHTVISION",
	[4222310262]=0.001,--"GADGET_PARACHUTE",
	[317205821]=0.001,--"WEAPON_AUTOSHOTGUN",
	[3441901897]=0.001,--"WEAPON_BATTLEAXE",
	[125959754]=0.001,--"WEAPON_COMPACTLAUNCHER",
	[-1813897027]=0.001,--"WEAPON_GRENADE",
	[-37975472]=0.001,--"WEAPON_SMOKEGRENADE",
	[-1121678507]=0.0003,--"WEAPON_MINISMG",
	[3125143736]=0.001,--"WEAPON_PIPEBOMB",
	[2484171525]=0.001,--"WEAPON_POOLCUE",
	[419712736]=0.001,--"WEAPON_WRENCH",
	[4208062921]=0.001,--"WEAPON_CARBINERIFLE_MK2",
	[-1357824103]=0.0008,--"WEAPON_ADVANCEDRIFLE",
	[3219281620]=0.001,--"WEAPON_PISTOL_MK2",
	[3686625920]=0.001,--"WEAPON_COMBATMG_MK2",
	[961495388]=0.001,--"WEAPON_ASSAULTRIFLE_MK2",
	[-2084633992]=0.0008,--"WEAPON_CARBINERIFLE",
	[177293209]=0.001,--"WEAPON_HEAVYSNIPER_MK2",
	[-952879014]=0.001,--"WEAPON_MARKSMANRIFLE",
	[2024373456]=0.001,--"WEAPON_SMG_MK2",
	[-270015777]=0.0006,--"WEAPON_ASSAULTSMG",
	[-335430670]=0.001,--"AKGOLD",
	[-335430670] =0.001,-- "WEAPON_AKB",
	[1084920949] =0.001,-- "WEAPON_BF3",
	[1595201550] =0.001,-- "WEAPON_XR2",
	[-1171598465] =0.001,-- "WEAPON_XM25",
	[-303983872] =0.001,-- "WEAPON_BUSTERSWORD",
	[1495124272] =0.001,-- "WEAPON_GUNBLADE",
	[-484865036] =0.001,-- "WEAPON_RUNESCAPE1",
	[-261839222] =0.001,-- "WEAPON_RUNESCAPE2",
	[1529117720] =0.001,-- "WEAPON_RUNESCAPE3",
	[693999755] =0.001,-- "WEAPON_RUNESCAPE4",
	[1034162531] =0.001,-- "WEAPON_XBOW",
	[1438000445] =0.001,-- "WEAPON_MAGIKSWORD",
	[1217255841] =0.001,-- "WEAPON_MSR",
	[1276725267] =0.001,-- "WEAPON_F4MINI",
	[757043420] =0.001,-- "WEAPON_CHEYTAC",
	[-851966428] =0.001,-- "WEAPON_AWPH",
	[1994451307] =0.001,-- "WEAPON_TOMAHAWK",
	[812656550] =0.001,-- "WEAPON_UV",
	[1198256469] =0.001,-- "WEAPON_RAYCARBINE",
	[-1238556825] =0.001,-- "WEAPON_RAYMINIGUN",
	[-1768145561] = 0.001 -- "WEAPON_SPECIALCARBINE_MK2"
	}
local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    local _, hash = GetCurrentPedWeapon( ped, true )
        if not HashInTable( hash ) then 
            HideHudComponentThisFrame( 14 )
		end 
end 


Citizen.CreateThread(function()
	Citizen.Wait(10000)
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		local curLvl = exports.XNLRankBar:Exp_XNL_GetCurrentPlayerLevel()
		--print(weapon) -- To get the weapon hash by pressing F8 in game
		
		-- Disable reticle
		
		--ManageReticle()
		
		-- Disable melee while aiming (may be not working)
		
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
		
		-- Disable ammo HUD
		
		--DisplayAmmoThisFrame(false)
		
		-- Shakycam
		
		-- Pistol
		--print(weapon)
		for k, v  in pairs(weaponList) do 
			--print(k)
			if weapon == k then 
				--print(k, v)
				if IsPedShooting(ped) then 
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ( v * shootMul ) * (( 100 - curLvl )/100))
					--ShakeGameplayCam('VIBRATE_SHAKE', v*shootMul*10)
				end 
			end 
		end
		
		-- Infinite FireExtinguisher
		
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then		
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
end)

-- recoil script by bluethefurry / Blumlaut https://forum.fivem.net/t/betterrecoil-better-3rd-person-recoil-for-fivem/82894
-- I just added some missing weapons because of the doomsday update adding some MK2.
-- I can't manage to make negative hashes works, if someone make it works, please let me know =)

local recoils = {
	[453432689] = 0.3, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.2, -- COMBAT PISTOL
	[584646201] = 0.1, -- AP PISTOL
	[2578377531] = 0.6, -- PISTOL .50
	[324215364] = 0.2, -- MICRO SMG
	[736523883] = 0.1, -- SMG
	[2024373456] = 0.1, -- SMG MK2
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = -0.5, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.1, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[487013001] = 0.4, -- PUMP SHOTGUN
	[1432025498] = 0.4, -- PUMP SHOTGUN MK2
	[2017895192] = 0.7, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 0.5, -- SNIPER RIFLE
	[205991906] = 0.9, -- HEAVY SNIPER
	[177293209] = 0.7, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[2009644972] = 0.25, -- SNS PISTOL MK2
	[1627465347] = 0.1, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.25, -- SPECIAL CARBINE MK2
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.25, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[-1746263880] = 0.4, -- DOUBLE ACTION REVOLVER
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.35, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.02, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
  	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.65, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.3, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG	,
	[-1768145561] = 0.17, -- "WEAPON_SPECIALCARBINE_MK2"
	[-2084633992] = -0.7,--"WEAPON_CARBINERIFLE",	
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= recoils[wep]
			end
			
		end
	end
end)