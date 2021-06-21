local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('teamDvm_idcard:open')
AddEventHandler('teamDvm_idcard:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive'then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('teamDvm_idcard:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "Bạn không có cái bằng nào..")
				end
			end)
		end
	end)
end)


--------------------------Usable item-------------------------
ESX.RegisterUsableItem('driver_license', function(source)
    local _source = source
    TriggerClientEvent('teamDvm_idcard:dv_license', source)
end)

ESX.RegisterUsableItem('id_card', function(source)
    local _source = source
    TriggerClientEvent('teamDvm_idcard:id_card', source)
end)