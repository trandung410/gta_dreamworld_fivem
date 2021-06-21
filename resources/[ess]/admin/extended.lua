_G.ESX = nil
TriggerEvent('esx:getSharedObject', function(o) ESX = o end)
if IsDuplicityVersion() then
    _G.IS_ESX_FINAL = GetResourceMetadata('es_extended', 'version', 0) == '1.2.0'
end