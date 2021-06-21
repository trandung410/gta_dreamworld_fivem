Citizen.CreateThread(function()
    Citizen.Wait(20000)
    local resnamne = GetCurrentResourceName()
    local current_version = GetResourceMetadata(resnamne, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/Luminous-Roleplay/versionsScripts/master/'..resnamne..'.txt',function(error, result, headers)
        local new_version = result:sub(1, -2)
        if tostring(new_version) ~= tostring(current_version) then
            print('^2['..resnamne..'] - New Update Available.^0\nCurrent Version: ^5'..current_version..'^0.\nNew Version: ^5'..new_version..'^0.')
        end
    end,'GET')
end)