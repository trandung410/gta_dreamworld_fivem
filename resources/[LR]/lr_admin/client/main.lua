ESX = nil

Admin = {}
Admin.__index = Admin

Player = {}
Player.__index = Player

function Admin:Init()
    local o = {}
    setmetatable(o, Admin)
    o.isOpen = false
    return o
end

function Admin:Command()
    RegisterCommand('admin', function()
        self:Open()
        ESX.TriggerServerCallback("lr_admin:callback:getPlayersData", function(data)
            print(json.encode(data))
            SendNUIMessage({
                event = 'data',
                data = {
                    playerList = data
                }
            })
        end)
    end, false)
end

function Admin:NUIHandler()
    RegisterNUICallback("ChangeValue", function(data, cb)
        data = json.decode(data)
        ESX.TriggerServerCallback("lr_admin:callback:ChangeValue", function(data)
            SendNUIMessage({
                event = 'data',
                data = {
                    playerList = data
                }
            })
        end, data)
        --TriggerServerEvent("lr_admin:server:ChangeValue", data)
        Wait(2000)
        cb()
    end)
    RegisterNUICallback("Close", function(data, cb)
        self:Close()
    end)
    RegisterNUICallback("Action", function(data, cb)
        data = json.decode(data)
        TriggerServerEvent("lr_admin:server:Action", data)
    end)
    RegisterNUICallback("AddItem", function(data, cb)
        data = json.decode(data)
        TriggerServerEvent("lr_admin:server:AddItem", data)
    end)
end

function Admin:Open()
    if not self.isOpen then 
        self.isOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            event = 'toggle',
            data = true
        })
    end
end

function Admin:Close()
    if self.isOpen then 
        self.isOpen = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            event = 'toggle',
            data = false
        })
    end
end

function Player:Init()
    local o = {}
    setmetatable(o, Player)
    o.isFreeze = false
    return o
end

function Player:EventHandler()
    RegisterNetEvent("lr_admin:client:goto")
    AddEventHandler("lr_admin:client:goto", function(coords, name)
        print(coords, name)
        ESX.Game.Teleport(PlayerPedId(), coords, function()
            ESX.ShowNotification("~y~Bạn đã được dịch chuyển tới "..name)
        end)
    end)
    RegisterNetEvent("lr_admin:client:bring")
    AddEventHandler("lr_admin:client:bring", function(coords)
        ESX.Game.Teleport(PlayerPedId(), coords, function()
            ESX.ShowNotification("~y~Bạn đã được dịch chuyển bởi ADMIN")
        end)
    end)
    RegisterNetEvent("lr_admin:client:freeze")
    AddEventHandler("lr_admin:client:freeze", function()
        self.isFreeze = not self.isFreeze
        FreezeEntityPosition(PlayerPedId(), self.isFreeze)
        if self.isFreeze then 
            ESX.ShowNotification("~y~Bạn đã bị đóng băng bởi ADMIN")
        else
            ESX.ShowNotification("~y~Bạn đã hết đóng băng bởi ADMIN")
        end
    end)
    RegisterNetEvent("lr_admin:client:kill")
    AddEventHandler("lr_admin:client:kill", function()
        SetEntityHealth(PlayerPedId(), 0)
    end)
end

AddEventHandler("onResourceStop", function(rN)
    if rN == GetCurrentResourceName() then 
        SetNuiFocus(false, false)
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(1)
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
    admin = Admin:Init()
    admin:Command()
    admin:NUIHandler()
    player = Player:Init()
    player:EventHandler()
end)


--[[ 
Citizen.CreateThread(function()
    while true do 
        Wait(100)
        TriggerServerEvent("test", "test2")
    end
end)
 ]]

--[[ Citizen.CreateThread(function()
    local txd = CreateRuntimeTxd('duiTxd')
    local duiObj = CreateDui('https://lorraxs.com/Color2.gif',1024, 1024)
    _G.duiObj = duiObj
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
    AddReplaceTexture("prop_flags", "prop_flag_us", "duiTxd", "duiTex")
end) ]]

local gate = nil 

-- RegisterCommand("testgate", function()
--     local pedCoords = GetEntityCoords(PlayerPedId()) 
--     if gate ~= nil then 
--         DeleteObject(gate)
--     end 
--     local model = GetHashKey("ap1_04_triaf01_reflproxy")
--     RequestModel(model)
--     while not HasModelLoaded(model) do
--         print("Request", model)
--         RequestModel(model)
--         Citizen.Wait(0)
--     end
--     print(GetHashKey("ap1_04_triaf01_reflproxy"))
--     gate = CreateObject(GetHashKey("ap1_04_triaf01_reflproxy"), pedCoords.x, pedCoords.y, pedCoords.z - 1.100, false, true)
-- end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then 
        if gate ~= nil then 
            DeleteObject(gate)
        end 
    end
end)

-- RegisterCommand("scr", function()
--     print("asasas")
--     exports['screenshot-basic']:requestScreenshot({encoding = "png"}, function(data)
--         print("asdasd")
--         print(data)
--         TriggerEvent('chat:addMessage', { template = '<img src="{0}" style="max-width: 300px;" />', args = { data } })
--     end)
--     exports['screenshot-basic']:requestScreenshotUpload('https://lorraxs.com/image/up.php', 'files[]', function(data)
--         print(data)
--         local resp = json.decode(data)
--         print(resp.files[1].url)
--     end)
-- end)