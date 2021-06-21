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
Config.Locale                     = 'vi'

Config.Gang1Stations = {

  Gang1 = {

    Blip = {
      Pos     = {x = -831.2587890625, y = 164.30830383301, z =69.097244262695 },
      Sprite  = 566,
      Display = 4,
      Scale   = 0.5,
      Colour  = 37,
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
      { x = -808.39855957031, y = 175.3851776123, z =76.740768432617 },
    },

    Vehicles = {
      {
        Spawner    = { x = -809.36804199219, y = 190.28190612793, z =72.478698730469 },
        SpawnPoint = {x = -822.12457275391, y = 182.65365600586, z =71.890258789062 },
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
      { x = -822.12457275391, y = 182.65365600586, z =71.890258789062 },
    },

    BossActions = {
      { x = -812.35479736328, y = 177.87149047852, z =76.740776062012 }
    },

  },

}
