Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 21
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Locale                     = 'vi'

Config.Gang1Stations = {

  Gang1 = {

    Blip = {
      Pos     = {x = 9.2952432632446, y = 529.49084472656, z =170.61735534668 },
      Sprite  = 303,
      Display = 4,
      Scale   = 0.5,
      Colour  = 1,
      Radius = 50,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_ASSAULTRIFLE',     price = 500000 },
    },

	  AuthorizedVehicles = {
		  { name = 't20',  label = 'T20' },
	  },

    -- Cloakrooms = {
    --   { x = -811.86, y = 175.04, z = 76.30 },
    -- },

    Armories = {
      { x = 9.2952432632446, y = 529.49084472656, z =170.61735534668 },
    },

    Vehicles = {
      {
        Spawner    = { x = 24.301225662231, y = 546.10638427734, z =176.02774047852 },
        SpawnPoint = {x = 15.99227809906, y = 547.99652099609, z =176.18600463867 },
        Heading    = 100.0,
      }
    },
	
	Helicopters = {
      {
        Spawner    = { x = 20.312, y = 535.667, z = 173.627 },
        SpawnPoint = { x = 3.40, y = 525.56, z = 177.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 15.99227809906, y = 547.99652099609, z =176.18600463867 },
    },

    BossActions = {
      { x = -1.4458767175674, y = 536.13800048828, z =175.34230041504 }
    },

  },

}
