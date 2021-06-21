function ExecuteCOMM(command, discordid)
    if string.starts(command, Config.Prefix) then

        -- Get Player Count
        if string.starts(command, Config.Prefix .. "playercount") then

            sendToDiscord("Player Counts", "Số người chơi hiện tại : " ..
                              GetNumPlayerIndices(), 16711680)

            -- Kick Someone

        elseif string.starts(command, Config.Prefix .. "kick") then

            local t = mysplit(command, " ")

            if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                sendToDiscord("Kick thành công",
                              "Đã kick người chơi " .. GetPlayerName(t[2]),
                              16711680)
                DropPlayer(t[2], "Bạn đã bị kick khỏi server.Liên hệ Admin để được giải đáp")

            else

                sendToDiscord("Could Not Find",
                              "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                              16711680)

            end

            -- Slay Someone

        elseif string.starts(command, Config.Prefix .. "slay") then

            local t = mysplit(command, " ")

            if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then

                TriggerClientEvent("discordc:kill", t[2])
                TriggerEvent('chat:addMessage', t[2], {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {
                        "System",
                        "^1 Bạn đã chết"
                    }
                })
                sendToDiscord("Slay thành công",
                              "Đã slay người chơi " .. GetPlayerName(t[2]),
                              16711680)

            else

                sendToDiscord("Could Not Find",
                              "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                              16711680)

            end

            -- Return Player List
        elseif string.starts(command, Config.Prefix .. "playerlist") then

            if Config.ESX then
                local count = 0
                local xPlayers = ESX.GetPlayers()
                local players = "Players: "
                for i = 1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    local job = xPlayer.getJob()
                    discord = "Not Found"
                    for _, id in ipairs(GetPlayerIdentifiers(xPlayers[i])) do
                        if string.match(id, "discord:") then
                            discord = string.gsub(id, "discord:", "")
                            break
                        end
                    end

                    count = count + 1
                    local players = players .. GetPlayerName(xPlayers[i]) ..
                                        " | " .. GetRealPlayerName(xPlayers[i]) ..
                                        "|ID " .. xPlayers[i] .. "His Job: " ..
                                        job.name .. " |"

                end
                if count == 0 then
                    sendToDiscord("PLAYER LIST", "There is 0 Player In Server",
                                  16711680)
                else
                    PerformHttpRequest(Config.WebHook,
                                       function(err, text, headers) end, 'POST',
                                       json.encode(
                                           {
                            username = 'Current Player Counts : ' .. count,
                            content = players,
                            avatar_url = Config.AvatarURL
                        }), {['Content-Type'] = 'application/json'})
                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- revive
        elseif string.starts(command, Config.Prefix .. "revive") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    TriggerClientEvent("58723448-c130-4256-9183-b146ffe912d2", t[2])
                    sendToDiscord("Hồi sinh thành công",
                                  "Đã hồi sinh người chơi " .. GetPlayerName(t[2]),
                                  16711680)

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end
            -- setjob
        elseif string.starts(command, Config.Prefix .. "setjob") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        if t[3] and t[4] then
                            xPlayer.setJob(tostring(t[3]), t[4])
                            sendToDiscord("Dream World",
                                          "SetJob cho " ..
                                              xPlayer.getName() .. ' thành công',
                                          16711680)
                        else
                            sendToDiscord("Dream World",
                                          "Tên JOB HOẶC JOB GRADE không hợp lệ. Hãy chắc chắn rằng bạn đang gõ như thế này: \n prefix + setjob + id + job_name + grade_number",
                                          16711680)
                        end

                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- getjob

        elseif string.starts(command, Config.Prefix .. "getjob") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        job = xPlayer.getJob()
                        if job then
                            sendToDiscord("Dream World",
                                          "Tên công việc : " .. job.name ..
                                              " \n Chức vụ : " .. job.grade ..
                                              " " .. job.grade_label, 16711680)

                        end
                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- getmoney

        elseif string.starts(command, Config.Prefix .. "getmoney") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        money = xPlayer.getMoney()
                        if money then
                            sendToDiscord("Dream World",
                                          "Người chơi : "..xPlayer.getName().." hiện có " .. money ..
                                              "$ trên người", 16711680)

                        end
                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- getbank
        elseif string.starts(command, Config.Prefix .. "getbank") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        money = xPlayer.getAccount('bank')
                        if money then
                            sendToDiscord("Dream World",
                                          "Người chơi : "..xPlayer.getName().." hiện có" ..
                                              money.money ..
                                              "$ trong ngân hàng",
                                          16711680)

                        end
                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- removeMoney 

        elseif string.starts(command, Config.Prefix .. "removemoney") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        if t[3] then
                            xPlayer.removeMoney(tonumber(t[3]))
                            sendToDiscord("Dream World",
                                          "Bạn đã xoá " ..tonumber(t[3]).." $ tư người chơi" ..
                                              xPlayer.getName(),
                                          16711680)
                        else
                            sendToDiscord("Dream World",
                                          "ID HOẶC SỐ TIỀN không hợp lệ, hãy chắc chắn rằng bạn đang viết như thế này: \n prefix + removemoney + id + money",
                                          16711680)
                        end

                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- addMoney

        elseif string.starts(command, Config.Prefix .. "addmoney") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        if t[3] then
                            xPlayer.addMoney(tonumber(t[3]))
                            sendToDiscord("Dream World",
                                          "Đã add cho người chơi " ..
                                              xPlayer.getName() .." "..tonumber(t[3]).. ' $',
                                          16711680)
                        else
                            sendToDiscord("Dream World",
                                          "ID HOẶC SỐ TIỀN không hợp lệ, hãy chắc chắn rằng bạn đang viết như thế này: \n prefix + addmoney + id + money",
                                          16711680)
                        end

                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- add to bank account

        elseif string.starts(command, Config.Prefix .. "addbank") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        if t[3] then
                            xPlayer.addAccountMoney('bank', tonumber(t[3]))
                            sendToDiscord("Dream World",
                                          "Đã add cho người chơi " ..
                                              xPlayer.getName() .." "..tonumber(t[3]).. ' $ tiền bank',
                                          16711680)
                        else
                            sendToDiscord("Dream World",
                                          "ID HOẶC SỐ TIỀN không hợp lệ, hãy chắc chắn rằng bạn đang viết như thế này: \n prefix + addbank + id + money",
                                          16711680)
                        end

                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- remove bank money

        elseif string.starts(command, Config.Prefix .. "removebank") then

            if Config.ESX then

                local t = mysplit(command, " ")
                if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                    local xPlayer = ESX.GetPlayerFromId(t[2])
                    if xPlayer then

                        if t[3] then
                            xPlayer.removeAccountMoney('bank', tonumber(t[3]))
                            sendToDiscord("Dream World",
                                          "Bạn đã xoá " ..tonumber(t[3]).." $ bank từ người chơi" ..
                                              xPlayer.getName(),
                                          16711680)
                        else
                            sendToDiscord("Dream World",
                                          "ID HOẶC SỐ TIỀN không hợp lệ, hãy chắc chắn rằng bạn đang viết như thế này: \n prefix + removebank + id + money",
                                          16711680)
                        end

                    end

                else

                    sendToDiscord("Could Not Find",
                                  "Không thể tìm thấy ID này.Hãy nhập đúng ID",
                                  16711680)

                end

            else

                sendToDiscord("Dream World", "ESX Is not enable", 16711680)

            end

            -- notific

        elseif string.starts(command, Config.Prefix .. "notific") then

            local safecom = command
            local t = mysplit(command, " ")
            if t[2] ~= nil and GetPlayerName(t[2]) ~= nil and t[3] ~= nil then

                TriggerClientEvent('chat:addMessage', t[2], {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {
                        "Discord Console",
                        "^1 " ..
                            string.gsub(safecom, "!notific " .. t[2] .. " ", "")
                    }
                })

                sendToDiscord("Gửi thành công",
                              "Đã gửi thông báo " ..
                                  string.gsub(safecom,
                                              "!notific " .. t[2] .. " ", "") ..
                                  " To " .. GetPlayerName(t[2]), 16711680)

            else

                sendToDiscord("Could Not Find", "Invalid InPut", 16711680)
            end

            -- announce

        elseif string.starts(command, Config.Prefix .. "announce") then

            local safecom = command
            local t = mysplit(command, " ")
            if t[2] ~= nil then

                TriggerClientEvent('chat:addMessage', -1, {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {
                        "Discord Console",
                        "^1 " ..
                            string.gsub(safecom, Config.Prefix .. "announce", "")
                    }
                })
                sendToDiscord("Gửi thành công",
                              "Đã gửi thành công : " ..
                                  string.gsub(safecom,
                                              Config.Prefix .. "announce", "") ..
                                  " | To " .. GetNumPlayerIndices() ..
                                  " Player in The Server", 16711680)

            else

                sendToDiscord("Could Not Find", "Invalid InPut", 16711680)
            end
            -- BAN a Player that is inside the server  -- prefix + banid + id
        elseif string.starts(command, Config.Prefix .. "banid") then

            if Config.RestrictBanToID then
                if has_value(Config.AllowedDiscordIdsToBan, discordid) then
                    local safecom = command
                    local t = mysplit(command, " ")
                    if t[2] and GetPlayerName(tonumber(t[2])) then
                        local identifier = nil
                        if Config.IdentifierToBan == 'license' then
                            for _, iden in ipairs(GetPlayerIdentifiers(t[2])) do
                                if string.match(iden, "license:") then
                                    identifier =
                                        string.gsub(iden, "license:", "")
                                    break
                                end
                            end

                        elseif Config.IdentifierToBan == 'discord' then

                            for _, iden in ipairs(GetPlayerIdentifiers(t[2])) do
                                if string.match(iden, "discord:") then
                                    identifier =
                                        string.gsub(iden, "discord:", "")
                                    break
                                end
                            end

                        elseif Config.IdentifierToBan == 'steam' then

                            for _, iden in ipairs(GetPlayerIdentifiers(t[2])) do
                                if string.match(iden, "steam:") then
                                    identifier = string.gsub(iden, "steam:", "")
                                    break
                                end
                            end

                        else

                            error(
                                'Config File. IdentifierToBan is Invalid input please write rockstar or discord or steam in it')

                        end

                        print(identifier)
                        DropPlayer(tonumber(t[2]), Config.BanString)
                        if identifier then
                            sendToDiscord("Discord Command",
                                          GetPlayerName(t[2]) ..
                                              ' đã bị ban. Identifier : ' ..
                                              identifier, 16711680)
                            BanIdentifier(identifier)
                        else
                            sendToDiscord("Discord Command",
                                          "Không thể tìm thấy Identifie, hệ thống sẽ tạm thời kick người chơi này.",
                                          16711680)
                        end
                    else
                        sendToDiscord("Discord Command", "ID không hợp lệ",
                                      16711680)
                    end

                else

                    sendToDiscord("Discord Command",
                                  "You Do Not Have Access To This Command",
                                  16711680)
                end
            else

                local safecom = command
                local t = mysplit(command, " ")
                if t[2] and GetPlayerName(tonumber(t[2])) then
                    local identifier = nil
                    if Config.IdentifierToBan == 'license' then
                        for _, iden in ipairs(GetPlayerIdentifiers(t[2])) do
                            if string.match(iden, "license:") then
                                identifier = string.gsub(iden, "license:", "")
                                break
                            end
                        end

                    elseif Config.IdentifierToBan == 'discord' then

                        for _, iden in ipairs(GetPlayerIdentifiers(t[2])) do
                            if string.match(iden, "discord:") then
                                identifier = string.gsub(iden, "discord:", "")
                                break
                            end
                        end

                    elseif Config.IdentifierToBan == 'steam' then

                        for _, iden in ipairs(GetPlayerIdentifiers(t[2])) do
                            if string.match(iden, "steam:") then
                                identifier = string.gsub(iden, "steam:", "")
                                break
                            end
                        end

                    else

                        error(
                            'Config File. IdentifierToBan is Invalid input please write rockstar or discord or steam in it')

                    end

                    name = GetPlayerName(t[2])
                    DropPlayer(tonumber(t[2]), Config.BanString)
                    if identifier then
                        sendToDiscord("Discord Command", name ..
                                          ' đã bị ban. Identifier : ' ..
                                          identifier, 16711680)
                        BanIdentifier(identifier)
                    else
                        sendToDiscord("Discord Command",
                                      "Không thể tìm thấy Identifie, hệ thống sẽ tạm thời kick người chơi này.",
                                      16711680)
                    end
                else
                    sendToDiscord("Discord Command", "ID không hợp lệ",
                                  16711680)
                end

            end
            -- Ban Someone offline with their identifier. prefix + banoffline + identifier
        elseif string.starts(command, Config.Prefix .. "banoffline") then
            if Config.RestrictBanToID then
                if has_value(Config.AllowedDiscordIdsToBan, discordid) then
                    local safecom = command
                    local t = mysplit(command, " ")

                    if t[2] then
                        BanIdentifier(t[2])
                        sendToDiscord("Discord Command",
                                      "Đã ban offline thành công", 16711680)
                    end

                else
                    sendToDiscord("Discord Command",
                                  "You Do Not Have Access To This Command",
                                  16711680)

                end
            else

                local safecom = command
                local t = mysplit(command, " ")

                if t[2] then
                    BanIdentifier(t[2])

                    sendToDiscord("Discord Command",
                                  "Đã  ban offline thành công", 16711680)

                end

            end
            -- Unban Someone Identifier. Prefix + unban + identifier
        elseif string.starts(command, Config.Prefix .. "unban") then
            if Config.RestrictBanToID then
                if has_value(Config.AllowedDiscordIdsToBan, discordid) then
                    local safecom = command
                    local t = mysplit(command, " ")

                    if t[2] then
                        UnbanIdentifier(t[2])
                        sendToDiscord("Discord Command",
                                      "Unban thành công", 16711680)
                    end

                else
                    sendToDiscord("Discord Command",
                                  "You Do Not Have Access To This Command",
                                  16711680)

                end
            else

                local safecom = command
                local t = mysplit(command, " ")

                if t[2] then
                    UnbanIdentifier(t[2])
                    sendToDiscord("Discord Command",
                                  "Unban thành công", 16711680)
                end

            end
        elseif string.starts(command, Config.Prefix .. "addwhitelist") then
            if Config.RestrictWhitelistToID then
                if has_value(Config.AllowedDiscordIdsToWhitelist, discordid) then
                    local safecom = command
                    local t = mysplit(command, " ")

                    if t[2] then
                        AddToWhitelists(t[2])
                        sendToDiscord("Discord Command",
                                      "Identifier Has Been Added To Whitelist List",
                                      16711680)
                    end

                else
                    sendToDiscord("Discord Command",
                                  "You Do Not Have Access To This Command",
                                  16711680)

                end
            else

                local safecom = command
                local t = mysplit(command, " ")

                if t[2] then
                    AddToWhitelists(t[2])
                    sendToDiscord("Discord Command",
                                  "Identifier Has Been Added To Whitelist List",
                                  16711680)
                end

            end
        elseif string.starts(command, Config.Prefix .. "removewhitelist") then
            if Config.RestrictWhitelistToID then
                if has_value(Config.AllowedDiscordIdsToWhitelist, discordid) then
                    local safecom = command
                    local t = mysplit(command, " ")

                    if t[2] then
                        RemoveWhitelists(t[2])
                        sendToDiscord("Discord Command",
                                      "Identifier Has Been Removed From Whitelist List",
                                      16711680)
                    end

                else
                    sendToDiscord("Discord Command",
                                  "You Do Not Have Access To This Command",
                                  16711680)

                end
            else

                local safecom = command
                local t = mysplit(command, " ")

                if t[2] then
                    RemoveWhitelists(t[2])
                    sendToDiscord("Discord Command",
                                  "Identifier Has Been Removed From Whitelist List",
                                  16711680)
                end

            end

        elseif string.starts(command, Config.Prefix .. "spawncar") then
            local safecom = command
            local t = mysplit(command, " ")

            if t[2] and GetPlayerName(tonumber(t[3])) then

                TriggerClientEvent('DiscordComm:SpawnCar', tonumber(t[3]), t[2])
                sendToDiscord("Discord Command",
                              "Spawn xe cho người chơi thành công",
                              16711680)
            else

                sendToDiscord("Discord Command",
                              "Vui lòng nhập đúng, prefix + spawncar + model + id",
                              16711680)
            end

        elseif string.starts(command, Config.Prefix .. "giveweapon") then
            local safecom = command
            local t = mysplit(command, " ")

            if t[2] and tonumber(t[3]) and GetPlayerName(tonumber(t[4])) then

                TriggerClientEvent('DiscordComm:GiveWeapon', tonumber(t[4]),
                                   t[2], tonumber(t[3]))
                sendToDiscord("Discord Command",
                              "Give weapon thành công",
                              16711680)
            else

                sendToDiscord("Discord Command",
                              "Vui long nhập đúng, prefix + giveweapon + model + ammo + id",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "setarmor") then
            local safecom = command
            local t = mysplit(command, " ")

            if t[2] and GetPlayerName(tonumber(t[3])) then

                TriggerClientEvent('DiscordComm:SetArmour', tonumber(t[3]), t[2])
                sendToDiscord("Discord Command",
                              "Set giáp thành công",
                              16711680)
            else

                sendToDiscord("Discord Command",
                              "Vui lòng nhập đúng, prefix + setarmor + amount + id",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "heal") then
            local safecom = command
            local t = mysplit(command, " ")

            if GetPlayerName(tonumber(t[2])) then

                TriggerClientEvent('DiscordComm:Heal', tonumber(t[2]))
                sendToDiscord("Discord Command",
                              "Heal thành công", 16711680)
            else

                sendToDiscord("Discord Command",
                              "Nhập chưa chính xác, prefix + heal + id",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "teleportcord") then
            local safecom = command
            local t = mysplit(command, " ")

            if GetPlayerName(tonumber(t[2])) and tonumber(t[3]) and
                tonumber(t[4]) and tonumber(t[5]) then

                TriggerClientEvent('DiscordComm:TpCords', tonumber(t[2]),
                                   tonumber(t[3]), tonumber(t[4]),
                                   tonumber(t[5]))
                sendToDiscord("Discord Command",
                              "Đã teleport thành công", 16711680)
            else

                sendToDiscord("Discord Command",
                              "Nhập chưa đúng, prefix + teleportcord + id + x + y + z",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "teleportplyr") then
            local safecom = command
            local t = mysplit(command, " ")

            if GetPlayerName(tonumber(t[2])) and GetPlayerName(tonumber(t[3])) then

                TriggerClientEvent('DiscordComm:TpPlayer', tonumber(t[2]),
                                   tonumber(t[3]))
                sendToDiscord("Discord Command",
                              "Teleport thành công ",
                              16711680)
            else

                sendToDiscord("Discord Command",
                              "Nhập chưa chính xác, prefix + teleportplyr + targetid + destinationid",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "screenshot") then
            local safecom = command
            local t = mysplit(command, " ")

            if Config.EnableDiscordScreenshot then
                if GetPlayerName(tonumber(t[2])) then
                    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                        tonumber(t[2]), Config.WebHook,
                        {encoding = "png", quality = 1}, {
                            username = Config.ReplyUserName,
                            avatar_url = Config.AvatarURL,
                            content = "Screenshot!",
                            embeds = {
                                {
                                    color = 16771584,
                                    author = {
                                        name = "Duy | IC Team",
                                        icon_url = "https://cdn.discordapp.com/embed/avatars/0.png"
                                    },
                                    title = "Developed By Duy | IC Team."
                                }
                            }
                        }, function(error)
                            if error then
                                sendToDiscord("Discord Command",
                                              "Lỗi. Reason : " ..
                                                  error, 16711680)
                            else
                                sendToDiscord("Discord Command",
                                              "Take Screenshot Succesfuly",
                                              16711680)
                            end
                        end)
                else

                    sendToDiscord("Discord Command",
                                  "VUi lòng nhập chính xác, prefix + screenshot + id",
                                  16711680)
                end
            else
                sendToDiscord("Discord Command",
                              "If You want to use Screenshot command please Enable it in Config file.",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "getinventory") then
            local safecom = command
            local t = mysplit(command, " ")

            if Config.ESX then
                if GetPlayerName(tonumber(t[2])) then
                    local inventory = 'INVENTORY : '
                    local xPlayer = ESX.GetPlayerFromId(tonumber(t[2]))
                    if xPlayer and xPlayer.getInventory() then
                        for i, v in pairs(xPlayer.getInventory()) do
                            if v.count > 0 then
                                inventory =
                                    inventory .. " |ItemName : " .. v.label ..
                                        ",Count : " .. v.count
                            end
                        end
                        sendToDiscord("Discord Command", inventory, 16711680)

                    else
                        sendToDiscord("Discord Command",
                                      "Something Went Wrong With ESX", 16711680)

                    end

                else

                    sendToDiscord("Discord Command",
                                  "Nhập chưa đúng, prefix + getinventory + id",
                                  16711680)
                end
            else
                sendToDiscord("Discord Command",
                              "If You want to use getinventory command please Enable ESX in Config file.",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "getloadout") then
            local safecom = command
            local t = mysplit(command, " ")

            if Config.ESX then
                if GetPlayerName(tonumber(t[2])) then
                    local inventory = 'LoadOut : '
                    local xPlayer = ESX.GetPlayerFromId(tonumber(t[2]))
                    if xPlayer and xPlayer.getLoadout() then
                        for i, v in pairs(xPlayer.getLoadout()) do

                            inventory = inventory .. " | Weapon Name : " ..
                                            v.label .. ",Ammo : " .. v.ammo

                        end
                        sendToDiscord("Discord Command", inventory, 16711680)

                    else
                        sendToDiscord("Discord Command",
                                      "Something Went Wrong With ESX", 16711680)

                    end

                else

                    sendToDiscord("Discord Command",
                                  " Nhập chưa đúng, prefix + getinventory + id",
                                  16711680)
                end
            else
                sendToDiscord("Discord Command",
                              "If You want to use getinventory command please Enable ESX in Config file.",
                              16711680)
            end
        elseif string.starts(command, Config.Prefix .. "getidentifiers") then
            local safecom = command
            local t = mysplit(command, " ")

            if t[2] then
                if GetPlayerName(tonumber(t[2])) then
                    local identifiers = "Identifiers : "

                    for i, v in pairs(GetPlayerIdentifiers(tonumber(t[2]))) do
                        identifiers = identifiers .. " | " .. v
                    end

                    sendToDiscord("Discord Command", identifiers, 16711680)

                else

                    sendToDiscord("Discord Command",
                                  "Nhập chưa đúng, prefix + getidentifiers + id",
                                  16711680)
                end
            else
                sendToDiscord("Discord Command",
                              "Nhập chưa đúng, prefix + getidentifiers + id",
                              16711680)
            end

            -- Command Not Found
        else

            sendToDiscord("Discord Command",
                          "Lệnh không tìm thấy. Hãy chắc chắn rằng bạn đang nhập một lệnh hợp lệ",
                          16711680)

        end
    end
end