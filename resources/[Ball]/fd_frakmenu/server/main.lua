ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local newJob

--[[TriggerEvent('es:addGroupCommand', 'invite', "user", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Frakname = xPlayer.job.label
    -- local Frakname = xPlayer.job.label
    local target = tonumber(args[1])
    local targetname = GetPlayerName(target)

    for _, v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer.getGroup() == "superadmin" or xPlayer.job.grade_name == "boss" then
            Citizen.CreateThread(function()
                TriggerClientEvent('dr_frakmenu:menu', target, Frakname,
                    "Möchtest du der Fraktion (" .. Frakname .. ") beitreten?")
            end)
            newJob = xPlayer.job
        else
            TriggerClientEvent("esx:showNotification", source, "~y~Du hast keine Permissions!")
        end
    end
end)--]]

TriggerEvent('es:addGroupCommand', 'invite', "user", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Frakname = xPlayer.job.label
    -- local Frakname = xPlayer.job.label
    local target = tonumber(args[1])
    local targetname = GetPlayerName(target)
    --local xPlayer = ESX.GetPlayerFromId(v)
    if xPlayer.getGroup() == "superadmin" or xPlayer.job.grade_name == "boss" then
        Citizen.CreateThread(function()
            TriggerClientEvent('fd_frakmenu:menu', target, Frakname,
                "Do you want to join (" .. Frakname .. ")?")
        end)
        newJob = xPlayer.job
    else
        TriggerClientEvent("esx:showNotification", source, "~y~Bạn không có quyền làm điều này!")
    end
end)

RegisterNetEvent('fd_frakmenu:jaserver')
AddEventHandler('fd_frakmenu:jaserver', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if ESX.DoesJobExist(newJob.name, 0) then
            xPlayer.setJob(newJob.name, 0)
        end
    end

end)
