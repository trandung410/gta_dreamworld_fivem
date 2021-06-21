local trunkData = nil

RegisterNetEvent("esx_inventoryhud:openSocietyInventory")
AddEventHandler(
    "esx_inventoryhud:openSocietyInventory",
    function()
        refreshSocietyInventory()
        openSocietyInventory()
    end
)

function refreshSocietyInventory()
    ESX.TriggerServerCallback(
        "lr_societydata:callback:getData",
        function(inventory)
            setSocietyInventoryData(inventory)
        end
    )
end

function setSocietyInventoryData(data)
    items = {}

    local sAccounts = data.accounts
    local sWeapons = data.weapons
    local sItems = data.items

    for k, v in pairs(sAccounts) do 
        if v > 0 then
            table.insert(items, {
                label = k,
                count = v,
                type = "item_account",
                name = k,
                usable = false,
                rare = false,
                limit = -1,
                canRemove = false
            })
        end
    end

    for k, v in pairs(sItems) do 
        table.insert(items, {
            name = v.name,
            label = v.name,
            count = v.count,
            type = "item_standard",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false,
        })
    end

    for k, v in pairs(sWeapons) do 
        table.insert(items, {
            label = v.name,
            limit = -1,
            count = v.count,
            type = "item_weapon",
            name = v.name,
            usable = false,
            rare = false,
            canRemove = false,
        })
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openSocietyInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "society"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoSociety",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("lr_societydata:server:putItem", data.item, count)
        end

        Wait(250)
        refreshSocietyInventory()
        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromSociety",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("lr_societydata:server:getItem", data.item, tonumber(data.number))
        end

        Wait(250)
        refreshSocietyInventory()
        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

