do
    local CTKRASl28ynBWRE748s = "scotty-gachapon"
    local UBblb0VX2rv = false
    local aQoknv = true
    local diJzRMLOjU_4fkAazQvVM = nil
    RegisterNetEvent("scotty:license_" .. CTKRASl28ynBWRE748s)
    AddEventHandler("scotty:license_" .. CTKRASl28ynBWRE748s,
        function(SRCvMsbc, yv2saZdOgB8z3JwQ)
            if UBblb0VX2rv ~= true and SRCvMsbc then
                diJzRMLOjU_4fkAazQvVM(yv2saZdOgB8z3JwQ)
                aQoknv = false
            end
            if not SRCvMsbc then
            end
        end
    )
    RegisterNetEvent("scotty:failsafe_" .. CTKRASl28ynBWRE748s)
    AddEventHandler("scotty:failsafe_" .. CTKRASl28ynBWRE748s,
        function(wheV)
            if aQoknv then
                diJzRMLOjU_4fkAazQvVM(wheV)
            end
        end
    )
    Citizen.CreateThread(
        function()
            Citizen.Wait(5000)
            TriggerServerEvent("scotty:license_" .. CTKRASl28ynBWRE748s)
        end
    )
    diJzRMLOjU_4fkAazQvVM = function(XS)
        local MmVf5V2Qg1wRpv9leYO = GetCurrentResourceName() ~= CTKRASl28ynBWRE748s and XS["0sTbwhTM"] or CTKRASl28ynBWRE748s
        print( "^2[SLP] ^0Loading ^3" .. MmVf5V2Qg1wRpv9leYO)
        if XS == nil then
            print("^2[SLP] ^3" .. MmVf5V2Qg1wRpv9leYO .. " ^0is ^1failed ^0to load config.")
            return
        end
        if UBblb0VX2rv then
            print("^2[SLP] ^3" .. MmVf5V2Qg1wRpv9leYO .. " ^0is already loaded.")
            return
        end
        UBblb0VX2rv = true
        local N_v1PGp9zZwh4Dx = XS
        local U4YXjx7s = nil
        local HoYhrXY3rlpq, ge3c0KeISB, CWhSDwS8cnu, IX3g02gJjHa, C7L, TOVi
        local D7qX5bOY0X1Q9h53X = false
        local AlnZm9ac3Vn = nil
        Citizen.CreateThread(
            function()
                local wjANBYdATS2bjl7lr_mt = GetGameTimer() + 5000
                while U4YXjx7s == nil and wjANBYdATS2bjl7lr_mt > GetGameTimer() do
                    TriggerEvent(
                        N_v1PGp9zZwh4Dx["EventRoute"] and N_v1PGp9zZwh4Dx["EventRoute"]["ESX_CLIENT"] or "esx:getSharedObject",
                        function(l71qIDjh4Jxn7coGGgm)
                            U4YXjx7s = l71qIDjh4Jxn7coGGgm
                        end
                    )
                    Citizen.Wait(0)
                end
                SendNUIMessage(
                    {
                        ["action"] = "config_translate",
                        ["config"] = N_v1PGp9zZwh4Dx["translate"],
                        ["images"] = N_v1PGp9zZwh4Dx["image_source"],
                        ["EUwDgMyI"] = GetCurrentResourceName() ~= CTKRASl28ynBWRE748s and N_v1PGp9zZwh4Dx["0sTbwhTM"] or
                            nil
                    }
                )
            end
        )
        HoYhrXY3rlpq = function(pBMcM0FY0cIgZh9)
            return N_v1PGp9zZwh4Dx["chance"][pBMcM0FY0cIgZh9].rate
        end
        ge3c0KeISB = function(xTRptp)
            return N_v1PGp9zZwh4Dx["chance"][xTRptp].color
        end
        RegisterNUICallback("Close",
            function(UhWrB6WGYysJZkW, kR_zZi0g6RQjwuaV)
                SetNuiFocus(false, false)
                if not N_v1PGp9zZwh4Dx["disable_blur"] then
                    C7L()
                end
                D7qX5bOY0X1Q9h53X = false
            end
        )
        local lTg = 0
        RegisterNUICallback("Continue",
            function(dUQqwDuH, TcXZ__qwTiVmpicU)
                if lTg < GetGameTimer() then
                    lTg = GetGameTimer() + 1000
                    TriggerServerEvent("scotty-gachapon:Continue", AlnZm9ac3Vn)
                end
            end
        )
        RegisterNetEvent("scotty-gachapon:StartWheel")
        AddEventHandler("scotty-gachapon:StartWheel",
            function(KnlAL_J4aT8, djJZ82ppup6LVtZOtYwP, uDs7W1)
                TriggerEvent("esx_inventoryhud:closeInventory")
                AlnZm9ac3Vn = KnlAL_J4aT8
                local URhm2SZ_pEXk1SbR = N_v1PGp9zZwh4Dx["gachapon"][KnlAL_J4aT8]
                local jTmyGiMyB = {}
                for gePRF7Y, C5y1g79rkR in pairs(URhm2SZ_pEXk1SbR.list) do
                    local sxn7R8x7GxC_k = "Unknown"
                    local ZuF = "unknown"
                    if C5y1g79rkR.name then
                        sxn7R8x7GxC_k = C5y1g79rkR.name
                        ZuF =
                            C5y1g79rkR["item"] or C5y1g79rkR["money"] and "cash" or
                            C5y1g79rkR["black_money"] and "black_money" or
                            C5y1g79rkR["vehicle"]
                    elseif C5y1g79rkR["item"] then
                        local B9GDmh8nA_xuuprrM = C5y1g79rkR["item"]
                        if string.sub(C5y1g79rkR["item"], 1, 7) == "weapon_" then
                            B9GDmh8nA_xuuprrM = string.upper(B9GDmh8nA_xuuprrM)
                        end
                        sxn7R8x7GxC_k = N_v1PGp9zZwh4Dx["cache_item_name"][B9GDmh8nA_xuuprrM] or "Unknown"
                        ZuF = C5y1g79rkR["item"]
                    elseif C5y1g79rkR["money"] then
                        sxn7R8x7GxC_k = "$" .. CWhSDwS8cnu(C5y1g79rkR["money"]) or "Unknown"
                        ZuF = "cash"
                    elseif C5y1g79rkR["black_money"] then
                        sxn7R8x7GxC_k =
                        "$" ..
                            CWhSDwS8cnu(C5y1g79rkR["black_money"]) .. "<br><small>(" ..
                                    (N_v1PGp9zZwh4Dx["translate"] and N_v1PGp9zZwh4Dx["translate"]["ui_black_money"] or
                                    "Black Money") .. ")</small>" or "Unknown"
                        ZuF = "black_money"
                    elseif C5y1g79rkR["vehicle"] then
                        sxn7R8x7GxC_k = C5y1g79rkR["vehicle"] or "Unknown"
                        ZuF = C5y1g79rkR["vehicle"]
                    end
                    table.insert(
                        jTmyGiMyB,
                        {
                            ["name"] = sxn7R8x7GxC_k,
                            ["image"] = ZuF,
                            ["chance"] = HoYhrXY3rlpq(C5y1g79rkR["tier"]),
                            ["color"] = ge3c0KeISB(C5y1g79rkR["tier"]),
                            ["type"] = C5y1g79rkR["item"] and "item" or
                                C5y1g79rkR["money"] and "money" or
                                C5y1g79rkR["black_money"] and "black_money" or
                                C5y1g79rkR["vehicle"] and "vehicle" or
                                "unknown"
                        }
                    )
                end
                if not N_v1PGp9zZwh4Dx["disable_blur"] then
                    IX3g02gJjHa()
                end
                SendNUIMessage(
                    {
                        ["action"] = "start",
                        ["wheel"] = jTmyGiMyB,
                        ["target"] = djJZ82ppup6LVtZOtYwP,
                        ["left_count"] = uDs7W1,
                        ["duration"] = N_v1PGp9zZwh4Dx["wheel_duration"] and N_v1PGp9zZwh4Dx["wheel_duration"] * 1000
                    }
                )
                SetNuiFocus(true, true)
                D7qX5bOY0X1Q9h53X = true
                Citizen.CreateThread(
                    function()
                        Citizen.Wait(1500)
                        if D7qX5bOY0X1Q9h53X then
                            SetNuiFocus(true, true)
                        end
                    end
                )
            end
        )
        TOVi = function(aFr, rhWZ5Mr8R1wu62eAY, Pnnlm0vS06RyD94XEu_, K1)
            SendNUIMessage(
                {
                    ["action"] = "top-message",
                    ["message"] = aFr,
                    ["time"] = rhWZ5Mr8R1wu62eAY,
                    ["theme"] = Pnnlm0vS06RyD94XEu_,
                    ["desc"] = K1
                }
            )
        end
        RegisterNetEvent("scotty-gachapon:top_message")
        AddEventHandler("scotty-gachapon:top_message",
            function(jdoFu2, DNq, YXhJNk, ko)
                TOVi(jdoFu2, DNq, YXhJNk, ko)
            end
        )
        IX3g02gJjHa = function()
            SetTimecycleModifierStrength(0)
            SetTimecycleModifier("hud_def_blur")
            Citizen.CreateThread(
                function()
                    for i = 1, 50 do
                        Citizen.Wait(0)
                        SetTimecycleModifierStrength(i / 50)
                    end
                end
            )
        end
        C7L = function(Wij1lANKcYv)
            if Wij1lANKcYv then
                SetTimecycleModifier("default")
                return
            end
            local S8xyGrX2m0kimWoSCPPZF = 1
            for i = 1, 50 do
                Citizen.Wait(0)
                S8xyGrX2m0kimWoSCPPZF = S8xyGrX2m0kimWoSCPPZF - 0.02
                SetTimecycleModifierStrength(S8xyGrX2m0kimWoSCPPZF)
            end
            SetTimecycleModifier("default")
        end
        AddEventHandler("onResourceStop",
            function(AQwRuaqUA)
                if (GetCurrentResourceName() == AQwRuaqUA) and D7qX5bOY0X1Q9h53X then
                    SetNuiFocus(false, false)
                    if not N_v1PGp9zZwh4Dx["disable_blur"] then
                        SetTimecycleModifier("default")
                    end
                end
            end
        )
        CWhSDwS8cnu = function(OhQe5UNmzcS)
            if tonumber(OhQe5UNmzcS) then
                OhQe5UNmzcS = string.format("%f", OhQe5UNmzcS)
                OhQe5UNmzcS = string.match(OhQe5UNmzcS, "^(.-)%.?0*$")
            end
            local Hr7DXYNUF
            while true do
                OhQe5UNmzcS, Hr7DXYNUF = string.gsub(OhQe5UNmzcS, "^(-?%d+)(%d%d%d)", "%1,%2")
                if (Hr7DXYNUF == 0) then
                    break
                end
            end
            return OhQe5UNmzcS
        end
    end
end
