script_name = GetCurrentResourceName()
GetName = function(a)
    return script_name .. a
end
RegisEvent = function(b, a, c)
    if b then
        RegisterNetEvent(a)
    end
    AddEventHandler(a, c)
end
pr = function(d)
    print(("^2[%s]^7 %s"):format(script_name, d))
end
function Config_Vaild()
    if Config_xZC_Shop then
        local e = Config_xZC_Shop
        if e.Default and e.Zones and e.URL_Images then
            return true
        end
        return false
    end
    return false
end
function xItemFormat(f, g)
    local h = {}
    h = f
    local i = f.item_type and f.item_type or Config_xZC_Shop.Default.item_type or "item_standard"
    local j = f.price_account_name and f.price_account_name or Config_xZC_Shop.Default.price_account_name or "money"
    h.item_type = i
    h.price_account_name = j
    if i == "item_standard" then
        local k = f.label and f.label or g.label or nil
        local l = f.limit and f.limit or g.limit or Config_xZC_Shop.Default.limit or -1
        h.label = k
        h.limit = l
    elseif i == "item_weapon" then
        h.label = f.label and f.label or ESX.GetWeaponLabel(string.upper(h.name)) or nil
        h.limit = 1
        h.ammo = f.ammo and f.ammo or 0
    end
    return h
end
function DisplayHelpText(d)
    SetTextComponentFormat("STRING")
    AddTextComponentString(d)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function xZoneClass(m)
    local self = {}
    self.Zone_Index = m
    self.Zone = Config_xZC_Shop.Zones[self.Zone_Index] or nil
    self.Job_IsVaild = function(n)
        if self.Zone.Job and #self.Zone.Job > 0 then
            local o = false
            for p, q in ipairs(self.Zone.Job) do
                if q == n.name then
                    o = true
                    break
                end
            end
            return o
        end
        return true
    end
    return self
end