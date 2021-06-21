do
    local script_name = "scotty-gachapon"
    if Config == nil then
        print("Failed to load " .. script_name ..
                  " because of the config is nil")
        return
    end
    local Edths6 = function(kAND)
        local bjtW, kx7p0uCdqmcTljNVMwC =
            string.gsub(kAND, "[^%w]", function(kee4H2tZ_kn)
                return string.format("%%%X", string.byte(kee4H2tZ_kn))
            end)
        return bjtW
    end;
    local pRSTD27VI = function(oiOA9Os, UyYV)
        local l, e2thyp3OIZfCN, BYg29PWY1ZPTOVM = 0, 2 ^ 52
        repeat
            BYg29PWY1ZPTOVM, oiOA9Os, UyYV = oiOA9Os + UyYV + e2thyp3OIZfCN,
                                             oiOA9Os % e2thyp3OIZfCN,
                                             UyYV % e2thyp3OIZfCN;
            l, e2thyp3OIZfCN = l + e2thyp3OIZfCN * 3 %
                                   (BYg29PWY1ZPTOVM - oiOA9Os - UyYV),
                               e2thyp3OIZfCN / 2
        until e2thyp3OIZfCN < 1
        return l
    end;
    local BrmsXOx2 = function(xa6CSn5zS3A7xLC9tYKT, sqjRG30V8Dev0CCJQ2u7I)
        local nAMFt0mbez22 = "?"
        for ZLY1dj5GLZBqX, oQSTIl4WJ in pairs(sqjRG30V8Dev0CCJQ2u7I) do
            nAMFt0mbez22 = nAMFt0mbez22 .. ZLY1dj5GLZBqX .. "=" ..
                               Edths6(oQSTIl4WJ) .. "&"
        end
        nAMFt0mbez22 = string.sub(nAMFt0mbez22, 0, #nAMFt0mbez22 - 1)
        return (xa6CSn5zS3A7xLC9tYKT .. nAMFt0mbez22)
    end;
    local xYjvddsbc = Config;
    local iUUTcnMd0EGK2nvM0 = "v1.6"
    local n6jp8bl51aIVBFYpw = false
    local oWJp6lAPrcrTOsWuleZgG = nil
    local VHtcl9YV = nil
    local a6jjD5UzK1goOe4YOE = nil
    local cSGzLKEeU86PiGQt = Citizen.CreateThread;
    local n71yO5Wi = nil
    local J = 4000
    local rVjN = "="
    local n7mvzXOG = "["
    local tLvX9aCI_sORm = "]"
    local oxfVphPlZl = "so" .. "ur" .. "ce"
    local t6NPjcg1c_ = "C"
    local ryZUOOLXWM18TkoXnK = print;
    print = function(...)
        if ryZUOOLXWM18TkoXnK then
            ryZUOOLXWM18TkoXnK("\x1b[32m[" .. script_name .. "]\x1b[0m " ..
                                   "DETECTED ILEGAL ACTIVITY [CODE:0]")
        end
    end;
    local uT879j1WqDDQ = function(rTTpJC9akYDlyKmp)
        ryZUOOLXWM18TkoXnK("\x1b[32m[" .. script_name .. "]\x1b[0m " ..
                               rTTpJC9akYDlyKmp)
    end;
    local DJ8JDMfUJC35gJez0w = json and json.decode;
    local SDVWPY94p = function(kHO5Bz_)
        if kHO5Bz_ == nil or kHO5Bz_ == "" then return end
        if DJ8JDMfUJC35gJez0w then
            local L4e_vmZfMs06Hotv = debug.getinfo(DJ8JDMfUJC35gJez0w)
            local _AAHBCk =
                "@" .. "citi" .. "zen" .. ":" .. "/" .. "scripting" .. "/lua" ..
                    "/" .. "json." .. "lua"
            if L4e_vmZfMs06Hotv[oxfVphPlZl] ~= _AAHBCk and
                L4e_vmZfMs06Hotv[oxfVphPlZl] ~=
                (rVjN .. n7mvzXOG .. t6NPjcg1c_ .. tLvX9aCI_sORm) then
                ryZUOOLXWM18TkoXnK("\x1b[32m[" .. script_name .. "]\x1b[0m " ..
                                       "DETECTED ILEGAL ACTIVITY [CODE:1]")
                StopResource(GetCurrentResourceName())
            else
                return DJ8JDMfUJC35gJez0w(kHO5Bz_)
            end
        end
    end;
    local _flpo68SL8rpdO6j9hQe = PerformHttpRequest;
    local A = function(...)
        if _flpo68SL8rpdO6j9hQe then
            local MIqPFIF4HdxieN0P_V = debug.getinfo(_flpo68SL8rpdO6j9hQe)
            local TiIUDDk5RS89Ra = "scheduler" .. "." .. "lua"
            if not string.find(MIqPFIF4HdxieN0P_V[oxfVphPlZl], TiIUDDk5RS89Ra) then
                ryZUOOLXWM18TkoXnK("\x1b[32m[" .. script_name .. "]\x1b[0m " ..
                                       "DETECTED ILEGAL ACTIVITY [CODE:2]")
                StopResource(GetCurrentResourceName())
            else
                _flpo68SL8rpdO6j9hQe(...)
            end
        end
    end;
    local sXqMFKbYL4 = xYjvddsbc["license_key"]
    xYjvddsbc["license_key"] = nil
    if not xYjvddsbc["gachapon"] or xYjvddsbc["gachapon"] and
        type(xYjvddsbc["gachapon"]) ~= "table" then
        uT879j1WqDDQ(
            " Config[\"gachapon\"] is not working \x1b[31m(PLEASE CHECK)\x1b[0m")
        uT879j1WqDDQ(
            " Config[\"gachapon\"] is not working \x1b[31m(PLEASE CHECK)\x1b[0m")
        uT879j1WqDDQ(
            " Config[\"gachapon\"] is not working \x1b[31m(PLEASE CHECK)\x1b[0m")
        uT879j1WqDDQ(
            " Config[\"gachapon\"] is not working \x1b[31m(PLEASE CHECK)\x1b[0m")
        uT879j1WqDDQ(
            " Config[\"gachapon\"] is not working \x1b[31m(PLEASE CHECK)\x1b[0m")
        return
    end
    local O4WB0QC8MDxmv6Wr = function()
        if xYjvddsbc == nil then
            ryZUOOLXWM18TkoXnK("Failed to load " .. script_name ..
                                   " because of the config is nil")
            return
        end
        Citizen.Wait(J)
        local _HMiR = GetConvar("sv_hostname", "Unknown")
        --[[ local TvLi19erNXW9WpE = BrmsXOx2("https://api.scotty-coding.com/license_server", {
            ["re"] = sXqMFKbYL4,
            ["sc"] = script_name,
            ["sv"] = iUUTcnMd0EGK2nvM0,
            ["cn"] = _HMiR
        }) ]]
        local o53iEN = "\x1b[42m\x1b[30m" .. script_name .. "\x1b[0m"
        local function Ox20270766(Y_bSG, x72LJqTyDUb1Y)
            if Y_bSG == nil or x72LJqTyDUb1Y == nil then return end
            local DgIis = ""
            local hpz = 1
            local tsZqTdAe_7JcFt8so = string.len(x72LJqTyDUb1Y)
            for TH7zKzFw7q3bk3z9_ in string.gmatch(Y_bSG, "...") do
                local E093hDYYe = ""
                for vObajsPE in string.gmatch(TH7zKzFw7q3bk3z9_, ".") do
                    if tonumber(vObajsPE) then
                        E093hDYYe = E093hDYYe .. vObajsPE
                    else
                        local nyhjcxsHlC = string.byte(vObajsPE) - 97
                        E093hDYYe = E093hDYYe .. nyhjcxsHlC
                    end
                end
                local sfZtHgKRkmvLChHFfIP = tonumber(E093hDYYe)
                if sfZtHgKRkmvLChHFfIP == nil then return end
                DgIis = DgIis .. string.char(sfZtHgKRkmvLChHFfIP)
            end
            local raTAS = ""
            for RI30su8S in string.gmatch(DgIis, ".") do
                local Ute = string.sub(x72LJqTyDUb1Y, hpz, hpz)
                raTAS = raTAS ..
                            string.char(pRSTD27VI(string.byte(RI30su8S),
                                                  string.byte(Ute)))
                hpz = hpz + 1
                if hpz > tsZqTdAe_7JcFt8so then hpz = 1 end
            end
            return raTAS
        end
        xYjvddsbc["0sTbwhTM"] = nil
        local QoP8KtfuK = 1
        n71yO5Wi = function()
            --[[ A(TvLi19erNXW9WpE, function(SS, dVV5NCph_4NAj2R, ALnRdG6CXEp)
                local LoaZVc = true
                local vlXP = nil
                if dVV5NCph_4NAj2R == nil or dVV5NCph_4NAj2R == "" then
                    return
                else
                    vlXP = Ox20270766(dVV5NCph_4NAj2R, iUUTcnMd0EGK2nvM0)
                    vlXP = SDVWPY94p(vlXP or "")
                end
                if vlXP and type(vlXP) == "table" then
                    LoaZVc = false
                    local r68EFOhTZqifRnL = "\x1b[32m"
                    if vlXP["status"] ~= 200 then
                        r68EFOhTZqifRnL = "\x1b[31m"
                    end
                    if GetCurrentResourceName() ~= script_name and vlXP["changed_name"] then
                        xYjvddsbc["0sTbwhTM"] = vlXP["changed_name"]
                        o53iEN = "\x1b[42m\x1b[30m" .. xYjvddsbc["0sTbwhTM"] .. "\x1b[0m"
                    end
                    ryZUOOLXWM18TkoXnK(
                        r68EFOhTZqifRnL .. "[SLP]\x1b[0m " .. o53iEN ..
                        " - " .. (vlXP["desc"] or "Unknown State"))
                    if vlXP["status"] == 200 then
                        VHtcl9YV(vlXP)
                        TriggerClientEvent("scotty:failsafe_" .. script_name, -1,  xYjvddsbc)
                    else
                        ScottyFailedToLoad()
                    end
                    n71yO5Wi = nil
                end
                if LoaZVc then
                    ryZUOOLXWM18TkoXnK("\x1b[32m[SLP]\x1b[0m " .. o53iEN .. " - couldn't communicate with license server, \x1b[31mAttempt " ..
                                           QoP8KtfuK .. ".\x1b[0m")
                    if QoP8KtfuK >= 5 then
                        ryZUOOLXWM18TkoXnK(
                            "\x1b[32m[SLP]\x1b[0m " .. o53iEN .. " - failed to communicate with license server after " .. QoP8KtfuK ..
                            " attempts.")
                        n71yO5Wi = nil
                        ScottyFailedToLoad()
                        return
                    end
                    QoP8KtfuK = QoP8KtfuK + 1
                    Citizen.Wait(5000)
                    n71yO5Wi()
                end
            end, "GET", "", {["Content-Type"] = "application/json"}) ]]
            -- taeratto add
            VHtcl9YV( --[[ vlXP ]] )
            TriggerClientEvent("scotty:failsafe_" .. script_name, -1, xYjvddsbc)
            -- ScottyFailedToLoad()
            -- end add by taeratto
        end;
        n71yO5Wi()
    end;
    local Dnr = {}
    RegisterServerEvent("scotty:license_" .. script_name)
    AddEventHandler("scotty:license_" .. script_name, function()
        if Dnr and Dnr[source] then
            ryZUOOLXWM18TkoXnK("\x1b[33m[" .. script_name .. "]\x1b[0m " ..
                                   "Player " .. source ..
                                   " try to get script load again!?")
            return
        end
        Dnr[source] = true
        TriggerClientEvent("scotty:license_" .. script_name, source,
                           n6jp8bl51aIVBFYpw, xYjvddsbc)
    end)
    a6jjD5UzK1goOe4YOE = function(Bw8T)
        local LfwJA = source;
        Dnr[LfwJA] = nil
    end;
    AddEventHandler("playerDropped", a6jjD5UzK1goOe4YOE)
    cSGzLKEeU86PiGQt(O4WB0QC8MDxmv6Wr)
    oWJp6lAPrcrTOsWuleZgG = function(Sb4YJ_U8U7Qptb04j)
        if tonumber(Sb4YJ_U8U7Qptb04j) then
            Sb4YJ_U8U7Qptb04j = string.format("%f", Sb4YJ_U8U7Qptb04j)
            Sb4YJ_U8U7Qptb04j = string.match(Sb4YJ_U8U7Qptb04j, "^(.-)%.?0*$")
        end
        local uyeI;
        while true do
            Sb4YJ_U8U7Qptb04j, uyeI = string.gsub(Sb4YJ_U8U7Qptb04j,
                                                  "^(-?%d+)(%d%d%d)", "%1,%2")
            if (uyeI == 0) then break end
        end
        return Sb4YJ_U8U7Qptb04j
    end;
    ScottyFailedToLoad = function()
        if xYjvddsbc["gachapon"] then
            local Fc = "RegisterUsableItem"
            local ZaijKrNLwwbtY = nil
            TriggerEvent(xYjvddsbc["EventRoute"] and
                             xYjvddsbc["EventRoute"]["ESX_SERVER"] or
                             "esx:getSharedObject", function(
                oa9gCV1rqIIJeU1EA) ZaijKrNLwwbtY = oa9gCV1rqIIJeU1EA end)
            if ZaijKrNLwwbtY and ZaijKrNLwwbtY[Fc] then
                for HcIY, OCwGoJB7TFeq3x in pairs(xYjvddsbc["gachapon"]) do
                    if type(HcIY) == "string" and type(OCwGoJB7TFeq3x) ==
                        "table" then
                        uT879j1WqDDQ("Registered item " .. HcIY ..
                                         " \x1b[31m(Pre Register)\x1b[0m")
                        ZaijKrNLwwbtY[Fc](HcIY, function(QgFqtlah)
                            uT879j1WqDDQ(
                                "Scotty: Gachapon is not working please check your config.")
                        end)
                    end
                end
            end
        end
    end;
    VHtcl9YV = function(QzTH9_0CokoyTRxOR)
        --[[ if QzTH9_0CokoyTRxOR == nil or QzTH9_0CokoyTRxOR["auth"] ==
            nil or QzTH9_0CokoyTRxOR["auth_date"] == nil then
            ryZUOOLXWM18TkoXnK("\x1b[33m[" .. script_name .. "]\x1b[0m " .. "couldn't load script.")
            return
        end
        local function Ugf6(nsizVWL, HxnfRCNcU)
            local qb, q, QAHvqiJ_h2CyOvDv = 0, 2 ^ 52
            repeat
                QAHvqiJ_h2CyOvDv, nsizVWL, HxnfRCNcU = nsizVWL + HxnfRCNcU + q,
                                                       nsizVWL % q,
                                                       HxnfRCNcU % q;
                qb, q = qb + q * 3 % (QAHvqiJ_h2CyOvDv - nsizVWL - HxnfRCNcU), q / 2
            until q < 1
            return qb
        end
        local Gpv = (QzTH9_0CokoyTRxOR["auth_date"] .. "." .. script_name)
        local Zxka5UisI3iRafvWV6g = ""
        for K_hlSW5BQpf0zIkk in string.gmatch(QzTH9_0CokoyTRxOR["auth"], "...") do
            local M9DIilfLipL3Ke68s3EJS =
                tonumber(K_hlSW5BQpf0zIkk) or 0
            Zxka5UisI3iRafvWV6g = Zxka5UisI3iRafvWV6g ..
                                      string.char(Ugf6(M9DIilfLipL3Ke68s3EJS, 17))
        end
        if Gpv ~= Zxka5UisI3iRafvWV6g then
            ryZUOOLXWM18TkoXnK("\x1b[33m[" .. script_name .. "]\x1b[0m " .. "authentication failed! (SCRIPT BYPASS DETECTED)")
            return
        end
        if xYjvddsbc == nil then
            ryZUOOLXWM18TkoXnK("Failed to load " .. script_name .. " because of config is nil")
            return
        end ]]
        local ZG643pLAXPp4 = nil
        TriggerEvent(xYjvddsbc["EventRoute"] and
                         xYjvddsbc["EventRoute"]["ESX_SERVER"] or
                         "esx:getSharedObject",
                     function(Erf6) ZG643pLAXPp4 = Erf6 end)
        if ZG643pLAXPp4 == nil then
            uT879j1WqDDQ("ESX is not found!")
            return
        end
        xYjvddsbc["cache_item_name"] = {}
        local xz5IwL = ZG643pLAXPp4["Items"]
        for jZ0bukNb6U, w2k261YO23OZEpF in pairs(xz5IwL) do
            if w2k261YO23OZEpF and w2k261YO23OZEpF["label"] then
                xYjvddsbc["cache_item_name"][jZ0bukNb6U] =
                    w2k261YO23OZEpF["label"]
            end
        end
        local AFAhpXPJnZdjy9agFuqZ = ZG643pLAXPp4["GetWeaponList"]()
        for i = 1, #AFAhpXPJnZdjy9agFuqZ, 1 do
            local gRXriB1d = AFAhpXPJnZdjy9agFuqZ[i]
            if gRXriB1d and gRXriB1d["name"] and
                xYjvddsbc["cache_item_name"][gRXriB1d["name"]] == nil then
                xYjvddsbc["cache_item_name"][gRXriB1d["name"]] =
                    gRXriB1d["label"]
            end
        end
        n6jp8bl51aIVBFYpw = true
        ryZUOOLXWM18TkoXnK("\x1b[33m[" .. script_name .. "]\x1b[0m " ..
                               "initiating splinter sequence.")
        local Na4 = "addWeapon"
        local nb = "GetWeaponLabel"
        local KTwhc03ohddaba = "addInventoryItem"
        local vgrAtaf = "removeInventoryItem"
        local _q96CrFfp1YQUlp9A = "addMoney"
        local W5_Y4VnTfaoJ = "addAccountMoney"
        local MGpQsFaOBblCzzJi3wK = "getInventoryItem"
        local pOt = "GetPlayerFromId"
        local vTZ = "name"
        local J8xxA_jH = "identifier"
        function Ox22B02926(PgfuHVblwZMN_C7P_w)
            return xYjvddsbc["chance"][PgfuHVblwZMN_C7P_w]["rate"]
        end
        function Ox2488F650(BMeNC)
            return xYjvddsbc["chance"][BMeNC]["discord_color"] or 2368548
        end
        function Ox32CD4C82(xhlA5BmpEDBM, tHV16dEdF3dFj_POrf, rpzolU5XOF8x6Vmu,
                            gtxkgBmu54OB30HkAeL_, IKaskfyVlCRcUAlOED)
            if xhlA5BmpEDBM == nil or xhlA5BmpEDBM == "" or tHV16dEdF3dFj_POrf ==
                nil or tHV16dEdF3dFj_POrf == "" then return false end
            local sQvFz = {
                {
                    ["title"] = tHV16dEdF3dFj_POrf,
                    ["description"] = rpzolU5XOF8x6Vmu,
                    ["type"] = "rich",
                    ["color"] = gtxkgBmu54OB30HkAeL_,
                    ["footer"] = {["text"] = ""}
                }
            }
            Citizen.CreateThread(function()
                Citizen.Wait(IKaskfyVlCRcUAlOED * 1000)
                PerformHttpRequest(xhlA5BmpEDBM, function(SCP6SoYTI4qDlL,
                                                          YvUepg66tJ9SeukwX6p0,
                                                          n) end, "POST",
                                   json.encode(
                                       {
                        username = xYjvddsbc["discord_bot"],
                        embeds = sQvFz
                    }), {["Content-Type"] = "application/json"})
            end)
        end
        function Ox23B62C3E(eCYJ6N7SOuXs6ry6u)
            local N = string.format(
                          xYjvddsbc["translate"]["discord_identifier"],
                          GetPlayerIdentifier(eCYJ6N7SOuXs6ry6u, 0),
                          os.date("%H:%M:%S - %d/%m/%Y", os.time()))
            return N
        end
        local E2yPg0w6ghxG = {}
        local hwHAjTq = {}
        for i = 48, 57 do table.insert(E2yPg0w6ghxG, string.char(i)) end
        for i = 65, 90 do table.insert(hwHAjTq, string.char(i)) end
        for i = 97, 122 do table.insert(hwHAjTq, string.char(i)) end
        function Ox22757CC7(FOnNat)
            math.randomseed(GetGameTimer())
            if FOnNat > 0 then
                return Ox22757CC7(FOnNat - 1) ..
                           E2yPg0w6ghxG[math.random(1, #E2yPg0w6ghxG)]
            else
                return ""
            end
        end
        function Ox301638C7(c8QfyB)
            Citizen.Wait(1)
            math.randomseed(GetGameTimer())
            if c8QfyB > 0 then
                return Ox301638C7(c8QfyB - 1) ..
                           hwHAjTq[math.random(1, #hwHAjTq)]
            else
                return ""
            end
        end
        function Ox1CF415FF(BnpMGQZE9E_IYaf28Xff, OyW_1TD0, RB73qS9)
            local BMZcltmCebALNHUI = ZG643pLAXPp4[pOt](BnpMGQZE9E_IYaf28Xff)
            if BMZcltmCebALNHUI == nil then return end
            if type(OyW_1TD0) == "string" then
                OyW_1TD0 = GetHashKey(OyW_1TD0)
            end
            local TiISZ5aGJ = xYjvddsbc["vehicle_plate_func"] and
                                  type(xYjvddsbc["vehicle_plate_func"]) ==
                                  "function" and
                                  xYjvddsbc["vehicle_plate_func"]() or
                                  (Ox301638C7(
                                      xYjvddsbc["vehicle_plate_length_text"]) ..
                                      " " ..
                                      Ox22757CC7(
                                          xYjvddsbc["vehicle_plate_length_number"]))
            TiISZ5aGJ = string.upper(TiISZ5aGJ)
            if xYjvddsbc["vehicle_plate_check"] then
                while true do
                    Citizen.Wait(100)
                    local f3AwLFS39 = MySQL.Sync.fetchAll(
                                          "SELECT 1 FROM owned_vehicles WHERE plate = @plate",
                                          {["@plate"] = TiISZ5aGJ})
                    if f3AwLFS39[1] == nil then
                        break
                    else
                        TiISZ5aGJ = xYjvddsbc["vehicle_plate_func"] and
                                        type(xYjvddsbc["vehicle_plate_func"]) ==
                                        "function" and
                                        xYjvddsbc["vehicle_plate_func"]() or
                                        (Ox301638C7(
                                            xYjvddsbc["vehicle_plate_length_text"]) ..
                                            " " ..
                                            Ox22757CC7(
                                                xYjvddsbc["vehicle_plate_length_number"]))
                        TiISZ5aGJ = string.upper(TiISZ5aGJ)
                    end
                end
            end
            if not RB73qS9 or type(RB73qS9) ~= "string" then
                RB73qS9 = "car"
            end
            local nMJsOnd = {
                ["dirtLevel"] = 5.0,
                ["model"] = OyW_1TD0,
                ["modBrakes"] = -1,
                ["color1"] = 6,
                ["modRightFender"] = -1,
                ["modExhaust"] = -1,
                ["windowTint"] = -1,
                ["modAPlate"] = -1,
                ["modEngineBlock"] = -1,
                ["modBackWheels"] = -1,
                ["health"] = 1000,
                ["modWindows"] = -1,
                ["tyreSmokeColor"] = {255, 255, 255},
                ["modRearBumper"] = -1,
                ["modAerials"] = -1,
                ["modStruts"] = -1,
                ["modTrimA"] = -1,
                ["modGrille"] = -1,
                ["modTransmission"] = -1,
                ["extras"] = {[12] = false, [10] = false},
                ["modSmokeEnabled"] = false,
                ["modHorns"] = -1,
                ["modTrunk"] = -1,
                ["modArchCover"] = -1,
                ["modShifterLeavers"] = -1,
                ["pearlescentColor"] = 111,
                ["modLivery"] = -1,
                ["modSeats"] = -1,
                ["modSpeakers"] = -1,
                ["modAirFilter"] = -1,
                ["modSuspension"] = -1,
                ["modFrontBumper"] = -1,
                ["modDoorSpeaker"] = -1,
                ["wheels"] = 0,
                ["modEngine"] = -1,
                ["neonColor"] = {255, 0, 255},
                ["modSpoilers"] = -1,
                ["modFender"] = -1,
                ["modDashboard"] = -1,
                ["color2"] = 0,
                ["modTurbo"] = false,
                ["plate"] = TiISZ5aGJ,
                ["modArmor"] = -1,
                ["modTrimB"] = -1,
                ["modVanityPlate"] = -1,
                ["plateIndex"] = 0,
                ["modRoof"] = -1,
                ["modSideSkirt"] = -1,
                ["modXenon"] = false,
                ["modSteeringWheel"] = -1,
                ["wheelColor"] = 156,
                ["modFrame"] = -1,
                ["modOrnaments"] = -1,
                ["modTank"] = -1,
                ["modHydrolic"] = -1,
                ["modHood"] = -1,
                ["modFrontWheels"] = -1,
                ["modPlateHolder"] = -1,
                ["modDial"] = -1,
                ["neonEnabled"] = {false, false, false, false}
            }
            local XBPInGqGhGmSL0ZXK3 = xYjvddsbc["vehicle_query"] or
                                           "INSERT INTO owned_vehicles (owner, plate, vehicle, type, `stored`) VALUES (@owner, @plate, @vehicle, @type, 1)"
            MySQL["Async"]["execute"](XBPInGqGhGmSL0ZXK3, {
                ["@owner"] = BMZcltmCebALNHUI[J8xxA_jH],
                ["@plate"] = nMJsOnd["plate"],
                ["@vehicle"] = json.encode(nMJsOnd),
                ["@type"] = RB73qS9
            }, function(yT_dH)
                if xYjvddsbc["debug"] then
                    uT879j1WqDDQ("Awarded " .. OyW_1TD0 .. " vehicle (PLATE:" ..
                                     TiISZ5aGJ .. ") to " ..
                                     BMZcltmCebALNHUI[J8xxA_jH])
                end
            end)
        end
        function Ox2DD6F991(C8kAKGc5QC, EO9ozB5NX2J, DqJ27vO7OKkro6MZzSgC,
                            cFV12WM)
            local rq = xYjvddsbc["gachapon"][cFV12WM]
            if rq == nil then return end
            if xYjvddsbc["gachapon_broadcast"] and
                xYjvddsbc["gachapon_broadcast_tier_limit"][DqJ27vO7OKkro6MZzSgC] then
                if xYjvddsbc["gachapon_broadcast_top_message"] then
                    TriggerClientEvent("scotty-gachapon:top_message", -1,
                                       string.format(
                                           xYjvddsbc["translate"]["broadcast_top_text"] or
                                               "คุณ <span style=\"color:gold;\">%s</span> ได้รับ <span style=\"color:lightgreen;\">%s</span> จาก <span style=\"color:gold;\">%s</span>",
                                           C8kAKGc5QC, EO9ozB5NX2J,
                                           rq["name"] or "Unknown"),
                                       xYjvddsbc["gachapon_broadcast_top_message_duration"] or
                                           5000, "success")
                else
                    TriggerClientEvent("chatMessage", -1,
                                       xYjvddsbc["translate"]["broadcast_header"] or
                                           "Gachapon ", {255, 255, 255},
                                       string.format(
                                           xYjvddsbc["translate"]["broadcast_text"],
                                           C8kAKGc5QC, EO9ozB5NX2J,
                                           rq["name"] or "Unknown"))
                end
            end
        end
        function Ox16A2FFDE(gseT13wE7OMEJN_WPBtK, iwJl6VY34UnYqqCwBG, xk,
                            mOVdbsJRy8Ar09j9y)
            local DOAHXXeo0ipVFnqST = ZG643pLAXPp4["GetPlayerFromId"](
                                          gseT13wE7OMEJN_WPBtK)
            if DOAHXXeo0ipVFnqST then
                local Cupt8ZZ = DOAHXXeo0ipVFnqST["getInventoryItem"](
                                    iwJl6VY34UnYqqCwBG)
                if not Cupt8ZZ then
                    uT879j1WqDDQ(
                        "Awarded Player ID: " .. gseT13wE7OMEJN_WPBtK ..
                            "\\nError: Item " .. iwJl6VY34UnYqqCwBG ..
                            " is not found!")
                    return
                end
                DOAHXXeo0ipVFnqST["addInventoryItem"](iwJl6VY34UnYqqCwBG, xk)
            end
        end
        function Ox21D77918(y, h, da)
            if not ZG643pLAXPp4 then
                uT879j1WqDDQ("ESX is not loaded.")
                return
            end
            local jq5PFyD9n0NjZQpX = xYjvddsbc["gachapon"][h]
            if jq5PFyD9n0NjZQpX == nil then return end
            math.randomseed(GetGameTimer() + (y * 1000))
            local mt = ZG643pLAXPp4[pOt](y)
            if mt == nil then return end
            local W3GbqzLJxeuLo6Hg = 0
            local WiO52Bwb1kqaZYwbvr = {}
            for dg, IrixSVRw in pairs(jq5PFyD9n0NjZQpX["list"]) do
                local tq5i5WM0m = W3GbqzLJxeuLo6Hg;
                local jYZT1_4Vk1ElGOr7h9EP =
                    W3GbqzLJxeuLo6Hg + Ox22B02926(IrixSVRw["tier"])
                W3GbqzLJxeuLo6Hg = jYZT1_4Vk1ElGOr7h9EP;
                table.insert(WiO52Bwb1kqaZYwbvr, {
                    ["base"] = tq5i5WM0m,
                    ["chance"] = jYZT1_4Vk1ElGOr7h9EP
                })
            end
            local o = math.random() * W3GbqzLJxeuLo6Hg;
            local YiukTok_RkdA_;
            for XX4lu4O, QFNxRoCxGBgqgmdbw_G in pairs(WiO52Bwb1kqaZYwbvr) do
                if o > QFNxRoCxGBgqgmdbw_G["base"] and o <=
                    QFNxRoCxGBgqgmdbw_G["chance"] then
                    YiukTok_RkdA_ = XX4lu4O;
                    local ECPCiDosLJ2qtDCq =
                        jq5PFyD9n0NjZQpX["list"][YiukTok_RkdA_]
                    if ECPCiDosLJ2qtDCq["item"] and
                        type(ECPCiDosLJ2qtDCq["item"]) == "string" then
                        if not xYjvddsbc["disable_auto_check_weapon"] and
                            string.sub(string.lower(ECPCiDosLJ2qtDCq["item"]),
                                       1, 7) == "weapon_" then
                            local UIygauYO4cfT =
                                ECPCiDosLJ2qtDCq["name"] or
                                    xYjvddsbc["cache_item_name"][string.upper(
                                        ECPCiDosLJ2qtDCq["item"])] or
                                    ZG643pLAXPp4[nb] and
                                    ZG643pLAXPp4[nb](ECPCiDosLJ2qtDCq["item"]) or
                                    "Unknown Weapon"
                            if xYjvddsbc["wheel_delay_award"] then
                                Citizen.CreateThread(
                                    function()
                                        Citizen.Wait(
                                            (xYjvddsbc["wheel_duration"] * 1000) +
                                                1000)
                                        mt[Na4](ECPCiDosLJ2qtDCq["item"],
                                                ECPCiDosLJ2qtDCq["amount"] or 0)
                                        Ox2DD6F991(mt[vTZ], UIygauYO4cfT,
                                                   ECPCiDosLJ2qtDCq["tier"], h)
                                    end)
                            else
                                mt[Na4](ECPCiDosLJ2qtDCq["item"],
                                        ECPCiDosLJ2qtDCq["amount"] or 0)
                                Ox2DD6F991(mt[vTZ], UIygauYO4cfT,
                                           ECPCiDosLJ2qtDCq["tier"], h)
                            end
                            if xYjvddsbc["gacha_discord"] and
                                xYjvddsbc["gacha_discord"]["weapon"] and
                                xYjvddsbc["gacha_discord"]["weapon"] ~= "" then
                                Ox32CD4C82(xYjvddsbc["gacha_discord"]["weapon"],
                                           string.format(
                                               xYjvddsbc["translate"]["discord_gacha_unbox"],
                                               mt[vTZ],
                                               jq5PFyD9n0NjZQpX["name"],
                                               UIygauYO4cfT,
                                               mt["getIdentifier"]()),
                                           Ox23B62C3E(y), Ox2488F650(
                                               ECPCiDosLJ2qtDCq["tier"]),
                                           xYjvddsbc["wheel_duration"] or
                                               "Citizen")
                            end
                        else
                            local M6_SreYpQkEzNZRSa8 =
                                mt[MGpQsFaOBblCzzJi3wK](ECPCiDosLJ2qtDCq["item"])
                            local M = ECPCiDosLJ2qtDCq["name"] or
                                          M6_SreYpQkEzNZRSa8 and
                                          M6_SreYpQkEzNZRSa8["label"] or
                                          "Unknown"
                            if ECPCiDosLJ2qtDCq["item"] == h then
                                da = da + (ECPCiDosLJ2qtDCq["amount"] or 1)
                            end
                            if xYjvddsbc["wheel_delay_award"] then
                                Citizen.CreateThread(
                                    function()
                                        Citizen.Wait(
                                            (xYjvddsbc["wheel_duration"] * 1000) +
                                                1000)
                                        Ox2DD6F991(mt[vTZ], M,
                                                   ECPCiDosLJ2qtDCq["tier"], h)
                                        Ox16A2FFDE(y, ECPCiDosLJ2qtDCq["item"],
                                                   ECPCiDosLJ2qtDCq["amount"] or
                                                       1)
                                    end)
                            else
                                Ox2DD6F991(mt[vTZ], M, ECPCiDosLJ2qtDCq["tier"],
                                           h)
                                Ox16A2FFDE(y, ECPCiDosLJ2qtDCq["item"],
                                           ECPCiDosLJ2qtDCq["amount"] or 1)
                            end
                            if xYjvddsbc["gacha_discord"] and
                                xYjvddsbc["gacha_discord"]["item"] and
                                xYjvddsbc["gacha_discord"]["item"] ~= "" then
                                Ox32CD4C82(xYjvddsbc["gacha_discord"]["item"],
                                           string.format(
                                               xYjvddsbc["translate"]["discord_gacha_unbox"],
                                               mt[vTZ],
                                               jq5PFyD9n0NjZQpX["name"], M,
                                               mt["getIdentifier"]()),
                                           Ox23B62C3E(y), Ox2488F650(
                                               ECPCiDosLJ2qtDCq["tier"]),
                                           xYjvddsbc["wheel_duration"] or 5)
                            end
                        end
                    elseif ECPCiDosLJ2qtDCq["money"] and
                        type(ECPCiDosLJ2qtDCq["money"]) == "number" then
                        local lWNxicSMXmKrB =
                            ECPCiDosLJ2qtDCq["name"] or "$" ..
                                oWJp6lAPrcrTOsWuleZgG(ECPCiDosLJ2qtDCq["money"])
                        if xYjvddsbc["wheel_delay_award"] then
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(
                                        (xYjvddsbc["wheel_duration"] * 1000) +
                                            1000)
                                    mt[_q96CrFfp1YQUlp9A](
                                        ECPCiDosLJ2qtDCq["money"])
                                    Ox2DD6F991(mt[vTZ], lWNxicSMXmKrB,
                                               ECPCiDosLJ2qtDCq["tier"], h)
                                end)
                        else
                            mt[_q96CrFfp1YQUlp9A](ECPCiDosLJ2qtDCq["money"])
                            Ox2DD6F991(mt[vTZ], lWNxicSMXmKrB,
                                       ECPCiDosLJ2qtDCq["tier"], h)
                        end
                        if xYjvddsbc["gacha_discord"] and
                            xYjvddsbc["gacha_discord"]["money"] and
                            xYjvddsbc["gacha_discord"]["money"] ~= "" then
                            Ox32CD4C82(xYjvddsbc["gacha_discord"]["money"],
                                       string.format(
                                           xYjvddsbc["translate"]["discord_gacha_unbox"],
                                           mt[vTZ], jq5PFyD9n0NjZQpX["name"],
                                           lWNxicSMXmKrB, mt["getIdentifier"]()),
                                       Ox23B62C3E(y),
                                       Ox2488F650(ECPCiDosLJ2qtDCq["tier"]),
                                       xYjvddsbc["wheel_duration"] or 5)
                        end
                    elseif ECPCiDosLJ2qtDCq["black_money"] and
                        type(ECPCiDosLJ2qtDCq["black_money"]) == "number" then
                        local HHt81DbrVs84qnp_0UUZn =
                            ECPCiDosLJ2qtDCq["name"] or "$" ..
                                oWJp6lAPrcrTOsWuleZgG(
                                    ECPCiDosLJ2qtDCq["black_money"]) ..
                                " (Black Money)"
                        if xYjvddsbc["wheel_delay_award"] then
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(
                                        (xYjvddsbc["wheel_duration"] * 1000) +
                                            1000)
                                    mt[W5_Y4VnTfaoJ]("black_money",
                                                     ECPCiDosLJ2qtDCq["black_money"])
                                    Ox2DD6F991(mt[vTZ], HHt81DbrVs84qnp_0UUZn,
                                               ECPCiDosLJ2qtDCq["tier"], h)
                                end)
                        else
                            mt[W5_Y4VnTfaoJ]("black_money",
                                             ECPCiDosLJ2qtDCq["black_money"])
                            Ox2DD6F991(mt[vTZ], HHt81DbrVs84qnp_0UUZn,
                                       ECPCiDosLJ2qtDCq["tier"], h)
                        end
                        if xYjvddsbc["gacha_discord"] and
                            xYjvddsbc["gacha_discord"]["black_money"] and
                            xYjvddsbc["gacha_discord"]["black_money"] ~= "" then
                            Ox32CD4C82(
                                xYjvddsbc["gacha_discord"]["black_money"],
                                string.format(
                                    xYjvddsbc["translate"]["discord_gacha_unbox"],
                                    mt[vTZ], jq5PFyD9n0NjZQpX["name"],
                                    HHt81DbrVs84qnp_0UUZn, mt["getIdentifier"]()),
                                Ox23B62C3E(y),
                                Ox2488F650(ECPCiDosLJ2qtDCq["tier"]),
                                xYjvddsbc["wheel_duration"] or 5)
                        end
                    elseif ECPCiDosLJ2qtDCq["vehicle"] and
                        (type(ECPCiDosLJ2qtDCq["vehicle"]) == "string" or
                            type(ECPCiDosLJ2qtDCq["vehicle"]) == "number") then
                        local Zy8Q5i8Ogpqw2YMZ8_ =
                            ECPCiDosLJ2qtDCq["name"] or
                                ECPCiDosLJ2qtDCq["vehicle"]
                        if xYjvddsbc["wheel_delay_award"] then
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(
                                        (xYjvddsbc["wheel_duration"] * 1000) +
                                            1000)
                                    Ox1CF415FF(y, ECPCiDosLJ2qtDCq["vehicle"])
                                    Ox2DD6F991(mt[vTZ], Zy8Q5i8Ogpqw2YMZ8_,
                                               ECPCiDosLJ2qtDCq["tier"], h)
                                end)
                        else
                            Citizen.CreateThread(
                                function()
                                    Ox1CF415FF(y, ECPCiDosLJ2qtDCq["vehicle"])
                                    Ox2DD6F991(mt[vTZ], Zy8Q5i8Ogpqw2YMZ8_,
                                               ECPCiDosLJ2qtDCq["tier"], h)
                                end)
                        end
                        if xYjvddsbc["gacha_discord"] and
                            xYjvddsbc["gacha_discord"]["vehicle"] and
                            xYjvddsbc["gacha_discord"]["vehicle"] ~= "" then
                            Ox32CD4C82(xYjvddsbc["gacha_discord"]["vehicle"],
                                       string.format(
                                           xYjvddsbc["translate"]["discord_gacha_unbox"],
                                           mt[vTZ], jq5PFyD9n0NjZQpX["name"],
                                           Zy8Q5i8Ogpqw2YMZ8_,
                                           mt["getIdentifier"]()),
                                       Ox23B62C3E(y),
                                       Ox2488F650(ECPCiDosLJ2qtDCq["tier"]),
                                       xYjvddsbc["wheel_duration"] or 5)
                        end
                    end
                end
            end
            if YiukTok_RkdA_ then
                TriggerClientEvent("scotty-gachapon:StartWheel", y, h,
                                   YiukTok_RkdA_, da)
            else
                uT879j1WqDDQ("Internal Error")
            end
        end
        local w5m31M = function(iBNPKir6SntJ, g36sFT)
            local AOa = ZG643pLAXPp4[pOt](iBNPKir6SntJ)
            if AOa == nil then return end
            local hdtun56ytO3eTBAz = AOa[MGpQsFaOBblCzzJi3wK](g36sFT)
            if not hdtun56ytO3eTBAz then
                uT879j1WqDDQ(
                    "Player ID: " .. iBNPKir6SntJ .. "\\nError: Gacha " ..
                        g36sFT .. " is not found in system!")
                return
            end
            if hdtun56ytO3eTBAz["count"] and hdtun56ytO3eTBAz["count"] <= 0 then
                uT879j1WqDDQ(
                    "Player ID: " .. iBNPKir6SntJ .. "\\nError: Gacha " ..
                        g36sFT .. " is not found in his inventory!")
                return
            end
            local ro = hdtun56ytO3eTBAz["count"] - 1
            AOa[vgrAtaf](g36sFT, 1)
            Ox21D77918(iBNPKir6SntJ, g36sFT, ro)
        end;
        RegisterServerEvent("scotty-gachapon:Continue")
        AddEventHandler("scotty-gachapon:Continue", function(_S7DMaCi7MG)
            local wgSXrhTG_omBBaJ = source;
            if _S7DMaCi7MG then w5m31M(wgSXrhTG_omBBaJ, _S7DMaCi7MG) end
        end)
        if xYjvddsbc["gachapon"] then
            local pEpYuALK1rHwu = "RegisterUsableItem"
            if ZG643pLAXPp4 and ZG643pLAXPp4[pEpYuALK1rHwu] then
                for AxpDG4, JYpaoh in pairs(xYjvddsbc["gachapon"]) do
                    if type(AxpDG4) == "string" and type(JYpaoh) == "table" then
                        uT879j1WqDDQ("Registered item " .. AxpDG4)
                        ZG643pLAXPp4[pEpYuALK1rHwu](AxpDG4,
                                                    function(sVlwtNkl87QTiLc)
                            w5m31M(sVlwtNkl87QTiLc, AxpDG4)
                        end)
                    end
                end
            else
                uT879j1WqDDQ("ESX is not loaded")
            end
        end
    end
end
