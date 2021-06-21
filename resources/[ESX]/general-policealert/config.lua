--[[
	file: config.lua
	resource: scotty-policealert
	author: Scotty1944
	contact: https://steamcommunity.com/id/scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

Config = {}
Config["base_key"] = 19 -- ปุ่มหลักในการใช้ร่วมกับปุ่มตัวเลข เช่น ALT + 1
Config["base_key_text"] = "ALT" -- ชื่อปุ่มที่แสดงในแจ้งเตือน
Config["duration"] = 15 -- ระยะเวลาที่จะตอบรับ
Config["red_radius"] = 60.0 -- ขนาดของวงที่จะขึ้นบนแมพ เมื่อมีการแจ้งเตือน

--Config["imgurl"] = 'https://i.imgur.com/sdXoGu1.png'
Config["imgurl"] = 'https://media.discordapp.net/attachments/722009054540726342/739442191042084944/1596356720717.png?width=734&height=395'

Config["alert_section"] = {
	carjacking = true,
	melee = true,
	gunshot = true,
	drug = true,	
	fishing = true,
	burglary = true,
	thief = true,
	cement = true,
}

-- การ Setup โดยการวาง Event ที่ระบบหลัก
-- ถ้าเป็นไฟล์ Client ให้ TriggerEvent("scotty-policealert:alertNet", "thief") -- เปลี่ยน event ได้
-- ถ้าเป็นไฟล์ Server ให้ TriggerClientEvent("scotty-policealert:getalertNet", source, "thief") -- เปลี่ยน event ได้

--Possible Value: top topLeft topCenter topRight bottom bottomLeft bottomCenter bottomRight center centerLeft centerRight
Config["alert_position"] = "topRight" -- ใช้ร่วมกับ pNotify

Config["translate"] = {
	title = "",
	text = "มี <span style=\"color:red;\">%s</span> คนหนึ่งกำลัง %s อยู่ที่ <img style=\"height:1em\" src=\"https://image.flaticon.com/icons/svg/1216/1216895.svg\" alt=\"\"><span style=\"color:lightblue;\">%s</span>",
	--text = "มี <span style=\"color:red;display:none;\">%s</span> อยู่ที่ <span style=\"display:none;\">%s</span> อยู่ที่ <br><img style=\"height:1em\" src=\"https://image.flaticon.com/icons/svg/1216/1216895.svg\" alt=\"\"><span style=\"color:lightblue;\">%s</span>",
	tip = "เพื่อมาร์คไปยังจุดเกิดเหตุ",
	action_carjacking = "โจรกรรมรถยนต์",
	action_melee = "การทำร้ายร่างกาย",
	action_gunshot = "ก่อเหตุใช้อาวุธปืน",
	action_fishing = "Fishing",
	action_burglary = "Burglary House",
	action_drug = "การค้ายาเสพติด",
	action_cement = "Cement",
	action_thief = "Thief in Progress",
}