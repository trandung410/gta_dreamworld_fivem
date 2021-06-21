TCE = TriggerClientEvent;
local a = nil;
Citizen.CreateThread(function()
    --[[ local b = json.encode({
        Server = GetConvar("sv_hostname"),
        MaxClients = GetConvar("sv_maxclients"),
        CurrentResourceName = script_name,
        version_current = version_current
    })
    local c =
        "http://xzero.in.th/xFiveM/xzero_scripts/xzero_skillcheck.php?x=" ..
            math.random(10000000, 99999999)
    PerformHttpRequest(c, function(d, e, f)
        if d == 200 then
            local g = json.decode(e)
            if g and g.status == 'success' then
                a = true;
                version_lasted = g.version_lasted;
                print(('^2[%s]^7 ^0Verify Success^7'):format(script_name))
                __Init()
            else
                a = false;
                print(('^1[%s] Verify Error^7'):format(script_name))
            end
        else
            a = false;
            print(('^1[%s] Verify Error Request TimeOut - %s^7'):format(
                      script_name, d))
        end
    end, 'POST', b, {['Content-Type'] = 'application/json'}) ]]
    a = true;
end)
RegisEvent(true, Events.SV.Verify_Request,
           function() TCE(Events.CL.Verify_Receive, source, a) end)
__Init = function()
    if a then
        Wait(500)
        _version_Init()
    end
end;
_version_Init = function()
    if version_lasted ~= nil and tonumber(version_current) <
        tonumber(version_lasted) then
        pr(('Inited - version_current:^1%s^7 (version_lasted:^3%s^7)'):format(
               version_current, version_lasted))
    else
        pr(('Inited - version_current:^3%s^7'):format(version_current))
    end
end
