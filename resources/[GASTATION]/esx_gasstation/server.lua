ESX = nil
TriggerEvent(
    Config.ESX.ESXSHAREDOBJECT,
    function(a)
        ESX = a
    end
)
local b = {}
local c = nil
function SendWebhookMessage(d, e)
    if d ~= nil and d ~= "" then
        PerformHttpRequest(
            d,
            function(f, g, h)
            end,
            "POST",
            json.encode({content = e}),
            {["Content-Type"] = "application/json"}
        )
    end
end
Citizen.CreateThread(
    function()
        Wait(5000)
        MySQL.Sync.execute(
            [[CREATE TABLE IF NOT EXISTS `gas_station_business`( `gas_station_id` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci', `user_id` VARCHAR(50) NOT NULL, `stock` INT(10) UNSIGNED NOT NULL DEFAULT '0', `price` INT(10) UNSIGNED NOT NULL DEFAULT '0', `stock_upgrade` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0', `truck_upgrade` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0', `relationship_upgrade` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0', `money` INT(10) UNSIGNED NOT NULL DEFAULT '0', `total_money_earned` INT(10) UNSIGNED NOT NULL DEFAULT '0', `total_money_spent` INT(10) UNSIGNED NOT NULL DEFAULT '0', `gas_bought` INT(10) UNSIGNED NOT NULL DEFAULT '0', `gas_sold` INT(10) UNSIGNED NOT NULL DEFAULT '0', `distance_traveled` DOUBLE UNSIGNED NOT NULL DEFAULT '0', `total_visits` INT(10) UNSIGNED NOT NULL DEFAULT '0', `customers` INT(10) UNSIGNED NOT NULL DEFAULT '0', `timer` INT(10) UNSIGNED NOT NULL DEFAULT '0', PRIMARY KEY (`gas_station_id`) USING BTREE) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB ; CREATE TABLE IF NOT EXISTS `gas_station_balance` ( `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, `gas_station_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci', `income` BIT(1) NOT NULL, `title` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci', `amount` INT(10) UNSIGNED NOT NULL, `date` INT(10) UNSIGNED NOT NULL, PRIMARY KEY (`id`) USING BTREE ) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB ; CREATE TABLE IF NOT EXISTS `gas_station_jobs` ( `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, `gas_station_id` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci', `name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci', `reward` INT(10) UNSIGNED NOT NULL DEFAULT '0', `amount` INT(11) NOT NULL DEFAULT '0', `progress` BIT(1) NOT NULL DEFAULT b'0', PRIMARY KEY (`id`) USING BTREE ) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB ;]]
        )
        MySQL.Sync.execute("UPDATE `gas_station_jobs` SET progress = 0", {})
    end
)
local i = 1
c = true
Citizen.CreateThread(
    function()
        Wait(6000)
        for m, n in pairs(Config.gas_station_locations) do
            if not Config.gas_station_types[n.type] then
                if Config.lang == "br" then
                    print(
                        "^8[" ..
                            GetCurrentResourceName() ..
                                "] Erro detectado no seu arquivo de configuracao, o tipo '" ..
                                    n.type .. "' nao esta cadastrado em Config.gas_station_types^7"
                    )
                else
                    print(
                        "^8[" ..
                            GetCurrentResourceName() ..
                                "] Error detected in your configuration file, the type '" ..
                                    n.type .. "' is not registered in Config.gas_station_types^7"
                    )
                end
            end
        end
    end
)
Citizen.CreateThread(
    function()
        Citizen.Wait(10000)
        while Config.clear_gas_stations.active do
            local o = "SELECT gas_station_id, user_id, stock, timer FROM gas_station_business"
            local p = MySQL.Sync.fetchAll(o, {})
            for m, n in pairs(p) do
                local q = json.decode(n.stock)
                if
                    n.stock <
                        Config.gas_station_types[Config.gas_station_locations[n.gas_station_id].type].stock_capacity *
                            Config.clear_gas_stations.min_stock_amount /
                            100
                 then
                    if n.timer + Config.clear_gas_stations.cooldown * 60 * 60 < os.time() then
                        local o = "DELETE FROM `gas_station_balance` WHERE gas_station_id = @gas_station_id;"
                        MySQL.Sync.execute(o, {["@gas_station_id"] = n.gas_station_id})
                        local o = "DELETE FROM `gas_station_jobs` WHERE gas_station_id = @gas_station_id;"
                        MySQL.Sync.execute(o, {["@gas_station_id"] = n.gas_station_id})
                        local o = "DELETE FROM `gas_station_business` WHERE gas_station_id = @gas_station_id;"
                        MySQL.Sync.execute(o, {["@gas_station_id"] = n.gas_station_id})
                        SendWebhookMessage(
                            Config.webhook,
                            Lang[Config.lang]["logs_lost_low_stock"]:format(
                                n.gas_station_id,
                                n.stock,
                                os.date("%d/%m/%Y %H:%M:%S", n.timer),
                                n.user_id ..
                                    os.date(
                                        "\n[" ..
                                            Lang[Config.lang]["logs_date"] ..
                                                "]: %d/%m/%Y [" .. Lang[Config.lang]["logs_hour"] .. "]: %H:%M:%S"
                                    )
                            )
                        )
                    end
                else
                    local o = "UPDATE `gas_station_business` SET timer = @timer WHERE gas_station_id = @gas_station_id"
                    MySQL.Sync.execute(o, {["timer"] = os.time(), ["@gas_station_id"] = n.gas_station_id})
                end
                Citizen.Wait(100)
            end
            Citizen.Wait(1000 * 60 * 60)
        end
    end
)
RegisterServerEvent("gas_station:getData")
AddEventHandler(
    "gas_station:getData",
    function(r)
        if c then
            local source = source
            local s = ESX.GetPlayerFromId(source)
            local t = s.identifier
            if t then
                local o = "SELECT user_id FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
                local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})
                if query and query[1] then
                    if query[1].user_id == t then
                        openUI(source, r, false)
                    else
                        TriggerClientEvent(
                            "gas_station:Notify",
                            source,
                            "negado",
                            Lang[Config.lang]["already_has_owner"]
                        )
                    end
                else
                    local o = "SELECT gas_station_id FROM `gas_station_business` WHERE user_id = @user_id"
                    local query = MySQL.Sync.fetchAll(o, {["@user_id"] = t})
                    if query and query[1] and #query >= Config.max_stations_per_player then
                        TriggerClientEvent(
                            "gas_station:Notify",
                            source,
                            "negado",
                            Lang[Config.lang]["already_has_business"]
                        )
                    else
                        TriggerClientEvent("gas_station:openRequest", source, Config.gas_station_locations[r].buy_price)
                    end
                end
            end
        end
    end
)
RegisterServerEvent("gas_station:buyMarket")
AddEventHandler(
    "gas_station:buyMarket",
    function(r)
        if c then
            local source = source
            local s = ESX.GetPlayerFromId(source)
            local t = s.identifier
            local u = Config.gas_station_locations[r].buy_price
            if Config.ESX.account_stores == "money" or Config.ESX.account_stores == "cash" then
                money = s.getMoney()
            else
                money = s.getAccount(Config.ESX.account_stores).money
            end
            if money >= u then
                if Config.ESX.account_stores == "money" or Config.ESX.account_stores == "cash" then
                    s.removeMoney(u)
                else
                    s.removeAccountMoney(Config.ESX.account_stores, u)
                end
                local o =
                    "INSERT INTO `gas_station_business` (user_id,gas_station_id,stock,timer) VALUES (@user_id,@gas_station_id,@stock,@timer);"
                MySQL.Sync.execute(
                    o,
                    {["@gas_station_id"] = r, ["@user_id"] = t, ["@stock"] = 0, ["@timer"] = os.time()}
                )
                TriggerClientEvent("gas_station:Notify", source, "sucesso", Lang[Config.lang]["businnes_bougth"])
                SendWebhookMessage(
                    Config.webhook,
                    Lang[Config.lang]["logs_bought"]:format(
                        r,
                        t ..
                            os.date(
                                "\n[" ..
                                    Lang[Config.lang]["logs_date"] ..
                                        "]: %d/%m/%Y [" .. Lang[Config.lang]["logs_hour"] .. "]: %H:%M:%S"
                            )
                    )
                )
            else
                TriggerClientEvent(
                    "gas_station:Notify",
                    source,
                    "negado",
                    Lang[Config.lang]["insufficient_funds_store"]:format(u)
                )
            end
        end
    end
)
RegisterServerEvent("gas_station:getJob")
AddEventHandler(
    "gas_station:getJob",
    function(r)
        local source = source
        local s = ESX.GetPlayerFromId(source)
        local t = s.identifier
        if t then
            local o =
                "SELECT id,name,reward FROM gas_station_jobs WHERE gas_station_id = @gas_station_id AND progress = 0 ORDER BY id ASC"
            local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1]
            if query == nil then
                TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["no_available_jobs"])
            end
            local o = "SELECT user_id FROM gas_station_business WHERE gas_station_id = @gas_station_id"
            local v = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1]
            if v ~= nil and v.user_id == t then
                TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["cannot_do_own_job"])
                query = nil
            end
            TriggerClientEvent("gas_station:getJob", source, r, query)
        end
    end
)
RegisterServerEvent("gas_station:startJob")
AddEventHandler(
    "gas_station:startJob",
    function(r, w)
        local source = source
        if b[source] == nil then
            b[source] = true
            local o = "SELECT * FROM gas_station_jobs WHERE id = @id ORDER BY id ASC"
            local query = MySQL.Sync.fetchAll(o, {["@id"] = w})[1]
            if query.progress == 0 then
                local o = "UPDATE `gas_station_jobs` SET progress = 1 WHERE id = @id"
                MySQL.Sync.execute(o, {["@id"] = w})
                TriggerClientEvent("gas_station:startContract", source, query.amount, 0, 1, 1, query)
            else
                TriggerClientEvent("gas_station:getJob", source, r, nil)
                TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["job_already_in_progress"])
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:failed")
AddEventHandler(
    "gas_station:failed",
    function(x)
        if x then
            local o = "UPDATE `gas_station_jobs` SET progress = 0 WHERE id = @id"
            MySQL.Sync.execute(o, {["@id"] = x.id})
        end
    end
)
RegisterServerEvent("gas_station:startContract")
AddEventHandler(
    "gas_station:startContract",
    function(r, p)
        local source = source
        if b[source] == nil then
            b[source] = true
            local y = Config.gas_station_types[Config.gas_station_locations[r].type]
            p.ressuply_id = p.ressuply_id + 1
            local o =
                "SELECT truck_upgrade, relationship_upgrade, stock FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
            local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})
            if query[1].truck_upgrade >= y.ressuply[p.ressuply_id].truck_level then
                local z =
                    y.ressuply[p.ressuply_id].liters +
                    math.floor(
                        y.ressuply[p.ressuply_id].liters * y.upgrades.truck.level_reward[query[1].truck_upgrade] / 100
                    )
                if p.type == 1 then
                    local u = y.ressuply[p.ressuply_id].price_per_liter_to_import * z
                    local A = y.upgrades.relationship.level_reward[query[1].relationship_upgrade]
                    A = math.floor(u * A / 100)
                    local B = u - A
                    if tryGetMarketMoney(r, B) then
                        insertBalanceHistory(
                            r,
                            1,
                            Lang[Config.lang]["buy_products_expenses"]:format(y.ressuply[p.ressuply_id].name, z),
                            B
                        )
                        TriggerClientEvent(
                            "gas_station:startContract",
                            source,
                            z,
                            query[1].truck_upgrade,
                            p.ressuply_id,
                            p.type
                        )
                    else
                        TriggerClientEvent(
                            "gas_station:Notify",
                            source,
                            "negado",
                            Lang[Config.lang]["insufficient_funds"]
                        )
                    end
                else
                    if tonumber(query[1].stock) >= z then
                        local o =
                            "UPDATE `gas_station_business` SET stock = @stock WHERE gas_station_id = @gas_station_id"
                        MySQL.Sync.execute(o, {["@gas_station_id"] = r, ["@stock"] = tonumber(query[1].stock) - z})
                        TriggerClientEvent(
                            "gas_station:startContract",
                            source,
                            z,
                            query[1].truck_upgrade,
                            p.ressuply_id,
                            p.type
                        )
                    else
                        TriggerClientEvent(
                            "gas_station:Notify",
                            source,
                            "negado",
                            Lang[Config.lang]["not_enought_stock"]
                        )
                    end
                end
            else
                TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["upgrade_your_truck"])
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:finishContract")
AddEventHandler(
    "gas_station:finishContract",
    function(r, z, C, D, type, x)
        local source = source
        local o =
            "SELECT stock, truck_upgrade, stock_upgrade FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
        local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})
        local E = query[1].stock
        if x then
            D = 0
            z = tonumber(x.amount)
            local s = ESX.GetPlayerFromId(source)
            if Config.ESX.account_stores == "money" or Config.ESX.account_stores == "cash" then
                s.addMoney(tonumber(x.reward) or 0)
            else
                s.addAccountMoney(Config.ESX.account_stores, tonumber(x.reward) or 0)
            end
            local o = "DELETE FROM `gas_station_jobs` WHERE id = @id;"
            MySQL.Sync.execute(o, {["@id"] = x.id})
        end
        if type == 1 then
            if
                query[1].stock + z <=
                    Config.gas_station_types[Config.gas_station_locations[r].type].stock_capacity +
                        Config.gas_station_types[Config.gas_station_locations[r].type].upgrades.stock.level_reward[
                            query[1].stock_upgrade
                        ]
             then
                E = E + z
            else
                z =
                    Config.gas_station_types[Config.gas_station_locations[r].type].stock_capacity +
                    Config.gas_station_types[Config.gas_station_locations[r].type].upgrades.stock.level_reward[
                        query[1].stock_upgrade
                    ] -
                    query[1].stock
                E = E + z
                TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["stock_full"])
            end
            local o =
                "UPDATE `gas_station_business` SET stock = @stock, gas_bought = gas_bought + @amount, distance_traveled = distance_traveled + @distance WHERE gas_station_id = @gas_station_id"
            MySQL.Sync.execute(o, {["@gas_station_id"] = r, ["@stock"] = E, ["@amount"] = z, ["@distance"] = D})
        else
            local u =
                Config.gas_station_types[Config.gas_station_locations[r].type].ressuply[C].price_per_liter_to_export * z
            giveMarketMoney(r, u)
            local o =
                "UPDATE `gas_station_business` SET distance_traveled = distance_traveled + @distance, total_money_earned = total_money_earned + @price WHERE gas_station_id = @gas_station_id"
            MySQL.Sync.execute(o, {["@gas_station_id"] = r, ["@distance"] = D, ["@price"] = u})
            insertBalanceHistory(
                r,
                0,
                Lang[Config.lang]["exported_income"]:format(
                    Config.gas_station_types[Config.gas_station_locations[r].type].ressuply[C].name,
                    z
                ),
                u
            )
        end
    end
)
RegisterServerEvent("gas_station:createJob")
AddEventHandler(
    "gas_station:createJob",
    function(r, p)
        local source = source
        if b[source] == nil then
            b[source] = true
            local o = "SELECT COUNT(id) as qtd FROM gas_station_jobs WHERE gas_station_id = @gas_station_id"
            local F = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1].qtd
            if F < 50 then
                local o =
                    "SELECT relationship_upgrade FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
                local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})
                local u =
                    Config.gas_station_types[Config.gas_station_locations[r].type].ressuply_deliveryman.price_per_liter *
                    p.amount
                local A =
                    Config.gas_station_types[Config.gas_station_locations[r].type].upgrades.relationship.level_reward[
                    query[1].relationship_upgrade
                ]
                A = math.floor(u * A / 100)
                local B = p.reward + u - A
                if tryGetMarketMoney(r, B) then
                    local o =
                        "INSERT INTO `gas_station_jobs` (gas_station_id,name,reward,amount) VALUES (@gas_station_id,@name,@reward,@amount);"
                    MySQL.Sync.execute(
                        o,
                        {["@gas_station_id"] = r, ["@name"] = p.name, ["@reward"] = p.reward, ["@amount"] = p.amount}
                    )
                    insertBalanceHistory(r, 1, Lang[Config.lang]["create_job_expenses"]:format(p.name), B)
                    openUI(source, r, true)
                else
                    TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["insufficient_funds"])
                end
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:deleteJob")
AddEventHandler(
    "gas_station:deleteJob",
    function(r, p)
        local source = source
        if b[source] == nil then
            b[source] = true
            local o = "SELECT name,reward,amount,progress FROM `gas_station_jobs` WHERE id = @id;"
            query = MySQL.Sync.fetchAll(o, {["@id"] = p.job_id})
            if query[1] then
                if query[1].progress == 0 then
                    local o = "DELETE FROM `gas_station_jobs` WHERE id = @id;"
                    MySQL.Sync.execute(o, {["@id"] = p.job_id})
                    local o =
                        "SELECT relationship_upgrade FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
                    local v = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})
                    local u =
                        Config.gas_station_types[Config.gas_station_locations[r].type].ressuply_deliveryman.price_per_liter *
                        query[1].amount
                    local A =
                        Config.gas_station_types[Config.gas_station_locations[r].type].upgrades.relationship.level_reward[
                        v[1].relationship_upgrade
                    ]
                    A = math.floor(u * A / 100)
                    local B = query[1].reward + u - A
                    local o =
                        "UPDATE `gas_station_business` SET total_money_spent = total_money_spent - @amount WHERE gas_station_id = @gas_station_id"
                    MySQL.Sync.execute(o, {["@amount"] = B, ["@gas_station_id"] = r})
                    giveMarketMoney(r, B)
                    insertBalanceHistory(r, 0, Lang[Config.lang]["create_job_income"]:format(query[1].name), B)
                    openUI(source, r, true)
                else
                    TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["cant_delete_job"])
                end
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:applyPrice")
AddEventHandler(
    "gas_station:applyPrice",
    function(r, p)
        local source = source
        if b[source] == nil then
            b[source] = true
            local s = ESX.GetPlayerFromId(source)
            local t = s.identifier
            if t then
                local o = "UPDATE `gas_station_business` SET price = @price WHERE gas_station_id = @gas_station_id"
                MySQL.Sync.execute(o, {["@gas_station_id"] = r, ["@price"] = p.value})
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:buyUpgrade")
AddEventHandler(
    "gas_station:buyUpgrade",
    function(r, p)
        local source = source
        if b[source] == nil then
            b[source] = true
            local s = ESX.GetPlayerFromId(source)
            local t = s.identifier
            if t then
                local o =
                    "SELECT " .. p.id .. "_upgrade FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
                local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1]
                if query[p.id .. "_upgrade"] < 5 then
                    local z = Config.gas_station_types[Config.gas_station_locations[r].type].upgrades[p.id].price
                    if tryGetMarketMoney(r, z) then
                        local o =
                            "UPDATE `gas_station_business` SET " ..
                            p.id .. "_upgrade = " .. p.id .. "_upgrade + 1 WHERE gas_station_id = @gas_station_id"
                        MySQL.Sync.execute(o, {["@gas_station_id"] = r})
                        insertBalanceHistory(
                            r,
                            1,
                            Lang[Config.lang]["upgrade_expenses"]:format(Lang[Config.lang][p.id .. "_upgrade"]),
                            z
                        )
                        openUI(source, r, true)
                    else
                        TriggerClientEvent(
                            "gas_station:Notify",
                            source,
                            "negado",
                            Lang[Config.lang]["insufficient_funds"]
                        )
                    end
                else
                    TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["max_level"])
                end
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:withdrawMoney")
AddEventHandler(
    "gas_station:withdrawMoney",
    function(r)
        local source = source
        if b[source] == nil then
            b[source] = true
            local s = ESX.GetPlayerFromId(source)
            local t = s.identifier
            if t then
                local o = "SELECT money FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
                local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1]
                local z = tonumber(query.money)
                if z and z > 0 then
                    local o = "UPDATE `gas_station_business` SET money = 0 WHERE gas_station_id = @gas_station_id"
                    MySQL.Sync.execute(o, {["@gas_station_id"] = r})
                    if Config.ESX.account_stores == "money" or Config.ESX.account_stores == "cash" then
                        s.addMoney(z)
                    else
                        s.addAccountMoney(Config.ESX.account_stores, z)
                    end
                    insertBalanceHistory(r, 1, Lang[Config.lang]["money_withdrawn"], z)
                    TriggerClientEvent("gas_station:Notify", source, "sucesso", Lang[Config.lang]["money_withdrawn"])
                    SendWebhookMessage(
                        Config.webhook,
                        Lang[Config.lang]["logs_money_withdrawn"]:format(
                            r,
                            z,
                            t ..
                                os.date(
                                    "\n[" ..
                                        Lang[Config.lang]["logs_date"] ..
                                            "]: %d/%m/%Y [" .. Lang[Config.lang]["logs_hour"] .. "]: %H:%M:%S"
                                )
                        )
                    )
                    openUI(source, r, true)
                end
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
RegisterServerEvent("gas_station:depositMoney")
AddEventHandler("gas_station:depositMoney", function(r,data)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local amount = tonumber(data.amount)
		if amount and amount > 0 then
			money = xPlayer.getAccount('bank').money
			if money >= amount then
				if Config.ESX.account_stores == "money" or Config.ESX.account_stores == "cash" then
                    xPlayer.removeMoney(Config.ESX.account_stores, amount)
                else
                    xPlayer.removeAccountMoney(Config.ESX.account_stores, amount)
                end
                giveMarketMoney(r, amount)
                insertBalanceHistory(r, 0, Lang[Config.lang]["money_deposited"], amount)
                TriggerClientEvent("gas_station:Notify", source,"sucesso",Lang[Config.lang]["money_deposited"])
                openUI(source, r, true)
			else
				TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficiente_money'])
			end
		else
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['invalid_value'])
		end
	end
end)

RegisterServerEvent("gas_station:sellMarket")
AddEventHandler(
    "gas_station:sellMarket",
    function(r)
        local source = source
        if b[source] == nil then
            b[source] = true
            local s = ESX.GetPlayerFromId(source)
            local t = s.identifier
            if t then
                local o = "SELECT user_id FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
                local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1]
                if query.user_id == t then
                    local o = "DELETE FROM `gas_station_business` WHERE gas_station_id = @gas_station_id;"
                    MySQL.Sync.execute(o, {["@gas_station_id"] = r})
                    local o = "DELETE FROM `gas_station_balance` WHERE gas_station_id = @gas_station_id;"
                    MySQL.Sync.execute(o, {["@gas_station_id"] = r})
                    local o = "DELETE FROM `gas_station_jobs` WHERE gas_station_id = @gas_station_id;"
                    MySQL.Sync.execute(o, {["@gas_station_id"] = r})
                    if Config.ESX.account_stores == "money" or Config.ESX.account_stores == "cash" then
                        s.addMoney(Config.gas_station_locations[r].sell_price)
                    else
                        s.addAccountMoney(Config.ESX.account_stores, Config.gas_station_locations[r].sell_price)
                    end
                    TriggerClientEvent("gas_station:Notify", source, "sucesso", Lang[Config.lang]["store_sold"])
                    SendWebhookMessage(
                        Config.webhook,
                        Lang[Config.lang]["logs_close"]:format(
                            r,
                            t ..
                                os.date(
                                    "\n[" ..
                                        Lang[Config.lang]["logs_date"] ..
                                            "]: %d/%m/%Y [" .. Lang[Config.lang]["logs_hour"] .. "]: %H:%M:%S"
                                )
                        )
                    )
                else
                    TriggerClientEvent("gas_station:Notify", source, "negado", Lang[Config.lang]["sell_error"])
                end
            end
            SetTimeout(
                500,
                function()
                    b[source] = nil
                end
            )
        end
    end
)
function giveMarketMoney(user_id, amount)
    local o = "UPDATE `gas_station_business` SET money = money + @amount WHERE gas_station_id = @gas_station_id"
    MySQL.Sync.execute(o, {["@amount"] = amount, ["@gas_station_id"] = user_id})
end

function tryGetMarketMoney(user_id, amount)
    local o = "SELECT money FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
    local query = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = user_id})[1]
    if tonumber(query.money) >= amount then
        local o =
            "UPDATE `gas_station_business` SET money = @money, total_money_spent = total_money_spent + @amount WHERE gas_station_id = @gas_station_id"
        MySQL.Sync.execute(o, {["@money"] = tonumber(query.money) - amount, ["@amount"] = amount, ["@gas_station_id"] = user_id})
        return true
    else
        return false
    end
end

function insertBalanceHistory(G, H, I, z)
    local o =
        "INSERT INTO `gas_station_balance` (gas_station_id,income,title,amount,date) VALUES (@gas_station_id,@income,@title,@amount,@date)"
    MySQL.Sync.execute(
        o,
        {["@gas_station_id"] = G, ["@income"] = H, ["@title"] = I, ["@amount"] = z, ["@date"] = os.time()}
    )
end
function openUI(source, r, J)
    local query = {}
    local s = ESX.GetPlayerFromId(source)
    local t = s.identifier
    if t then
        local o = "SELECT * FROM `gas_station_business` WHERE gas_station_id = @gas_station_id"
        query.gas_station_business = MySQL.Sync.fetchAll(o, {["@gas_station_id"] = r})[1]
        local o = "SELECT * FROM `gas_station_jobs` WHERE gas_station_id = @gas_station_id"
        query.gas_station_jobs =
            MySQL.Sync.fetchAll(o, {["@gas_station_id"] = query.gas_station_business.gas_station_id})
        local o = "SELECT * FROM `gas_station_balance` WHERE gas_station_id = @gas_station_id ORDER BY id DESC"
        query.gas_station_balance =
            MySQL.Sync.fetchAll(o, {["@gas_station_id"] = query.gas_station_business.gas_station_id})
        query.config = {}
        query.config.format = deepcopy(Config.format)
        query.config.lang = deepcopy(Config.lang)
        query.config.gas_station_locations = deepcopy(Config.gas_station_locations[r])
        query.config.gas_station_types = deepcopy(Config.gas_station_types[Config.gas_station_locations[r].type])
        query.config.warning = 0
        if
            query.gas_station_business.stock <
                Config.gas_station_types[Config.gas_station_locations[r].type].stock_capacity *
                    Config.clear_gas_stations.min_stock_amount /
                    100
         then
            query.config.warning = 1
        else
            local o = "UPDATE `gas_station_business` SET timer = @timer WHERE gas_station_id = @gas_station_id"
            MySQL.Sync.execute(o, {["timer"] = os.time(), ["@gas_station_id"] = r})
        end
        TriggerClientEvent("gas_station:open", source, query, J)
    end
end
function tablelength(K)
    local F = 0
    for L in pairs(K) do
        F = F + 1
    end
    return F
end
function deepcopy(M)
    local N = type(M)
    local O
    if N == "table" then
        O = {}
        for P, Q in next, M, nil do
            O[deepcopy(P)] = deepcopy(Q)
        end
        setmetatable(O, deepcopy(getmetatable(M)))
    else
        O = M
    end
    return O
end
RegisterServerEvent("gas_station:vehicleLock")
AddEventHandler(
    "gas_station:vehicleLock",
    function()
        local source = source
        TriggerClientEvent("gas_station:vehicleClientLock", source)
    end
)
local R = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function dec(p)
    p = string.gsub(p, "[^" .. R .. "=]", "")
    return p:gsub(
        ".",
        function(S)
            if S == "=" then
                return ""
            end
            local T, U = "", R:find(S) - 1
            for V = 6, 1, -1 do
                T = T .. (U % 2 ^ V - U % 2 ^ (V - 1) > 0 and "1" or "0")
            end
            return T
        end
    ):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(S)
            if #S ~= 8 then
                return ""
            end
            local W = 0
            for V = 1, 8 do
                W = W + (S:sub(V, V) == "1" and 2 ^ (8 - V) or 0)
            end
            return string.char(W)
        end
    )
end
function print_table(X)
    local function Y(Z)
        local _ = ""
        for V = 1, Z do
            _ = _ .. "\t"
        end
        return _
    end
    local a0, a1, a2 = {}, {}, {}
    local a3 = 1
    local a4 = "{\n"
    if type(X) == "table" then
        while true do
            local a5 = 0
            for m, n in pairs(X) do
                a5 = a5 + 1
            end
            local a6 = 1
            for m, n in pairs(X) do
                if a0[X] == nil or a6 >= a0[X] then
                    if string.find(a4, "}", a4:len()) then
                        a4 = a4 .. ",\n"
                    elseif not string.find(a4, "\n", a4:len()) then
                        a4 = a4 .. "\n"
                    end
                    table.insert(a2, a4)
                    a4 = ""
                    local r
                    if type(m) == "number" or type(m) == "boolean" then
                        r = "[" .. tostring(m) .. "]"
                    else
                        r = "['" .. tostring(m) .. "']"
                    end
                    if type(n) == "number" or type(n) == "boolean" then
                        a4 = a4 .. Y(a3) .. r .. " = " .. tostring(n)
                    elseif type(n) == "table" then
                        a4 = a4 .. Y(a3) .. r .. " = {\n"
                        table.insert(a1, X)
                        table.insert(a1, n)
                        a0[X] = a6 + 1
                        break
                    else
                        a4 = a4 .. Y(a3) .. r .. " = '" .. tostring(n) .. "'"
                    end
                    if a6 == a5 then
                        a4 = a4 .. "\n" .. Y(a3 - 1) .. "}"
                    else
                        a4 = a4 .. ","
                    end
                else
                    if a6 == a5 then
                        a4 = a4 .. "\n" .. Y(a3 - 1) .. "}"
                    end
                end
                a6 = a6 + 1
            end
            if #a1 > 0 then
                X = a1[#a1]
                a1[#a1] = nil
                a3 = a0[X] == nil and a3 + 1 or a3 - 1
            else
                break
            end
        end
        table.insert(a2, a4)
        a4 = table.concat(a2)
    else
        a4 = X
    end
    print(a4)
end
