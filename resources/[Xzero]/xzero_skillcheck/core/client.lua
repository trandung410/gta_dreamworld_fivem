TSE = TriggerServerEvent;
local a = nil;
RegisEvent(true, Events.CL.Verify_Receive, function(b) a = b end)
Citizen.CreateThread(function()
    local c = GetGameTimer()
    while a == nil and GetGameTimer() - c <= 30 * 1000 do
        TSE(Events.SV.Verify_Request)
        Wait(300)
    end
    __Init()
end)
ESX = nil;
_xZero = {}
_xZero.funcs = {}
_xZero.isStartGame = false;
_xZero.OnFinshReceiveCallback = nil;
__Init = function()
    Wait(500)
    if a then
        _version_Init()
        CFG_SETUP()
        _Events_Init()
    else
        print("^1Verify:ERROR^7")
    end
end;
_Events_Init = function()
    exports('startGame', function(d, e)
        startGame(d, function(f)
            e(f.status, f.countSuccess, f.countFailed)
        end)
    end)
    exports('startGameSync', function(d)
        local g = false;
        local h = {}
        startGame(d, function(f)
            h = f;
            g = true
        end)
        while not g do Wait(10) end
        return h
    end)
    startGame = function(d, e)
        if not a then return end
        if _xZero.isStartGame or d == nil then
            e({status = false})
            return
        end
        _xZero.isStartGame = true;
        local i = PlayerPedId()
        local j = _xZero.funcs.freezePosVaild(d)
        if j then
            Citizen.CreateThread(function()
                local k = IsEntityDead(i)
                while _xZero.isStartGame and not k do
                    FreezeEntityPosition(i, true)
                    Wait(100)
                end
                FreezeEntityPosition(i, false)
            end)
        end
        local l = _xZero.funcs.playScenarioVaild(d)
        if l then TaskStartScenarioInPlace(i, d.playScenario, 0, true) end
        local m = _xZero.funcs.playAnimVaild(d)
        if m then
            _xZero.funcs.PlayAnim(i, d.playAnim.Dict, d.playAnim.Name)
        end
        _xZero.OnFinshReceiveCallback = function(f)
            _xZero.OnFinshReceiveCallback = nil;
            _xZero.isStartGame = false;
            if j then FreezeEntityPosition(i, false) end
            if m or l then ClearPedTasks(i) end
            e(f)
        end;
        local n = d.speedMin or 10;
        SendNUIMessage({
            type = "GAME_SETUP",
            IS_START = true,
            SETUP = {
                textTitle = d.textTitle or "xZero skillCheck",
                textHelp = d.textHelp or Config.textHelp or "",
                speedMin = n,
                speedMax = d.speedMax or n,
                countSuccessMax = d.countSuccessMax or 5,
                countFailedMax = d.countFailedMax or 5,
                layOut = d.layOut or "bottom"
            }
        })
        SetNuiFocus(true, true)
    end;
    RegisterNUICallback(Events.NUI.OnFinsh_Receive, function(o)
        if not a then return end
        SetNuiFocus(false, false)
        if _xZero.OnFinshReceiveCallback then
            _xZero.OnFinshReceiveCallback(o)
        end
    end)
end;
_version_Init = function()
    print(('Inited - version_current:^3%s^7'):format(version_current))
end;
CFG_SETUP = function()
    if not a then return end
    SendNUIMessage({
        type = "SETUP",
        URL_Base = ('http:/%s/'):format(script_name),
        keyPress = Config.keyPress,
        textHelp = Config.textHelp or "",
        isStartGameDelay = Config.isStartGameDelay or 1200
    })
end;
_xZero.funcs.RequestAnimDict = function(p, q)
    if not HasAnimDictLoaded(p) then
        RequestAnimDict(p)
        local r = GetGameTimer()
        while not HasAnimDictLoaded(p) and GetGameTimer() - r <= 10 * 1000 do
            Citizen.Wait(1)
        end
    end
    if q ~= nil then q() end
end;
_xZero.funcs.PlayAnim = function(i, p, s)
    _xZero.funcs.RequestAnimDict(p, function()
        TaskPlayAnim(i, p, s, 8.0, 8.0, -1, 33, 0, false, false, false)
    end)
end;
_xZero.funcs.freezePosVaild = function(d) return d.freezePos or false end;
_xZero.funcs.playScenarioVaild = function(d)
    return d.playScenario and d.playScenario ~= "" and true or false
end;
_xZero.funcs.playAnimVaild = function(d)
    return d.playAnim and (d.playAnim.Dict and d.playAnim.Dict ~= "") and
               (d.playAnim.Name and d.playAnim.Name ~= "") and true or false
end
