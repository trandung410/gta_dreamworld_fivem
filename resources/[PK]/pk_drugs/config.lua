Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.CircleZones = {
	WeedField = {
		Zone1 = {
			coords = vector3(3344.58, 5490.53, 19.9), name = "1", color = 25, sprite = 496, radius = 0.0
		},
	}
}

Config.TextHelper = "Nhấn ~INPUT_CONTEXT~ để ~b~nhặt ~g~cần sa"
Config.Model = "prop_weed_02"
Config.ItemName = "cannabis"
Config.ItemCount = {1, 1}
Config.pro = 'pk_LoadBar' -- แก้ชื่อไฟล์ได้นะครับ ตัวของ my นี้ไม่แน่ใจได้มั้ยแต่พวก carubypro หรือ progress ไรพวกนี้ใช้ได้
Config.load = "Đang hài cần sa " -- ข้อความทั้งหลอดโหลด และ แจ้งเตือน
Config.time = 2 -- เวลาที่รอ

Config.GroundValue = { 10.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 , 300.0, 400.0}

Config.CopsRequiredToSell = 0 -- จำนวนตำรวจ

Config.Delays = {
	Processing = 1000 * 10
}