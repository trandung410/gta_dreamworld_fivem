Society = {}
Society.__index = Society

function Society:Init(data, name)
    --print(json.encode(data.items))
    local o = {}
    o.name = name
    if data then 
        o.items = data.items
        o.weapons = data.weapons
        o.ammos = data.ammos
        o.accounts = data.accounts
    else
        o.items = {}
        o.weapons = {}
        o.ammos = {}
        o.accounts = {
            ['money'] = 0,
            ['black_money'] = 0,
        }
    end
    setmetatable(o, Society)
    o.props = {
        GetWeapons = function() return self:GetWeapons() end,
        AddWeapon = function(weaponData) self:AddWeapon(weaponData) end,
        RemoveWeapon = function(weaponId) self:RemoveWeapon(weaponId) end,
        AddItem = function(itemName, count) self:AddItem(itemName, count) end,
        GetItem = function(name) return self:GetItem(name) end,
        RemoveItem = function(itemName, count) self:RemoveItem(itemName, count) end,
        AddAmmo = function(...) self:AddAmmo(...) end,
        RemoveAmmo = function(...) self:RemoveAmmo(...) end,
        AddAccountMoney = function(...) self:AddAccountMoney(...) end,
        RemoveAccountMoney = function(...) self:RemoveAccountMoney(...) end,
        GetAccount = function(...) self:GetAccount(...) end,
    }
    return o
end

function Society:GetWeapons()
    return self.weapons
end

function Society:AddWeapon(weaponData, ammo)
    --[[ table.insert(self.weapons, {
        name = weaponData.name,
        label = weaponData.label,
        id = weaponData.weaponId,
        reliability = weaponData.reliability * weaponData.maxReliability / 100
    }) ]]
    table.insert(self.weapons, {
        name = weaponData.name,
        count = ammo
    })
    self:Save()
end

function Society:HasWeapon(weaponName)
    for k, v in pairs(self.weapons) do 
        if v.name == weaponName then 
            return true
        end
    end
    return false
end

function Society:RemoveWeapon(weaponName)
    for k, v in pairs(self.weapons) do 
        if v.name == weaponName then 
            table.remove(self.weapons, k)
        end
    end
    self:Save()
end

function Society:AddItem(itemName, count)
    local found = false
    for k, v in pairs(self.items) do 
        if v.name == itemName then 
            found = true
            v.count = v.count + count
        end
    end
    if not found then 
        table.insert(self.items, {
            name = itemName,
            count = count
        })
    end
    self:Save()
end

function Society:GetItem(name)
    for k, v in pairs(self.items) do
        if v.name == name then 
            return v
        end
    end
    self:Save()
    return {
        name = name,
        count = 0
    }
end

function Society:RemoveItem(itemName, count)
    for k, v in pairs(self.items) do 
        if v.name == itemName then 
            v.count = v.count - count
            if v.count <= 0 then 
                table.remove(self.items, k)
            end
        end
    end
    self:Save()
end

function Society:GetAmmo(ammoName)
    for k, v in pairs(self.ammos) do 
        if v.name == ammoName then 
            return v.count
        end
    end
    return 0
end

function Society:AddAmmo(ammoName, count)
    local found = false
    for k, v in pairs(self.ammos) do 
        if v.name == ammoName then 
            v.count = v.count + count
            found = true
        end
    end
    if not found then 
        table.insert(self.ammos, {
            name = ammoName, 
            count = count
        })
    end
    self:Save()
end

function Society:RemoveAmmo(ammoName, count)
    for k, v in pairs(self.ammos) do 
        if v.name == ammoName then 
            v.count = v.count - count
            if v.count < 0 then v.count = 0 end
        end
    end
    self:Save()
end

function Society:AddAccountMoney(account, money)
    print(account)
    self.accounts[account] = self.accounts[account] + math.floor(money)
    self:Save()
end

function Society:RemoveAccountMoney(account, money)
    self.accounts[account] = self.accounts[account] - math.floor(money)
    self:Save()
end

function Society:GetAccount(accName)
    return self.accounts[accName]
end 

function Society:Save()
    print(self.name)
    print(json.encode({items = self.items, weapons = self.weapons, accounts = self.accounts, ammos = self.ammos}))
    MySQL.Async.execute("UPDATE jobs SET society_data = @data WHERE name = @name", {
        ['@data'] = json.encode({items = self.items, weapons = self.weapons, accounts = self.accounts, ammos = self.ammos}),
        ['@name'] = self.name
    })
end