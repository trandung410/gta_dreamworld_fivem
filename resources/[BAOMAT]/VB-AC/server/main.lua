local BanList = {}
local BlacklistedPropList = {}
local WhitelistedPropList = {}
local BlacklistedExplosionsList = {}
local ResourceMetadata = {}
local ResourceFiles = {}
local canbanforentityspawn = false

--
-- MAIN EVENTS
-- 
if VB_AC.UseESX then
    TriggerEvent(VB_AC.ESXTrigger, function(obj) ESX = obj end)
    ESX.RegisterServerCallback('fx4XO610W8ZMIBaz1iTU', function(source, callback)
        local _src = source
        local _char = ESX.GetPlayerFromId(_src)
        if _char ~= nil then
            local _charmoney = _char.getMoney()
            local _charbank = _char.getAccount('bank').money
            if _charmoney ~= nil and _charbank ~= nil then
                local tosend = {
                    _charmoney,
                    _charbank
                }
                callback(tosend)
            end
        end
    end)
    RegisterNetEvent('OvqsM1NM4Mu2PCAVEECL')
    AddEventHandler('OvqsM1NM4Mu2PCAVEECL', function(efectivo, banco)
        local _src = source
        local _char = ESX.GetPlayerFromId(_src)
        if _char ~= nil then
            local _charmoney = _char.getMoney()
            local _charbank = _char.getAccount('bank').money
            if _charmoney ~= nil and efectivo ~= nil then
                if tonumber(_charmoney) > tonumber(efectivo) then
                    local amount = tonumber(_charmoney) - tonumber(efectivo)
                    if amount > VB_AC.MaxTransferAmount then 
                        LogDetection(_src, "Player spawned/received "..amount.." in cash", "basic")
                    end
                end
                if tonumber(_charbank) > tonumber(banco) then
                    local amount = tonumber(_charbank) - tonumber(banco)
                    if amount > VB_AC.MaxTransferAmount then
                        LogDetection(_src, "Player spawned/deposited "..amount.." in his/her bank account", "basic")
                    end
                end
            end
        end
    end)
end

RegisterNetEvent('PJHxig0KJQFvQsrIhd5h')
AddEventHandler('PJHxig0KJQFvQsrIhd5h', function(Metadata, Files)
    local _src = source
    local _mdata = Metadata
    local _files = Files
    if _mdata ~= nil then
        for k,v in pairs(_mdata) do
            if not VB_AC.WhitelistedResources[k] then
                if not ResourceMetadata[k] then
                    LogDetection(_src, "Abnormal resource injection. Resource: "..k,"basic")
                    kickandbanuser(" Resource Injection", _src)
                end
                if json.encode(ResourceMetadata[k]) ~= json.encode(_mdata[k]) then
                    LogDetection(_src, "Resource metadata not valid in resource: "..k,"basic")
                    kickandbanuser(" Resource Injection", _src)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                LogDetection(_src, "Executor detected: "..k,"basic")
                kickandbanuser(" Resource Injection", _src)
            end
        end
        for k,v in pairs(ResourceMetadata) do
            if not VB_AC.WhitelistedResources[k] then
                if not _mdata[k] then
                    LogDetection(_src, "Injection: Resource stopped: "..k,"basic")
                    kickandbanuser(" Resource Injection", _src)
                end
                if json.encode(_mdata[k]) ~= json.encode(ResourceMetadata[k]) then
                    LogDetection(_src, "Resource metadata not valid in resource: "..k,"basic")
                    kickandbanuser(" Resource Injection", _src)
                end
            end
            if k == "unex" or k == "Unex" or k == "rE" or k == "redENGINE" or k == "Eulen" then
                LogDetection(_src, "Executor detected: "..k,"basic")
                kickandbanuser(" Resource Injection", _src)
            end
        end
    end
    if _files ~= nil then
        for k,v in pairs(_files) do
            if not VB_AC.WhitelistedResources[k] then
                if json.encode(ResourceFiles[k]) ~= json.encode(v) then
                    LogDetection(_src, "Client script files modified in resource: "..k,"basic")
                    kickandbanuser(" Resource Injection", _src)
                end
            end
        end
    end
end)

RegisterServerEvent("Ue53dCG6hctHvrOaJB5Q")
AddEventHandler("Ue53dCG6hctHvrOaJB5Q", function(type, item)
    local _type = type or "default"
    local _item = item or "none"
    local _src = source
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, "vbacbypass") and not IsPlayerAceAllowed(_src, "vbacadmin") then
        if (_type == "invisible") then
            LogDetection(_src, "Tried to be Invisible","basic")
            kickandbanuser(" Invisible Player Detected", _src)
        elseif (_type == "godmode") then
            LogDetection(_src, "Tried to use GodMode. Type: ".._item,"basic")
            kickandbanuser(" GodMode Detected", _src)
        elseif (_type == "antiragdoll") then
            LogDetection(_src, "Tried to activate Anti-Ragdoll","basic")
            kickandbanuser(" AntiRagdoll Detected", _src)
        elseif (_type == "displayradar") then
            LogDetection(_src, "Tried to activate Radar","basic")
            kickandbanuser(" Radar Detected", _src)
        elseif (_type == "explosiveweapon") then
            LogDetection(_src, "Tried to change bullet type","explosion")
            kickandbanuser(" Weapon Explosion Detected", _src)
        elseif (_type == "spectatormode") then
            LogDetection(_src, "Tried to Spectate a Player","basic")
            kickandbanuser(" Spectate Detected", _src)
        elseif (_type == "speedhack") then
            LogDetection(_src, "Tried to SpeedHack","basic")
            kickandbanuser(" SpeedHack Detected", _src)
        elseif (_type == "blacklistedweapons") then
            LogDetection(_src, "Tried to spawn a Blacklisted Weapon","basic")
            kickandbanuser(" Weapon in Blacklist Detected", _src)
        elseif (_type == "thermalvision") then
            LogDetection(_src, "Tried to use Thermal Camera","basic")
            kickandbanuser(" Thermal Camera Detected", _src)
        elseif (_type == "nightvision") then
            LogDetection(_src, "Tried to use Night Vision","basic")
            kickandbanuser(" Night Vision Detected", _src)
        elseif (_type == "antiresourcestop") then
            LogDetection(_src, "Tried to stop/start a Resource","basic")
            kickandbanuser(" Resource Stopped", _src)
        elseif (_type == "licenseclear") then
            LogDetection(_src, "Tried to Clear His Licenses","basic")
            kickandbanuser(" AntiLicenseClear", _src)
        elseif (_type == "luainjection") then
            LogDetection(_src, "Tried to Inject a Menu","basic")
            kickandbanuser(" Injection Detected", _src)
        elseif (_type == "keyboardinjection") then
            LogDetection(_src, "(AntiKeyBoardInjection)","basic")
            kickandbanuser(" Injection Detected", _src)
        elseif (_type == "cheatengine") then
            LogDetection(_src, "Tried to use CheatEngine to change Vehicle Hash","basic")
            kickandbanuser(" CheatEngine Detected", _src)
        elseif (_type == "pedchanged") then
            LogDetection(_src, "Tried to change his PED","model")
            kickandbanuser(" Ped Changed", _src)
        elseif (_type == "freecam") then
            LogDetection(_src, "Tried to use Freecam (Fallout or similar)","basic")
            kickandbanuser(" FreeCam Detected", _src)
        elseif (_type == "noclip") then
            LogDetection(_src, "Tried to use NoClip","basic")
            kickandbanuser(" NoClip Detected", _src)
        elseif (_type == "playerblips") then
            LogDetection(_src, "Tried to put Player Blips","basic")
            kickandbanuser(" Blips Detected", _src)
        elseif (_type == "damagemodifier") then
            LogDetection(_src, "Tried to change Weapon's Bullet Damage. Type: ".._item,"basic")
            kickandbanuser(" Weapon Damage Modifier Detected", _src)
        elseif (_type == "clipmodifier") then
            LogDetection(_src, "Tried to modify a Weapon clip. Type: ".._item,"basic")
            kickandbanuser(" Weapon Clip Modifier Detected", _src)
        elseif (_type == "infiniteammo") then
            LogDetection(_src, "Tried to put Infinite Ammo","basic")
            kickandbanuser(" Infinite Ammo Detected", _src)
        elseif (_type == "vehiclemodifier") then
            local type = tonumber(_item)
            if VB_AC.UseESX then
                local _char = ESX.GetPlayerFromId(_src)
                local _job = _char.job.name
                if type == 1 or type == 2 or type == 3 or type == 4 or type == 5 or type == 6 then
                    LogDetection(_src, "Tried to modify vehicle features. Type: ".._item,"model")
                    kickandbanuser(" Vehicle Modifier Detected.", _src)
                else
                    if _job ~= VB_AC.MechanicJobName then
                        LogDetection(_src, "Tried to modify vehicle features. Type: ".._item,"model")
                        kickandbanuser(" Vehicle Modifier Detected.", _src)
                    end
                end
            else
                if type == 1 or type == 2 or type == 3 or type == 4 or type == 5 or type == 6 then
                    LogDetection(_src, "Tried to modify vehicle features. Type: ".._item,"model")
                    kickandbanuser(" Vehicle Modifier Detected.", _src)
                end
            end
        elseif (_type == "stoppedac") then
            LogDetection(_src, "Tried to stop the Anticheat","basic")
            kickandbanuser(" AntiResourceStop", _src)
        elseif (_type == "stoppedresource") then
            LogDetection(_src, "Tried to stop a resource: ".._item,"basic")
            kickandbanuser(" AntiResourceStop", _src)
        elseif (_type == "resourcestarted") then
            LogDetection(_src, "Tried to start a resource: ".._item,"basic")
            kickandbanuser(" AntiResourceStart", _src)
        elseif (_type == "resourceinjection") then
            LogDetection(_src, "Tried to inject a resource: ".._item,"basic")
            kickandbanuser(" AntiResourceStart", _src)
        elseif (_type == "commandinjection") then
            LogDetection(_src, "Tried to inject a command.","basic")
            kickandbanuser(" AntiCommandInjection", _src)
        elseif (_type == "menyoo") then
            LogDetection(_src, "Tried to inject Menyoo Menu.","basic")
            kickandbanuser(" Anti Menyoo", _src)
        elseif (_type == "antisuicide") then
            LogDetection(_src, "Tried to SUICIDE using a menu","basic")
            kickandbanuser(" Anti Suicide", _src)
        elseif (_type == "givearmour") then
            LogDetection(_src, "Tried to Give Armor.","basic")
            kickandbanuser(" Anti Give Armor", _src)
        elseif (_type == "weirdresource") then
            LogDetection(_src, "Tried to inject a resource with a lot of letters (Change Resource Name if you get banned while entering the server) Resource: ".._item,"basic")
            kickandbanuser(" Weird Resource Started", _src)
        elseif (_type == "receivedpickup") then
            LogDetection(_src, "Pickup received. Args: ".._item,"basic")
        elseif (_type == "aimassist") then
            LogDetection(_src, "Aim Assist Detected. Mode: ".._item,"basic")
        elseif (_type == "blacklistedtask") then
            LogDetection(_src, "Tried to execute a blacklisted task. Task ID: ".._item,"basic")
            kickandbanuser(" Blacklisted Task", _src)
        elseif (_type == "blacklistedanim") then
            LogDetection(_src, "Tried executing a blacklisted anim. This player might not be a cheater. Anim: ".._item,"basic")
            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearpeds" , -1) -- Delete this if you don't want peds to be removed after detecting this anim
        elseif (_type == "infinitestamina") then
            LogDetection(_src, "Tried to use Infinite Stamina (BETA)","basic")
            kickandbanuser(" Anti Infinite Stamina", _src)
        elseif (_type == "shotplayerwithoutbeingonhisscreen") then
            LogDetection(_src, "Hit a Player Without Being in his Screen. Possible Aimbot/TriggerBot/RageBot. Distance Difference: ".._item,"basic")
            kickandbanuser(" Anti Aimbot/TriggerBot", _src)
        elseif (_type == "aimbot") then
            LogDetection(_src, "Aimbot detected (BETA). Type:" .._item,"basic")
            kickandbanuser(" Anti Aimbot", _src)
        elseif (_type == "onscreenmenudetection") then
            LogDetection(_src, "On Screen Menu Detection (BETA). Blacklisted word detected in Player's screen: " .._item,"basic")
            kickandbanuser(" Inyection Detected", _src)
        end
    end
end)

RegisterNetEvent('7ZYhfWQtmoA369TBJ5G8')
AddEventHandler('7ZYhfWQtmoA369TBJ5G8', function(resource, info)
    local _src = source
    if resource ~= nil and info ~= nil then
        LogDetection(_src, "Injection detected in resource: "..resource.. " Type: "..info, "basic")
        kickandbanuser(" Injection detected", _src)
    end
end)

RegisterNetEvent('5a1Ltc8fUyH3cPvAKRZ8')
AddEventHandler('5a1Ltc8fUyH3cPvAKRZ8', function()
    local _src = source
    if IsPlayerUsingSuperJump(_src) then
        LogDetection(_src, "SuperJump Detected.", "basic")
        kickandbanuser(" SuperJump Detected", _src)
    end
end)

RegisterNetEvent('pcIRIvXPEWe12SxRepMz')
AddEventHandler('pcIRIvXPEWe12SxRepMz', function(coords)
    local _src = source
    if not coords then
        LogDetection(_src, "Revive Detected.", "basic")
        kickandbanuser("Revive Detected", _src)
    else
        TriggerClientEvent('ZRQA3nmMqUBOIiKwH4I5:cancelnoclip', _src)
    end
end)

RegisterNetEvent('luaVRV3cccsj9q6227jN')
AddEventHandler('luaVRV3cccsj9q6227jN', function(isneargarage, coords)
    local _src = source
    if not isneargarage then
        LogDetection(_src, "Vehicle Spawn Detected in Abnormal Coords: "..coords, "basic")
        kickandbanuser(" Vehicle Spawn Detected", _src)
    end
end)

RegisterNetEvent('SBmQ5ucMg4WGbpPHoSTl')
AddEventHandler('SBmQ5ucMg4WGbpPHoSTl', function()
    local _src = source
    if not canbanforentityspawn then
        canbanforentityspawn = true
    end
    if IsPlayerAceAllowed(_src, "vbacadmin") then
        TriggerClientEvent('MEBjy6juCnscQrxcDzvs', _src)
    end
end)

RegisterNetEvent('cq1PxSiVi0iCw0maULS3')
AddEventHandler('cq1PxSiVi0iCw0maULS3', function()
    if IsPlayerAceAllowed(source, "vbacadmin") then
        TriggerClientEvent('ZRQA3nmMqUBOIiKwH4I5:clearvehicles', -1)
    end
end)

RegisterNetEvent('xsc8yaDNYGoCMvAWogff')
AddEventHandler('xsc8yaDNYGoCMvAWogff', function()
    if IsPlayerAceAllowed(source, "vbacadmin") then
        TriggerClientEvent('ZRQA3nmMqUBOIiKwH4I5:clearprops', -1)
    end
end)

RegisterNetEvent('m0QCCVqpGuCSLNBc60Tc')
AddEventHandler('m0QCCVqpGuCSLNBc60Tc', function()
    if IsPlayerAceAllowed(source, "vbacadmin") then
        TriggerClientEvent('ZRQA3nmMqUBOIiKwH4I5:clearpeds', -1)
    end
end)

RegisterNetEvent('tBtysfoC96Vx4JK8p3pW')
AddEventHandler('tBtysfoC96Vx4JK8p3pW', function()
    local _src = source
    if IsPlayerAceAllowed(source, "vbacadmin") then
        local players = {}
        for _,v in pairs(GetPlayers()) do
            table.insert(players, {
                name = GetPlayerName(v),
                id = v
            })
        end
        TriggerClientEvent('ppskINSwjmAXyHcpLLp', _src, players)
    end
end)

--
-- COMMANDS
--

RegisterCommand('reloadacbans', function(source)
    local _src = source
    if _src ~= 0 then
        if IsPlayerAceAllowed(_src, "vbacbypass") or IsPlayerAceAllowed(_src, "vbacadmin") then
            loadBanList()
            TriggerClientEvent('chat:addMessage', _src, {args = {"^*^7[^1VB-AC^7]: BanList Reloaded"}})
        end
    else
        loadBanList()
        print("^*^7[^1VB-AC^7]: BanList Reloaded")
    end
end, false)

--
-- THREADS
--

Citizen.CreateThread(function()
    Citizen.Wait(3000)
    while true do
        loadBanList()
        Citizen.Wait(VB_AC.ReloadBanListTime)
    end
end)

Citizen.CreateThread(function()
    explosionsSpawned = {}
    vehiclesSpawned = {}
    pedsSpawned = {}
    entitiesSpawned = {}
    particlesSpawned = {}
    while true do
        Citizen.Wait(VB_AC.ReloadEntityTime) -- augment/lower this if you want.
        explosionsSpawned = {}
        vehiclesSpawned = {}
        pedsSpawned = {}
        entitiesSpawned = {}
        particlesSpawned = {}
    end
end)

--
-- EVENT HANDLERS
--

AddEventHandler('playerConnecting', function (playerName,setKickReason, deferrals)
    local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

    local _src = source

    for k,v in ipairs(GetPlayerIdentifiers(_src))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamID = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid  = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
        end
    end
    local tokens = {}
    for it = 0, GetNumPlayerTokens(_src) do
        table.insert(tokens, GetPlayerToken(_src, it))
    end
    for i = 1, #BanList, 1 do
        if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].identifier)) == tostring(steamID) or (tostring(BanList[i].liveid)) == tostring(liveid) or (tostring(BanList[i].xblid)) == tostring(xblid) or (tostring(BanList[i].discord)) == tostring(discord) or (tostring(BanList[i].playerip)) == tostring(playerip)) then
            setKickReason("[VB-AC] YYou've been permanently banned for: " .. BanList[i].reason)
            print("^6[VB-AC] - ".. GetPlayerName(_src) .." is trying to join the server, but he/she's banned ;(")
            CancelEvent()
        end
        local bannedtokens = json.decode(BanList[i].token)
        for k,v in pairs(bannedtokens) do
            for i3 = 1, #tokens, 1 do
                if v == tokens[i3] then
                    setKickReason("[VB-AC] You've been permanently banned for: " .. BanList[i].reason)
                    print("^6[VB-AC] - ".. GetPlayerName(_src) .." is trying to join the server, but he/she's banned ;(")
                    CancelEvent()
                end
            end
        end
    end
    if VB_AC.AntiVPN then
        local _playerip = tostring(GetPlayerEndpoint(_src))
        if not VB_AC.WhitelistedIPS[_playerip] then
            deferrals.defer()
            Wait(0)
            deferrals.update("[VB-AC]: Checking and securing your connection...")
            PerformHttpRequest("https://blackbox.ipinfo.app/lookup/" .. _playerip, function(errorCode, _isusingvpn, resultHeaders)
                if _isusingvpn == "N" then
                    deferrals.done()
                else
                    print("^6[VB-AC]^0: The user ^0" .. playerName .. " ^1has been kicked for using a VPN, ^8IP: ^0" .. _playerip .. "^0")
                    deferrals.done("[VB-AC]: We've detected a VPN/Proxy in your machine. Please disable it or ask the server owners.")
                end
            end)
        end
    end
end)

AddEventHandler("entityCreating", function(entity)
    if canbanforentityspawn then
        if DoesEntityExist(entity) then
            local _src = NetworkGetEntityOwner(entity)
            local model = GetEntityModel(entity)
            local _entitytype = GetEntityPopulationType(entity)
            if _src == nil then
                CancelEvent()
            end
            
            if _entitytype == 0 then
                if inTable(WhitelistedPropList, model) == false then
                    if model ~= 0 and model ~= 225514697 then
                        LogDetection(_src, "Tried to spawn a blacklisted prop : " .. model,"model")
                        kickandbanuser(" Blacklisted Prop", _src)
                        CancelEvent()
                        entitiesSpawned[_src] = (entitiesSpawned[_src] or 0) + 1
                        if entitiesSpawned[_src] > VB_AC.MaxEntitiesPerUser then
                            LogDetection(_src, "Tried to spawn "..entitiesSpawned[_src].." props","model")
                            kickandbanuser(" Mass Prop Spawn", _src)
                            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearprops" , -1)
                        end
                    end
                end
            end
            
            if GetEntityType(entity) == 3 then
                if _entitytype == 6 or _entitytype == 7 then
                    if inTable(WhitelistedPropList, model) == false then
                        if model ~= 0 then
                            LogDetection(_src, "Tried to spawn a blacklisted prop: " .. model,"model")
                            kickandbanuser(" Blacklisted Prop", _src)
                            CancelEvent()
                            entitiesSpawned[_src] = (entitiesSpawned[_src] or 0) + 1
                            if entitiesSpawned[_src] > VB_AC.MaxPropsPerUser then
                                LogDetection(_src, "Tried to spawn "..entitiesSpawned[_src].." props","model")
                                kickandbanuser(" Mass Prop Spawn", _src)
                                TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearprops" , -1)
                            end
                        end
                    end
                end
            else
                if GetEntityType(entity) == 2 then
                    if _entitytype == 6 or _entitytype == 7 then
                        if inTable(BlacklistedPropList, model) ~= false then
                            if model ~= 0 then
                                LogDetection(_src, "Tried to spawn a blacklisted vehicle : " .. model,"model")
                                kickandbanuser(" Blacklisted Vehicle", _src)
                                CancelEvent()
                            end
                        end
                        vehiclesSpawned[_src] = (vehiclesSpawned[_src] or 0) + 1
                        if vehiclesSpawned[_src] > VB_AC.MaxVehiclesPerUser then
                            LogDetection(_src, "Tried to spawn "..vehiclesSpawned[_src].." vehicles","model")
                            kickandbanuser(" Mass Vehicle Spawn", _src)
                            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearvehicles" , -1, _src) -- Only deletes source's spawned vehs.
                            CancelEvent()
                        end
                        -- ANTIVEHICLESPAWN
                        TriggerClientEvent('ZRQA3nmMqUBOIiKwH4I5:checkifneargarage', _src)
                    end
                elseif GetEntityType(entity) == 1 then
                    if _entitytype == 6 or _entitytype == 7 then
                        if inTable(BlacklistedPropList, model) ~= false then
                            if model ~= 0 or model ~= 225514697 then
                                LogDetection(_src, "Tried to spawn a blacklisted PED : " .. model,"model")
                                kickandbanuser(" Blacklisted Ped", _src)
                                CancelEvent()
                            end
                        end
                        pedsSpawned[_src] = (pedsSpawned[_src] or 0) + 1
                        if pedsSpawned[_src] > VB_AC.MaxPedsPerUser then
                            LogDetection(_src, "Tried to spawn "..pedsSpawned[_src].." peds","model")
                            kickandbanuser(" Mass Ped Spawn", _src)
                            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearpeds" , -1)
                        end
                    end
                else
                    if inTable(BlacklistedPropList, GetHashKey(entity)) ~= false then
                        if model ~= 0 or model ~= 225514697 then
                            LogDetection(_src, "Tried to spawn a blacklisted prop: " .. model,"model")
                            kickandbanuser(" Blacklisted Prop", _src)
                            CancelEvent()
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler("explosionEvent", function(sender, exp)
    if VB_AC.ExplosionProtection then
        if exp.damageScale ~= 0.0 then
            if inTable(BlacklistedExplosionsList, exp.explosionType) ~= false then
                CancelEvent()
                LogDetection(sender, "Tried to create an explosion - Type : "..exp.explosionType,"explosion")
                kickandbanuser(" Blacklisted Explosion", sender)
            end
            if exp.explosionType ~= 9 then
                explosionsSpawned[sender] = (explosionsSpawned[sender] or 0) + 1
                if explosionsSpawned[sender] > 3 then
                    LogDetection(sender, "Tried to spawn mass explosions - Type : "..exp.explosionType,"explosion")
                    kickandbanuser(" Mass Explosions", sender)
                    CancelEvent()
                end
            else
                explosionsSpawned[sender] = (explosionsSpawned[sender] or 0) + 1
                if explosionsSpawned[sender] > 3 then
                    LogDetection(sender, "Tried to spawn mass explosions - Type: (gas pump)","explosion")
                    kickandbanuser(" Mass Explosions", sender)
                    CancelEvent()
                end
            end
            if exp.damageScale > 1.0 then
                LogDetection(sender, "Tried to spawn a mortal explosion. Type : "..exp.explosionType,"explosion")
                kickandbanuser(" Explosion Detected", sender)
            end
            if exp.isInvisible == true then
                LogDetection(sender, "Tried to spawn an invisible explosion. Type : "..exp.explosionType,"explosion")
                kickandbanuser(" Invisible Explosion Detected", sender)
            end
            if exp.isAudible == false then
                LogDetection(sender, "Tried to spawn a silent explosion. Type : "..exp.explosionType,"explosion")
                kickandbanuser(" Silent Explosion Detected", sender)
            end
            CancelEvent()
        end
    end
end)

AddEventHandler('ptFxEvent', function(sender, data)
    local _src = sender
    particlesSpawned[_src] = (particlesSpawned[_src] or 0) + 1
    if particlesSpawned[_src] > VB_AC.MaxParticlesPerUser then
        LogDetection(_src, "Has tried to spawn "..particlesSpawned[_src].." particles","model")
        kickandbanuser(" Mass Particle Spawn", _src)
        CancelEvent()
    end
end)

AddEventHandler("weaponDamageEvent", function(sender, data)
    if VB_AC.UseESX and VB_AC.AntiTazePlayers then
        local _src = sender
        local _char = ESX.GetPlayerFromId(_src)
        if _char ~= nil and not VB_AC.WhitelistedJobs[_char.job.name] and data.weaponType == 911657153 or data.weaponType == GetHashKey("WEAPON_STUNGUN") then
            LogDetection(_src, "Tried to shoot with a taser without having a whitelisted job.","model")
            kickandbanuser(" Anti Taze Player", _src)
            CancelEvent()
        end
    end
end)

AddEventHandler("respawnPlayerPedEvent", function(player)
    TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:checknearbypeds", player)
end)

AddEventHandler("giveWeaponEvent", function(sender, data)
    if VB_AC.AntiGiveorRemoveWeapons then
        if data.givenAsPickup == false then
            LogDetection(sender, "Tried to give weapons to a Ped (GiveWeaponToPed)","basic")
            kickandbanuser(" GiveWeaponToPed", sender)
            CancelEvent()
        end
    end
end)

AddEventHandler("removeWeaponEvent", function(sender, data)
    LogDetection(sender, "Tried to remove weapons to player.","basic")
    kickandbanuser(" Weapons Removed", sender)
    CancelEvent()
end)

AddEventHandler("removeAllWeaponsEvent", function(sender, data)
    LogDetection(sender, "Tried to remove all weapons from a player.","basic")
    kickandbanuser(" Remove All Weapons", sender)
    CancelEvent()
end)

AddEventHandler("chatMessage", function(source, name, message)
    local _src = source
    if VB_AC.AntiBlacklistedWords then
        for k, word in pairs(VB_AC.BlacklistedWords) do
            if string.match(message:lower(), word:lower()) then
                LogDetection(_src, "Tried to say a blacklisted word : " .. word,"basic")
                kickandbanuser(" Blacklisted Word", _src)
            end
        end
    end
    if VB_AC.AntiFakeChatMessages then
        local _playername = GetPlayerName(_src);
        if name ~= _playername then
            LogDetection(_src, "Tried to fake a chat message (Fake Message) : " .. message,"basic")
            kickandbanuser(" Fake Chat Message", _src)
        end
    end
end)

AddEventHandler("clearPedTasksEvent", function(source, data)
    if VB_AC.AntiClearPedTasks then
        if data.immediately then
            LogDetection(source, "Tried to Clear Ped Tasks Inmediately","basic")
            kickandbanuser(" Clear Peds Tasks Inmediately", source)
            CancelEvent()
        end
        local entity = NetworkGetEntityFromNetworkId(data.pedId)
        local sender = tonumber(source)
        if DoesEntityExist(entity) then
            local owner = NetworkGetEntityOwner(entity)
            if owner ~= sender then
                LogDetection(source, "Tried to ClearPedTasks to another player","basic")
                kickandbanuser(" Clear Peds Tasks", source)
                CancelEvent()
            end
        end
    end
end)

-- Resource Started Print (Don't remove this 😢)                                         

AddEventHandler('onResourceStart', function(resourceName)
    Citizen.Wait(1000)

    if GetCurrentResourceName() == resourceName then
        
        for k, v in pairs(VB_AC.BlacklistedModels) do
            table.insert(BlacklistedPropList, GetHashKey(v))
        end
        
        for k,v in pairs(VB_AC.WhitelistedProps) do
            table.insert(WhitelistedPropList, GetHashKey(v))
        end

        for k,v in pairs(VB_AC.BlockedExplosions) do
            table.insert(BlacklistedExplosionsList, v)
        end

        if VB_AC.AntiBlacklistedTriggers then
            for k, trigger in pairs(VB_AC.BlacklistedTriggers) do
                RegisterServerEvent(trigger)
                AddEventHandler(trigger, function()
                    LogDetection(source, "Tried to execute a blacklisted trigger: " .. trigger,"basic")
                    kickandbanuser(" Blacklisted Trigger", source)
                    CancelEvent()
                end)
            end
        end

        for i = 0, GetNumResources()-1, 1 do
            local resource = GetResourceByFindIndex(i)
            if GetResourceState(resource) == "started" then
                for i = 0, GetNumResourceMetadata(resource, 'client_script') do
                    local type = GetResourceMetadata(resource, 'client_script', i)
                    local file = LoadResourceFile(tostring(resource), tostring(type))
                    if ResourceMetadata[resource] == nil then
                        ResourceMetadata[resource] = {}
                    end
                    if ResourceFiles[resource] == nil then
                        ResourceFiles[resource] = {}
                    end
                    if type ~= nil then
                        table.insert(ResourceMetadata[resource], #type)
                    end
                    if file ~= nil then
                        table.insert(ResourceFiles[resource], #file)
                    end
                end
                for i = 0, GetNumResourceMetadata(resource, 'client_scripts') do
                    local type = GetResourceMetadata(resource, 'client_scripts', i)
                    local file = LoadResourceFile(tostring(resource), tostring(type))
                    if ResourceMetadata[resource] == nil then
                        ResourceMetadata[resource] = {}
                    end
                    if ResourceFiles[resource] == nil then
                        ResourceFiles[resource] = {}
                    end
                    if type ~= nil then
                        table.insert(ResourceMetadata[resource], #type)
                    end
                    if file ~= nil then
                        table.insert(ResourceFiles[resource], #file)
                    end
                end
                for i = 0, GetNumResourceMetadata(resource, 'ui_page') do
                    local type = GetResourceMetadata(resource, 'ui_page', i)
                    local file = LoadResourceFile(tostring(resource), tostring(type))
                    if ResourceMetadata[resource] == nil then
                        ResourceMetadata[resource] = {}
                    end
                    if ResourceFiles[resource] == nil then
                        ResourceFiles[resource] = {}
                    end
                    if type ~= nil then
                        table.insert(ResourceMetadata[resource], #type)
                    end
                    if file ~= nil then
                        table.insert(ResourceFiles[resource], #file)
                    end
                end
            end
        end

        print([[

        
                        ^1/$$    /$$ /$$$$$$$           /$$$$$$   /$$$$$$ 
                        ^2| $$   | $$| $$__  $$         /$$__  $$ /$$__  $$
                        ^3| $$   | $$| $$  \ $$        | $$  \ $$| $$  \__/
                        ^4|  $$ / $$/| $$$$$$$  /$$$$$$| $$$$$$$$| $$      
                         ^5\  $$ $$/ | $$__  $$|______/| $$__  $$| $$      
                          ^6\  $$$/  | $$  \ $$        | $$  | $$| $$    $$
                           ^6\  $/   | $$$$$$$/        | $$  | $$|  $$$$$$/
                            ^9\_/    |_______/         |__/  |__/ \______/
                            

            ^1DISCLAIMER: This is the most advanced of VB-AC, and includes exclusive features 
   ^1(Anti Aimbot, Anti TriggerBot, Anti Rape Players, Anti Taze Players, Anti Blacklisted Anims...)  
                                ^5VB-Scripts: https://discord.gg/EAU2DM4hdn
                                        ^5Thanks for using my script!

                                         ^2VB-AC Initialized. Enjoy!
]])   
        SetConvarServerInfo("AntiCheat:", "Protected by VB-AC v4")

        Citizen.Wait(1000)
        PerformHttpRequest("https://raw.githubusercontent.com/visibait/vbacversion/main/vb_ac-version", function(error, latestVersion, headers)
            local currentVersion = "4.0"
            if tonumber(currentVersion) < tonumber(latestVersion) then
                print("                                             VB-AC" .. " ^1is outdated.\n                                           Current version: ^8" .. currentVersion .. "\n                                            Newest version: ^2" .. latestVersion .. "\n                                ^3Update^7: https://github.com/visibait/VB-AC")
            elseif tonumber(currentVersion) > tonumber(latestVersion) then
                print("                                VB-AC" .. " has skipped the latest version ^2" .. latestVersion .. "                      Either Github is offline or the version file has been changed")
            else
                print("                                          ^2VB-AC" .. " is updated. ("..currentVersion..")")
            end
        end, "GET")
    end
end)

--
-- FUNCS
--

kickandbanuser = function(reason, servertarget)
    if not IsPlayerAceAllowed(servertarget, "vbacbypass") and not IsPlayerAceAllowed(servertarget, "vbacadmin") and VB_AC.BanPlayers then
        local target
        local reason    = reason

        if not reason then reason = "Not Specified" end

        if tostring(source) == "" then
            target = tonumber(servertarget)
        else
            target = source
        end

        if target and target > 0 then
            local ping = GetPlayerPing(target)
            if ping and ping > 0 then
                local identifier, license, xblid, playerip, discord, liveid = getidentifiers(target)
                local targetplayername = GetPlayerName(target)
                local token = {}
                for i = 0, GetNumPlayerTokens(target) do
                    table.insert(token, GetPlayerToken(target, i))
                end
                ban_user(target,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,reason)
                DropPlayer(target, "[VB-AC]:" .. reason)
            end
        end
    end
end

ban_user = function(source,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,reason)
    if not IsPlayerAceAllowed(source, "vbacbypass") and not IsPlayerAceAllowed(source, "vbacadmin") then
        MySQL.Async.execute('INSERT INTO VB_AC (token,license,identifier,liveid,xblid,discord,playerip,targetplayername,reason) VALUES (@token,@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@reason)',{
            ['@token']          = json.encode(token),
            ['@license']          = license,
            ['@identifier']       = identifier,
            ['@liveid']           = liveid,
            ['@xblid']            = xblid,
            ['@discord']          = discord,
            ['@playerip']         = playerip,
            ['@targetplayername'] = targetplayername,
            ['@reason']           = reason,
            }, function ()
        end)
        Citizen.Wait(1000)
        loadBanList()
    end
end

loadBanList = function()
    MySQL.Async.fetchAll('SELECT * FROM VB_AC', {}, function (data)
        BanList = {}
        for i=1, #data, 1 do
            table.insert(BanList, {
                token    = data[i].token,
                license    = data[i].license,
                identifier = data[i].identifier,
                liveid     = data[i].liveid,
                xblid      = data[i].xblid,
                discord    = data[i].discord,
                playerip   = data[i].playerip,
                reason     = data[i].reason
            })
        end
    end)
end

LogDetection = function(playerId, reason,bantype)
    if not IsPlayerAceAllowed(playerId, "vbacbypass") and not IsPlayerAceAllowed(playerId, "vbacadmin") then
        playerId = tonumber(playerId)
        local name = GetPlayerName(playerId)

        if name == nil then
            name = "Not Found"
        end

        local steamid, license, xbl, playerip, discord, liveid = getidentifiers(playerId)
        local discordlogimage = "https://i.imgur.com/6B1WvOo.png"
        
        local loginfo = {["color"] = "15158332", ["type"] = "rich", ["title"] = "A player has been banned by VB-AC", ["description"] =  "**Name : **" ..name .. "\n **Reason : **" ..reason .. "\n **ID : **" ..playerId .. "\n **IP : **" ..playerip.. "\n **Steam Hex : **" ..steamid .. "\n **Xbox Live : **" .. xbl .. "\n **Live ID: **" .. liveid .. "\n **Rockstar License : **" .. license .. "\n **Discord : **" .. discord, ["footer"] = { ["text"] = " © VB-AC | VisiBait#0712 - "..os.date("%c").."" }}
        if name ~= "Unknown" then
            if bantype == "basic" then
                PerformHttpRequest(VB_AC.GeneralBanWebhook, function(err, text, headers) end, "POST", json.encode({username = " VB-AC", avatar_url = discordlogimage, embeds = {loginfo}}), {["Content-Type"] = "application/json"})
            elseif bantype == "model" then
                PerformHttpRequest(VB_AC.EntitiesWebhookLog, function(err, text, headers) end, "POST", json.encode({username = " VB-AC", avatar_url = discordlogimage, embeds = {loginfo}}), {["Content-Type"] = "application/json"})
            elseif bantype == "explosion" then 
                PerformHttpRequest(VB_AC.ExplosionWebhookLog, function(err, text, headers) end, "POST", json.encode({username = " VB-AC", avatar_url = discordlogimage, embeds = {loginfo}}), {["Content-Type"] = "application/json"} )
            end
        end
        if VB_AC.ScreenshotPlayers then
            TriggerClientEvent("EuiAtK0QfujTpzWY0Mmp", playerId, VB_AC.ScreenShotWebhookLog)
        end
    end
end

inTable = function(table, item)
    for k,v in pairs(table) do
        if v == item then return true end
    end
    return false
end

getidentifiers = function(player)
    local steamid = "Not Linked"
    local license = "Not Linked"
    local discord = "Not Linked"
    local xbl = "Not Linked"
    local liveid = "Not Linked"
    local ip = "Not Linked"

    for k, v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    return steamid, license, xbl, ip, discord, liveid
end

--
-- VB-AC: ANTI INJECTION INSTALLATION FUNCS
--

RegisterCommand("vbacinstall", function(source)
    count = 0
    skip = 0
    if source == 0 then
        local randomtextfile = RandomLetter(12) .. ".lua"
        _antiinjection = LoadResourceFile(GetCurrentResourceName(), "VB-AC(AntiInjection).lua")
        for resources = 0, GetNumResources() - 1 do
            local _resname = GetResourceByFindIndex(resources)
            _resourcemanifest = LoadResourceFile(_resname, "__resource.lua")
            _resourcemanifest2 = LoadResourceFile(_resname, "fxmanifest.lua")
            if _resourcemanifest then
                Wait(100)
                _toadd = _resourcemanifest .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                print("^1[VB-AC]: Anti Injection Installed on ".._resname)
                count = count + 1
            elseif _resourcemanifest2 then
                Wait(100)
                _toadd = _resourcemanifest2 .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                print("^1[VB-AC]: Anti Injection Installed on ".._resname)
                count = count + 1
            else
                skip = skip + 1
                print("[VB-AC]: Skipped Resource: " .._resname)
            end
        end
        print("[VB-AC] Installation has finished. Succesfully installed Anti-Injection in "..count.." Resources. Skipped: "..skip.." Resources. Enjoy!")
    end
end)

RegisterCommand("vbacuninstall", function(source, args, rawCommand)
    if source == 0 then
        count = 0
        skip = 0
        if args[1] then
            local filetodelete = args[1] .. ".lua"
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[VB-AC]: Anti Injection Uninstalled on ".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[VB-AC]: Skipped Resource: " .._resname)
                    end
                elseif resourcefile2 then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[VB-AC]: Anti Injection Uninstalled on ".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[VB-AC]: Skipped Resource: " .._resname)
                    end
                else
                    skip = skip + 1
                    print("[VB-AC]: Skipped Resource: ".._resname)
                end
            end
            print("[VB-AC] UNINSTALLATION has finished. Succesfully uninstalled Anti-Injection in "..count.." Resources. Skipped: "..skip.." Resources. Enjoy!")
        else
            print("[VB-AC] You must write the file name to uninstall Anti-Injection!")
        end
    end
end)

local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end
