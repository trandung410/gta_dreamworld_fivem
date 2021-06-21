local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/854301248920092682/ngY4PLAo7g3JPmanolLW_daS5Cv7jy7vLzODqrCzxXh8EBx1eb7N4LEFR1xppEaY4XCV"


RegisterServerEvent('log')
AddEventHandler('log', function(data)



    local connect = {
        {
            ["color"] = "255",
            ["title"] = "Đơn Xin Việc | " ..data.plate.."-"..data.lastname,
            ["description"] = "Discord và ID: **"..data.plate.."** \n Tên Ingame: **"..data.lastname.."** \n Tuổi: **"..data.age.."** \n Kinh nghiệm Và Khung giờ: \n **"..data.why.."**\n Giới Tính: **"..data.gender.."**",
	        ["footer"] = {
                ["text"] = "Đơn xin việc Cảnh sát",
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "Xét Tuyển cảnh sát",  avatar_url = "https://static.wikia.nocookie.net/gta/images/5/5e/Sceau-lspd-gtav.png/revision/latest?cb=20140916194909&path-prefix=fr",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

