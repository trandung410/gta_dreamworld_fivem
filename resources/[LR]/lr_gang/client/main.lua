ESX = nil

LR_GANG = {}
LR_GANG.__index = LR_GANG

function LR_GANG:Init()
    local o = {}
    setmetatable(o, LR_GANG)
    o.PlayerData = {}
    o.isOpen = false
    o.gangData = {
        gangName = "",
        gangSrc = "",
        gangText = "",
        gangLevel = 1,
        gangMember = 0,
        members = {},
        store = {},
        gangGrade = {},
        upgradeUnlock = {},
        upgradeRequire = {},
    }
    o.gangHouse = {}
    o.gangBlips = {}
    o:InventoryThread()
    o:GangHouse()
    return o
end

function LR_GANG:GangHouse()
    Citizen.CreateThread(function()
        while true do 
            coroutine.yield(0)
            local shouldDelay = true
            for k, v in pairs(self.gangHouse) do 
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped, true)
                local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pedCoords, true)
                if distance <= 50 and v.owner == nil then 
                    DrawMarker(6, v.x, v.y, v.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 2.0, 2.0, 2.0, 22, 199, 154, 150, false, false, 2, nil, nil, false)
                    if distance <= 1.0 then 
                        ESX.ShowHelpNotification("Nhấn [E] để đặt khu vực này thành nhà Gang của bạn")
                        if IsControlJustReleased(0, 38) then 
                            --TriggerServerEvent("lr_gang:server:setHouse", k)
                            ESX.TriggerServerCallback("lr_gang:callback:canSetHouse", function(canSet)
                                if canSet then 
                                    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "choose_sprite", {
                                        title = "Vui lòng chọn mã icon để hiện lên bản đồ (https://docs.fivem.net/docs/game-references/blips/)"
                                    }, function(data, menu)
                                        local sprite = data.value
                                        if sprite == nil then 
                                            ESX.ShowNotification("không được để trống")
                                        else
                                            menu.close()
                                            TriggerServerEvent("lr_gang:server:setHouse", k, sprite)
                                        end
                                    end)
                                end
                            end, k)
                        end
                    end
                end
            end
        end
    end)
end

function LR_GANG:EventHandler()
    RegisterNetEvent("lr_gang:client:syncBlip")
    AddEventHandler("lr_gang:client:syncBlip", function(gangHouse)
        self.gangHouse = gangHouse
        for k, v in pairs(self.gangBlips) do 
            RemoveBlip(v)
        end
        for k, v in pairs(gangHouse) do 
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, v.sprite or 350)
            SetBlipScale(blip, 1.0)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.owner or "<FONT FACE='Montserrat'>Nhà Gang Trống")
            EndTextCommandSetBlipName(blip)
            table.insert(self.gangBlips, blip)
            local blip = AddBlipForRadius(v.x, v.y, v.z, 50.0)
            SetBlipColour(blip, 1)
            SetBlipAlpha(blip, 150)
            table.insert(self.gangBlips, blip)
        end
    end)
    RegisterNetEvent("esx:playerLoaded")
    AddEventHandler("esx:playerLoaded", function(xPlayer)
        self.PlayerData = xPlayer
        ESX.TriggerServerCallback("lr_gang:callback:getGangData", function(data)
            self.gangData = data
            self:UpdateData()
        end, self.PlayerData.job.name)
    end)
    RegisterNetEvent("esx:setJob")
    AddEventHandler("esx:setJob", function(job)
        self.PlayerData.job = job
        ESX.TriggerServerCallback("lr_gang:callback:getGangData", function(data)
            self.gangData = data
            self:UpdateData()
        end, self.PlayerData.job.name)
    end)
    RegisterNUICallback("Close", function(data, cb)
        self:Close()
    end)
    RegisterNetEvent("lr_gang:client:syncGangData")
    AddEventHandler("lr_gang:client:syncGangData", function(data)
        self.gangData = data
        self:UpdateData()
    end)
    RegisterNUICallback("ChangeLogo", function(data, cb)
        print("ChangeLogo", json.encode(data))
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:changeLogo", data.data)
    end)
    RegisterNUICallback("ChangeSlogan", function(data, cb)
        print("ChangeSlogan", json.encode(data))
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:changeSlogan", data.data)
    end)
    RegisterNUICallback("QuitGang", function(data, cb)
        print("QuitGang")
        TriggerServerEvent("lr_gang:server:quitGang")
    end)
    RegisterNUICallback("FireMember", function(data, cb)
        print("FireMember", json.encode(data))
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:fireMember", data)
    end)
    RegisterNUICallback("Promote", function(data, cb)
        print("Promote", json.encode(data))
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:promote", data)
    end)
    RegisterNUICallback("Buy", function(data, cb)
        print("Buy", json.encode(data))
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:buy", data)
    end)
    RegisterNUICallback("Upgrade", function(data, cb)
        print("Upgrade", json.encode(data))
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:upgrade", data)
    end)
    RegisterNUICallback("ChangeInventory", function(data, cb)
        print("ChangeInventory", json.encode(data))
        local pedCoords = GetEntityCoords(PlayerPedId(), true)
        --data = json.decode(data)
        TriggerServerEvent("lr_gang:server:changeInventory", pedCoords)
    end)
    RegisterNUICallback("OpenBossMenu", function(data, cb)
        print("OpenBossMenu", json.encode(data))
        self:Close()
        --TriggerServerEvent("lr_gang:server:openBossMenu", pedCoords)
        TriggerEvent("esx_society:openBossMenu", self.gangData.gangName, function(data, menu)
            menu.close()
        end, {wash = false})
    end)
end

function LR_GANG:Open()
    --[[ if self.PlayerData.job.name == "nogang" or self.PlayerData.job.name == "police" or self.PlayerData.job.name == "" then 
        ESX.ShowNotification("Bạn không có trong băng đảng")
        return
    end ]]
    if Config.ExcludeJob[self.PlayerData.job.name] then 
        ESX.ShowNotification("Bạn không có trong băng đảng")
        return
    end
    ESX.TriggerServerCallback("lr_gang:callback:getGangData", function(data)
        self.gangData = data
        self:UpdateData()
    end, self.PlayerData.job.name)
    self.isOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        event = "toggle",
        data = true
    })
end

function LR_GANG:Close()
    self.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        event = "toggle",
        data = false
    })
end

function LR_GANG:UpdateData()
    SendNUIMessage({
        event = "init-data",
        data = self.gangData
    })
end

function LR_GANG:MainThread()
    while true do 
        coroutine.yield(0)
        if not self.isOpen then 
            if IsControlJustPressed(0, Config.OpenKey) then 
                self:Open()
            end
        else
            Wait(1000)
        end
    end
end

function LR_GANG:InventoryThread()
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if self.gangData.inventoryPos and self.gangData.inventoryPos.x then 
                local pedCoords = GetEntityCoords(PlayerPedId(), true)
                local distance = GetDistanceBetweenCoords(pedCoords, self.gangData.inventoryPos.x, self.gangData.inventoryPos.y, self.gangData.inventoryPos.z, true)
                if distance <= 20.0 then 
                    DrawMarker(6, self.gangData.inventoryPos.x, self.gangData.inventoryPos.y, self.gangData.inventoryPos.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 2.0, 2.0, 2.0, 22, 199, 154, 150, false, false, 2, nil, nil, false)
                    if distance <= 1.0 then 
                        ESX.ShowHelpNotification("Nhấn [E] để mở kho đồ")
                        if IsControlJustReleased(0, 38) then 
                            TriggerEvent("esx_inventoryhud:openSocietyInventory")
                        end
                    end
                end
            end
        end
    end)
end

Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(0)
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
    rt = LR_GANG:Init()
    rt:EventHandler()
    if ESX.IsPlayerLoaded() then 
        rt.PlayerData = ESX.GetPlayerData()
    end
    Wait(5000)
    ESX.TriggerServerCallback("lr_gang:callback:getGangData", function(data)
        rt.gangData = data
        rt:UpdateData()
    end, rt.PlayerData.job.name)
    rt:MainThread()
end)
local regZone = {x = -888.19525146484, y = -853.11029052734, z = 20.566030502319}
Citizen.CreateThread(function()
    while ESX == nil do 
        Wait(0)
    end
    while true do 
        Wait(0)
        local ped = PlayerPedId()
        SetPedSuffersCriticalHits(ped, false)
        local pedCoords = GetEntityCoords(ped, true)
        local distance = GetDistanceBetweenCoords(regZone.x, regZone.y, regZone.z, pedCoords, true)
        if distance <= 20.0 then 
            DrawMarker(6, regZone.x, regZone.y, regZone.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 2.0, 2.0, 2.0, 22, 199, 154, 150, false, false, 2, nil, nil, false)
            if distance <= 1.0 then 
                ESX.ShowHelpNotification("Nhấn [E] để bái Quan Nhị Ca")
                if IsControlJustReleased(0, 38) then 
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'create_gang', {
						title = 'Nhập Tên Băng Đảng Muốn Tạo!'
					}, function(data, menu )
                        local gangLabel = data.value
                        if gangLabel == nil then 
                            ESX.ShowNotification("Tên băng đảng không được để trôngs")
                        else
                            ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "gang_name", {
                                title = "Tên viết tắt của Gang (VD:Mafia, Gang, ABC) viết liền không dấu"
                            }, function(data2, menu2)
                                menu2.close()
                                local gangName = string.gsub(data2.value, "%s+", "")
                                if gangName == nil then 
                                    ESX.ShowNotification("Tên viết tắt không được để trống")
                                else    
                                    SetEntityCoords(PlayerPedId(), regZone.x, regZone.y, regZone.z, 0.0, 0.0, 0.0, false)
                                    SetEntityHeading(PlayerPedId(), 104.87752532959)
                                    TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", -1, false)
                                    Wait(5000)
                                    ClearPedTasks(PlayerPedId())
                                    TriggerServerEvent("lr_gang:server:createGang", gangName, gangLabel)
                                end
                                
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
						menu.close()
					end, function(data, menu )
						menu.close()
					end)
                end
            end
        end
    end
end)