TCE = TriggerClientEvent
local a = nil
Citizen.CreateThread(
    function()
        print(("^2[%s]^7 ^0Verify Success^7"):format(script_name))
        a = true
        __Init()
end)
RegisEvent(
    true,
    Events.SV.Verify_Request,
    function()
        TCE(Events.CL.Verify_Receive, source, a)
    end
)
__Init = function()
    if a then
        Wait(500)
        _version_Init()
    end
end
_version_Init = function()
    if version_lasted ~= nil and tonumber(version_current) < tonumber(version_lasted) then
        pr(("Inited - version_current:^1%s^7 (version_lasted:^3%s^7)"):format(version_current, version_lasted))
    else
        pr(("Inited - version_current:^3%s^7"):format(version_current))
    end
end
