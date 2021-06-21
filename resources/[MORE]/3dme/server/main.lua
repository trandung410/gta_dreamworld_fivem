ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("me", function(source , args , rawCommand)
    args = table.concat(args, ' ')
    TriggerClientEvent('me:event', -1, source, args, 0)
end)

RegisterCommand("do", function(source , args , rawCommand)
    args = table.concat(args, ' ')
    TriggerClientEvent('me:event', -1, source, args, 1)
end)