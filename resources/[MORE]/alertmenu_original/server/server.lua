ESX = nil
TriggerEvent(Config.ESX, function(obj) ESX = obj end)
local AlertData = {}

RegisterServerEvent('AlertMenu:AcceptTask')
AddEventHandler('AlertMenu:AcceptTask', function(steamid, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sender = ESX.GetPlayerFromId(steamid)

    for i = 1, #AlertData, 1 do
        if AlertData[i].sender == steamid then
            if AlertData[i].type == type then
                AlertData[i].accept = 1
                AlertData[i].recivedid = xPlayer.source
                AlertData[i].recived = xPlayer.name
                TriggerClientEvent('AlertMenu:Refresh', -1)
                sender.showNotification(_U('accept_task', xPlayer.name))
            end
        end 
    end 

    local typelb = '' 
    if type == 'ambulance' then
        typelb = _U('ambulance_service')
    elseif type == 'mechanic' then
        typelb = _U('mechanic_service')
    elseif type == 'taxi' then
        typelb = _U('taxi_service')
    elseif type == 'police' then
        typelb = _U('police_service')
    end
    TriggerClientEvent('chat:addMessage', -1, { args = { _U('Header_messenges'), _U('accept_messenges', xPlayer.name, typelb, sender.name) }, color = { 249, 166, 0 } })
end)

RegisterServerEvent('AlertMenu:CancelTask')
AddEventHandler('AlertMenu:CancelTask', function(steamid, type)
    for i = 1, #AlertData, 1 do
        if AlertData[i].sender == steamid then
            if AlertData[i].type == type then
                AlertData[i].accept = 0
                AlertData[i].recivedid = 0
                AlertData[i].recived = 'N/A'
                TriggerClientEvent('AlertMenu:Refresh', -1)
            end
        end
    end
end)

RegisterServerEvent('AlertMenu:DoneTask')
AddEventHandler('AlertMenu:DoneTask', function(steamid, type)
	local xPlayer = ESX.GetPlayerFromId(source)
    for i = 1, #AlertData, 1 do
        if AlertData[i].sender == steamid then
            if AlertData[i].type == type then
                table.remove(AlertData, i)
                TriggerClientEvent('AlertMenu:Refresh', -1)
            end
        end 
    end 
end)

RegisterServerEvent('AlertMenu:RefreshMenu')
AddEventHandler('AlertMenu:RefreshMenu', function()
	TriggerClientEvent('AlertMenu:Refresh', -1)
end)

RegisterServerEvent('AlertMenu:SendAlert')
AddEventHandler('AlertMenu:SendAlert', function(type, coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = {
        sender = xPlayer.source,
        name = xPlayer.name,
        sdt = GetPhoneNumber(xPlayer.identifier),
        recivedid = 0,
        type = type,
        recived = 'N/A',
        accept = 0,
        x = coords.x,
        y = coords.y,
        z = coords.z
    }
    table.insert(AlertData, data)
    -- sender.showNotification(_U('accept_task', xPlayer.name))
    TriggerClientEvent('AlertMenu:Notification', -1, type,xPlayer.name)
	TriggerClientEvent('AlertMenu:Refresh', -1)
end)

ESX.RegisterServerCallback('AlertMenu:GetAlert', function(source, cb, type)
    local Alert = {}
        for i=1, #AlertData, 1 do
            if type == 'mechanic' or type == 'taxi' then
                if AlertData[i].type == 'mechanic' or AlertData[i].type == 'taxi' then   
                    table.insert(Alert, AlertData[i])
                end
            else
                if AlertData[i].type == type then   
                    table.insert(Alert, AlertData[i])
                end
            end
        end
    
    cb(Alert)
end)

function UpdateCountJob(jobname)
    local xPlayers = ESX.GetPlayers()	 
    local count = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == jobname then
            count = count + 1
        end
    end
    return count
end

ESX.RegisterServerCallback('AlertMenu:CheckTask', function(source, cb, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local CountJob = UpdateCountJob(type)
    if CountJob == 0 then
        return cb('not_online')
    end
		for i = 1 , #AlertData, 1 do
            if AlertData[i].sender == xPlayer.source then
                if AlertData[i].type == type then
                    return cb(false)
                end
			end
		end
	cb(true)
end)

AddEventHandler('playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    for i = 1, #AlertData, 1 do
        if AlertData[i].sender == xPlayer.source then
            table.remove(AlertData, i)
            TriggerClientEvent('AlertMenu:Refresh', -1)
        end 

        if AlertData[i].recivedid == xPlayer.source then
            AlertData[i].accept = 0
            AlertData[i].recivedid = 0
            AlertData[i].recived = 'N/A'
            TriggerClientEvent('AlertMenu:Refresh', -1)
        end
    end 
end)

function GetPhoneNumber(identifier)
    local result = MySQL.Sync.fetchAll('SELECT phone_number FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    if not (result[1] == nil) then
        return result[1].phone_number
    end
    return nil
end