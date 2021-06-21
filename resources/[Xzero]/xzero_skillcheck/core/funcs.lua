script_name = GetCurrentResourceName()
TE = TriggerEvent;
GetName = function(a) return script_name .. a end;
RegisEvent = function(b, a, c)
    if b then RegisterNetEvent(a) end
    AddEventHandler(a, c)
end;
pr = function(d) print(('^2[%s]^7 %s'):format(script_name, d)) end;
Events = {}
Events.SV = {Verify_Request = GetName(":SV:Verify_Request:9999")}
Events.CL = {Verify_Receive = GetName(":CL:Verify_Receive:9999")}
Events.NUI = {OnFinsh_Receive = "OnFinsh_Receive"}
funcs = {}
funcs.Dump = function(e, f)
    if f == nil then f = 0 end
    if type(e) == 'table' then
        local g = ''
        for h = 1, f + 1, 1 do g = g .. "    " end
        g = '{\n'
        for i, j in pairs(e) do
            if type(i) ~= 'number' then i = '"' .. i .. '"' end
            for h = 1, f, 1 do g = g .. "    " end
            g = g .. '[' .. i .. '] = ' .. funcs.Dump(j, f + 1) .. ',\n'
        end
        for h = 1, f, 1 do g = g .. "    " end
        return g .. '}'
    else
        return tostring(e)
    end
end
