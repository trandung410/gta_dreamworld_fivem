-- PM
webhook = 'https://discord.com/api/webhooks/854979295756025856/33QsNc-kUtJMtlwQWApgLt_oy4qbzKV609D1X3UHgtSiZ3N6p5exVIT9fIxmnQcUT5k9' -- Webhook URL. If you want to be more secure about your players, you might change 'none' to your webhook (in ' ') and enable logging in config.

TriggerEvent('es:addCommand', 'pm', function(source, args)
     local id = tonumber(args[1])
     local sendername = GetPlayerName(source)
     local receiver = GetPlayerName(tonumber(args[1]))
     local msg = table.concat(args, " ") 
     msg = string.gsub(msg, id, '')
     if id ~= nil and msg ~= nil then
        if GetPlayerName(id) ~= GetPlayerName(source) then
            if GetPlayerName(id) ~= nil then 
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.4); border-radius: 5px;"><i class="fas fa-sms"></i><b> '.._U('pm_send')..' {1} ({0})</b><br> {2} <br></div>',
                args = { id, receiver, msg }
            })
            TriggerClientEvent('chat:addMessage', tonumber(args[1]), {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.4); border-radius: 5px;"><i class="fas fa-sms"></i><b> '.._U('pm_receive')..' {1} ({0})</b><br> {2}<br></div>',
                args = { source, sendername, msg }
            })
            if Config.Logging then
            local headers = {
				['Content-Type'] = 'application/json'
			  }
			  local data = {
				["username"] = 'Private Message',
				["embeds"] = {{
				  ["color"] = 1752220,
				  ["timestamp"] = dateNow,
				  ['description'] = '('..GetPlayerName(source).. ' - '..GetPlayerIdentifier(source)..')\n'.._U('pm_sent_to')..':\n('..GetPlayerName(tonumber(args[1])).. ' - '..GetPlayerIdentifier(tonumber(args[1]))..')\n*'.._U('message')..':*\n***' ..msg.. '***'
				}}
			  }
              PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)	
            end
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('wrong_id') } })
           end
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('self_pm') } })
        end
     else
       TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('wrong_usage') } })
     end
 end, {help = _U('pm'), params = {{name = "id", help = _U('id')}, {name = "text", help = _U('msg')}} })