----- Editor By pk -----------

local ESX = nil
pk = GetCurrentResourceName()
cops = 0

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

AddEventHandler('esx:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' then
		cops = cops +1
	end

end)


AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    cops = 0
    Wait(1000)
    CheckPolice()
    print ('SET JOB Now Cops = '..cops)
end)

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer.job.name == "police" then
       cops = cops -1  
    end
end)


ESX.RegisterUsableItem('Cement_take', function(source)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	TriggerClientEvent(pk..'StartWork',source)	

end)

RegisterServerEvent(pk.."retrieveelectronic")
AddEventHandler(pk.."retrieveelectronic", function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem('cement')
    local xWorking = xPlayer.getInventoryItem('Cement_take')

    if xWorking.count >= 1 then
        if xItem.limit ~= -1 and  xItem.count+1 > xItem.limit then
            -- full
            TriggerClientEvent("pNotify:SendNotification", source, {
                text = 'ปูนของคุณเต็ม',
                type = "success",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            }) 
        else
            xPlayer.addInventoryItem(Config.Itemname, 1)
            TriggerClientEvent(pk..'false', source)
        end
    else
        -- No Item
        TriggerClientEvent("pNotify:SendNotification", source, {
            text = 'ท่านไม่มีที่ตีปูน',
            type = "success",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        }) 

    end  
    
end)



RegisterServerEvent(pk.."Checkpolice")
AddEventHandler(pk.."Checkpolice", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    
        if cops >= Config.Needcop then
            TriggerClientEvent(pk..'OK',source)
        else
            TriggerClientEvent(pk..'NO',source)
        end
end)


function CheckPolice() --- เช็คตำรวจ
	
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	--return cops
end

