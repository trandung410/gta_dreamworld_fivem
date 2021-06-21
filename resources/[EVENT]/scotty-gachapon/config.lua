--[[
	file: config.lua
	resource: scotty-gachapon
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

Config = {}
Config["debug"] = true -- Chế độ phát triển
Config["wheel_duration"] = 10 -- Khoảng thời gian cần thiết để mở gacha
Config["wheel_delay_award"] = true -- Đưa những thứ trong gacha vào cuối wheel_duration
Config["gachapon_broadcast"] = true -- Đăng trò chuyện khi ai đó nhận được thứ? ?

Config["gachapon_broadcast_top_message"] = true -- Thông báo giải thưởng là văn bản trên. Battle X
Config["gachapon_broadcast_top_message_duration"] = 2500 -- Thời gian thông báo

Config["gachapon_broadcast_tier_limit"] = { -- Thông báo khi nhận được cấp nào
	[1] = false, -- Common
	[2] = false, -- Rare
	[3] = false, -- Epic
	[4] = true, -- Unique
	[5] = true, -- Legendary
	[6] = true,
	[7] = true,
}
Config["vehicle_plate_length_text"] = 3 -- Chiều dài của biển số xe mà chữ sẽ được hiển thị
Config["vehicle_plate_length_number"] = 3 -- Chiều dài của biển số sẽ được đánh số
Config["vehicle_plate_check"] = true -- Kiểm tra biển số và SQL để xem nó có bị trùng lặp hay không.

Config["disable_auto_check_weapon"] = false -- Tắt hệ thống để kiểm tra xem vật phẩm có phải là vũ khí hay không. (Phải được bật nếu máy chủ của bạn là một vũ khí như một vật phẩm)

--Config["vehicle_plate_func"] = function(src, hash) local text = "TEST 123" return text end -- ออกแบบป้ายทะเบียนเอง ใช้ไม่เป็นอย่าเปิดใช้โดยเด็ดขาด
--Config["vehicle_query"] = 'INSERT INTO owned_vehicles (owner, plate, vehicle, type, `stored`) VALUES (@owner, @plate, @vehicle, @type, 1)'

Config["image_source"] = "nui://esx_inventoryhud/html/img/items/"

Config["chance"] = {
	[1] = { name = "Chung", rate = 50, color = "#242424", discord_color = 2368548 },
	[2] = { name = "Thường", rate = 25, color = "blue", discord_color = 255 },
	[3] = { name = "Hiếm Có", rate = 15, color = "purple", discord_color = 8388736 },
	[4] = { name = "Sử Thi", rate = 8, color = "gold", discord_color = 13938487 },
	[5] = { name = "Độc Nhất", rate = 0.9, color = "yellow", discord_color = 65280 },
	[6] = { name = "Huyền thoại", rate = 0.6, color = "green", discord_color = 65280 },
	[7] = { name = "Thần Thoại", rate = 0.5, color = "red", discord_color = 65280 },
}

Config["gachapon"] = {
	
	["hommayman"] = {
		name = "Quả Cầu May Mắn",
		list = {
			{ item = "diamond", name = "Kim Cương", tier = 3 },
			{ item = "daxin", name = "Da Xịn", tier = 3 },
			{ item = "chi", name = "Chì", tier = 3 },
			{ item = "carbon", name = "Carbon", tier = 3 },
			{ item = "wood_pro", name = "Gỗ Quý", tier = 3 },
			{ item = "giay", name = "Giấy", tier = 3 },
			{ item = "bangsungm4", name = "Báng Súng M4A1", tier = 5 },
			{ item = "banvem4", name = "Bản Vẽ Súng M4A1", tier = 5 },
			{ item = "khuonsungm4", name = "Khuôn Súng M4A1", tier = 5 },
			{ item = "nongsungm4", name = "Nòng Súng M4A1", tier = 5 },
			{ item = "thansungm4", name = "Thân Súng M4A1", tier = 5 },
			{ vehicle = "neon", name = "Neon", tier = 5 },
			--{ item = "katana", name = "Katana", tier = 2 },
			{ money = 5000, tier = 1 },
			{ money = 10000, tier = 1 },
			{ money = 20000, tier = 2 },
			{ money = 50000, tier = 3 },
			{ money = 100000, tier = 4 },
			{ money = 150000, tier = 4 },
			{ money = 250000, tier = 4 },
			{ money = 200000, tier = 4 },
			{ money = 300000, tier = 4 },
			{ black_money = 5000, tier = 1 },
			{ black_money = 10000, tier = 1 },
			{ black_money = 20000, tier = 2 },
			{ black_money = 50000, tier = 3 },
			{ black_money = 100000, tier = 4 },
			{ black_money = 200000, tier = 4 },
			{ item = "WEAPON_ASSAULTRIFLE",name = "AK47", tier = 5},
			{ item = "WEAPON_CARBINERIFLE",name = "M416", tier = 6},
		}
	},
}

Config["discord_bot"] = "Gachapon" -- ชื่อ Bot
Config["gacha_discord"] = {
	["item"] = "",
	["weapon"] = "",
	["money"] = "",
	["vehicle"] = "",
}

Config["translate"] = {
	broadcast_header = "^3^*Gachapon: ",
	broadcast_text = "Bạn ^6^*%s ^7^rđược ^2%s ^7từ ^3%s",
	broadcast_top_text = 'Bạn <span style="color:gold;">%s</span> được <span style="color:lightgreen;">%s</span> từ <span style="color:gold;">%s</span>',
	discord_gacha_unbox = "bạn %s Mở gashapon %s Sau đó, có %s!",
	discord_identifier = "\nSteam Identifier: %s\n lần: %s",
	
	ui_you_got = "Bạn đã trúng %s!",
	ui_exit = "Thoát",
	ui_open_more = "Tiếp tục mở (%s)",
	ui_black_money = "Tiền bẩn",
}