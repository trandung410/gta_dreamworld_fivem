_dpEmoInsObjName = "xzero_emotes_ui:export:"
_xzero = {}
AddEventHandler(
    _dpEmoInsObjName .. "EmoteMenuStart",
    function(a, b)
        if a == nil or b == nil then
            return
        end
        if a == "reset" and b == "expression" then
            ClearFacialIdleAnimOverride(PlayerPedId())
            return
        end
        EmoteMenuStart(a, b)
    end
)
AddEventHandler(
    _dpEmoInsObjName .. "WalkMenuStart",
    function(a)
        if a == nil or a == "reset" then
            ResetPedMovementClipset(PlayerPedId())
            return
        end
        WalkMenuStart(a)
    end
)
AddEventHandler(
    _dpEmoInsObjName .. "EmoteShareSyncing",
    function(a, b, c)
        if a == nil or DP.Shared[a] == nil and DP.Dances[a] == nil then
            return
        end
        local d, e = GetClosestPlayer()
        if e ~= -1 and e < 3 then
            TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(d), a, b or nil)
            SimpleNotify(Config.Languages[lang]["sentrequestto"] .. GetPlayerName(d) .. " ~w~(~g~" .. c .. "~w~)")
        else
            SimpleNotify(Config.Languages[lang]["nobodyclose"])
        end
    end
)
_xzero.getDP = function()
    return DP
end
AddEventHandler(
    _dpEmoInsObjName .. "getIns",
    function(f)
        f(_xzero.getIns() or nil)
    end
)
_xzero.getIns = function()
    return _xzero
end
