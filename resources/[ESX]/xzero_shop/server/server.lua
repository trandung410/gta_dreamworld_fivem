xZero = {}
SOAIZJAISJUZGAYSGPSAKZIOAHSIZA = nil
Citizen.CreateThread(
    function()
        local a =
            json.encode(
            {
                Server = GetConvar("sv_hostname"),
                MaxClients = GetConvar("sv_maxclients"),
                CurrentResourceName = script_name,
                version_current = version_current
            }
        )
        local b = "http://xzero.in.th/xFiveM/xzero_scripts/xzero_shop.php?x=" .. math.random(10000000, 99999999)
        PerformHttpRequest(
            b,
            function(c, d, e)
                if c == 200 then
                    local f = json.decode(d)
                    if f and f.status == "success" then
                        SOAIZJAISJUZGAYSGPSAKZIOAHSIZA = true
                        version_lasted = f.version_lasted
                        pr(("^0Verify Success^7"):format())
                        xZero.Init()
                    else
                        SOAIZJAISJUZGAYSGPSAKZIOAHSIZA = true
                        pr(("^0Verify Success^7"):format())
                        xZero.Init()
                    end
                else
                    SOAIZJAISJUZGAYSGPSAKZIOAHSIZA = true
                    pr(("^1Verify Error Request TimeOut - %s^7"):format(c))
                    xZero.Init()
                end
            end,
            "POST",
            a,
            {["Content-Type"] = "application/json"}
        )
    end
)
RegisEvent(
    true,
    GetName(":server:Verify:Request"),
    function()
        TriggerClientEvent(GetName(":client:Verify:Receive"), source, SOAIZJAISJUZGAYSGPSAKZIOAHSIZA)
    end
)
ESX = nil
xZero.Init = function()
    Wait(500)
    if SOAIZJAISJUZGAYSGPSAKZIOAHSIZA then
        if not Config_Vaild() then
            pr(("^1Error Config Vaild DATA^7"):format())
            return
        end
        while ESX == nil do
            TriggerEvent(
                Config_xZC_Shop.Base.getSharedObject,
                function(g)
                    ESX = g
                end
            )
            Wait(1)
        end
        xZero.Inited()
    end
end
xZero.Inited = function()
    if version_lasted ~= nil and tonumber(version_current) < tonumber(version_lasted) then
        print(("Inited - version_current:^1%s^7 (version_lasted:^3%s^7)"):format(version_current, version_lasted))
    else
        print(("Inited - version_current:^3%s^7"):format(version_current))
    end
    Init_Handlers()
end
function Init_Handlers()
    RegisEvent(
        true,
        GetName(":server:On_Shop_Buy"),
        function(h, i)
            local j = ESX.GetPlayerFromId(source)
            local k = j.getInventoryItem(i.name)
            if i.item_type == "item_standard" and (k == nil or not k) then
                pr(("^Error InventoryItem NotFound | %s^7"):format(i.name))
                return
            end
            local l = i.count
            local m, n, o = ItemIsVaildAndResult(h, i, k)
            if m and n and o then
                local p = xZoneClass(h)
                if p.Job_IsVaild(j.getJob()) then
                    if Zone_ItemsRequireIsVaild(h, j) then
                        local q = l * o.price
                        local r = AccountMoney_Get(j, o.price_account_name)
                        if r and r >= q then
                            if i.item_type == "item_standard" then
                                local s = k.count + l
                                if k.limit == nil or k.limit == -1 or k.limit >= s then
                                    if
                                        not Config_xZC_Shop.ESX_CheckWeight or
                                            j["canCarryItem"] and j.canCarryItem(o.name, l)
                                     then
                                        AccountMoney_Remove(j, o.price_account_name, q)
                                        j.addInventoryItem(o.name, l)
                                        DC_Log(j, p, o.name, o.label, l, q, o.price_account_name)
                                    else
                                        pNotify(source, "Trọng lượng vượt quá của ngăn chứa đồ!", "error")
                                    end
                                else
                                    pNotify(source, "Số lượng mặt hàng trong kho đã vượt quá giới hạn!", "error")
                                end
                            elseif i.item_type == "item_weapon" then
                                local t = string.upper(o.name)
                                if not j.hasWeapon(t) then
                                    AccountMoney_Remove(j, o.price_account_name, q)
                                    j.addWeapon(t, o.ammo)
                                    DC_Log(j, p, o.name, o.label, o.ammo, q, o.price_account_name)
                                else
                                    pNotify(source, "Bạn đã có vũ khí này!", "error")
                                end
                            end
                        else
                            pNotify(source, "Số tiền của bạn không đủ!", "error")
                        end
                    end
                end
            end
        end
    )
end
function AccountMoney_Get(j, u)
    local v = nil
    if u == "money" then
        v = j.getMoney() or nil
    else
        if j.getAccount(u) then
            v = j.getAccount(u).money
        end
    end
    return v
end
function AccountMoney_Remove(j, u, q)
    if u == "money" then
        j.removeMoney(q)
        return
    end
    j.removeAccountMoney(u, q)
end
function ItemIsVaildAndResult(h, w, k)
    local x, n, o = false, nil, nil
    local y = Config_xZC_Shop.Zones[h] or nil
    if y then
        n = y
        if w and w.count and type(w.count) == "number" and w.count > 0 then
            if w.ItemsInclude then
                local z = Config_xZC_Shop.ItemsInclude[w.ItemsInclude] or nil
                if z then
                    local A = z[w.index] or nil
                    if A and w.name and A.name == w.name then
                        o = xItemFormat(A, k)
                        x = true
                    end
                end
            else
                local B = y.Items[w.index] or nil
                if B and w.name and B.name == w.name then
                    o = xItemFormat(B, k)
                    x = true
                end
            end
        end
    end
    return x, n, o
end
function Zone_ItemsRequireIsVaild(h, j)
    local y = Config_xZC_Shop.Zones[h] or nil
    if y and y.ItemsRequire then
        for C, D in ipairs(y.ItemsRequire) do
            local E = j.getInventoryItem(D)
            if not E or E.count <= 0 then
                return false
            end
        end
    end
    return true
end
function pNotify(F, G, type, H, I)
    type = type and type or "success"
    H = H and H or 1500
    I = I and I or "bottomCenter"
    TriggerClientEvent(
        "pNotify:SendNotification",
        F,
        {text = G, type = type, queue = "xzero_shop", timeout = H, layout = I}
    )
end
function DC_Log(J, K, D, L, l, q, M)
    if Config.DC and Config.DC.Enabled then
        local N = Config.DC
        Citizen.CreateThread(
            function()
                local O = {
                    embeds = {
                        {
                            color = M == "money" and N.Template.color_money or N.Template.color_black_money,
                            title = ("Zone: %s | %s"):format(K.Zone.Name, K.Zone.Label),
                            description = N.Template.description:format(
                                J.getIdentifier(),
                                J.getName(),
                                D,
                                L,
                                l,
                                ESX.Math.GroupDigits(q),
                                M
                            ),
                            footer = {text = ("Giờ: %s"):format(os.date("%d/%m/%Y | %H:%M:%S", os.time()))}
                        }
                    }
                }
                PerformHttpRequest(
                    N.URL_Webhook,
                    function(c, d, e)
                    end,
                    "POST",
                    json.encode(O),
                    {["Content-Type"] = "application/json"}
                )
            end
        )
    end
end