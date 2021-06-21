RegisterServerEvent('lorraxs:forceDelete')
AddEventHandler('lorraxs:forceDelete', function(netId)
	TriggerClientEvent('lorraxs:forceDelete', -1, netId)
end)
	