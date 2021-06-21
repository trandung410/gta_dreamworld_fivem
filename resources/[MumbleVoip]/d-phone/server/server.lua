ESX = nil

local backgroundurl

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
    Wait(1000)
    MySQL.Async.fetchAll('SELECT * FROM jobs ', {}, function(result)
        for _,v in pairs(result) do
            MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver OR `sender` = @receiver" , {["@receiver"] = v.label}, function(messages)
                if messages[1] ~= nil then
                    MySQL.Async.execute("DELETE FROM `phone_messages` WHERE `receiver` = @receiver" , {
                        ["@receiver"] = v.label,
                    })
                    MySQL.Async.execute("DELETE FROM `phone_messages` WHERE `sender` = @receiver" , {
                        ["@receiver"] = v.label,
                    })
                end
            end)
        end
    end)
end)


-- NUMBER
function getPhoneRandomNumber()
    local numBase0 = math.random(Config.LowerPrefix, Config.HigherPrefix)
    local numBase1 = math.random(Config.LowerNumber, Config.HigherNumber)
    local num = string.format(numBase0.. "-"..numBase1)
	return num
end

-- NORMAL
RegisterServerEvent('d-phone:server:setvalues')
AddEventHandler('d-phone:server:setvalues', function(source, background, darkbackground)
    backgroundurl = background
    darkbackgroundurl = darkbackground
end)

RegisterServerEvent('d-phone:server:getphonedata')
AddEventHandler('d-phone:server:getphonedata', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM `phone_information` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if result[1] ~= nil then
            MySQL.Async.fetchAll('SELECT * FROM jobs ', {}, function(jobs)
                Wait(100)
                TriggerClientEvent("d-phone:client:showphone", _source, result[1], jobs)
            end)
        else
            MySQL.Async.execute("INSERT INTO `phone_information` (`identifier`, `wallpaper`) VALUES (@identifier, @wallpaper)",
            {['@identifier'] = xPlayer.identifier, ['@wallpaper'] = backgroundurl})
            Wait(100)
            TriggerEvent("d-phone:server:getphonedata", _source)
        end
    end)
end)

RegisterServerEvent('d-phone:server:checkphone')
AddEventHandler('d-phone:server:checkphone', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem("phone")

    if item.count >= 1 then
        TriggerClientEvent("d-phone:client:hasphone", _source)
    end
end)

RegisterServerEvent('d-phone:server:checkphonenumber')
AddEventHandler('d-phone:server:checkphonenumber', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if result[1] ~= nil then
            local xPlayernumber = getNumberPhone(xPlayer.identifier)
            TriggerClientEvent("d-phone:client:hasnumber", _source, xPlayernumber)
        else
            local number = getPhoneRandomNumber()
            MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `phone_number` = @phone_number", {["@phone_number"] = number}, function(numberr)
                if numberr[1] == nil then
                    MySQL.Async.execute("INSERT INTO `phone_contacts` (`identifier`, `name`, `number`, `favourite`) VALUES (@identifier, @name, @number, @favourite)",
                    {['@identifier'] = xPlayer.identifier, ['@name'] = _U("mynumber"), ['@number'] = number, ['@favourite'] = 1})

                    MySQL.Async.execute('UPDATE `users` SET `phone_number` = @phone_number WHERE `identifier` = @id', {['@phone_number'] =  number,  ['@id'] =  xPlayer.identifier})

                    TriggerClientEvent("d-phone:client:hasnumber", _source, number)
                else
                    TriggerEvent("d-phone:server:checkphonenumber", _source)
                end
            end)
        end
    end)
end)

-- CONTACT
RegisterServerEvent('d-phone:server:addcontact')
AddEventHandler('d-phone:server:addcontact', function(source, name, number2)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local number = string.format(number2)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `phone_number` = @phone_number", {["@phone_number"] = number}, function(result)
        if result[1] ~= nil then
            MySQL.Async.execute("INSERT INTO `phone_contacts` (`identifier`, `name`, `number`) VALUES (@identifier, @name, @number)",
            {['@identifier'] = xPlayer.identifier, ['@name'] = name, ['@number'] = number})
            Wait(50)
            TriggerEvent("d-phone:server:loadcontact", _source)
        else
            TriggerClientEvent("d-notification", _source, _U("numbernotexist"))
        end
    end)
end)

RegisterServerEvent('d-phone:server:addcontactfavourit')
AddEventHandler('d-phone:server:addcontactfavourit', function(source, name, number2)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local number = string.format(number2)
    MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `name` = @name AND `number` = @number", {["@name"] = name, ["@number"] = number}, function(contact)
        if contact[1].favourite == 1 then
            MySQL.Async.execute('UPDATE `phone_contacts` SET `favourite` = @favourite WHERE `name` = @name AND `number` = @number', {["@favourite"] = 0,["@name"] = name, ["@number"] = number})
        else
            MySQL.Async.execute('UPDATE `phone_contacts` SET `favourite` = @favourite WHERE `name` = @name AND `number` = @number', {["@favourite"] = 1,["@name"] = name, ["@number"] = number})
        end
    end)
    Wait(250)
    TriggerEvent("d-phone:server:loadcontact", _source)
end)

RegisterServerEvent('d-phone:server:editcontact')
AddEventHandler('d-phone:server:editcontact', function(source, name, number3, name2, number4)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local number = string.format(number3)
    local number2 = string.format(number4)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `phone_number` = @phone_number", {["@phone_number"] = number}, function(result)
        if result[1] ~= nil then
            MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `name` = @name AND `number` = @number", {["@name"] = name2, ["@number"] = number2}, function(contact)
                MySQL.Async.execute('UPDATE `phone_contacts` SET `name` = @name, `number` = @number WHERE `id` = @id', {['@name'] =  name, ['@number'] =  number,  ['@id'] =  contact[1].id})
            end)
            Wait(250)
            TriggerEvent("d-phone:server:loadcontact", _source)
        else
            TriggerClientEvent("d-notification", _source, _U("numbernotexist"))
        end
    end)
end)

RegisterServerEvent('d-phone:server:deletecontact')
AddEventHandler('d-phone:server:deletecontact', function(source, name, number2)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local number = string.format(number2)
        MySQL.Async.execute("DELETE FROM `phone_contacts` WHERE `identifier` = @identifier AND `name` = @name AND `number` = @number" , {
            ["@identifier"] = xPlayer.identifier,
            ["@name"] = name,
            ["@number"] = number
        })
        TriggerClientEvent("d-notification", _source, _U("deletedcontact"))
        Wait(50)
        TriggerEvent("d-phone:server:loadcontact", _source)
end)

RegisterServerEvent('d-phone:server:sharecontact')
AddEventHandler('d-phone:server:sharecontact', function(source, name, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("d-phone:client:sharecontact", _source, _U("sharedcontact"), number)
end)

RegisterServerEvent('d-phone:server:loadcontact')
AddEventHandler('d-phone:server:loadcontact', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if (result) then
            local html = ""
            for _,v in pairs(result) do
                local id = v.id
                local name = v.name
                local number = v.number
                local favourite = v.favourite
                if favourite == 1 then
                    html = html .. string.format('<div class="phone-contact" data-contactid="%s" data-name="%s" data-number="%s" data-favourite="%s"><i class="phone-contact-favourite far fa-star"></i> <div class="phone-contact-name"> %s</div> <div class="phone-contact-actions"><i class="fas fa-chevron-right"></i></div>  </div>', id, name, number, favourite, name)
                else
                    html = html .. string.format('<div class="phone-contact" data-contactid="%s" data-name="%s" data-number="%s" data-favourite="%s"> <div class="phone-contact-name"> %s</div> <div class="phone-contact-actions"><i class="fas fa-chevron-right"></i></div>  </div>', id, name, number, favourite, name)
                end
            end
            TriggerClientEvent("d-phone:client:loadcontact", _source, html)
        else
            local html = ""
            html = html .. string.format('<div class="phone-contact" data-contactid="none" data-name="none" data-number="none"> <div class="phone-contact-name">%s </div> <div class="phone-contact-actions"></div>  </div>',  _U("youdonthaveanycontacts"))
            TriggerClientEvent("d-phone:client:loadcontact", _source, html)
        end
    end)
end)

TriggerEvent('es:addGroupCommand', 'sca', 'user', function(p, args, user)
    TriggerClientEvent("d-phone:client:acceptsharecontact", p)
end)

TriggerEvent('es:addGroupCommand', 'scd', 'user', function(p, args, user)
    TriggerClientEvent("d-phone:client:declinesharecontact", p)
end)


-- MESSAGES
RegisterServerEvent('d-phone:server:loadmessage')
AddEventHandler('d-phone:server:loadmessage', function(source, sender)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local allmessages = {}
    local havecontacts
    MySQL.Async.fetchAll("SELECT phone_number FROM `users` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(contact)
            if contact[1] ~= nil then
                havecontacts = true
            else
                havecontacts = false
            end

            MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver AND `sender` = @sender", {["@receiver"] =  result[1].phone_number, ["@sender"] = sender}, function(message)
                MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver AND `sender` = @sender", {["@receiver"] = sender, ["@sender"] =  result[1].phone_number}, function(sendersql)
                    local html = ""
                    for i,v in ipairs(message) do                
                        table.insert(allmessages, v)
                    end

                    for i,v in ipairs(sendersql) do           
                        table.insert(allmessages, v)
                    end

                    table.sort(allmessages, function(a,b) return a.id < b.id end)

                    for i,v in ipairs(allmessages) do                      
                        local message = v.message
                        local date = v.date
                        local isRead = v.isRead
                        local contactname
                        if havecontacts == true then
                            for _,k in pairs(contact) do
                                if k.number == v.sender then
                                    contactname = k.name
                                elseif v.sender == result[1].phone_number then
                                    contactname = v.receiver
                                elseif v.receiver == result[1].phone_number then
                                    contactname = v.sender
                                end
                            end
                        else
                            if v.sender == result[1].phone_number then
                                contactname = v.receiver
                            elseif v.receiver == result[1].phone_number then
                                contactname = v.sender
                            end
                        end

                        local sendernummber = v.sender
                        local mynumber = result[1].phone_number

                        if v.isService == '0' then
                            if sendernummber == mynumber then
                                if v.isgps == '0' then
                                    html = html .. string.format('<div class="phone-chat-message me"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font> </div> <div class="phone-chat-message-message"> %s </div> </div>', _U("me"), date, message)
                                else
                                    local gps =json.decode(v.isgps)
                                    html = html .. string.format('<div class="phone-chat-message me"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font><font id="phone-chat-message-date"> %s </font></div><div class="phone-chat-message-message" id="phone-chat-message-message-gps" data-x="%s"data-y="%s" data-z="%s"><div class=" phone-chat-message-message-gps"><i style="position: relative;" class="fas fa-map-marker-alt"> </i> %s: </div><div class=" phone-chat-message-message-picture"> <img src="https://i.gyazo.com/aed2edc29867c81215c5cf5b9eea96fb.png"></div></div></div>', _U("me"), date, gps.x, gps.y, gps.z, _U("location"))
                                end
                            else
                                if v.isgps == '0' then
                                    html = html .. string.format('<div class="phone-chat-message"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font> </div> <div class="phone-chat-message-message"> %s </div> </div>', contactname, date, message)
                                else
                                    local gps = json.decode(v.isgps)
                                    html = html .. string.format('<div class="phone-chat-message"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font><font id="phone-chat-message-date"> %s </font></div><div class="phone-chat-message-message" id="phone-chat-message-message-gps" data-x="%s"data-y="%s" data-z="%s"><div class=" phone-chat-message-message-gps"><i style="position: relative;" class="fas fa-map-marker-alt"> </i> %s: </div><div class=" phone-chat-message-message-picture"> <img src="https://i.gyazo.com/aed2edc29867c81215c5cf5b9eea96fb.png"></div></div></div>', contactname, date, gps.x, gps.y, gps.z, _U("location"))
                                end
                            end
                        else
                            if v.isService == sender then
                                if v.isgps == '0' then
                                    html = html .. string.format('<div class="phone-chat-message"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font> </div> <div class="phone-chat-message-message"> %s </div> </div>', contactname, date, message)
                                else
                                    local gps = json.decode(v.isgps)
                                    html = html .. string.format('<div class="phone-chat-message"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font><font id="phone-chat-message-date"> %s </font></div><div class="phone-chat-message-message" id="phone-chat-message-message-gps" data-x="%s"data-y="%s" data-z="%s"><div class=" phone-chat-message-message-gps"><i style="position: relative;" class="fas fa-map-marker-alt"> </i> %s: </div><div class=" phone-chat-message-message-picture"> <img src="https://i.gyazo.com/aed2edc29867c81215c5cf5b9eea96fb.png"></div></div></div>', contactname, date, gps.x, gps.y, gps.z, _U("location"))
                                end
                            end
                        end
                    end
                    TriggerClientEvent("d-phone:client:loadmessages", _source, html)
                end)
            end)
        end)
    end)
end)

RegisterServerEvent('d-phone:server:loadrecentmessage')
AddEventHandler('d-phone:server:loadrecentmessage', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local allmessages = {}
    local contacts = {}
    local havecontacts
    MySQL.Async.fetchAll("SELECT phone_number FROM `users` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(contact)
            if contact[1] ~= nil then
                havecontacts = true
            else
                havecontacts = false
            end
            MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver OR `sender` = @sender", {["@receiver"] = result[1].phone_number, ["@sender"] = result[1].phone_number}, function(message)
                local html = ""
                for i,v in ipairs(message) do                
                    table.insert(allmessages, v)
                end

                table.sort(allmessages, function(a,b) return a.id > b.id end)

                for i,v in ipairs(allmessages) do
                    local already = false
                    for i,k in ipairs(contacts) do     
                        if v.sender ==  result[1].phone_number then
                            if v.receiver == k.receiver then
                                already = true
                            end
                        else
                            if v.sender == k.sender then
                                already = true
                            end
                        end
                    end
                    if already == false then
                        table.insert(contacts, v)
                    end
                end

                table.sort(contacts, function(a,b) return a.id > b.id end)

                local alreadysended = {}
                local sended = false
                local ismynumber = false
                for i,v in ipairs(contacts) do
                    local existing = false
                        local message = v.message
                        local date = v.date
                        local isRead = v.isRead
                        local contactname
                        if havecontacts == true then
                            for _,k in pairs(contact) do
                                if k.number ~= result[1].phone_number then
                                    ismynumber = false
                                    if k.number == v.sender or k.number == v.receiver then
                                        if k.number == v.sender then
                                            contactname = k.name
                                        elseif k.number == v.receiver then
                                            contactname = k.name
                                        else
                                            contactname = v.sender
                                        end
                                    elseif v.sender == result[1].phone_number then
                                        contactname = v.receiver
                                    elseif v.sender ~= result[1].phone_number then
                                        contactname = v.sender
                                    end
                                else
                                    ismynumber = true
                                end
                            end

                            if ismynumber == true then
                                if v.sender == result[1].phone_number then
                                    contactname = v.receiver
                                elseif v.sender ~= result[1].phone_number then
                                    contactname = v.sender
                                end
                            end
                        else
                            if v.sender == result[1].phone_number then
                                contactname = v.receiver
                            elseif v.sender ~= result[1].phone_number then
                                contactname = v.sender
                            end
                        end

        
                        local sendernummber =v.sender
                        local mynumber = result[1].phone_number
                        if sended == true then
                            for i,k in ipairs(alreadysended) do
                                if k == contactname then
                                    existing = true
                                end
                            end
                        end
                        if existing == false then
                            table.insert(alreadysended, contactname)

                            if sendernummber == mynumber then
                                html = html .. string.format('<div class="phone-recent-messages-selection me" data-number="%s"><div id="prm-contactname"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font></div><div id="prm-message">%s</div></div>', v.receiver, contactname, v.date,  message)
                            else
                                html = html .. string.format('<div class="phone-recent-messages-selection" data-number="%s"><div id="prm-contactname"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font></div><div id="prm-message">%s</div></div>', sendernummber, contactname,  v.date, message)
                            end
                        end
                        sended = true
                end
                TriggerClientEvent("d-phone:client:loadrecentmessages", _source, html)
            end)
        end)
    end)
end)

RegisterServerEvent('d-phone:server:sendmessage')
AddEventHandler('d-phone:server:sendmessage', function(source, message, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")

    MySQL.Async.fetchAll("SELECT phone_number FROM `users` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `date`) VALUES (@sender, @receiver, @message, @date)",
        {['@sender'] =result[1].phone_number, ['@receiver'] = number, ['@message'] = message, ['@date'] = time})
        Wait(10)
        TriggerEvent("d-phone:server:loadmessage", _source, number)
    end)

    local Otheridentifier = getIdentifierByPhoneNumber(number)
    local players = ESX.GetPlayers()
    local isservicee = false
    for i=1, #players do
        local zPlayer = ESX.GetPlayerFromId(players[i])
        if zPlayer.job.label == number then
            TriggerClientEvent("d-phone:client:playbusinessmessagesound", zPlayer.source)
            isservicee = true
            TriggerClientEvent("d-notification", zPlayer.source, _U("newservicemessage"))
        end        
    end
    if isservicee == false then
        getSourceFromIdentifier(Otheridentifier, function (Othersource)
            if Othersource ~= nil then
                TriggerClientEvent("d-phone:client:playmessagesound", Othersource)

                TriggerClientEvent("d-notification", Othersource, _U("newservicemessage"))
            end
        end)
    end
end)

RegisterServerEvent('d-phone:server:sendgps')
AddEventHandler('d-phone:server:sendgps', function(source, number, pos)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")
    MySQL.Async.fetchAll("SELECT phone_number FROM `users` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `date`, `isgps`) VALUES (@sender, @receiver, @message, @date, @isgps)",
        {['@sender'] =result[1].phone_number, ['@receiver'] = number, ['@message'] = 'GPS', ['@date'] = time, ['@isgps'] = json.encode(pos)})
        Wait(10)
        TriggerEvent("d-phone:server:loadmessage", _source, number)

        local Otheridentifier = getIdentifierByPhoneNumber(number)
        getSourceFromIdentifier(Otheridentifier, function (Othersource)
            if Othersource ~= nil then
                TriggerClientEvent("d-phone:client:playmessagesound", Othersource)
    
                TriggerClientEvent("d-notification", Othersource, _U("newmessage"))
            end
        end)
    end)

    local Otheridentifier = getIdentifierByPhoneNumber(number)
    getSourceFromIdentifier(Otheridentifier, function (Othersource)
        if Othersource ~= nil then
            TriggerClientEvent("d-phone:client:playmessagesound", Othersource)
        end
    end)
end)

-- CALL
RegisterServerEvent('d-phone:server:startcall')
AddEventHandler('d-phone:server:startcall', function(source, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayernumber = getNumberPhone(xPlayer.identifier)
    local contactname = nil
    local Otheridentifier = getIdentifierByPhoneNumber(number)
    MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = Otheridentifier}, function(contact)
        local result = false
        for _,k in pairs(contact) do
            if k.number == xPlayernumber then
                contactname = k.name
                result = true
            end
        end
        if result == false then
            contactname = xPlayernumber
        end
    end)
    Wait(100)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")

    MySQL.Async.execute("INSERT INTO `phone_calls` (`receiver`, `num`, `time`) VALUES (@receiver, @num, @time)",
            {['@receiver'] = number, ['@num'] = xPlayernumber, ['@time'] = time})

    getSourceFromIdentifier(Otheridentifier, function (Othersource)
        if Othersource ~= nil then
            TriggerClientEvent("d-phone:client:callrequest", Othersource, _source, xPlayernumber, number, contactname)
        end
    end)

end)

RegisterServerEvent('d-phone:server:acceptcall')
AddEventHandler('d-phone:server:acceptcall', function(source, requeser, requesternumber, sourcenumber, callnumber)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(contact)
        local contactname = nil
        local result = false
        for _,k in pairs(contact) do
            if k.number == requesternumber then
                contactname = k.name
                result = true
            end
        end

        if result == false then
            contactname = requesternumber
        end
        
        TriggerClientEvent("d-phone:client:acceptcall", source, requeser, requesternumber, callnumber, contactname)
    end)
end)

RegisterServerEvent('d-phone:server:loadrecentcalls')
AddEventHandler('d-phone:server:loadrecentcalls', function(source, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayernumber = getNumberPhone(xPlayer.identifier)

    local recentcalls = ''

    MySQL.Async.fetchAll("SELECT * FROM `phone_calls` WHERE `receiver` = @receiver OR `num` = @num", {["@receiver"] = xPlayernumber, ["@num"] = xPlayernumber}, function(calls)
        for _,v in pairs(calls) do
            print(v.num)
            print(v.receiver)
            print(xPlayernumber)
            if v.num == xPlayernumber then
                local  contactname = getContactname(xPlayer.identifier, v.receiver)
                recentcalls = recentcalls .. string.format('<div class="phone-all-call-sector-selection" data-number="%s"><div class="phone-all-call-sector-selection-text"><font style="color: gray;"> %s </font><br> %s</div><div class="phone-all-call-sector-selection-recall"><i id="pacs-message" data-number="%s"   style="margin-top: 2.5vh; margin-left: 1vh" class="fas fa-envelope pacs-icon"></i><i id="pacs-call" data-number="%s" class="fas fa-phone pacs-icon"></i></div></div>', v.receiver, _U("incomingcall") ,contactname, v.receiver, v.receiver)
            else
                local  contactname = getContactname(xPlayer.identifier, v.num)
                recentcalls = recentcalls .. string.format('<div class="phone-all-call-sector-selection" data-number="%s"><div class="phone-all-call-sector-selection-text"><font style="color: gray;"> %s </font><br> %s</div><div class="phone-all-call-sector-selection-recall"><i id="pacs-message" data-number="%s"  style="margin-top: 2.5vh; margin-left: 1vh" class="fas fa-envelope pacs-icon"></i><i id="pacs-call" data-number="%s" class="fas fa-phone pacs-icon"></i></div></div>', v.num, _U("outgoingcall"), contactname, v.num, v.num)
            end
        end
    end)
    Wait(250)
    TriggerClientEvent("d-phone:client:loadrecentcalls", _source, recentcalls)
end)


RegisterServerEvent('d-phone:server:acceptsalty')
AddEventHandler('d-phone:server:acceptsalty', function(source, requeser)
    exports['saltychat']:EstablishCall(requeser, source)
    exports['saltychat']:EstablishCall(source, requeser)
end)

RegisterServerEvent('d-phone:server:endsalty')
AddEventHandler('d-phone:server:endsalty', function(source, requeser)
    exports['saltychat']:EndCall(requeser, source)
    exports['saltychat']:EndCall(source, requeser)
end)

RegisterServerEvent('d-phone:server:endcall')
AddEventHandler('d-phone:server:endcall', function(source, requeser)
    TriggerClientEvent("d-phone:client:endcall", source)
    TriggerClientEvent("d-phone:client:endcall", requeser)
end)


RegisterServerEvent('d-phone:server:declinecall')
AddEventHandler('d-phone:server:declinecall', function(source, requeser)
    TriggerClientEvent("d-phone:client:declinecall", requeser)
end)

RegisterServerEvent('d-phone:server:stopcall')
AddEventHandler('d-phone:server:stopcall', function(source, number)
    local Otheridentifier = getIdentifierByPhoneNumber(number)

    getSourceFromIdentifier(Otheridentifier, function (Othersource)
        if Othersource ~= nil then
            TriggerClientEvent("d-phone:client:stopcall", Othersource)
        end
    end)


end)


-- SETTINGS
RegisterServerEvent('d-phone:server:changewallpaper')
AddEventHandler('d-phone:server:changewallpaper', function(source, url)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM `phone_information` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if result[1] ~= nil then
            MySQL.Async.execute('UPDATE `phone_information` SET `wallpaper` = @wallpaper WHERE `identifier` = @identifier', {['@wallpaper'] =  url, ['@identifier'] =  xPlayer.identifier})

            TriggerClientEvent("d-phone:client:changewallpaper", _source, url)

            TriggerClientEvent("d-notification", Othersource, _U("changedbg"))
        else
            MySQL.Async.execute("INSERT INTO `phone_information` (`identifier`, `wallpaper`) VALUES (@identifier, @wallpaper)",
            {['@identifier'] = xPlayer.identifier, ['@wallpaper'] = url})

            TriggerClientEvent("d-phone:client:changewallpaper", _source, url)

            TriggerClientEvent("d-notification", Othersource,  _U("changedbg"))
        end
    end)
end)


RegisterServerEvent('d-phone:server:changedarkmode')
AddEventHandler('d-phone:server:changedarkmode', function(source, state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM `phone_information` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if result[1] ~= nil then
            MySQL.Async.execute('UPDATE `phone_information` SET `darkmode` = @darkmode WHERE `identifier` = @identifier', {['@darkmode'] =  state, ['@identifier'] =  xPlayer.identifier})

            TriggerClientEvent("d-phone:client:changedarkmode", _source, state)

            TriggerClientEvent("d-notification", _source, _U("changeddarkmode"))
            if result[1].wallpaper == Config.backgroundurl or result[1].wallpaper == Config.darkbackgroundurl or result[1].wallpaper == nil then
                if state == 1 then  
                    TriggerEvent("d-phone:server:changewallpaper", _source, Config.darkbackgroundurl )
                else
                    TriggerEvent("d-phone:server:changewallpaper", _source, Config.backgroundurl )
                end
            end
        else
            MySQL.Async.execute("INSERT INTO `phone_information` (`identifier`, `darkmode`) VALUES (@identifier, @darkmode)",
            {['@identifier'] = xPlayer.identifier, ['@darkmode'] = state})

            TriggerClientEvent("d-phone:client:changedarkmode", _source, state)

        end
    end)
end)

-- UTILS
function getSourceFromIdentifier(identifier, cb)
    TriggerEvent("es:getPlayers", function(users)
        for k , user in pairs(users) do
            if (user.getIdentifier ~= nil and user.getIdentifier() == identifier) or (user.identifier == identifier) then
                cb(k)
                return
            end
        end
    end)
    cb(nil)
end

function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end

function getIdentifierByPhoneNumber(phone_number) 
    local result = MySQL.Sync.fetchAll("SELECT identifier FROM users WHERE phone_number = @phone_number", {
        ['@phone_number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function getContactname(identifier, number)
    local hascontacts = false
    local hasthiscontact = false
    local number2 = number
    local contacte 

    MySQL.Async.fetchAll("SELECT * FROM `phone_contacts` WHERE `identifier` = @identifier", {["@identifier"] = identifier}, function(contact)
        if contact[1] then
            hascontacts = true
        end

        contacte = contact
    end)

    if hascontacts == true then
        for _, v in ipairs(contacte) do
            if v.number == number2 then
                hasthiscontact = true
                return v.name
            end
        end

        if hasthiscontact == false then
            return number2
        end
    else
        return number2
    end
end

-- NOTIFICATION 
RegisterNetEvent("d-notification")
AddEventHandler("d-notification", function(source, text, length)
	TriggerClientEvent("d-notification", source, text, length)
end)



TriggerEvent('es:addGroupCommand', 'testcall', 'admin', function(source, args, user)
    TriggerEvent("d-phone:server:startcall", source, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

-- Business
RegisterServerEvent('d-phone:server:showBusiness')
AddEventHandler('d-phone:server:showBusiness', function(source, job)
    local players = ESX.GetPlayers()
    local _source = source
    local Player = ESX.GetPlayerFromId(_source)
    -- Online Players
    local member = ''
    local onlinemember = 0
	for i=1, #players, 1 do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer.job.label == job then
            MySQL.Async.fetchAll("SELECT phone_number, firstname, lastname FROM `users` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)

                onlinemember =  onlinemember + 1
                local name = result[1].firstname .. " " .. result[1].lastname
               if Player.identifier ~= xPlayer.identifier then
                    member = member .. string.format('<div class="phone-ba-member" data-number="%s"><div id="phone-ba-member-name">%s</div><div id="phone-ba-member-number">%s | %s: %s</div><i class="fas fa-phone" id="phone-ba-member-call" data-name="%s" data-number="%s"></i><i class="fas fa-comments" id="phone-ba-member-message" data-name="%s" data-number="%s"></i></div>' ,result[1].phone_number, name, result[1].phone_number, _U("rank"),xPlayer.job.grade, name, result[1].phone_number, name, result[1].phone_number)
               end
            end)
        end
    end

    local motd
    MySQL.Async.fetchAll("SELECT motd FROM `phone_business` WHERE `job` = @job", {["@job"] = job}, function(motds)
        if motds[1] ~= nil then
            motd = motds[1].motd
        else
            motd = _U("theresnomessage")
        end
    end)
    Wait(250)
    TriggerClientEvent("d-phone:client:showBusiness", _source, member, onlinemember, motd)
end)

RegisterServerEvent('d-phone:server:loadbusinessrecentmessage')
AddEventHandler('d-phone:server:loadbusinessrecentmessage', function(source, job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local allmessages = {}
    local contacts = {}
    MySQL.Async.fetchAll("SELECT phone_number FROM `users` WHERE `identifier` = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)

            MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver OR `sender` = @sender", {["@receiver"] = job, ["@sender"] = job}, function(message)
                local html = ""
                for i,v in ipairs(message) do                
                    table.insert(allmessages, v)
                end

                table.sort(allmessages, function(a,b) return a.id > b.id end)

                for i,v in ipairs(allmessages) do
                    local already = false
                    for i,k in ipairs(contacts) do     
                        if v.sender ==  job then
                            if v.receiver == k.receiver then
                                already = true
                            end
                        else
                            if v.sender == k.sender then
                                already = true
                            end
                        end
                    end
                    if already == false then
                        table.insert(contacts, v)
                    end
                end

                table.sort(contacts, function(a,b) return a.id > b.id end)

                local alreadysended = {}
                local sended = false

                for i,v in ipairs(contacts) do
                    local existing = false
                        local message = v.message
                        local date = v.date
                        local isRead = v.isRead
                        local contactname
                        if v.sender == job then
                            contactname = v.receiver 
                        else
                            contactname = v.sender
                        end
        
                        local sendernummber = v.sender
                        local mynumber = job
                        if sended == true then
                            for i,k in ipairs(alreadysended) do
                                if k == contactname then
                                    existing = true
                                end
                            end
                        end
                        if existing == false then
                            table.insert(alreadysended, contactname)

                            if sendernummber == mynumber then
                                html = html .. string.format('<div class="phone-recent-businessapp-selection me" data-number="%s"><div id="prm-contactname"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font></div><div id="prm-message">%s</div></div>', contactname, _U("hidden"), v.date,  message)
                            else
                                html = html .. string.format('<div class="phone-recent-businessapp-selection" data-number="%s"><div id="prm-contactname"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font></div><div id="prm-message">%s</div></div>', contactname,  _U("hidden"),   v.date, message)
                            end
                        end
                        sended = true
                end
                TriggerClientEvent("d-phone:client:loadbusinessrecentmessage", _source, html)
            end)
    end)
end)

RegisterServerEvent('d-phone:server:loadbusinessmessage')
AddEventHandler('d-phone:server:loadbusinessmessage', function(source, job, sender)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local allmessages = {}
    MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver AND `sender` = @sender", {["@receiver"] = job, ["@sender"] = sender}, function(message)
        MySQL.Async.fetchAll("SELECT * FROM `phone_messages` WHERE `receiver` = @receiver AND `sender` = @sender", {["@receiver"] = sender, ["@sender"] = job}, function(sendersql)
            local html = ""
            for i,v in ipairs(message) do         
                table.insert(allmessages, v)
            end

            for i,v in ipairs(sendersql) do           
                table.insert(allmessages, v)
            end

            table.sort(allmessages, function(a,b) return a.id < b.id end)

            for i,v in ipairs(allmessages) do                      
                local message = v.message
                local date = v.date
                local isRead = v.isRead
                local contactname
                if v.sender == job then
                    contactname = v.receiver 
                else
                    contactname = v.sender
                end

                local sendernummber = v.sender
                local mynumber =job
                  
                if sendernummber == mynumber then
                    if v.isgps == '0' then
                        html = html .. string.format('<div class="phone-chat-message me"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font> </div> <div class="phone-chat-message-message"> %s </div> </div>', 'Ich', date, message)
                    else
                        local gps =json.decode(v.isgps)
                        html = html .. string.format('<div class="phone-chat-message me"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font><font id="phone-chat-message-date"> %s </font></div><div class="phone-chat-message-message" id="phone-chat-message-message-gps" data-x="%s"data-y="%s" data-z="%s"><div class=" phone-chat-message-message-gps"><i style="position: relative;" class="fas fa-map-marker-alt"> </i> %s: </div><div class=" phone-chat-message-message-picture"> <img src="https://i.gyazo.com/aed2edc29867c81215c5cf5b9eea96fb.png"></div></div></div>', _U("me"), date, gps.x, gps.y, gps.z, _U("location"))
                    end
                else
                    if v.isgps == '0' then
                        html = html .. string.format('<div class="phone-chat-message"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font> <font id="phone-chat-message-date"> %s </font> </div> <div class="phone-chat-message-message"> %s </div> </div>', "", date, message)
                    else
                        local gps = json.decode(v.isgps)
                        html = html .. string.format('<div class="phone-chat-message"><div class="phone-chat-message-header"><font id="phone-chat-message-name"> %s </font><font id="phone-chat-message-date"> %s </font></div><div class="phone-chat-message-message" id="phone-chat-message-message-gps" data-x="%s"data-y="%s" data-z="%s"><div class=" phone-chat-message-message-gps"><i style="position: relative;" class="fas fa-map-marker-alt"> </i> %s: </div><div class=" phone-chat-message-message-picture"> <img src="https://i.gyazo.com/aed2edc29867c81215c5cf5b9eea96fb.png"></div></div></div>', "", date, gps.x, gps.y, gps.z, _U("location"))
                    end
                end
            end
            TriggerClientEvent("d-phone:client:loadbusinessmessages", _source, html)
        end)
    end)
end)

RegisterServerEvent('d-phone:server:sendbusinessmessage')
AddEventHandler('d-phone:server:sendbusinessmessage', function(source, message, number, job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")

        MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `date`, `isService`) VALUES (@sender, @receiver, @message, @date, @isService)",
        {['@sender'] = job, ['@receiver'] = number, ['@message'] = message, ['@date'] = time, ['@isService'] = job})
        Wait(10)
        TriggerEvent("d-phone:server:loadbusinessmessage", _source, job, number)

        local Otheridentifier = getIdentifierByPhoneNumber(number)
        getSourceFromIdentifier(Otheridentifier, function (Othersource)
            if Othersource ~= nil then
                TriggerClientEvent("d-phone:client:playbusinessmessagesound", Othersource)
                TriggerClientEvent("d-notification", Othersource, _U("newservicemessage"))
            end
        end)
end)

RegisterServerEvent('d-phone:server:sendbusinessgps')
AddEventHandler('d-phone:server:sendbusinessgps', function(source, number, pos, job, position)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")
        MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `date`, `isgps`, `isService`) VALUES (@sender, @receiver, @message, @date, @isgps, @isService)",
        {['@sender'] =job, ['@receiver'] = number, ['@message'] = 'GPS', ['@date'] = time, ['@isgps'] = json.encode(position),  ['@isService'] = job})
        Wait(10)
        TriggerEvent("d-phone:server:loadbusinessmessage", _source, job, number)

        local Otheridentifier = getIdentifierByPhoneNumber(number)
        getSourceFromIdentifier(Otheridentifier, function (Othersource)
            if Othersource ~= nil then
                TriggerClientEvent("d-phone:client:playbusinessmessagesound", Othersource)
                TriggerClientEvent("d-notification", Othersource,_U("newservicemessage"))
            end
        end)
end)

RegisterServerEvent('d-phone:server:changemotd')
AddEventHandler('d-phone:server:changemotd', function(source, job, motd)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT motd FROM `phone_business` WHERE `job` = @job", {["@job"] = job}, function(motds)
        if motds[1] ~= nil then
            MySQL.Async.execute('UPDATE `phone_business` SET `motd` = @motd, `motdchanged` = @motdchange WHERE `job` = @job', {['@motd'] =  motd, ['@motdchange'] =  xPlayer.identifier,  ['@job'] =  job})
        else
            MySQL.Async.execute("INSERT INTO `phone_business` (`job`, `motd`, `motdchanged`) VALUES (@job, @motd, @motdchange)",
        {['@job'] = job, ['@motd'] = motd, ['@motdchange'] = xPlayer.identifier})
        end
    end)

    TriggerClientEvent("d-notification", _source, _U("changesmessage", motd), 5000)
end)


RegisterServerEvent('d-phone:server:sendservicemessage')
AddEventHandler('d-phone:server:sendservicemessage', function(source, rawmessage, job, sendnumber, gps, position, isDead)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")
    local xPlayernumber = getNumberPhone(xPlayer.identifier)

    local message
    if sendnumber == 1 then
        message = rawmessage ..  _U("servicenumber", xPlayernumber)
    else
        message = rawmessage
    end
        MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `date`) VALUES (@sender, @receiver, @message, @date)",
        {['@sender'] = xPlayernumber, ['@receiver'] = job, ['@message'] = message, ['@date'] = time})
        if gps == 1 then
            MySQL.Async.execute("INSERT INTO `phone_messages` (`sender`, `receiver`, `message`, `date`, `isgps`) VALUES (@sender, @receiver, @message, @date, @isgps)",
        {['@sender'] = xPlayernumber, ['@receiver'] = job, ['@message'] = 'GPS', ['@date'] = time, ['@isgps'] =  json.encode(position)})
        end
       Wait(100)
        if isDead == nil then
            TriggerEvent("d-phone:server:loadmessage", _source, job)
        end

        local players = ESX.GetPlayers()
        for i=1, #players, 1 do
            local zPlayer = ESX.GetPlayerFromId(players[i])
            if zPlayer.job.label == job then
                TriggerClientEvent("d-phone:client:playbusinessmessagesound", zPlayer.source)

                TriggerClientEvent("d-notification", zPlayer.source, _U("newservicemessage"))
            end        
        end

end)

-- Services

RegisterServerEvent('d-phone:server:loadservices')
AddEventHandler('d-phone:server:loadservices', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local html = ''
    MySQL.Async.fetchAll("SELECT * FROM `jobs` WHERE `handyservice` = @handyservice", {['@handyservice'] = '1'}, function(result)
        for _,v in pairs(result) do
            html = html .. string.format('<div class="phone-service" data-service="%s"><div class="phone-service-name">%s</div><div class="phone-service-actions"><i class="fas fa-chevron-right"></i></div></div>', v.label, v.label)
        end
    end)
    Wait(250)
    TriggerClientEvent("d-phone:client:loadservices", _source, html)
end)


RegisterServerEvent('d-phone:server:serviceaccept')
AddEventHandler('d-phone:server:serviceaccept', function(source, job, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local Otheridentifier = getIdentifierByPhoneNumber(number)
    getSourceFromIdentifier(Otheridentifier, function (Othersource)
        if Othersource ~= nil then
            TriggerClientEvent("d-phone:client:playbusinessmessagesound", Othersource)
            TriggerClientEvent("d-notification", Othersource, _U("serviceaccepted"), 5000)
        end
    end)

    local players = ESX.GetPlayers()
        for i=1, #players, 1 do
            local zPlayer = ESX.GetPlayerFromId(players[i])
            if zPlayer.job.label == job then
                TriggerClientEvent("d-phone:client:syncbpbabutton", zPlayer.source, number)
            end        
        end
end)

RegisterServerEvent('d-phone:server:serviceclose')
AddEventHandler('d-phone:server:serviceclose', function(source, job, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    MySQL.Async.execute("DELETE FROM `phone_messages` WHERE `receiver` = @receiver AND `sender` = @sender" , {
        ["@receiver"] = job,
        ["@sender"] = number,
    })

    MySQL.Async.execute("DELETE FROM `phone_messages` WHERE `receiver` = @receiver AND `sender` = @sender" , {
        ["@receiver"] = number,
        ["@sender"] = job,
    })

    local Otheridentifier = getIdentifierByPhoneNumber(number)

    getSourceFromIdentifier(Otheridentifier, function (Othersource)
        if Othersource ~= nil then
            TriggerClientEvent("d-phone:client:playbusinessmessagesound", Othersource)
            TriggerClientEvent("d-notification", Othersource, _U("servicedeclined"), 5000)
        end
    end)

    local players = ESX.GetPlayers()
        for i=1, #players, 1 do
            local zPlayer = ESX.GetPlayerFromId(players[i])
            if zPlayer.job.label == job then
                TriggerClientEvent("d-phone:client:syncclosebmessage", zPlayer.source, number)
            end        
        end
end)


-- Twitter
-- Twitter Functions
function GetUserTwitterAccount(identifier) 
    local accounts = MySQL.Sync.fetchAll("SELECT * FROM `phone_twitter_accounts` WHERE `identifier` = @identifier", {["@identifier"] = identifier})
    if accounts[1] ~= nil then
        return accounts[1]
    end
    return nil
end

function GetUserTwitterAccountByID(userid) 
    local accounts = MySQL.Sync.fetchAll("SELECT * FROM `phone_twitter_accounts` WHERE `userid` = @userid", {["@userid"] = userid})
    if accounts[1] ~= nil then
        return accounts[1]
    end
    return nil
end

RegisterServerEvent('d-phone:server:twitter:open')
AddEventHandler('d-phone:server:twitter:open', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local twitteracount = GetUserTwitterAccount(xPlayer.identifier)

    if twitteracount == nil then
        TriggerClientEvent("d-phone:client:twitter:openregister", _source)
    else
        TriggerEvent("d-phone:server:twitter:load", _source)
        TriggerEvent("d-phone:server:twitter:loadlikes", _source)
    end
end)

-- Twitter Register
RegisterServerEvent('d-phone:server:twitter:registeraccount')
AddEventHandler('d-phone:server:twitter:registeraccount', function(source, username, userid, avatar)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local hasid = GetUserTwitterAccountByID(userid)

    if hasid == nil then
        MySQL.Async.execute("INSERT INTO `phone_twitter_accounts` (`identifier`, `username`, `userid`, `avatar`) VALUES (@identifier, @username, @userid, @avatar)",
        {
            ['@identifier'] = xPlayer.identifier, 
            ['@username'] = username, 
            ['@userid'] = userid,
            ['@avatar'] = avatar,
        })
        TriggerClientEvent("d-phone:client:twitter:accountsuccess", _source )
        TriggerEvent("d-phone:server:twitter:load", _source )
    else
        TriggerClientEvent("d-notification", _source, _U("useralreadyexist"), red)
    end
end)

-- Twitter Get Home screens
RegisterServerEvent('d-phone:server:twitter:load')
AddEventHandler('d-phone:server:twitter:load', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local twitteracount = GetUserTwitterAccount(xPlayer.identifier)
    local tweets = {}
    local html = ""

    MySQL.Async.fetchAll("SELECT * FROM `phone_twitter_messages`", {}, function(result)
        for i,v in ipairs(result) do                
            table.insert(tweets, v)
        end
    end)
    Wait(100)
    print(tweets)
    if tweets[1] ~= nil then
        table.sort(tweets, function(a,b) return a.id < b.id end)

        for _,v in pairs(tweets) do
            if v.identifier == xPlayer.identifier then
                if v.imageurl == '0' then
                    html = html .. string.format('<div class="phone-tweet tweetme"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" class="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.id, v.id, v.likes)
                else
                    html = html .. string.format('<div class="phone-tweet tweetme"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-image"><img src=%s></div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" class="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.imageurl, v.id, v.id, v.likes)
                end
            else
                if v.imageurl == '0' then
                    html = html .. string.format('<div class="phone-tweet"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.id, v.id, v.likes)
                else
                    html = html .. string.format('<div class="phone-tweet"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-image"><img src=%s></div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.imageurl, v.id, v.id, v.likes)
                end
            end
        end
    end
    Wait(100)

    TriggerClientEvent("d-phone:client:twitter:load", _source, html, twitteracount)
end)

RegisterServerEvent('d-phone:server:twitter:refresh')
AddEventHandler('d-phone:server:twitter:refresh', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local twitteracount = GetUserTwitterAccount(xPlayer.identifier)
    local tweets = {}
    local html = ""

    MySQL.Async.fetchAll("SELECT * FROM `phone_twitter_messages`", {}, function(result)
        for i,v in ipairs(result) do                
            table.insert(tweets, v)
        end
    end)
    Wait(100)
    print(tweets)
    if tweets[1] ~= nil then
        table.sort(tweets, function(a,b) return a.id < b.id end)

        for _,v in pairs(tweets) do
            if v.identifier == xPlayer.identifier then
                if v.imageurl == '0' then
                    html = html .. string.format('<div class="phone-tweet tweetme"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" class="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.id, v.id, v.likes)
                else
                    html = html .. string.format('<div class="phone-tweet tweetme"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-image"><img src=%s></div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" class="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.imageurl, v.id, v.id, v.likes)
                end
            else
                if v.imageurl == '0' then
                    html = html .. string.format('<div class="phone-tweet"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.id, v.id, v.likes)
                else
                    html = html .. string.format('<div class="phone-tweet"><div class="phone-tweet-header"><div class="phone-tweet-usericon" style="background-image: url(%s);"></div><div class="phone-tweet-user"><div class="phone-tweet-name"> %s </div><div class="phone-tweet-id"> %s </div></div><div class="phone-tweet-date"> %s </div></div><div class="phone-tweet-message"> %s </div><div class="phone-tweet-image"><img src=%s></div><div class="phone-tweet-footer "><div class="phone-tweet-footer-like"><i class="phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart" data-id="%s"></i><font id="phone-tweet-footer-likes" data-id="%s">%s</font></div></div></div>', v.avatar, v.username, v.userid, v.date, v.message, v.imageurl, v.id, v.id, v.likes)
                end
            end
        end
    end
    Wait(100)

    TriggerClientEvent("d-phone:client:twitter:refresh", _source, html, twitteracount)
end)

-- Twitter Write Tweet
RegisterServerEvent('d-phone:server:twitter:writetweet')
AddEventHandler('d-phone:server:twitter:writetweet', function(source, message, twitteraccount, image)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")
    
    print(twitteraccount.username)
    MySQL.Async.execute("INSERT INTO `phone_twitter_messages` (`identifier`, `username`, `userid`, `avatar`, `date`, `message`, `imageurl`) VALUES (@identifier, @username, @userid, @avatar, @date, @message, @imageurl)",
        {
            ['@identifier'] = xPlayer.identifier, 
            ['@username'] = twitteraccount.username, 
            ['@userid'] = twitteraccount.userid,
            ['@avatar'] = twitteraccount.avatar,
            ['@date'] = time,
            ['@message'] = message,
            ['@imageurl'] = image,
        })
        TriggerClientEvent("d-notification", _source, _U("tweetsended"), 5000, "cyan")
    TriggerEvent("d-phone:server:twitter:load", _source)
end)

-- Twitter Tweets loadlikedtweet
RegisterServerEvent('d-phone:server:twitter:loadlikes')
AddEventHandler('d-phone:server:twitter:loadlikes', function(source, id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local likedtweets = {}

    MySQL.Async.fetchAll("SELECT * FROM `phone_twitter_likes` WHERE `identifier` = @identifier", {["@id"] = id, ["@identifier"] = xPlayer.identifier}, function(result)
        for i,v in ipairs(result) do                
            table.insert(likedtweets, v)
            print("terst")
        end
    end)
    Wait(500)

    if likedtweets[1] ~= nil then
        TriggerClientEvent("d-phone:client:twitter:loadlikes", _source, likedtweets)
    end
end)

-- Twitter Tweets liketweet
RegisterServerEvent('d-phone:server:twitter:liketweet')
AddEventHandler('d-phone:server:twitter:liketweet', function(source, id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local time = os.date("%x") .. ' ' .. os.date("%H") .. ':' .. os.date("%M")
    local players = ESX.GetPlayers()
    local alreadyliked = MySQL.Sync.fetchAll("SELECT * FROM `phone_twitter_likes` WHERE `liked` = @id AND `identifier` = @identifier", {["@id"] = id, ["@identifier"] = xPlayer.identifier})
    local likes = MySQL.Sync.fetchAll("SELECT `likes` FROM `phone_twitter_messages` WHERE `id` = @id", {["@id"] = id})
    Wait(10)
    local newlikes
    if alreadyliked[1] == nil then
        MySQL.Async.execute("INSERT INTO `phone_twitter_likes` (`identifier`, `liked`) VALUES (@identifier, @liked)",
        {
            ['@identifier'] = xPlayer.identifier, 
            ['@liked'] = id
        })
        newlikes = (likes[1].likes + 1)
        MySQL.Async.execute('UPDATE `phone_twitter_messages` SET `likes` = @likes WHERE `id` = @id', {['@likes'] =  newlikes,  ['@id'] =  id})
        TriggerClientEvent("d-notification", _source, _U("tweetliked"), 5000, "#BF0000")
    else
        MySQL.Async.execute("DELETE FROM `phone_twitter_likes` WHERE `identifier` = @identifier AND `liked` = @liked" , {
            ["@identifier"] = xPlayer.identifier,
            ["@liked"] = id,
        })

        newlikes = (likes[1].likes - 1)
        MySQL.Async.execute('UPDATE `phone_twitter_messages` SET `likes` = @likes WHERE `id` = @id', {['@likes'] = newlikes,  ['@id'] =  id})
        TriggerClientEvent("d-notification", _source, _U("tweetunliked"), 5000, "#BF0000")
    end
    for i=1, #players do
        local zPlayer = ESX.GetPlayerFromId(players[i])
        print(zPlayer.source)
        TriggerClientEvent("d-phone:client:twitter:updatelikes", zPlayer.source, id, tostring(newlikes))
    end
end)

-- Twitter Settings
-- Twitter Settings changepb
RegisterServerEvent('d-phone:server:twitter:changepb')
AddEventHandler('d-phone:server:twitter:changepb', function(source, avatar)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('UPDATE `phone_twitter_accounts` SET `avatar` = @avatar WHERE `identifier` = @id', {['@avatar'] =  avatar,  ['@id'] =  xPlayer.identifier})
    MySQL.Async.execute('UPDATE `phone_twitter_messages` SET `avatar` = @avatar WHERE `identifier` = @id', {['@avatar'] =  avatar,  ['@id'] =  xPlayer.identifier})

end)

RegisterServerEvent('d-phone:server:twitter:updateusername')
AddEventHandler('d-phone:server:twitter:updateusername', function(source, username)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('UPDATE `phone_twitter_accounts` SET `username` = @username WHERE `identifier` = @id', {['@username'] =  username,  ['@id'] =  xPlayer.identifier})
    MySQL.Async.execute('UPDATE `phone_twitter_messages` SET `username` = @username WHERE `identifier` = @id', {['@username'] =  username,  ['@id'] =  xPlayer.identifier})

end)