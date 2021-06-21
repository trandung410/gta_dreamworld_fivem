ESX = nil 
LR = {}
LR.__index = LR

function LR:Init()
    local o = {}
    setmetatable(o, LR)
    o.PlayerData = {}
    o.isBusy = false
    if ESX.IsPlayerLoaded() then 
        o.PlayerData = ESX.GetPlayerData()
    end

    o:EventHandler()
    return o
end

function LR:EventHandler()
    RegisterNetEvent("lr_impound:client:openImpoundMenu", function()
        if self.PlayerData.job.name == "police" or self.PlayerData.job.name == "army" then 
            self:OpenMenu()
        end
    end)
    AddEventHandler("onResourceStop", function(rsName)
        if rsName == GetCurrentResourceName() then 
            SetNuiFocus(false, false)
        end
    end)
    RegisterNetEvent("esx:playerLoaded", function(xPlayer)
        self.PlayerData = xPlayer
    end)
    RegisterNetEvent("esx:setJob", function(job)
        self.PlayerData.job = job
    end)
    RegisterNUICallback("Close", function(data, cb)
        self:Close()
    end)
    RegisterNUICallback("Impound", function(data, cb)
        self:Close()
        TriggerServerEvent("lr_impound:server:impound", data)
    end)
end

function LR:Close()
    self.isBusy = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        event = "toggle",
        data = false
    })
end

function LR:OpenMenu()
    local vehicle = ESX.Game.GetVehicleInDirection()
    if DoesEntityExist(vehicle) then 
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
        print(plate)
        ESX.TriggerServerCallback("lr_impound:callback:getVehicleOwner", function(data)
            if data then 
                SetNuiFocus(true, true)
                SendNUIMessage({
                    event = "toggle",
                    data = true
                })
                SendNUIMessage({
                    event = "init",
                    data = data
                })
            else
                self.isBusy = false
                ESX.ShowNotification("Phương tiện này không có chủ sở hữu ")
            end
        end, plate)
    else
        self.isBusy = false
        ESX.ShowNotification("Không có phương tiện nào gần đây")
    end
end

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(1)
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
    LR:Init()
end)

--[[ RegisterCommand("open", function()
    TriggerEvent("lr_impound:client:openImpoundMenu")
end) ]]