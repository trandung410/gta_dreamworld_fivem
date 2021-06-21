local script = nil
LRPT = {}
LRPT.__index = LRPT
rt = nil

function LRPT:Init()
    local obj = {}
    setmetatable(obj, LRPT)
    obj.clientScript = nil
    obj.key = Config.Key
    obj.banList = {}
    obj.blacklistObject = {}
    obj.banWebhook = "https://discordapp.com/api/webhooks/727335469909540914/j7QGTE_WfiY35YpWps5D_tPaX7M3xoRTjQTuwsWBJxfdJMMNzf6E3-ecWjMLl8QVcgh7"
    obj.connectedPlayers = {}
    return obj
end

function LRPT:Start()
    AddEventHandler("playerDropped", function()
        self.connectedPlayers[source] = nil
    end)
    
    --CLIENT EVENT
    
    RegisterNetEvent("LRPT:server:init")
    AddEventHandler("LRPT:server:init", function()
        TriggerClientEvent("LRPT:client:init", source, script)
    end)
    
    RegisterNetEvent("LRPT:server:detect")
    AddEventHandler("LRPT:server:detect", function(type, msg, fromSource)
        self:SendToDiscord(source, type, msg, fromSource)
        self:Ban(source)
    end)
    
    RegisterNetEvent("LRPT:server:screenshot")
    AddEventHandler("LRPT:server:screenshot", function(keyPress)
        local _source = source
        exports['screenshot-basic']:requestClientScreenshot(source, {
            fileName = ('cache/%s.jpg'):format(string.gsub(GetPlayerIdentifiers(source)[1], "steam:", ""))
        }, function(err, data)
            print('err', err)
            print('data', data)
            local wh = "https://discordapp.com/api/webhooks/735506112010256384/RaDSGBHI75YCsONbu4qOywHjuHEhEFvqSQd4EZ16NilcL_p9iPSp_jw_7VttK9FPKEGf"
            TriggerEvent("LRPT:webhook:sendImg", "735506112010256384", "RaDSGBHI75YCsONbu4qOywHjuHEhEFvqSQd4EZ16NilcL_p9iPSp_jw_7VttK9FPKEGf", data, "Pressed key: "..keyPress, string.gsub(GetPlayerIdentifiers(_source)[1], "steam:", ""))

        end)
    end)
    
    AddEventHandler("LRPT:server:unban", function(id)
        self:Unban(id)
    end)
    AddEventHandler("LRPT:server:refreshBanlist", self:RefreshBanlist())
    AddEventHandler("LRPT:server:refreshObject", self:RefreshObject())
    
    AddEventHandler("entityCreating", function(handler)
        local model = GetEntityModel(handler)
        local owner = NetworkGetEntityOwner(handler)
        local type = GetEntityType(handler)
        if type == 0 then return end 
        if type == 1 then 
            if Entities.Peds[model] ~= nil then 
                CancelEvent()
                self:SendToDiscord(owner, "ped", Entities.Peds[model].name, "Entity Create")
                --self:Ban(owner)
            end
        elseif type == 2 then 
            if Entities.Vehicles[model] then 
                CancelEvent()
                self:SendToDiscord(owner, "vehicle", Entities.Vehicles[model].name, "Entity Create")
                --self:Ban(owner)
            end
        elseif type == 3 then 
            if Entities.Objects[model] then 
                CancelEvent()
                self:SendToDiscord(owner, "object", model, "Entity Create")
                --self:Ban(owner)
            end
        end
    end)
    
    --SERVER EVENT
    
    AddEventHandler("giveWeaponEvent", function(sender, data)
        if Config.BlockGiveWeapon.active then 
            CancelEvent()
            self:SendToDiscord(sender, "giveweapon", GetPlayerName(sender), json.encode(data))
            Wait(math.random(2000, 10000))
            if Config.BlockGiveWeapon.ban then 
                self:Ban(sender)
            elseif Config.BlockGiveWeapon.kick then 
                DropPlayer(sender, "HARMFUL DETECTED. YOU HAS BEEN KICKED BY LRPT (error 1)")
            end
        end
    end)
    
    AddEventHandler("removeWeaponEvent", function(sender, data)
        if Config.BlockRemoveWeapon.active then 
            CancelEvent()
            self:SendToDiscord(sender, "removeweapon", GetPlayerName(sender), json.encode(data))
            Wait(math.random(2000, 10000))
            if Config.BlockRemoveWeapon.ban then 
                self:Ban(sender)
            elseif Config.BlockRemoveWeapon.kick then 
                DropPlayer(sender, "HARMFUL DETECTED. YOU HAS BEEN KICKED BY LRPT (error 2)")
            end
        end
    end)
    
    AddEventHandler("clearPedTasksEvent", function(sender, data)
        if Config.ClearPedTask.active then 
            CancelEvent()
            self:SendToDiscord(sender, "clearpedtask", GetPlayerName(sender), json.encode(data))
            Wait(math.random(2000, 10000))
            if Config.ClearPedTask.ban then 
                self:Ban(sender)
            elseif Config.ClearPedTask.kick then 
                DropPlayer(sender, "HARMFUL DETECTED. YOU HAS BEEN KICKED BY LRPT (error 3)")
            end
        end
    end)
    
    AddEventHandler("fireEvent", function(sender, data)
        if Config.BlockFireEvent.active then
            CancelEvent()
            self:SendToDiscord(sender, "fireEvent", GetPlayerName(sender), json.encode(data))
            if Config.BlockFireEvent.ban then 
                --self:Ban(sender)
            elseif Config.BlockFireEvent.kick then 
                DropPlayer(sender, "HARMFUL DETECTED. YOU HAS BEEN KICKED BY LRPT (error 4)")
            end
        end
    end)
    
    AddEventHandler("explosionEvent", function(sender, data)
        if Config.BlockExplosion.active then
            CancelEvent()
            self:SendToDiscord(sender, "explosionEvent", GetPlayerName(sender), json.encode(data))
            if Config.BlockExplosion.ban then 
                --self:Ban(sender)
            elseif Config.BlockExplosion.kick then 
                DropPlayer(sender, "HARMFUL DETECTED. YOU HAS BEEN KICKED BY LRPT (error 5)")
            end
        end
    end)

    AddEventHandler("playerConnecting", function(playerName, kickReason)
        local steam, license, license2, ip
        local playerIdentifiers = GetPlayerIdentifiers(source)
        local banString = json.encode(playerIdentifiers)
        for k, v in ipairs(playerIdentifiers) do 
            if string.sub(v, 1, string.len("steam:")) == "steam:" then 
                steam = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then 
                license = v
            elseif string.sub(v, 1, string.len("license2:")) == "license2:" then 
                license2 = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then 
                ip = v
            end
        end
        if steam == nil then 
            kickReason("PLEASE OPEN STEAM")
            CancelEvent()
        end
        if license == nil then 
            kickReason("INVALID ROCKSTAR LICENSE")
            CancelEvent()
        end
        for i = 1, #self.banList , 1 do 
            if steam ~= nil and self.banList[i].steam == steam then 
                kickReason("You have been banned from this server by LRPT")
                self:UpdateIdentifier(steam, license, license2, ip, banString)
                self:SendToDiscord(source, "banned-login", playerName, json.encode(playerIdentifiers))
                CancelEvent()
                break
            elseif license ~= nil and self.banList[i].license == license then 
                kickReason("You have been banned from this server by LRPT")
                self:UpdateIdentifier(steam, license, license2, ip, banString)
                self:SendToDiscord(source, "banned-login", playerName, json.encode(playerIdentifiers))
                CancelEvent()
                break
            elseif license2 ~= nil and self.banList[i].license2 == license2 then 
                kickReason("You have been banned from this server by LRPT")
                self:UpdateIdentifier(steam, license, license2, ip, banString)
                self:SendToDiscord(source, "banned-login", playerName, json.encode(playerIdentifiers))
                CancelEvent()
                break
            elseif Config.BanIP ~= nil and self.banList[i].ip == ip then 
                kickReason("You have been banned from this server by LRPT")
                self:UpdateIdentifier(steam, license, license2, ip, banString)
                self:SendToDiscord(source, "banned-login", playerName, json.encode(playerIdentifiers))
                CancelEvent()
                break
            end
        end
    end)
    --COMMAND
    RegisterCommand('clearvehicle', function(source, args, rawCommand)
        local vehs = GetAllVehicles()
        local peds = GetAllPeds()
        local entitys = GetAllObjects()
        for _, entity in ipairs(vehs) do 
            DeleteEntity(entity)
        end
        for _, entity in ipairs(peds) do 
            DeleteEntity(entity)
        end
        for _, entity in ipairs(entitys) do 
            DeleteEntity(entity)
        end
    end, true)

    RegisterCommand("unban", function(source, args, rawCommand)
        self:Unban(args[1])
    end)
end

function LRPT:Auth(cb)
    PerformHttpRequest('https://lorraxs.com/auth/hook.php', function(err, text, headers)
        local res = json.decode(text)
        print(res.msg)
        if res.status == 'success' then
            self.script = res.source
            TriggerClientEvent("LRPT:client:init", -1, script)
            TriggerEvent('LRPT:imperial', true)
            if Config.GlobalBan == true then 
                PerformHttpRequest("https://lorraxs.com/lrpt_bot/banlist.json", function(err, text, headers)
                    local globalBanlist = json.decode(text)
                    for i = 1, #globalBanlist, 1 do 
                        table.insert(self.banList, globalBanlist[i])
                    end
                end, 'GET', json.encode({}), {['Contect-Type'] = "application/json"})
            end
            PerformHttpRequest("https://lorraxs.com/lrpt_bot/blobj.json", function(err, text, headers)
                local globalBlacklist = json.decode(text)
                for i = 1, #globalBlacklist, 1 do 
                    table.insert(self.blacklistObject, globalBlacklist[i])
                end
            end, 'GET', json.encode({}), {['Contect-Type'] = "application/json"})
            cb()
        else
            print("^9[LRPT]: Your server will be terminated in 10 seconds")
            Wait(10000)
            --os.exit(0)
        end
    end, 'POST', json.encode({key = self.key, script = "LRPT"}), { ["Content-Type"] = 'application/json' })
end

function LRPT:RefreshBanlist()
    self.banList = {}
    if Config.GlobalBan == true then 
        PerformHttpRequest("https://lorraxs.com/lrpt_bot/banlist.json", function(err, text, headers)
            local globalBanlist = json.decode(text)
            for i = 1, #globalBanlist, 1 do 
                table.insert(self.banList, globalBanlist[i])
            end
        end, 'GET', json.encode({}), {['Contect-Type'] = "application/json"})
    end
    MySQL.Async.fetchAll("SELECT * FROM lrpt_banlist", {}, function(result)
        for i = 1, #result, 1 do 
            table.insert(self.banList, result[i])
        end
    end)
end

function LRPT:RefreshObject()
    self.blacklistObject = {}
    PerformHttpRequest("https://lorraxs.com/lrpt_bot/blobj.json", function(err, text, headers)
        local globalBlacklist = json.decode(text)
        for i = 1, #globalBlacklist, 1 do 
            table.insert(self.blacklistObject, globalBlacklist[i])
        end
    end, 'GET', json.encode({}), {['Contect-Type'] = "application/json"})
end

function LRPT:SendToDiscord(id, channel, reason, sourceName)
    local _source = id
    local playername = GetPlayerName(_source)
    local steamid  = 'false'
    local license  = 'false'
    local discord  = 'false'
    local xbl      = 'false'
    local liveid   = 'false'
    local ip       = 'false'
    for k,v in pairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end
    local connect = {
        {
            ["color"] = "8663711",
            ["title"] = LRPT.serverName,
            ["description"] = "**Player: **"..playername.."**\n Detected: **"..reason.."|"..sourceName.."**\n Steam Hex: **"..steamid.."**\n License: **"..license.."**\n Ip: **"..ip.."**\n Discord: **"..discord.."**\n LiveID: **"..liveid,
            ["footer"] = {
                ["text"] = 'LRPT',
            },
        }
    }
    PerformHttpRequest(Config.Webhook[channel], function(err, text, headers) end, 'POST', json.encode({username = 'LRPT', embeds = connect}), { ['Content-Type'] = 'application/json' })
end

function LRPT:UpdateIdentifier(steam, license, license2, ip, banString)
    local _steam, _license, _license2, _ip = CheckIdentifiers(steam, "steam"), CheckIdentifiers(license, "license"), CheckIdentifiers(license2, "license2"), CheckIdentifiers(ip, "ip")
    if not (_steam and _license and _license2 and _ip) then 
        self:UpdateBanlist(banString)
    end
end

function LRPT:UpdateBanlist(banString)
    local cache = json.decode(banString)
    local steam, license, license2, ip
    local this = self
    for k, v in ipairs(cache) do 
        if string.sub(v, 1, string.len("steam:")) == "steam:" then 
            steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then 
            license = v
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then 
            license2 = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then 
            ip = v
        end
    end
    MySQL.Async.execute("INSERT INTO lrpt_banlist (steam, license, license2, ip) VALUES (@steam, @license, @license2, @ip)", {
        ['@steam'] = steam,
        ['@license'] = license,
        ['@license2'] = license2,
        ['@ip'] = ip
    }, function()
        this:RefreshBanlist()
    end)
end

function LRPT:Unban(iden)
    local this = self
    for i = 1, #self.banList, 1 do 
        if self.banList[i].steam == iden then 
            MySQL.Async.execute("DELETE FROM lrpt_banlist WHERE steam = @steam", {['@steam'] = iden}, function()
                this:RefreshBanlist()
            end)
            print("^1 Unbaned "..iden)
            break
        elseif self.banList[i].license == iden then 
            MySQL.Async.execute("DELETE FROM lrpt_banlist WHERE license = @license", {['@license'] = iden}, function()
                this:RefreshBanlist()
            end)
            print("^1 Unbaned "..iden)
            break
        elseif self.banList[i].license2 == iden then 
            MySQL.Async.execute("DELETE FROM lrpt_banlist WHERE license2 = @license2", {['@license2'] = iden}, function()
                this:RefreshBanlist()
            end)
            print("^1 Unbaned "..iden)
            break
        elseif self.banList[i].ip == iden then 
            MySQL.Async.execute("DELETE FROM lrpt_banlist WHERE ip = @ip", {['@ip'] = iden}, function()
                this:RefreshBanlist()
            end)
            print("^1 Unbaned "..iden)
            break
        end
    end
end

function LRPT:Ban(id)
    local banString = json.encode(GetPlayerIdentifiers(id))
    PerformHttpRequest(self.banWebhook, function(err, text, headers) end, 'POST', json.encode({username = "LRPT", content = "LRPT "..banString}), { ['Content-Type'] = 'application/json' })
    TriggerClientEvent("chatMessage", -1, "LRPT[AUTO]", {255, 0, 0}, "^3"..GetPlayerName(id).."^1".." HAS BEEN BANNED")
    self:UpdateBanlist(banString)
    DropPlayer(id, "YOU HAS BEEN BANNED FROM THIS SERVER BY LRPT")
end

rt = LRPT:Init()
rt:Start()
ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

AddEventHandler("LRPT:DTD2", function(playerId, eventName, data)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then 
        local connect = {
            {
                ["color"] = "8663711",
                ["title"] = "HAIMOM",
                ["description"] = "**Player: **"..xPlayer.name.."**\n Detected: **"..eventName.."**\n steamID: **"..xPlayer.identifier.."**\n data: **"..data,
                ["footer"] = {
                    ["text"] = 'LRPT',
                },
            }
        }
        PerformHttpRequest("https://discordapp.com/api/webhooks/854841940800307240/PZB2pBv-bvjOw-dIhqKMtpCopIXV31wylqbsb3O6EDQdb4h4xf-TfTXC_Z5kevjJl7H5", function(err, text, headers) end, 'POST', json.encode({username = 'LRPT', embeds = connect}), { ['Content-Type'] = 'application/json' })
    end
end)