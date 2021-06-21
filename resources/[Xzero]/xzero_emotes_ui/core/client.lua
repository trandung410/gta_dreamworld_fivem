TSE = TriggerServerEvent
local a = nil
RegisEvent(
    true,
    Events.CL.Verify_Receive,
    function(b)
        a = b
    end
)
Citizen.CreateThread(
    function()
        local c = GetGameTimer()
        while a == nil and GetGameTimer() - c <= 30 * 1000 do
            TSE(Events.SV.Verify_Request)
            Wait(300)
        end
        __Init()
    end
)
_UI_isShow = false
_DP = {}
_dpEmoInsObjName = "xzero_emotes_ui:export:"
_dpEmoInsObj = nil
_emoItemList = {}
__Init = function()
    Wait(500)
    if a then
        _version_Init()
        CFG_SETUP()
        _EmoIns_Init()
        _Events_Init()
    else
        print("^1Verify:ERROR^7")
    end
end
_Events_Init = function()
    if Config.keyPress ~= nil then
        Citizen.CreateThread(
            function()
                while true do
                    Wait(5)
                    if IsControlJustPressed(0, Config.keyPress) then
                        SetTimecycleModifier('hud_def_blur')
                        UI_SET_isShow(true)
                        Wait(300)
                    end
                end
            end
        )
    end
    RegisterNUICallback(
        Events.NUI.OnClose,
        function()
            SetTimecycleModifier('default')
            UI_SET_isShow(false)
        end
    )
    RegisterNUICallback(
        Events.NUI.OnEmoClicked,
        function(d)
            SetTimecycleModifier('default')
            UI_SET_isShow(false)
            if not d or d == nil then
                return
            end
            if d.etype then
                TE(_dpEmoInsObjName .. "EmoteMenuStart", d.name, d.etype)
                return
            end
            if d.type == "Walks" then
                TE(_dpEmoInsObjName .. "WalkMenuStart", d.name)
                return
            end
            if d.type == "Shared" then
                TE(_dpEmoInsObjName .. "EmoteShareSyncing", d.name, d.typeby, d.label)
                return
            end
        end
    )
end
UI_SET_isShow = function(e)
    _UI_isShow = e
    SendNUIMessage({type = "SET_ISSHOW", STATUS = _UI_isShow})
    if _UI_isShow then
        Wait(200)
    end
    SetNuiFocus(_UI_isShow, _UI_isShow)
end
RegisEvent(false, Events.CL.UI_SET_isShow, UI_SET_isShow)
_EmoIns_Init = function()
    local f = GetGameTimer()
    while _dpEmoInsObj == nil and GetGameTimer() - f <= 30 * 1000 do
        TE(
            _dpEmoInsObjName .. "getIns",
            function(g)
                _dpEmoInsObj = g
            end
        )
        Wait(100)
    end
    if _dpEmoInsObj == nil then
        print("^1ERROR:EmoInsGet^7")
        return
    end
    local h = 0
    if Config.emoTypes and #Config.emoTypes > 0 then
        _DP = _dpEmoInsObj.getIns().getDP()
        for i, j in ipairs(Config.emoTypes) do
            if not _emoItemList[j.name] then
                _emoItemList[j.name] = {}
            end
            CFG_emoItemList_Loaded(j.name, _emoItemList[j.name])
            local k = #_emoItemList[j.name]
            for l, m in funcs.pairsByKeys(_DP[j.name]) do
                k = k + 1
                _emoItemList[j.name][k] = {
                    id = k,
                    name = j.index_name ~= nil and m[j.index_name] or l,
                    label = j.index_label ~= nil and m[j.index_label] or l
                }
            end
            h = h + k
        end
        _emoItemList_AddByType("Shared", "Dances")
        collectgarbage()
    end
    print(("emoItemList Loaded - ^2%s^7"):format(h))
    UI_SET_EMO()
end
CFG_emoItemList_Loaded = function(j, n)
    local o = Config.emoItemList and Config.emoItemList[j] or nil
    if o then
        if #o > 0 then
            for p = 1, #o do
                local q = o[p]
                n[p] = {id = p, name = q.name, label = q.label}
            end
        end
    end
end
_emoItemList_AddByType = function(r, s)
    local j = _emoTypeFind(s)
    if j then
        local k = #_emoItemList[r]
        for l, m in funcs.pairsByKeys(_DP[s]) do
            k = k + 1
            _emoItemList[r][k] = {
                id = k,
                name = j.index_name ~= nil and m[j.index_name] or l,
                label = j.index_label ~= nil and m[j.index_label] or l,
                typeby = s
            }
        end
    end
end
_emoTypeFind = function(t)
    for u, q in ipairs(Config.emoTypes) do
        if q.name == t then
            return q
        end
    end
    return nil
end
UI_SET_EMO = function()
    SendNUIMessage({type = "SET_EMO", empTypes = Config.emoTypes or {}, emoItemList = _emoItemList or {}})
end
_version_Init = function()
    print(("Inited - version_current:^3%s^7"):format(version_current))
end
CFG_SETUP = function()
    if not a then
        return
    end
    SendNUIMessage(
        {
            type = "SETUP",
            URL_Base = ("http:/%s/"):format(script_name),
            textTitleHeader = Config.textTitleHeader or nil,
            textTitleHistory = Config.textTitleHistory or nil,
            audioEmoClicked = Config.audioEmoClicked,
            audioEmoClickedVol = Config.audioEmoClickedVol
        }
    )
end
