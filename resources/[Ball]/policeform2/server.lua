ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getInfo(source)

	local identifier = getPlayersIdentifier(source)
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local info = result[1]

		return info
	else
		return nil
	end
end

function getPlayersIdentifier(id)
	if ESX_VERSION >= 1.2 then
		local identifier = GetPlayerIdentifiers(id)[2]
		local cutIdentifier = string.gsub(identifier, "license:", "")
		return cutIdentifier
	else
		local identifier = GetPlayerIdentifiers(id)[1]
		return identifier
	end
end

ESX.RegisterServerCallback('strin_jobform:getInfo', function(source, cb) 
	local info = getInfo(source)
    cb(info)
end)

RegisterServerEvent('strin_jobform:sendWebhook')
AddEventHandler('strin_jobform:sendWebhook', function(data)
	local job = data.job
	local label = data.label
	local info = getInfo(source)
	local headers = {
		['Content-Type'] = 'application/json'
	}
	local data = {
		["username"] = label,
		["embeds"] = {{
		  	["color"] = 3447003,
		  	['description'] = '📝**Đơn Xin Việc**📝\nHọ: '..info['firstname']..'\nTên: '..info['lastname']..'\nNgày sinh: '..info['dateofbirth']..'\nGiới Tính: '..info['sex']..'\nSố điện thoại: '..info['phone_number']..'\n \nTên Discord và ID?\n'..data.wayjoc..'\n \nKinh nghiệm và khung giờ làm việc\n'..data.tuaby,
		  	["footer"] = {
			  	["text"] = info['name']
		  	}
		}}
	}
	PerformHttpRequest(WEBHOOKS[job], function(err, text, headers) end, 'POST', json.encode(data), headers)
end)
