RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('_chat:messageEnteredP')
RegisterServerEvent('_chat:messageEnteredM')
RegisterServerEvent('_chat:messageEnteredG')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

ESX = nil 

local MutedPlayers = {}

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(1)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if MutedPlayers[xPlayer.identifier] then 
        if os.time() < MutedPlayers[xPlayer.identifier] then 
            TriggerClientEvent('chatMessage', source, ("^1HỆ THỐNG :^0 bạn đang bị cấm chat trong ^1%s giây"):format(math.floor(MutedPlayers[xPlayer.identifier] - os.time())))  
            return
        end
    end
    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 0, 255, 0 }, message)
    end

    print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('_chat:messageEnteredP', function(author, color, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then 
        if not message or not author then
            return
        end
    
        TriggerEvent('chatMessageP', source, author, message)
    
        if not WasEventCanceled() then
            TriggerClientEvent('chatMessageP', -1, author,  { 0, 255, 0 }, message)
        end
    
        print(author .. '^7: ' .. message .. '^7')
    else 
        xPlayer.triggerEvent('esx:showNotification', 'Bạn không có quyền chat trong kênh này')
    end
end)

AddEventHandler('_chat:messageEnteredM', function(author, color, message)
    -- if not message or not author then
    --     return
    -- end

    -- TriggerEvent('chatMessageM', source, author, message)

    -- if not WasEventCanceled() then
    --     TriggerClientEvent('chatMessageM', -1, author,  { 0, 255, 0 }, message)
    -- end

    -- print(author .. '^7: ' .. message .. '^7')
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'ambulance' then 
        if not message or not author then
            return
        end
    
        TriggerEvent('chatMessageM', source, author, message)
    
        if not WasEventCanceled() then
            TriggerClientEvent('chatMessageM', -1, author,  { 0, 255, 0 }, message)
        end
    
        print(author .. '^7: ' .. message .. '^7')
    else 
        xPlayer.triggerEvent('esx:showNotification', 'Bạn không có quyền chat trong kênh này')
    end
end)


RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and '[^1ADMIN^7]' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
end)



AddEventHandler('_chat:messageEnteredG', function(author, color, message)
    -- if not message or not author then
    --     return
    -- end

    -- TriggerEvent('chatMessageG', source, author, message)

    -- if not WasEventCanceled() then
    --     TriggerClientEvent('chatMessageG', -1, author,  { 0, 255, 0 }, message)
    -- end

    -- print(author .. '^7: ' .. message .. '^7')
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'mechanic' then 
        if not message or not author then
            return
        end
    
        TriggerEvent('chatMessageG', source, author, message)
    
        if not WasEventCanceled() then
            TriggerClientEvent('chatMessageG', -1, author,  { 0, 255, 0 }, message)
        end
    
        print(author .. '^7: ' .. message .. '^7')
    else 
        xPlayer.triggerEvent('esx:showNotification', 'Bạn không có quyền chat trong kênh này')
    end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
-- AddEventHandler('chat:init', function()
--     --    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^3* ' .. GetPlayerName(source) .. '^2 joined')
--         -- TriggerClientEvent("pNotify:SendNotification", -1,{
--         --     text =	'* <b style="color: orange">' .. GetPlayerName(source) .. '</b> đã tham gia',
--         --     type = "success",
--         --     timeout = (3000),
--         --     layout = "centerright",
--         --     queue = "global"
--         -- })
-- end)
    
--[[     AddEventHandler('playerDropped', function(reason)
     --   TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left')
        TriggerClientEvent("pNotify:SendNotification", -1,{
            text =	'* <b style="color: red">' .. GetPlayerName(source) ..'</b> đã thoát',
            type = "error",
            timeout = (3000),
            layout = "centerright",
            queue = "global"
        })
    end) ]]

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

RegisterCommand("mute", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source) 
    if (xPlayer.job.name == "police" and xPlayer.job.grade_name == "boss") or xPlayer.getGroup() == "admin" then 
        local target = tonumber(args[1])
        local tPlayer = ESX.GetPlayerFromId(target)
        local time = tonumber(args[2])
        if tPlayer then 
            MutedPlayers[tPlayer.identifier] = os.time() + time
            TriggerClientEvent('chatMessage', -1, ("^1HỆ THỐNG :^0 [^3%s^0] đã bị cấm chat trong ^1%s giây"):format(tPlayer.name, math.floor(time)))  
        else
            xPlayer.showNotification("Sai lệnh. /mute [id] [thời-gian]")
        end
    end
end)

RegisterCommand("unmute", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source) 
    if (xPlayer.job.name == "police" and xPlayer.job.grade_name == "boss") or xPlayer.getGroup() == "admin" then 
        local target = tonumber(args[1])
        local tPlayer = ESX.GetPlayerFromId(target)
        if tPlayer then 
            MutedPlayers[tPlayer.identifier] = 0
        else
            xPlayer.showNotification("Sai lệnh. /unmute [id]")
        end
    end
end)