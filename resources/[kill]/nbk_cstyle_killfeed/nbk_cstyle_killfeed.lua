local snew = true 
local deadmessage = nil

CreateThread(function()
    SetPlayerWantedLevel(PlayerId(),6)
    SetPlayerWantedLevelNow(PlayerId(),6)
    CreateThread(function()
    
    local slotList = {};
      slotList.WEAPON_INVALID = 0;
      slotList.WEAPON_OBJECT = 966099553;
      slotList.WEAPON_UNARMED = -1569615261;
      slotList.WEAPON_PISTOL = 453432689;
      slotList.WEAPON_PISTOL_COMBAT = 1593441988;
      slotList.WEAPON_PISTOL_50 = -1716589765;
      slotList.WEAPON_PISTOL_AP = 584646201;
      slotList.WEAPON_SMG_MICRO = 324215364;
      slotList.WEAPON_SMG = 736523883;
      slotList.WEAPON_SMG_ASSAULT = -270015777;
      slotList.WEAPON_RIFLE_ASSAULT = -1074790547;
      slotList.WEAPON_RIFLE_CARBINE = -2084633992;
      slotList.WEAPON_RIFLE_HEAVY = -947031628;
      slotList.WEAPON_RIFLE_ADVANCED = -1357824103;
      slotList.WEAPON_LMG = -1660422300;
      slotList.WEAPON_LMG_COMBAT = 2144741730;
      slotList.WEAPON_LMG_ASSAULT = -572349828;
      slotList.WEAPON_SHOTGUN_PUMP = 487013001;
      slotList.WEAPON_SHOTGUN_SAWNOFF = 2017895192;
      slotList.WEAPON_SHOTGUN_BULLPUP = -1654528753;
      slotList.WEAPON_SHOTGUN_ASSAULT = -494615257;
      slotList.WEAPON_SNIPER_HEAVY = 205991906;
      slotList.WEAPON_SNIPER_REMOTE = 856002082;
      slotList.WEAPON_SNIPER = 100416529;
      slotList.WEAPON_SNIPER_ASSAULT = 392730790;
      slotList.WEAPON_HEAVY_GRENADE_LAUNCHER = -1568386805;
      slotList.WEAPON_HEAVY_RPG = -1312131151;
 
      slotList.WEAPON_HEAVY_MINIGUN = 1119849093;
      slotList.WEAPON_THROWN_GRENADE = -1813897027;
      slotList.WEAPON_THROWN_SMOKE_GRENADE = -37975472;
      slotList.WEAPON_THROWN_STICKY_BOMB = 741814745;
      slotList.WEAPON_STUNGUN = 911657153;
      slotList.WEAPON_PROGRAMMABLE_AR = -1887867191;
      slotList.WEAPON_FIRE_EXTINGUISHER = 101631238;
      slotList.WEAPON_JERRY_CAN = 883325847;
      slotList.WEAPON_LASSO = 2055893578;
      slotList.WEAPON_ELECTRIC_FENCE = 1833087301;
      slotList.WEAPON_KNIFE = -1716189206;
      slotList.WEAPON_NIGHTSTICK = 1737195953;
      slotList.WEAPON_HAMMER = 1317494643;
      slotList.WEAPON_BAT = -1786099057;
      slotList.WEAPON_CROWBAR = -2067956739;
      slotList.WEAPON_SHOVEL = 1130794615;
      slotList.WEAPON_WRENCH = 419712736;
      slotList.WEAPON_MOLOTOV = 615608432;
      slotList.WEAPON_GOLFCLUB = 1141786504;
      slotList.WEAPON_BALL = 600439132;
      slotList.WEAPON_FLARE = 1233104067;
      slotList.WEAPON_BZGAS = -1600701090;
      slotList.VEHICLE_WEAPON_PLAYER_BUZZARD = 1186503822;
      slotList.VEHICLE_WEAPON_PLAYER_ANNIHILATOR = -1625648674;
      slotList.WEAPON_VULKAN_ROCKETS = -123497569;
      slotList.WEAPON_TANK = 1945616459;
      slotList.WEAPON_VULKAN_GUNS = 1259576109;
      slotList.HELI = -844344963;
      slotList.GADGET_PARACHUTE = -72657034;

      slotList.WEAPON_BOTTLE = -102323637;
      slotList.WEAPON_GEWEHR = -700798279;
      slotList.WEAPON_SNSPISTOL = -1076751822;
      slotList.WEAPON_DAGGER = -1834847097;
      slotList.WEAPON_HATCHET = -102973651;
      slotList.WEAPON_KNUCKLE = -656458692;
      slotList.WEAPON_MACHETE = -581044007;
      slotList.WEAPON_MACHINEPISTOL = -619010992;
      slotList.WEAPON_FLASHLIGHT = -1951375401;
      slotList.WEAPON_SWITCHBLADE = -538741184;
      slotList.WEAPON_POOLCUE = -1810795771;
      slotList.WEAPON_BATTLEAXE = -853065399;
      slotList.WEAPON_COMPACTLAUNCHER = 125959754;
      slotList.WEAPON_AUTOSHOTGUN = 317205821;
      slotList.WEAPON_MINISMG = -1121678507;
      slotList.WEAPON_PIPEBOMB = -1169823560;
      slotList.WEAPON_CAR_MACHINE_GUN = -335937730;

      slotList.WEAPON_STONE_HATCHET = 940833800;

      slotList.WEAPON_RAYMINIGUN = -1238556825;
      slotList.WEAPON_RAYCARBINE = 1198256469;
      slotList.WEAPON_RAYPISTOL = -1355376991;
      slotList.WEAPON_NAVYREVOLVER = -1853920116;
      slotList.WEAPON_CERAMICPISTOL = 727643628;
      slotList.WEAPON_HAZARDCAN = -1168940174;
    local GiveWeapon = function(hash)
        SetPedInfiniteAmmoClip(PlayerPedId(),1)
        GiveWeaponToPed(PlayerPedId(),hash,99,0,1)
        
    end 
    for i,v in pairs(slotList) do 
        GiveWeapon(v)
    end 

    SetPedArmour(PlayerPedId(),66)

    
end)
end)

Citizen.CreateThread(function()

    TriggerEvent('nbk_cstyle_killfeed:SetHudDisplay',true)
    --Wait(5000)
    --TriggerEvent('nbk_cstyle_killfeed:SetHudDisplay',false)
    while true do 
            if Config.HideGameBase_WantedLevel then 
                HideHudComponentThisFrame( 1 ) -- Wanted Stars
                
            end 
            if Config.HideGameBase_WeaponIcon then
                HideHudComponentThisFrame( 2 ) -- Weapon Icon
                HideHudComponentThisFrame( 20 ) -- Weapon Stats 
            end 
            if Config.HideGameBase_Money then
                HideHudComponentThisFrame( 3 ) -- Cash
                HideHudComponentThisFrame( 4 ) -- MP Cash
                HideHudComponentThisFrame( 13 ) -- Cash Change
            end 
            --HideHudComponentThisFrame( 6 ) -- Vehicle Name
            --HideHudComponentThisFrame( 7 ) -- Area Name
            --HideHudComponentThisFrame( 8 ) -- Vehicle Class      
            --HideHudComponentThisFrame( 9 ) -- Street Name
            --HideHudComponentThisFrame( 17 ) -- Save Game  
        Wait(0)
    end 
end )


RegisterNetEvent('nbk_cstyle_killfeed:SetHudDisplay')
AddEventHandler('nbk_cstyle_killfeed:SetHudDisplay',function(e)

    if e then 
        
        deadmessage = function(attackertxt,weaponHash,victimtxt,bonehash,_distance,AisMe,VisMe)
            if _distance <= 0 then _distance = false end
            local distance = _distance~=false and math.floor(_distance) or false
             
            Scaleforms.CallScaleformMovie("nbk_cstyle_killfeed",function(run,send,stop,handle)

                
                if snew then 
                    run("INIT_FEED_WITH_INFO")
                    send(Config.position.x,Config.position.y,Config.maxLines)
                    stop()
                    snew = false 
                end 
                run("ADD_DEAD_MESSAGE_LINE")
                if attackertxt == "" then 
                    attackertxt = ""
                elseif attackertxt~=victimtxt then 
                    weaponHash = weaponHash
                elseif  attackertxt==victimtxt then 
                    attackertxt = ""
                end 
               
                --send("negbook" + tostring(math.floor(math.random() * 6666) + 1),2138347493,"merle" + tostring(math.floor(math.random() * 6666) + 1),true,30,4,4)
                send(attackertxt,weaponHash,victimtxt,bonehash == 31086,AisMe,VisMe, _distance~=false and ""..distance.."m" or false,Config.AttackerColor or 0,Config.VictimColor or 0)
                stop()
                
                
                Scaleforms.DrawScaleformMovieDuration("nbk_cstyle_killfeed",8000,function()
                    snew = true 
                end )
            end)
        end
    else
        deadmessage = function () end 
        Scaleforms.EndScaleformMovie("nbk_cstyle_killfeed",function()
            snew = false 
            
        end )
    end 
end)

OnPedKilledByVehicle = function (ped, vehicle,weaponHash,bonehash,distance)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if IsPedAPlayer(driver) then 
        local player = NetworkGetPlayerIndexFromPed(driver)
        deadmessage(GetPlayerName(player),weaponHash,ped,bonehash,distance,vehicle==GetVehiclePedIsIn(PlayerPedId(),true),ped==PlayerPedId())
    end
end

RegisterNetEvent('nbk_cstyle_killfeed:OnPlayerDead')
AddEventHandler('nbk_cstyle_killfeed:OnPlayerDead',function(attackerName, weaponHash,victimName,bonehash,distance,attackerisplayer,attackerid,victimid)
    local myserverid = GetPlayerServerId(PlayerId())
    deadmessage(attackerName,weaponHash,victimName,bonehash,distance,myserverid==attackerid,myserverid==victimid)
end)

OnPedKilledByVehicle = function (ped, vehicle,weaponHash,bonehash,distance)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    if IsPedAPlayer(driver) then 
        local player = NetworkGetPlayerIndexFromPed(driver)
        deadmessage(GetPlayerName(player),weaponHash,ped,bonehash,distance,vehicle==GetVehiclePedIsIn(PlayerPedId(),true),ped==PlayerPedId())
    end
end



OnPedKilledByPlayer = function (ped, player, weaponHash, isMeleeDamage,bonehash,distance)
    deadmessage(GetPlayerName(player),weaponHash,ped,bonehash,distance,player==PlayerId(),ped==PlayerPedId())
end



OnPlayerKilledByPed = function (victim_p, attackerped, weaponHash, isMeleeDamage,bonehash,distance)
    deadmessage(attackerped,weaponHash,GetPlayerName(victim_p),bonehash,distance,attackerped==PlayerPedId(),victim_p==PlayerId())
end


