Config = {

	BlipSprite = 643,
	BlipColor = 46,
	BlipText = '<FONT FACE="Montserrat">Khu chế tạo',
	
	UseLimitSystem = true, -- Enable if your esx uses limit system
	
	CraftingStopWithDistance = true, -- Crafting will stop when not near workbench
	
	ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
	
	HideWhenCantCraft = false, -- Instead of lowering the opacity it hides the item that is not craftable due to low level or wrong job
	
	Categories = {
	
	['misc'] = {
		Label = 'MISC',
		Image = 'rubber_band',
		Jobs = {}
	},
	['weapons'] = {
		Label = 'Vũ Khí',
		Image = 'assault-rifle',
		Jobs = {}
	},
	['medical'] = {
		Label = 'Cứu thương',
		Image = 'bandage',
		Jobs = {}
	},
	['nguyensung'] = {
		Label = 'NL Súng',
		Image = 'fishingrod',
		Jobs = {}
	}
	
	
	},
	
	PermanentItems = { -- Items that dont get removed when crafting
		['wrench'] = true
	},
	
	Recipes = { -- Enter Item name and then the speed value! The higher the value the more torque
	
	['WEAPON_CARBINERIFLE'] = {
		Level = 7, -- From what level this item will be craftable
		Category = 'weapons', -- The category item will be put in
		isGun = true, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, --  100% you will recieve the item
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 120, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['banvem4'] = 1, -- item name and count, adding items that dont exist in database will crash the script
			['bangsungm4'] = 1,
			['thansungm4'] = 1,
			['nongsungm4'] = 1,
			['khuonsungm4'] = 1,
		}
	}, 
	
	['banvem4'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'nguyensung', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['giay'] = 50, -- item name and count, adding items that dont exist in database will crash the script
			['wood_pro'] = 50, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	['bangsungm4'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'nguyensung', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['wood_pro'] = 50, -- item name and count, adding items that dont exist in database will crash the script
			['sattinhluyen'] = 100, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	['thansungm4'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'nguyensung', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['nhua'] = 50, -- item name and count, adding items that dont exist in database will crash the script
			['sattinhluyen'] = 100, -- item name and count, adding items that dont exist in database will crash the script
			['carbon'] = 50, -- item name and count, adding items that dont exist in database will crash the script
			['daxin'] = 50, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	['nongsungm4'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'nguyensung', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['chi'] = 50, -- item name and count, adding items that dont exist in database will crash the script
			['sattinhluyen'] = 100, -- item name and count, adding items that dont exist in database will crash the script
			['vangtinhluyen'] = 100, -- item name and count, adding items that dont exist in database will crash the script
			['dongtinhluyen'] = 100, -- item name and count, adding items that dont exist in database will crash the script
			['diamond'] = 20, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	['khuonsungm4'] = {
		Level = 5, -- From what level this item will be craftable
		Category = 'nguyensung', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 1, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['nhua'] = 50, -- item name and count, adding items that dont exist in database will crash the script
			['iron'] = 200, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	-- ['sattinhluyen'] = {
	-- 	Level = 0, -- From what level this item will be craftable
	-- 	Category = 'misc', -- The category item will be put in
	-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	-- 	Amount = 50, -- The amount that will be crafted
	-- 	SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
	-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	-- 	Time = 120, -- Time in seconds it takes to craft this item
	-- 	Ingredients = { -- Ingredients needed to craft this item
	-- 		['iron'] = 100, -- item name and count, adding items that dont exist in database will crash the script
	-- 	}
	-- },
	['sattinhluyen'] = {
		Level = 0, -- From what level this item will be craftable
		Category = 'misc', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 50, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['iron'] = 100, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	['dongtinhluyen'] = {
		Level = 0, -- From what level this item will be craftable
		Category = 'misc', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 50, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['copper'] = 100, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	['vangtinhluyen'] = {
		Level = 0, -- From what level this item will be craftable
		Category = 'misc', -- The category item will be put in
		isGun = false, -- Specify if this is a gun so it will be added to the loadout
		Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		Amount = 50, -- The amount that will be crafted
		SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		Time = 20, -- Time in seconds it takes to craft this item
		Ingredients = { -- Ingredients needed to craft this item
			['gold'] = 100, -- item name and count, adding items that dont exist in database will crash the script
		}
	},
	},
	
	Workbenches = { -- Every workbench location, leave {} for jobs if you want everybody to access
		{coords = vector3(-320.40188598633,6085.6298828125,31.459997177124), jobs = {}, blip = true, recipes = {}, radius = 3.0},
		{coords = vector3(1690.8055419922,3588.8146972656,35.620964050293), jobs = {}, blip = true, recipes = {}, radius = 3.0},
		  {coords = vector3(-503.08239746094,-976.21337890625,23.550052642822), jobs = {}, blip = true, recipes = {}, radius = 3.0}
	},
	 
	
	Text = {
	
		['inv_limit_exceed'] = '<FONT FACE="Montserrat">~r~Inventory limit exceeded! Clean up before you lose more',
		['crafting_failed'] = '<FONT FACE="Montserrat">~r~Chế tạo thất bại',
		['not_enough_ingredients'] = '<FONT FACE="Montserrat">~r~Bạn không đủ nguyên liệu để chế',
		['you_cant_hold_item'] = '<FONT FACE="Montserrat">~r~Bạn không thể chế item này',
		['item_crafted'] = '<FONT FACE="Montserrat">~y~Chế tạo thành công!',
		['wrong_job'] = '<FONT FACE="Montserrat">~r~Bạn không thể dùng bàn chế tạo này',
		['workbench_hologram'] = '<FONT FACE="Montserrat">[~b~E~w~] Bàn chế tạo',
		['wrong_usage'] = '<FONT FACE="Montserrat">~r~Wrong usage of command'
	}
	
	}
	
	
	
	function SendTextMessage(msg)
	
			SetNotificationTextEntry('STRING')
			AddTextComponentString(msg)
			DrawNotification(0,1)
	
			--EXAMPLE USED IN VIDEO
			--exports['mythic_notify']:SendAlert('inform', msg)
	
	end
	