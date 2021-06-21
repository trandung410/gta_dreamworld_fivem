script_name = GetCurrentResourceName()
TE = TriggerEvent
GetName = function(a)
    return script_name .. a
end
RegisEvent = function(b, a, c)
    if b then
        RegisterNetEvent(a)
    end
    AddEventHandler(a, c)
end
pr = function(d)
    print(("^2[%s]^7 %s"):format(script_name, d))
end
Events = {}
Events.SV = {Verify_Request = GetName(":SV:Verify_Request:48789156")}
Events.CL = {Verify_Receive = GetName(":CL:Verify_Receive:48789156"), UI_SET_isShow = GetName(":CL:UI_SET_isShow")}
Events.NUI = {OnClose = "OnClose", OnEmoClicked = "OnEmoClicked"}
funcs = {}
funcs.Dump = function(table, e)
    if e == nil then
        e = 0
    end
    if type(table) == "table" then
        local f = ""
        for g = 1, e + 1, 1 do
            f = f .. "    "
        end
        f = "{\n"
        for h, i in pairs(table) do
            if type(h) ~= "number" then
                h = '"' .. h .. '"'
            end
            for g = 1, e, 1 do
                f = f .. "    "
            end
            f = f .. "[" .. h .. "] = " .. funcs.Dump(i, e + 1) .. ",\n"
        end
        for g = 1, e, 1 do
            f = f .. "    "
        end
        return f .. "}"
    else
        return tostring(table)
    end
end
funcs.pairsByKeys = function(j, k)
    local l = {}
    for m in pairs(j) do
        table.insert(l, m)
    end
    table.sort(l, k)
    local g = 0
    local n = function()
        g = g + 1
        if l[g] == nil then
            return nil
        else
            return l[g], j[l[g]]
        end
    end
    return n
end
