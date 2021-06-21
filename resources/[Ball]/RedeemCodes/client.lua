AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:addSuggestion', '/multiGen', 'Generate multiple codes at once', {
            { name="type", help="What code you want to generate. For example: money" },
            { name="amount", help="How much (in this case money) will the player be rewarded. For example: 200" },
            { name="count", help="How many keys you want to generate. For Example: 20" }
        })
        TriggerEvent('chat:addSuggestion', '/genCode', 'Generate a reward code', {
            { name="type", help="What code you want to generate. For example: money" },
            { name="amount", help="How much (in this case money) will the player be rewarded. For example: 200" }
        })
        TriggerEvent('chat:addSuggestion', '/nhanqua', 'Redeem a reward code', {
            { name="code", help="Nhập mã quà tặng để nhận." }
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/genCode')
        TriggerEvent('chat:removeSuggestion', '/multiGen')
        TriggerEvent('chat:removeSuggestion', '/nhanqua')
    end
end)