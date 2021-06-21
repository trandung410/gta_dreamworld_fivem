ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function ExecuteSql(wait, query, cb)
	local rtndata = {}
    local waiting = true

	MySQL.Async.fetchAll(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
    end
    
	return rtndata
end

banks = {}
Citizen.CreateThread(function()
    local ready = 0
    local buis = 0
    local cur = 0
    local sav = 0
    local gang = 0

    ExecuteSql(true, "SELECT * FROM `banks`", function(bankssql)
        for k, v in pairs(bankssql) do
            local coords = json.decode(v.coords)
            if v.moneyBags ~= nil then
                moneyBags = json.decode(v.moneyBags)
            else
                moneyBags = nil
            end
            banks[tonumber(v.id)] = { ['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['bankOpen'] = v.bankOpen, ['bankCooldown'] = v.bankCooldown, ['bankType'] = v.bankType, ['moneyBags'] = moneyBags }
        end
        ready = ready + 1
    end)

    ExecuteSql(true, "SELECT * FROM `bank_accounts` WHERE `account_type` = 'Buisness'", function(accts)
        buis = #accts
        if accts[1] ~= nil then
            for k, v in pairs(accts) do
                local acctType = v.buisness
                if buisnessAccounts[acctType] == nil then
                    buisnessAccounts[acctType] = {}
                end
                buisnessAccounts[acctType][tonumber(v.buisnessid)] = generateBuisnessAccount(tonumber(v.account_number), tonumber(v.sort_code), tonumber(v.buisnessid))
                while buisnessAccounts[acctType][tonumber(v.buisnessid)] == nil do Wait(0) end
            end
        end
        ready = ready + 1
    end)

    ExecuteSql(true, "SELECT * FROM `bank_accounts` WHERE `account_type` = 'Savings'", function(savings)
        sav = #savings
        if savings[1] ~= nil then
            for k, v in pairs(savings) do
                savingsAccounts[v.citizenid] = generateSavings(v.citizenid)
            end
        end
        ready = ready + 1
    end)

    ExecuteSql(true, "SELECT * FROM `bank_accounts` WHERE `account_type` = 'Gang'", function(gangs)
        gang = #gangs
        if gangs[1] ~= nil then
            for k, v in pairs(gangs) do
                gangAccounts[v.gangid] = loadGangAccount(v.gangid)
            end
        end
        ready = ready + 1
    end)

    repeat Wait(0) until ready == 5
    local totalAccounts = (buis + cur + sav + gang)
end)

exports('buisness', function(acctType, bid)
    if buisnessAccounts[acctType] then
        if buisnessAccounts[acctType][tonumber(bid)] then
            return buisnessAccounts[acctType][tonumber(bid)]
        end
    end
end)

RegisterServerEvent('rl-banking:server:modifyBank')
AddEventHandler('rl-banking:server:modifyBank', function(bank, k, v)
    if banks[tonumber(bank)] then
        banks[tonumber(bank)][k] = v
        TriggerClientEvent('rl-banking:client:syncBanks', -1, banks)
    end
end)

exports('modifyBank', function(bank, k, v)
    TriggerEvent('rl-banking:server:modifyBank', bank, k, v)
end)

exports('registerAccount', function(cid)
    local _cid = tonumber(cid)
    currentAccounts[_cid] = generateCurrent(_cid)
end)

exports('current', function(cid)
    if currentAccounts[cid] then
        return currentAccounts[cid]
    end
end)

exports('debitcard', function(cardnumber)
    if bankCards[tonumber(cardnumber)] then
        return bankCards[tonumber(cardnumber)]
    else
        return false
    end
end)

exports('savings', function(cid)
    if savingsAccounts[cid] then
        return savingsAccounts[cid]
    end
end)

exports('gang', function(gid)
    if gangAccounts[cid] then
        return gangAccounts[cid]
    end
end)

ESX.RegisterServerCallback('rl-banking:server:requestBanks', function(source, cb)
    repeat Wait(0) until banks ~= nil
    cb(banks)
end)

ESX.RegisterServerCallback('rl-banking:server:checkMoneyBagCount', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    cb(xPlayer.Functions.GetItemByName('moneybag').count)
end)



AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
       return
    end
end)

function checkAccountExists(acct, sc)
    local success
    local cid
    local processed = false
    ExecuteSql(true, "SELECT * FROM `user` WHERE `account_number` = '" .. acct .. "' AND `sort_code` = '" .. sc .. "'", function(exists)
        if exists[1] ~= nil then 
            success = true
            cid = exists[1].identifier
            actype = exists[1].account_type
        else
            success = false
            cid = false
            actype = false
        end
        processed = true
    end)
    repeat Wait(0) until processed == true
    return success, cid, actype
end

RegisterServerEvent('rl-banking:createNewCard')
AddEventHandler('rl-banking:createNewCard', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer ~= nil then
        local cid = xPlayer.identifier
        if (cid) then
            MySQL.Async.execute("UPDATE bank_cards SET cardNumber = @cardNumber, cardType = @cardType, cardActive = @cardActive WHERE steamid = @steamid", {
                ['@cardNumber'] = math.random(1000000000000000,9999999999999999),
                ['@cardType'] = Config.cardTypes[math.random(1,#Config.cardTypes)],
                ['@cardActive'] = 'true',
                ['@steamid'] = cid
            }, function(rowsChanged)
            end)
            TriggerClientEvent('rl-banking:openBankScreen', src)
        end
    end
end)

RegisterServerEvent('rl-banking:createNewAccount')
AddEventHandler('rl-banking:createNewAccount', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local Identifier = Player.identifier
    local character = GetCharacter(src)

    if character.account_number == nil or character.account_number == "" then
        local accN = math.random(11111, 55555)
        ExecuteSql(false, "UPDATE `users` SET `account_number` = '" .. accN .. "' WHERE `identifier`='" .. Identifier .. "'")
    end
end)

RegisterServerEvent('rl-base:itemUsed')
AddEventHandler('rl-base:itemUsed', function(_src, data)
    if data.item == "moneybag" then
        TriggerClientEvent('rl-banking:client:usedMoneyBag', _src, data)
    end
end)

RegisterServerEvent('rl-banking:server:unpackMoneyBag')
AddEventHandler('rl-banking:server:unpackMoneyBag', function(item)
    local _src = source
    if item ~= nil then
        local xPlayer = ESX.GetPlayerFromId(_src)
        local xPlayerCID = xPlayer.identifier
        local decode = json.decode(item.metapublic)
        --_char:Inventories():Remove().Item(item, 1)
        --_char:Cash().Add(tonumber(decode.amount))
        --TriggerClientEvent('pw:notification:SendAlert', _src, {type = "success", text = "The cashier has counted your money bag and gave you $"..decode.amount.." cash.", length = 5000})
    end
end)

function getCharacterName(cid)
    local name
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `cid` = @cid", {['@cid'] = cid}, function(exists)
        if exists[1] ~= nil then 
            name = exists[1].firstname..' '..exists[1].lastname
        else
            name = false
        end
    end)
    while name == nil do Wait(0) end
    return name
end

RegisterServerEvent('rl-banking:initiateTransfer')
AddEventHandler('rl-banking:initiateTransfer', function(data)

    local _src = source
    local _startChar = ESX.GetPlayerFromId(_src)
    while _startChar == nil do Wait(0) end

    local checkAccount, cid, acType = checkAccountExists(data.account, data.sortcode)
    while checkAccount == nil do Wait(0) end

    if (checkAccount) then 
        local receiptName = getCharacterName(cid)
        while receiptName == nil do Wait(0) end

        if receiptName ~= false or receiptName ~= nil then 
            local userOnline = NetworkPlayerGetName(cid)
            
            if userOnline ~= false then
                -- User is online so we can do a straght transfer 
                -- local _targetUser = exports.rl-base:Source(userOnline)
                if acType == "Current" then
                    -- local targetBank = _targetUser:Bank().Add(data.amount, 'Bank Transfer from '.._startChar.GetName())
                    -- while targetBank == nil do Wait(0) end
                    -- local bank = _startChar:Bank().Remove(data.amount, 'Bank Transfer to '..receiptName)
                    _startChar.removeAccountMoney('bank', tonumber(data.amount))
				    targetBank.addAccountMoney('bank', tonumber(data.amount))
                    TriggerClientEvent('pw:notification:SendAlert', _src, {type = "inform", text = "You have sent a bank transfer to "..receiptName..' for the amount of $'..data.amount, length = 5000})
                    TriggerClientEvent('pw:notification:SendAlert', userOnline, {type = "inform", text = "You have received a bank transfer from ".._startChar.GetName()..' for the amount of $'..data.amount, length = 5000})
                    TriggerClientEvent('rl-banking:openBankScreen', _src)
                    TriggerClientEvent('rl-banking:successAlert', _src, 'You have sent a bank transfer to '..receiptName..' for the amount of $'..data.amount)
                else
                    -- local targetBank = savingsAccounts[cid].AddMoney(data.amount, 'Bank Transfer from '.._startChar.GetName())
                    -- while targetBank == nil do Wait(0) end
                    -- local bank = _startChar:Bank().Remove(data.amount, 'Bank Transfer to '..receiptName)
                    _startChar.removeAccountMoney('bank', tonumber(data.amount))
				    targetBank.addAccountMoney('bank', tonumber(data.amount))
                    TriggerClientEvent('pw:notification:SendAlert', _src, {type = "inform", text = "You have sent a bank transfer to "..receiptName..' for the amount of $'..data.amount, length = 5000})
                    TriggerClientEvent('pw:notification:SendAlert', userOnline, {type = "inform", text = "You have received a bank transfer from ".._startChar.GetName()..' for the amount of $'..data.amount, length = 5000})
                    TriggerClientEvent('rl-banking:openBankScreen', _src)
                    TriggerClientEvent('rl-banking:successAlert', _src, 'You have sent a bank transfer to '..receiptName..' for the amount of $'..data.amount)
                end
                
            else
                -- User is not online so we need to manually adjust thier bank balance.
                    MySQL.Async.fetchScalar("SELECT `amount` FROM `bank_accounts` WHERE `account_number` = @an AND `sort_code` = @sc AND `character_id` = @cid", {
                        ['@an'] = data.account,
                        ['@sc'] = data.sortcode,
                        ['@cid'] = cid
                    }, function(currentBalance)
                        if currentBalance ~= nil then
                            local newBalance = currentBalance + data.amount
                            if newBalance ~= currentBalance then
                                MySQL.Async.execute("UPDATE `bank_accounts` SET `amount` = @newBalance WHERE `account_number` = @an AND `sort_code` = @sc AND `character_id` = @cid", {
                                    ['@an'] = data.account,
                                    ['@sc'] = data.sortcode,
                                    ['@cid'] = cid,
                                    ['@newBalance'] = newBalance
                                }, function(rowsChanged)
                                    if rowsChanged == 1 then
                                        local time = os.date("%Y-%m-%d %H:%M:%S")
                                        MySQL.Async.insert("INSERT INTO `bank_statements` (`account`, `character_id`, `account_number`, `sort_code`, `deposited`, `withdraw`, `balance`, `date`, `type`) VALUES (@accountty, @cid, @account, @sortcode, @deposited, @withdraw, @balance, @date, @type)", {
                                            ['@accountty'] = acType,
                                            ['@cid'] = cid,
                                            ['@account'] = data.account,
                                            ['@sortcode'] = data.sortcode,
                                            ['@deposited'] = data.amount,
                                            ['@withdraw'] = nil,
                                            ['@balance'] = newBalance,
                                            ['@date'] = time,
                                            ['@type'] = 'Bank Transfer from '.._startChar.GetName()
                                        }, function(statementUpdated)
                                            if statementUpdated > 0 then 
                                                -- local bank = _startChar:Bank().Remove(data.amount, 'Bank Transfer to '..receiptName)
                                                _startChar.removeAccountMoney('bank', tonumber(data.amount))
                                                TriggerClientEvent('pw:notification:SendAlert', _src, {type = "inform", text = "You have sent a bank transfer to "..receiptName..' for the amount of $'..data.amount, length = 5000})
                                                TriggerClientEvent('rl-banking:openBankScreen', _src)
                                                TriggerClientEvent('rl-banking:successAlert', _src, 'You have sent a bank transfer to '..receiptName..' for the amount of $'..data.amount)
                                            end
                                        end)
                                    end
                                end)
                            end
                        end
                    end)
            end
        end
    else
        -- Send error to client that account details do no exist.
        TriggerClientEvent('rl-banking:transferError', _src, 'The account details entered could not be located.')
    end
end)

function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

ESX.RegisterServerCallback('rl-banking:getBankingInformation', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local char = GetCharacter(src)
    while xPlayer == nil do Wait(0) end
        if (xPlayer) then
            local banking = {
                    ['name'] = char.firstname .. ' ' .. char.lastname,
                    ['bankbalance'] = '$'.. format_int(xPlayer.getAccount('bank').money),
                    ['cash'] = '$'.. format_int(xPlayer.getMoney()),
                    ['accountinfo'] = char.account_number,
                }
                
                if savingsAccounts[xPlayer.identifier] then
                    local cid = xPlayer.identifier
                    banking['savings'] = {
                        ['amount'] = savingsAccounts[cid].GetBalance(),
                        ['details'] = savingsAccounts[cid].getAccount(),
                        ['statement'] = savingsAccounts[cid].getStatement(),
                    }
                end

                if GetBankCards(src) ~= false then
                    banking['cardInformation'] = GetBankCardsD(src)
                end

                cb(banking)
        else
            cb(nil)
        end
end)

function GetBankCards(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local result = MySQL.Sync.fetchAll('SELECT * FROM bank_cards WHERE steamid = @steamid', {
		['@steamid'] = xPlayer.identifier
    })
    
    if result[1] ~= nil then
        return true
    else
        return false
    end
end

function GetBankCardsD(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local result = MySQL.Sync.fetchAll('SELECT * FROM bank_cards WHERE steamid = @steamid', {
		['@steamid'] = xPlayer.identifier
    })

    return result[1]
end

function GetCharacter(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local result = MySQL.Sync.fetchAll('SELECT account_number,firstname,lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    return result[1]
end

RegisterServerEvent('rl-banking:createBankCard')
AddEventHandler('rl-banking:createBankCard', function(pin)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        local cid = xPlayer.identifier
        if (cid) then
            MySQL.Async.insert("INSERT INTO `bank_cards` (`record_id`, `steamid`, `cardNumber`, `cardPin`, `cardActive`, `cardType`) VALUES (@record_id, @steamid, @cardNumber, @cardPin, @cardActive, @cardType)", {
                ['@record_id'] = math.random(500000, 10000000),
                ['@steamid'] = cid,
                ['@cardNumber'] = math.random(1000000000000000,9999999999999999),
                ['@cardPin'] = pin,
                ['@cardActive'] = 'false',
                ['@cardType'] = Config.cardTypes[math.random(1,#Config.cardTypes)]
            }, function(cardCreated)
            end)
            TriggerClientEvent('rl-banking:openBankScreen', src)
            TriggerClientEvent('rl-banking:successAlert', src, 'You have successfully ordered a Debit Card.')
        end


    end
end)

RegisterServerEvent('rl-banking:doQuickDeposit')
AddEventHandler('rl-banking:doQuickDeposit', function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    while xPlayer == nil do Wait(0) end
    local currentCash = xPlayer.getMoney()

    if tonumber(amount) <= currentCash then
        local cash = xPlayer.removeMoney(tonumber(amount))
        local bank = xPlayer.addAccountMoney('bank', tonumber(amount))
        if bank then
            TriggerClientEvent('rl-banking:openBankScreen', _src)
            TriggerClientEvent('rl-banking:successAlert', _src, 'You made a cash deposit of $'..amount..' successfully.')
            TriggerEvent('bb-logs:server:createLog', 'banking', 'Banking', 'Made a cash deposit of $'..amount..' successfully.', src)
        end
    end
end)

RegisterServerEvent('rl-banking:toggleCard')
AddEventHandler('rl-banking:toggleCard', function(toggle)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    while xPlayer == nil do Wait(0) end
    if toggle == false then
        ExecuteSql(false, "UPDATE `bank_cards` SET `cardActive` = 'false' WHERE `steamid` = '" ..xPlayer.identifier.. "'", function(rowsChanged) end)
    elseif toggle == true then
        ExecuteSql(false, "UPDATE `bank_cards` SET `cardActive` = 'true' WHERE `steamid` = '" ..xPlayer.identifier.. "'", function(rowsChanged) end)
    end
end)

RegisterServerEvent('rl-banking:doQuickWithdraw')
AddEventHandler('rl-banking:doQuickWithdraw', function(amount, branch)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    while xPlayer == nil do Wait(0) end
    local currentCash = xPlayer.getAccount('bank').money
    
    if tonumber(amount) <= currentCash then
        local cash = xPlayer.removeAccountMoney('bank', tonumber(amount))
        local bank = xPlayer.addMoney(tonumber(amount))
        if cash then 
            TriggerClientEvent('rl-banking:openBankScreen', _src)
            TriggerClientEvent('rl-banking:successAlert', _src, 'You made a cash withdrawal of $'..amount..' successfully.')
            TriggerEvent('bb-logs:server:createLog', 'banking', 'Banking', 'Made a cash withdrawal of $'..amount..' successfully.', src)
        end
    end
end)

RegisterServerEvent('rl-banking:updatePin')
AddEventHandler('rl-banking:updatePin', function(pin)
    if pin ~= nil then 
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        while xPlayer == nil do Wait(0) end

        ExecuteSql(false, "UPDATE `bank_cards` SET `cardPin` = '" .. pin .. "' WHERE `steamid` = '" ..xPlayer.identifier.. "'", function(rowsChanged) end)
        TriggerClientEvent('rl-banking:openBankScreen', src)
        TriggerClientEvent('rl-banking:successAlert', src, 'You have successfully updated your Debit card pin.')
    end
end)

RegisterServerEvent('rl-banking:savingsDeposit')
AddEventHandler('rl-banking:savingsDeposit', function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    while xPlayer == nil do Wait(0) end
    local currentBank = xPlayer.getAccount('bank').money
    
    if tonumber(amount) <= currentBank then
        local bank = xPlayer.removeAccountMoney('bank', tonumber(amount))
        local savings = savingsAccounts[xPlayer.identifier].AddMoney(tonumber(amount), 'Current Account to Savings Transfer')
        while bank == nil do Wait(0) end
        while savings == nil do Wait(0) end
        TriggerClientEvent('rl-banking:openBankScreen', src)
        TriggerClientEvent('rl-banking:successAlert', src, 'You made a savings deposit of $'..tostring(amount)..' successfully.')
        TriggerEvent('bb-logs:server:createLog', 'banking', 'Banking', 'made a savings deposit of $'..tostring(amount)..' successfully..', src)
    end
end)

RegisterServerEvent('rl-banking:savingsWithdraw')
AddEventHandler('rl-banking:savingsWithdraw', function(amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    while xPlayer == nil do Wait(0) end
    local currentSavings = savingsAccounts[xPlayer.identifier].GetBalance()
    
    if tonumber(amount) <= currentSavings then
        local savings = savingsAccounts[xPlayer.identifier].RemoveMoney(tonumber(amount), 'Savings to Current Account Transfer')
        local bank = xPlayer.addAccountMoney('bank', tonumber(amount))
        while bank == nil do Wait(0) end
        while savings == nil do Wait(0) end
        TriggerClientEvent('rl-banking:openBankScreen', src)
        TriggerClientEvent('rl-banking:successAlert', src, 'You made a savings withdrawal of $'..tostring(amount)..' successfully.')
        TriggerEvent('bb-logs:server:createLog', 'banking', 'Banking', 'Made a savings withdrawal of $'..tostring(amount)..' successfully.', src)
    end
end)

RegisterServerEvent('rl-banking:createSavingsAccount')
AddEventHandler('rl-banking:createSavingsAccount', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local success = createSavingsAccount(xPlayer.identifier)
    
    repeat Wait(0) until success ~= nil
    TriggerClientEvent('rl-banking:openBankScreen', src)
    TriggerClientEvent('rl-banking:successAlert', src, 'You have successfully opened a savings account.')
    TriggerEvent('bb-logs:server:createLog', 'banking', 'Banking', "Created new saving account", src)
end)