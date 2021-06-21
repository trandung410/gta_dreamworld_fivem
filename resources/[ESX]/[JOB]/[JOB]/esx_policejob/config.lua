Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 5 * 60000 -- 5 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6),
			vector3(1855.8, 3688.74, 34.27),
			vector3(128.91, -767.12, 45.75)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6),
			vector3(1848.52, 3688.71, 34.27),
			vector3(142.31, -769.48, 45.75)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(1859.68, 3680.78, 33.74),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(1866.12, 3680.66, 33.62), heading = 302.5, radius = 6.0 },
					{ coords = vector3(1854.86, 3673.63, 33.65), heading = 302.5, radius = 6.0 }
				}
			}

			--[[{
				Spawner = vector3(103.86, -747.51, 45.75),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(62.32, -743.06, 44.22), heading = 302.5, radius = 6.0 },
					{ coords = vector3(66.34, -733.03, 44.22), heading = 302.5, radius = 6.0 },

				}
			}]]
		},

		Helicopters = {
			{
				Spawner = vector3(1836.47, 3678.55, 39.38),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(1832.36, 3689.74, 39.74), heading = 92.6, radius = 10.0 },
					{ coords = vector3(1824.83, 3674.47, 40.28), heading = 92.6, radius = 10.0 }
				}
			},

			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6),
			vector3(1853.33, 3689.75, 34.27),
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },	
		{ weapon = 'WEAPON_PISTOL', price = 2000 },	
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	officer = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },
		{ weapon = 'WEAPON_PISTOL', price = 2000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 6000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },
		{ weapon = 'WEAPON_PISTOL', price = 2000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 6000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 600, 100, 400, 800, nil }, price = 7000 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 8000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },
		{ weapon = 'WEAPON_PISTOL', price = 2000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 6000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 600, 100, 400, 800, nil }, price = 7000 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 8000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 6000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 600, 100, 400, 800, nil }, price = 7000 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 8000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chef = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },
		{ weapon = 'WEAPON_PISTOL', price = 2000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 6000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 600, 100, 400, 800, nil }, price = 7000 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 8000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		--{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 4000 },
		{ weapon = 'WEAPON_PISTOL', price = 2000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 5000 },
		--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 6000 },
		--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 600, 100, 400, 800, nil }, price = 7000 },
		--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 8000 },	
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }	,
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		--{ weapon = 'WEAPON_SMOKEGRENADE', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },


	}
}

Config.CarShop = {
	CarList = {		
		-- { model = 'police2', label = 'Xe Áp Giải', price = 10000 },
		{ model = 'polchiron', label = 'Polchiron', price = 15000 },
		{ model = 'pd_bmwr', label = 'Xe 4 chỗ', price = 15000 },
		{ model = 'pbus', label = 'Xe Bus', price = 20000 },
		{ model = 'riot', label = 'Xe Bọc Thép', price = 25000 },
		-- { model = 'polmp4', label = 'Xe Donate', price = 100000 },
		-- { model = 'wmfenyrcop', label = 'Xe BOSS', price = 5000000 }
		---{ model = 'polp1', label = 'Xe Đặc Vụ', price = 30000 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {		
		{ model = 'police2', label = 'Xe Áp Giải', price = 10000 },
		{ model = 'polchiron', label = 'Polchiron', price = 15000 },
		{ model = 'pd_bmwr', label = 'Xe 4 chỗ', price = 15000 },
		{ model = 'pbus', label = 'Xe Bus', price = 20000 },
		{ model = 'riot', label = 'Xe Bọc Thép', price = 25000 },
		-- { model = 'polmp4', label = 'Xe Donate', price = 100000 },
		-- { model = 'wmfenyrcop', label = 'Xe BOSS', price = 5000000 }
		---{ model = 'polp1', label = 'Xe Đặc Vụ', price = 30000 }
	}
	--[[
	recruit = {
	
	},

	officer = {						
	},

	sergeant = {						
		
	},

	intendent = {

	},

	lieutenant = {								
		
	},

	chef = {								
		

	},

	boss = {												
		{ model = 'wmfenyrcop', label = 'Xe BOSS', price = 500000 }

	}
	]]
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 200000 },
		--{ model = 'valkyrie', label = 'Police Valkyrie', livery = 0, price = 200000 }
	},

	chef = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 150000 },
		--{ model = 'valkyrie', label = 'Police Valkyrie', livery = 0, price = 200000 }
	},

	boss = {
		{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 100000 },
		--{ model = 'valkyrie', label = 'Police Valkyrie', livery = 0, price = 200000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}