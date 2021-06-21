Config = {}
Config.FixReward = 1500
Config.MechanicOnline = 1

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function howmanymechanic(cb)
	local xPlayers = ESX.GetPlayers()
	local MechanicConnected = 0
	for i=1, #xPlayers, 1 do
	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'mechanic' then
			MechanicConnected = MechanicConnected + 1
		end
	end
	cb(MechanicConnected)
end

RegisterServerEvent('ai_mechanic:carfix')
AddEventHandler('ai_mechanic:carfix', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerMoney = 0
    local societyAccount
    playerMoney = xPlayer.getMoney()

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic',function(account)
        societyAccount = account
    end)

    if societyAccount  then
        local societyMoney
        howmanymechanic(function(MechanicConnected)
            if MechanicConnected < Config.MechanicOnline then
                if playerMoney >= Config.FixReward then
                    xPlayer.removeMoney(Config.FixReward)
                    societyAccount.addMoney(Config.FixReward)
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bạn đã trả 1500$ cho cứu hộ' })
                    TriggerClientEvent('knb:mech', source)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Chúng tôi rất tiếc nhưng vì bạn không có tiền trả nên chúng tôi sẽ không đến nơi' })
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Chúng tôi không thể đến đó, bởi vì đang có hơn 1 cứu hộ online'})
            end
        end)
    end

end)

TriggerEvent('es:addCommand', 'cuuho', function(source)
    TriggerEvent('ai_mechanic:carfix', source)
end)