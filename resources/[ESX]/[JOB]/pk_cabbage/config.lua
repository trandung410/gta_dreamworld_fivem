Config = {}

Config.Zone = {
	Pos = { ------ จุดเกิดที่เก็บ
		x = 2055.72,
		y = 4927.79,  
		z = 39.56
	},
	Blips = { ------ จุดในเเผนที่
		Id = 501,
		Color = 2,
		Size = 0.8,
		Text = "Cabbage"
	},
}

----------อนิเมชั่นตอนทำงาน------------
Config.RequestAnimDict = 'amb@world_human_gardener_plant@male@base' -- animDict
Config.TaskPlayAnim = 'base' -- animName


-------อนิเมชั่น + ออพเจคที่ถือตอนทำงานเสร็จ -------------------
Config.RequestAnimDict2 = 'impexp_int-0' -- animDict
Config.TaskPlayAnim2 = 'mp_m_waremech_01_dual-0' -- animName
Config.prop2 = 'prop_veg_crop_03_cab' --ออฟเจ็คถือตอนตัดเสร็จ


Config.ItemCount = {1, 1}  -----จำนวนไอเทมที่ได้รับ

Config.ItemName = "cabbage" --ไอเท็มที่ได้

Config.ItemFull = 'Không thể chứa thêm' ------ข้อความของเต็ม

Config.ItemBonus = { ---- โบนัส
 	-- {
 	-- 	ItemName = "uni",  ----ชื่อไอเทม
	-- 	Label = "ไข่หอยเม่น",  ----ชื่อเลเบลไอเทม
 	-- 	ItemCount = 1,   -----จำนวนที่ได้
 	-- 	Percent = 100   -----เปอเซ็น
 	-- },
	-- {
 	-- 	ItemName = "coffee_beans",
	-- 	Label = "เมล็ดกาแฟ",
 	-- 	ItemCount = 1,
 	-- 	Percent = 100
 	-- },
 }
 
Config.ItembonusFull = ' Không thể chứa thêm ' ------ข้อความถ้าหากไอเทมโบนัสเต็ม

Config.itemuse = 'cabbageshovel' --ชื่อไอเท็มที่ใช้ทำงาน

Config.nohave = ' Bạn không có dụng cụ ' -----ข้อความถ้าหากไม่มีอุปกรณ์

Config.deleteobject = 1 --1=100%, 2=50%, 3=33%, 4=25%, 5=20% เปอเซ็นลบออพเจค

Config.object = 'prop_veg_crop_03_cab' --ออฟเจ็คงานที่ spawn บนพื้น

Config.prop = 'prop_cs_trowel' --พร๊อพถือตอนทำงาน

Config.bartext = "Đang hái..."  ---ข้อความตอนเก็บ

Config.time = 5000 -----เวลาในการเก็บ




