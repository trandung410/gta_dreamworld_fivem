-- EXAMPLES
--
-- RegisterCommand("menu", function()
--     local myItems = {
--         {img = "identity.png", text = "Identity", text2 = "see your identity", callBack = function() print('identity openned') end},
--         {img = "givemoney.png", text = "Give money", text2 = "give money to the nearest player", callBack = function() print('give money openned') end},
--         {img = "bank.png", text = "Bank", text2 = "view your bank account", callBack = function() print('my bank account openned') end},
--         {img = "backpack.png", text = "Inventory", text2 = "open your Inventory", callBack = function() print('my inventory openned') end},
--     }

--     local configs = {
--         positionX   = "90%",
--         positionY   = "50%"
--     }

--     IconMenu.OpenMenu(myItems, configs)     
-- end)

-- RegisterCommand("menu2", function()
--     local myItems = {}

--     for i = 1, 10, 1 do
--         table.insert(
--             myItems,
--             {img = "myIcon.png", text = "My title item", text2 = "My description",
--             callBack = function()
-- 	            TriggerEvent("chat:addMessage", {args={"I pressed " .. i}})
--             end }
--         )
--     end

--     IconMenu.OpenMenu(myItems)
-- end)

local List = {}
local openned = false

function OpenMenu(list, configs)
    local elements = {}

    for i,k in pairs(list) do
        local image = ""
        if not string.find(k.img, "http") then
            image = "./img/"
        end

        table.insert(elements, {img = image .. k.img, text = k.text, text2 = k.text2})
    end

    List = list

    SendNUIMessage({
        elements = elements,
        configs = configs
    })

    openned = true
end

function ForceCloseMenu()
    SendNUIMessage({
        goBack = true
    })
    openned = false
end

CreateThread(function()
    Wait(5000)
    SendNUIMessage({
        config_default = config_default
    })
end)

CreateThread(function()
    while true do
        if openned then
            DisableControlAction(0, config_keys.moveUP, true)
            DisableControlAction(0, config_keys.moveDown, true)

            if IsDisabledControlJustPressed(0,config_keys.moveUP) then 
                SendNUIMessage({
                    upSelected = true
                })
            elseif IsDisabledControlJustPressed(0,config_keys.moveDown) then
                SendNUIMessage({
                    downSelected = true
                })
            elseif IsControlJustPressed(0,config_keys.enter) then
                SendNUIMessage({
                    enterSelected = true
                })
            elseif IsControlJustPressed(0,config_keys.back) then
                ForceCloseMenu()
            end
        end

        Wait(0)
    end

end)

RegisterNUICallback('enterSelected', function(data, cb)
    local selected = tonumber(data.selected)
    List[selected+1].callBack()

    cb('ok')
end)

exports("OpenMenu", OpenMenu)
exports("ForceCloseMenu", ForceCloseMenu)