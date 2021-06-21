local ESX = nil

TriggerEvent("esx:getSharedObject", function(library)
    ESX = library
end)

RegisterServerEvent('mechanic:sv:removeCash')
AddEventHandler('mechanic:sv:removeCash', function(amount)
	local src = source

    amount = tonumber(amount)
    if (not amount or amount <= 0) then return end
    
    local esxPlayer = ESX.GetPlayerFromId(src)
    if (esxPlayer) then
        esxPlayer.removeMoney(amount)
    end
end)