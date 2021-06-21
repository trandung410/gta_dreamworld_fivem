CurrentBans = json.decode(LoadResourceFile(GetCurrentResourceName(),"Bans.json"))
CurrentWhitelists = json.decode(LoadResourceFile(GetCurrentResourceName(),"Whitelists.json"))
local lastdata = nil
ESX = nil
if Config.ESX then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

AddEventHandler('playerConnecting', function(name, kick, deferrals)

    -- mandatory wait!
    -- Wait(0)

    -- Citizen.Wait(100)
    local player = source
    local identifier = nil
    if Config.IdentifierToBan == 'license' then
        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "license:") then
                identifier = string.gsub(iden, "license:", "")
                break
            end
        end

    elseif Config.IdentifierToBan == 'discord' then

        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "discord:") then
                identifier = string.gsub(iden, "discord:", "")
                break
            end
        end

    elseif Config.IdentifierToBan == 'steam' then

        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "steam:") then
                identifier = string.gsub(iden, "steam:", "")
                break
            end
        end

    else

        error(
            'Config File. IdentifierToBan is Invalid input please write rockstar or discord or steam in it')

    end
    if has_value(CurrentBans, identifier) then
        CancelEvent()
        kick(Config.BanString)
    end
    local whitelistid = nil
    if Config.WhitelistIdentifier == 'license' then
        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "license:") then
                whitelistid = string.gsub(iden, "license:", "")
                break
            end
        end

    elseif Config.WhitelistIdentifier == 'discord' then

        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "discord:") then
                whitelistid = string.gsub(iden, "discord:", "")
                break
            end
        end

    elseif Config.WhitelistIdentifier == 'steam' then

        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "steam:") then
                whitelistid = string.gsub(iden, "steam:", "")
                break
            end
        end

    else

        error(
            'Config File. IdentifierToBan is Invalid input please write rockstar or discord or steam in it')

    end
    if Config.EnableWhitelist then
        if not has_value(CurrentWhitelists, whitelistid) then
            CancelEvent()
            kick(Config.WhitelistString)

        end
    end

    if Config.AnnounceJoins then
        local identifiers = 'Identifiers : '
        for _, iden in ipairs(GetPlayerIdentifiers(player)) do
            if string.match(iden, "license:") then
                identifiers = identifiers .. ' | license : ' .. iden
            end
            if string.match(iden, "steam:") then
                identifiers = identifiers .. ' | steam : ' .. iden
            end
            if string.match(iden, "discord:") then
                identifiers = identifiers .. ' | discord : ' .. iden
            end
        end
        sendToDiscord(GetPlayerName(player) .. ' Is Connecting To The Server.',
                      identifiers, 16711680)
    end
end)
AddEventHandler('playerDropped', function(reason)
    if Config.AnnounceLeaves then
        player = source
        local identifiers = 'Identifiers : '
        for _, iden in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(iden, "license:") then
                identifiers = identifiers .. ' | license : ' .. iden
            end
            if string.match(iden, "steam:") then
                identifiers = identifiers .. ' | steam : ' .. iden
            end
            if string.match(iden, "discord:") then
                identifiers = identifiers .. ' | discord : ' .. iden
            end
        end
        sendToDiscord(GetPlayerName(player) .. 'Left, Reason: ' .. reason,
                      identifiers, 16711680)
    end

end)

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/" .. endpoint,
                       function(errorCode, resultData, resultHeaders)
        data = {data = resultData, code = errorCode, headers = resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bot " .. Config.BotToken
    })

    while data == nil do Citizen.Wait(0) end

    return data
end
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function mysplit(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function GetRealPlayerName(playerId)
    if Config.ESX then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        return xPlayer.getName()
    else
        return "ESX NOT ENABLED"
    end
end
RemoveWhitelists = function(identifier)
    if has_value(CurrentWhitelists, identifier) then
        table.removekey(CurrentWhitelists,
                        tablefind(CurrentWhitelists, identifier))
        SaveResourceFile(GetCurrentResourceName(), "Whitelists.json",
                         json.encode(CurrentWhitelists), -1)
    end
end

AddToWhitelists = function(identifier)
    if not has_value(CurrentWhitelists, identifier) then
        table.insert(CurrentWhitelists, identifier)
        SaveResourceFile(GetCurrentResourceName(), "Whitelists.json",
                         json.encode(CurrentWhitelists), -1)
    end

end

BanIdentifier = function(identifier)
    if not has_value(CurrentBans, identifier) then
        table.insert(CurrentBans, identifier)
        SaveResourceFile(GetCurrentResourceName(), "Bans.json",
                         json.encode(CurrentBans), -1)
    end
end
UnbanIdentifier = function(identifier)
    if has_value(CurrentBans, identifier) then
        table.removekey(CurrentBans, tablefind(CurrentBans, identifier))
        SaveResourceFile(GetCurrentResourceName(), "Bans.json",
                         json.encode(CurrentBans), -1)
    end
end
function tablefind(tab, el)
    if tab and el then
        for index, value in pairs(tab) do
            if value == el then return index end
        end
    end
end
function table.removekey(table, key)
    if table and key then
        local element = table[key]
        table[key] = nil
        return element
    end
end
Citizen.CreateThread(function()

    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST',
                       json.encode({
        username = Config.ReplyUserName,
        content = "Discord Bot Is Now Online",
        avatar_url = Config.AvatarURL
    }), {['Content-Type'] = 'application/json'})
    while true do

        local chanel =
            DiscordRequest("GET", "channels/" .. Config.ChannelID, {})

        if chanel.code and chanel.data and tostring(chanel.code) == "200" then
            local data = json.decode(chanel.data)
            local lst = data.last_message_id
            local lastmessage = DiscordRequest("GET", "channels/" ..
                                                   Config.ChannelID ..
                                                   "/messages/" .. lst, {})

            if lastmessage.data then
                local lstdata = json.decode(lastmessage.data)
                if lastdata == nil then lastdata = lstdata.id end
                if not lstdata.author.bot then

                    if lastdata ~= lstdata.id then
                        if Config.EnableRestrictID then
                            if has_value(Config.RestrictIDS, lstdata.author.id) then
                                ExecuteCOMM(lstdata.content, lstdata.author.id)
                                lastdata = lstdata.id
                                --sendToDiscord('New Message Recived',lstdata.content,16711680)
                            else
                                sendToDiscord('Access Denied',
                                              'You Cannot Use Discord Command Bot.',
                                              16711680)
                            end
                        else

                            ExecuteCOMM(lstdata.content, lstdata.author.id)
                            lastdata = lstdata.id
                            --sendToDiscord('New Message Recived',lstdata.content,16711680)
                        end
                    end
                end
            end
        elseif chanel.code and tostring(chanel.code) == "429" then
            sendToDiscord("Discord Command",
                          "Discord Command Bot Is Getting Rate Limited, Please Increase the Wait time Between Each Ticks in Config File.",
                          16711680)
            Citizen.Wait(Config.WaitInRateLimit * 1000)
        elseif chanel.code and tostring(chanel.code) ~= '0' then
            sendToDiscord("Discord Command",
                          "Something Went Wrong. Code : " .. chanel.code,
                          16711680)
        end
        Citizen.Wait(Config.WaitEveryTick)
    end
end)
function has_value(tab, val)
    for index, value in ipairs(tab) do if value == val then return true end end

    return false
end
function sendToDiscord(name, message, color)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {["text"] = Config.ServerName}
        }
    }
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST',
                       json.encode({
        username = Config.ReplyUserName,
        embeds = connect,
        avatar_url = Config.AvatarURL
    }), {['Content-Type'] = 'application/json'})
end
