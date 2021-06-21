xZero = {}
SOAIZJAISJUZGAYSGPSAKZIOAHSIZA = nil
RegisEvent(
    true,
    GetName(":client:Verify:Receive"),
    function(a)
        SOAIZJAISJUZGAYSGPSAKZIOAHSIZA = a
    end
)
Citizen.CreateThread(
    function()
        local b = GetGameTimer()
        while SOAIZJAISJUZGAYSGPSAKZIOAHSIZA == nil and GetGameTimer() - b <= 30 * 1000 do
            TriggerServerEvent(GetName(":server:Verify:Request"))
            Wait(300)
        end
        xZero.Init()
    end
)
ESX = nil
_InventoryItem = {}
ShopOpen_Status = false
Shop_CurrentActions = {}
Shop_CurrentActions.hasEnterMarker = false
Shop_CurrentActions.Zone_Index = nil
Shop_CurrentActions.Zone = nil
Shop_CurrentActions.Zone_Pos = nil
Shop_Zones_JobNotAllow = {}
BlipList = {}
_IsKeyPress_Prograss = false
xZero.Init = function()
    Wait(500)
    if SOAIZJAISJUZGAYSGPSAKZIOAHSIZA then
        if not Config_Vaild() then
            print(("^1[%s] Error Config Vaild DATA^7"):format(script_name))
            return
        end
        while ESX == nil do
            TriggerEvent(
                Config_xZC_Shop.Base.getSharedObject,
                function(c)
                    ESX = c
                end
            )
            Wait(1)
        end
        while true do
            if ESX.GetPlayerData() and ESX.GetPlayerData().inventory and #ESX.GetPlayerData().inventory > 0 then
                Wait(100)
                break
            end
            Wait(1)
        end
        for d, e in ipairs(ESX.GetPlayerData().inventory) do
            _InventoryItem[e.name] = e
        end
        xZero.Inited()
    else
        print("^1Verify:ERROR^7")
    end
end
xZero.Inited = function()
    print(("Inited - version_current:^3%s^7"):format(version_current))
    SendNUIMessage({action = "config_settings", URL_Images = Config_xZC_Shop.URL_Images})
    xZero.Init_CreateThread()
    xZero.Init_Handlers()
end
xZero.Init_CreateThread = function()
    Blip_Reloaded()
    Citizen.CreateThread(
        function()
            while true do
                if Config_xZC_Shop.Zones then
                    for f, g in ipairs(Config_xZC_Shop.Zones) do
                        if g.Marker and g.Marker.Show and g.Pos then
                            for h, i in ipairs(g.Pos) do
                                local j = Config_xZC_Shop.Default.Marker.Distance
                                local k = #(GetEntityCoords(PlayerPedId()) - vector3(i.x, i.y, i.z))
                                if k <= j then
                                    if not Shop_Zones_JobNotAllow or Shop_Zones_JobNotAllow[f] == nil then
                                        local l = g.Marker.Type and g.Marker.Type or Config_xZC_Shop.Default.Marker.Type
                                        local m = g.Marker.Size and g.Marker.Size or Config_xZC_Shop.Default.Marker.Size
                                        local n =
                                            g.Marker.Color and g.Marker.Color or Config_xZC_Shop.Default.Marker.Color
                                        local o = i.z
                                        o = g.Marker.Pos_Z_up and o + g.Marker.Pos_Z_up or o
                                        o = g.Marker.Pos_Z_down and o - g.Marker.Pos_Z_down or o
                                        DrawMarker(
                                            l,i.x,i.y,o,0.0,0.0,0.0,0,0.0,0.0,m.x,m.y,m.z,n.r,n.g,n.b,100,false,true,2,false,false,false,false)
                                    end
                                end
                            end
                        end
                    end
                end
                Wait(1)
            end
        end
    )
    Citizen.CreateThread(
        function()
            while true do
                local p = false
                local q = nil
                local r = nil
                local s = nil
                if Config_xZC_Shop.Zones then
                    for f, g in ipairs(Config_xZC_Shop.Zones) do
                        if g.Pos then
                            for h, i in ipairs(g.Pos) do
                                Wait(1)
                                local k = #(GetEntityCoords(PlayerPedId()) - vector3(i.x, i.y, i.z))
                                local m =
                                    g.Marker and g.Marker.Size and g.Marker.Size or Config_xZC_Shop.Default.Marker.Size
                                if k < m.x then
                                    p = true
                                    q = f
                                    r = g
                                    s = i
                                end
                            end
                        end
                    end
                end
                if p and not Shop_CurrentActions.hasEnterMarker then
                    Shop_CurrentActions.hasEnterMarker = true
                    TriggerEvent(GetName(":client:On_EnterMarker"), q, r)
                end
                if not p and Shop_CurrentActions.hasEnterMarker then
                    Shop_CurrentActions.hasEnterMarker = false
                    TriggerEvent(GetName(":client:On_ExitMarker"))
                end
                Wait(10)
            end
        end
    )
    Citizen.CreateThread(
        function()
            while true do
                if Shop_CurrentActions.Zone_Index and Shop_CurrentActions.Zone then
                    if not Shop_Zones_JobNotAllow or Shop_Zones_JobNotAllow[Shop_CurrentActions.Zone_Index] == nil then
                        DisplayHelpText("Nhấn [E] de mua hàng")
                        if IsControlPressed(0, 38) and not ShopOpen_Status and not _IsKeyPress_Prograss then
                            _IsKeyPress_Prograss = true
                            if Zone_ItemsRequireIsVaild(Shop_CurrentActions.Zone_Index) then
                                TriggerEvent(
                                    GetName(":client:Shop_ItemsList_Setup"),
                                    function(t)
                                        if t then
                                            TriggerEvent(GetName(":client:Shop_Open"))
                                        else
                                        end
                                        _IsKeyPress_Prograss = false
                                    end,
                                    Shop_CurrentActions.Zone_Index
                                )
                            else
                                pNotify("Bạn không có giấy phép súng!", "error")
                                Wait(2000)
                                _IsKeyPress_Prograss = false
                            end
                        end
                    else
                        Wait(1000)
                    end
                else
                    Wait(500)
                end
                Wait(10)
            end
        end
    )
end
xZero.Init_Handlers = function()
    RegisEvent(
        false,
        GetName(":client:On_EnterMarker"),
        function(u, v)
            Shop_CurrentActions.Zone_Index = u
            Shop_CurrentActions.Zone = v
        end
    )
    RegisEvent(
        false,
        GetName(":client:On_ExitMarker"),
        function()
            Shop_CurrentActions.Zone_Index = nil
            Shop_CurrentActions.Zone = nil
            TriggerEvent(GetName(":client:Shop_Close"))
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_ItemsList_Setup"),
        function(w, u)
            if Config_xZC_Shop.Zones and Config_xZC_Shop.Zones[u] then
                local g = Config_xZC_Shop.Zones[u]
                local x = {}
                x.action = "itemslist_setup"
                x.Zone_Index = u
                x.Zone_Name = g.Name
                x.Zone_Label = g.Label
                x.ItemsList = {}
                if g.Items and #g.Items > 0 then
                    for y, z in ipairs(g.Items) do
                        local A = _InventoryItem[z.name]
                        if A or z.item_type and z.item_type == "item_weapon" then
                            local B = xItemFormat(z, A)
                            table.insert(
                                x.ItemsList,
                                {
                                    index = y,
                                    name = B.name,
                                    label = B.label,
                                    limit = B.limit,
                                    item_type = B.item_type,
                                    price_account_name = B.price_account_name,
                                    price = B.price,
                                    count = 1
                                }
                            )
                        else
                            print(("^1Error InvItem NotFound | %s^1 | %s^7"):format(z.name, z.item_type))
                        end
                    end
                end
                if g.ItemsInclude and #g.ItemsInclude > 0 and Config_xZC_Shop.ItemsInclude then
                    for d, C in ipairs(g.ItemsInclude) do
                        local D = Config_xZC_Shop.ItemsInclude[C] or nil
                        if D and #D > 0 then
                            for y, z in ipairs(D) do
                                local A = _InventoryItem[z.name]
                                if A or z.item_type and z.item_type == "item_weapon" then
                                    local B = xItemFormat(z, A)
                                    table.insert(
                                        x.ItemsList,
                                        {
                                            index = y,
                                            name = B.name,
                                            label = B.label,
                                            limit = B.limit,
                                            item_type = B.item_type,
                                            price_account_name = B.price_account_name,
                                            price = B.price,
                                            count = 1,
                                            ItemsInclude = C
                                        }
                                    )
                                else
                                    print(("^1Error InvItem NotFound | %s | %s^7"):format(z.name, z.item_type))
                                end
                            end
                        end
                    end
                end
                SendNUIMessage(x)
                w(true)
            else
                w(nil)
            end
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_SetShow"),
        function(t)
            SendNUIMessage({action = "shop_open", status = t})
            ShopOpen_Status = t
            if ShopOpen_Status then
                Citizen.Wait(100)
            end
            SetNuiFocus(ShopOpen_Status, ShopOpen_Status)
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_Open"),
        function()
            TriggerEvent(GetName(":client:Shop_SetShow"), true)
        end
    )
    RegisEvent(
        false,
        GetName(":client:Shop_Close"),
        function()
            TriggerEvent(GetName(":client:Shop_SetShow"), false)
        end
    )
    RegisterNUICallback(
        "Close",
        function(x, w)
            TriggerEvent(GetName(":client:Shop_Close"))
            w(true)
        end
    )
    RegisterNUICallback(
        "On_Buy",
        function(x, w)
            local E = {}
            E.status = "error"
            local F = math.random(100, 500)
            Wait(F)
            local u = x.Zone_Index
            local G = x.Item
            if ItemIsVaild(u, G) then
                E.status = "success"
                TriggerServerEvent(GetName(":server:On_Shop_Buy"), u, G)
            end
            w(E)
        end
    )
    RegisEvent(
        true,
        Config_xZC_Shop.Base.setJob,
        function(H)
            Wait(1000)
            Blip_Reloaded()
        end
    )
end
function ItemIsVaild(u, I)
    local g = Config_xZC_Shop.Zones[u] or nil
    if g then
        if I and I.count and type(I.count) == "number" and I.count > 0 then
            if I.ItemsInclude then
                local J = Config_xZC_Shop.ItemsInclude[I.ItemsInclude] or nil
                if J then
                    local K = J[I.index] or nil
                    if K and I.name and K.name == I.name then
                        return true
                    end
                end
            else
                local z = g.Items[I.index] or nil
                if z and I.name and z.name == I.name then
                    return true
                end
            end
        end
    end
    return false
end
function Blip_Reloaded()
    Citizen.CreateThread(
        function()
            if Config_xZC_Shop.Zones and #Config_xZC_Shop.Zones > 0 then
                if BlipList and #BlipList > 0 then
                    for d, e in ipairs(BlipList) do
                        RemoveBlip(e)
                    end
                end
                BlipList = {}
                for f, g in ipairs(Config_xZC_Shop.Zones) do
                    local L = xZoneClass(f)
                    local M = ESX.GetPlayerData().job
                    if L.Job_IsVaild(M) then
                        Shop_Zones_JobNotAllow[f] = nil
                        if g.Blip and g.Blip.Show and (g.Pos and #g.Pos > 0) then
                            for h, i in ipairs(g.Pos) do
                                local N = g.Blip.Name and g.Blip.Name or g.Name
                                local O = g.Blip.Sprite and g.Blip.Sprite or Config_xZC_Shop.Default.Blip.Sprite
                                local P = g.Blip.Colour and g.Blip.Colour or Config_xZC_Shop.Default.Blip.Colour
                                local Q = g.Blip.Scale and g.Blip.Scale or Config_xZC_Shop.Default.Blip.Scale
                                local R = AddBlipForCoord(i.x, i.y, i.z)
                                SetBlipSprite(R, O)
                                SetBlipColour(R, P)
                                SetBlipScale(R, Q)
                                SetBlipAsShortRange(R, true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString(N)
                                EndTextCommandSetBlipName(R)
                                table.insert(BlipList, R)
                            end
                        end
                    else
                        Shop_Zones_JobNotAllow[f] = true
                    end
                end
            end
        end
    )
end
function Zone_ItemsRequireIsVaild(u)
    local g = Config_xZC_Shop.Zones[u] or nil
    if g and g.ItemsRequire then
        for d, S in ipairs(g.ItemsRequire) do
            if not InventoryFindItem(S) then
                return false
            end
        end
    end
    return true
end
function InventoryFindItem(S)
    local T = ESX.GetPlayerData()
    if T and T.inventory then
        local U = false
        for d, e in ipairs(T.inventory) do
            if e.name == S and e.count > 0 then
                U = true
                break
            end
        end
        return U
    end
    return false
end
function pNotify(V, type, W, X)
    type = type and type or "info"
    W = W and W or 3000
    X = X and X or "bottomCenter"
    TriggerEvent("pNotify:SendNotification", {text = V, type = type, queue = "xzero_shop", timeout = W, layout = X})
end
