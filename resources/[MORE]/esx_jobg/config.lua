Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 2.0, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MafiaStations = {

  Gang = {

    Blip = {

      Pos     = { x = -17.50,y = -1454.3,z = 30.51},
      Sprite  = 543,
      Display = 4,
      Scale   = 1.2,
      Colour  = 58,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_POOLCUE',       price = 50000 },
	  { name = 'WEAPON_PISTOL',        price = 130000 },
      { name = 'WEAPON_PISTOL50',      price = 295000 },
      
    },
	  
    

	  AuthorizedVehicles = {
		  { name = 'vortex',  label = 'Xe Moto' },
		  
    },
    AuthorizedVehiclesBoss = {
		  { name = 'mi8',  label = 'Xe 4 Chỗ' },
		  
	  },
    Cloakrooms = {
      { x = -18.831636428833, y = -1432.6755371094, z = 31.101526260376 - 0.9},
    },

    Armories = {
      { x = -12.429188728333, y = -1435.0927734375, z = 31.101556777954 - 0.9},
    },
  Vehicles = {
      {

        Spawner    = { x = -17.50,y = -1454.3,z = 30.51 - 0.9},
        SpawnPoint = { x = -24.87, y = -1454.65, z = 30.75 - 0.9},
        Heading    = 90.00,
      }
    },
	  Helicopters = {
      {
        Spawner    = { x = -2667.8415527344, y = 1332.9372558594, z = 156.93173217773 },
        SpawnPoint = { x = -2672.2844238281, y = 1340.421875, z = 156.93173217773 },
        Heading    = 264.0495300293,
      }
    },
    

    VehicleDeleters = {
      { x = -25.426250457764, y = -1433.1604003906, z = 30.653148651123 - 0.9},
    },

    BossActions = {
      { x = -9.1197824478149, y = -1441.0880126953, z = 31.101554870605 - 0.9}
    },
    WeaponShop = {
    },

  },

}


Config.Uniforms = {
	job_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 24,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 128,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 12,   ['pants_2'] = 7,
			['shoes_1'] = 14,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 98,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
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

}
    