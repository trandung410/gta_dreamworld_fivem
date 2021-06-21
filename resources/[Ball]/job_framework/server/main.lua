ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Jobs = {}
Job = {}
Job.__index = Job

function Job:Init(jobName)
    local o = Config.Jobs[jobName]
    setmetatable(o, Job)
    o.worker = {}
    o.name = jobName
    return o
end

function Job:CalculateLevel(playerId)
    local exp = self['worker'][playerId]
    local curLvl = 0
    for i =1 ,#self['level'], 1 do 
        if self['level'][i+1] ~= nil then
            if curLvl >= self['level'][i] and curLvl < self['level'][i+1] then 
                curLvl = i
                return curLvl
            end
        else
            curLvl = i
            return curLvl
        end
    end
end

function Job:EventHandler()
    RegisterNetEvent("job_framework:server:join:"..self.name)
    AddEventHandler("job_framework:server:join:"..self.name, function()
        local xPlayer = ESX.GetPlayerFromId(source)
        self.worker[source] = 0
    end)
    RegisterNetEvent("job_framework:server:quit:"..self.name)
    AddEventHandler("job_framework:server:quit:"..self.name, function()
        if self.worker[source] then 
            self.worker[source] = nil
        end
    end)
    RegisterNetEvent("job_framework:server:gather:"..self.name)
    AddEventHandler("job_framework:server:gather:"..self.name, function(step)
        if self.worker[source] then 
            local xPlayer = ESX.GetPlayerFromId(source)
            for k, v in pairs(self['step'][step].work.reward) do
                local xItem = xPlayer.getInventoryItem(v.name)
                if self:GetRandom() <= v.probability then 
                    -- if xPlayer.canCarryItem(v.name, v.count) then 
                    if xItem.limit == -1 then 
                        xPlayer.addInventoryItem(v.name, v.count)
                    elseif xItem.limit ~= -1 and xItem.count < xItem.count + v.count then
                        xPlayer.addInventoryItem(v.name, v.count)
                    else
                        xPlayer.showNotification("Kho đồ đã đầy")
                    end
                end
            end
        end
    end)
    RegisterNetEvent("job_framework:server:reward:"..self.name)
    AddEventHandler("job_framework:server:reward:"..self.name, function(step)
        if self.worker[source] then 
            local xPlayer = ESX.GetPlayerFromId(source)
            local require = self['step'][step].work.require
            local reward = self['step'][step].work.reward
            local workerLevel = self:CalculateLevel(source)
            -- print(workerLevel)
            local lvlBonus
            if self['step'][step].work.levelBonus ~= nil then 
                lvlBonus = self['step'][step].work.levelBonus[workerLevel]
            end
            local hasEnough = true
            if require ~= nil then
                for k, v in pairs(require) do 
                    local rItem = xPlayer.getInventoryItem(v.name)
                    if rItem.count < v.count or v.count == 0 then 
                        hasEnough = false
                        break
                    end
                end
            end
            if hasEnough then 
                if require ~= nil then
                    for k, v in pairs(require) do 
                        xPlayer.removeInventoryItem(v.name, v.count)
                    end
                end
                for k,v in pairs(reward) do 
                    if self:GetRandom() <= v.probability then 
                        if xItem.limit == -1 then 
                            xPlayer.addInventoryItem(v.name, v.count)
                        elseif xItem.limit ~= -1 and xItem.count < xItem.count + v.count then
                            xPlayer.addInventoryItem(v.name, v.count)
                        else
                            xPlayer.showNotification("Kho đồ đã đầy")
                        end
                    end
                end
                if lvlBonus ~= nil then 
                    for k,v in pairs(lvlBonus) do 
                        if self:GetRandom() <= v.probability then 
                            if xItem.limit == -1 then 
                                xPlayer.addInventoryItem(v.name, v.count)
                            elseif xItem.limit ~= -1 and xItem.count < xItem.count + v.count then
                                xPlayer.addInventoryItem(v.name, v.count)
                            else
                                xPlayer.showNotification("Kho đồ đã đầy")
                            end
                        end
                    end
                end
                if step == 1 then 
                    -- xPlayer.addJobExp(self.name, 1)
                    self.worker[source] = self.worker[source] + 1
                end
            else
                TriggerClientEvent("esx:showNotification", source, "Bạn không có đủ vật phẩm để tiếp tục")
            end
        end
    end)
    RegisterNetEvent("job_framework:server:sell:"..self.name)
    AddEventHandler("job_framework:server:sell:"..self.name, function(itemName, value)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getInventoryItem(itemName).count >= value then 
            xPlayer.removeInventoryItem(itemName, value)
            xPlayer.addMoney(self['items'][itemName]*value)
        end
    end)
end

function Job:GetRandom()
    math.randomseed(os.time())
    local rd = math.random(1, 100)
    return rd
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Jobs) do 
        Jobs[k] = Job:Init(k)
        Jobs[k]:EventHandler()
    end
end)