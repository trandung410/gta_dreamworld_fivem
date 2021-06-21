--[[
***** How to Setup a vehicle_names.lua for Custom Addon Vehicles *****
* Create a vehicle_names.lua & past the below Code
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	--Example 1: AddTextEntry('SPAWN_NAME_HERE', 'VEHICLE_NAME_HERE')
	--Example 2: AddTextEntry('f350', '2013 Ford F350')
end)
]]

Config = {}
Config.Locale = 'en'

Config.KickPossibleCheaters = true -- If true it will kick the player that tries store a vehicle that they changed the Hash or Plate.
Config.UseCustomKickMessage = true -- If KickPossibleCheaters is true you can set a Custom Kick Message in the locales.

Config.UseDamageMult = true-- If true it costs more to store a Broken Vehicle.
Config.DamageMult = 13 -- Higher Number = Higher Repair Price.

Config.CarPoundPrice      = 2000 -- Car Pound Price.
Config.BoatPoundPrice     = 2000 -- Boat Pound Price.
Config.AircraftPoundPrice = 2000 -- Aircraft Pound Price.

Config.PolicingPoundPrice  = 2000 -- Policing Pound Price.
Config.AmbulancePoundPrice = 2000 -- Ambulance Pound Price.

Config.UseCarGarages        = true -- Allows use of Car Garages.
Config.UseBoatGarages       = true -- Allows use of Boat Garages.
Config.UseAircraftGarages   = true -- Allows use of Aircraft Garages.
Config.UsePrivateCarGarages = true -- Allows use of Private Car Garages.
Config.UseJobCarGarages     = true -- Allows use of Job Garages.

Config.ParkVehicles = false ----ปิดคือเวลารีเซิฟเวอร์รถไปอยู่พาว 

Config.DontShowPoundCarsInGarage = true -- If set to true it won't show Cars at the Pound in the Garage.
Config.ShowVehicleLocation       = true -- If set to true it will show the Location of the Vehicle in the Pound/Garage in the Garage menu.
Config.UseVehicleNamesLua        = true -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

Config.ShowGarageSpacer1 = false -- If true it shows Spacer 1 in the List.
Config.ShowGarageSpacer2 = true -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowGarageSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.ShowPoundSpacer2 = true -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.MarkerType   = 1
Config.DrawDistance = 100.0

Config.BlipGarage = {
	Sprite = 50,
	Color = 29,
	Display = 2,
	Scale = 0.8
}

Config.BlipGaragePrivate = {
	Sprite = 50,
	Color = 53,
	Display = 2,
	Scale = 0.8
}

Config.BlipPound = {
	Sprite = 67,
	Color = 64,
	Display = 2,
	Scale = 0.8
}

Config.BlipJobPound = {
	Sprite = 67,
	Color = 49,
	Display = 2,
	Scale = 0.8
}

Config.PointMarker = {
	r = 0, g = 255, b = 0,    -- Green Color
	x = 1.5, y = 1.5, z = 0.5  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,      -- Red Color
	x = 5.0, y = 5.0, z = 0.5  -- Big Size Circle
}

Config.PoundMarker = {
	r = 255, g = 151, b = 0,    -- Blue Color
	x = 1.5, y = 1.5, z = 0.5  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,    -- Red Color
	x = 1.5, y = 1.5, z = 0.5  -- Standard Size Circle
}

-- Start of Jobs

Config.PolicePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 472.15, y = -1019.43, z = 28.21 },
	    SpawnPoint = { x = 478.23, y = -1021.08, z = 28.01, h = 271.31 }
	},
	 Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	 Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
 }

Config.AmbulancePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 29.29 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	 Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
 }

-- End of Jobs
-- Start of Cars

Config.CarGarages = {
	Garage_CentralLS = {
		GaragePoint = { x = -301.9, y = -898.51, z = 30.1 },
		SpawnPoint = { x = -301.9, y = -898.51, z = 30.1, h = 347.5 },
		DeletePoint = { x = -276.564, y = -899.21, z = 30.08 }
	},
	Garage_Alta = {
		GaragePoint = { x = -298.3, y = -899.43, z = 30.1 },
		SpawnPoint = { x = -298.3, y = -899.43, z = 30.1, h = 347.5 },
		DeletePoint = { x = -322.91, y = -971.12, z = 30.09 }
	},
	Garage_Sandy = {
		GaragePoint = { x = -305.53, y = -897.92, z = 30.1},
		SpawnPoint = { x = -305.53, y = -897.92, z = 30.1, h = 347.5 },
		DeletePoint = { x = -322.91, y = -971.12, z = 30.09 }
	},
	Garage_Paletoo = {
		GaragePoint = { x = -303.31, y = -936.85, z = 30.11 },
		SpawnPoint = { x = -303.31, y = -936.85, z = 30.1, h = 67.5 },
		DeletePoint = { x = -322.91, y = -971.12, z = 30.09 }
	},
	Garage_Paletoo1 = {
		GaragePoint = { x = -302.05, y = -933.35, z = 30.1 },
		SpawnPoint = { x = -302.05, y = -933.35, z = 30.1, h = 67.5 },
		DeletePoint = { x = -322.91, y = -971.12, z = 30.09 }
	},
	Garage_Paletoo2 = {
		GaragePoint = { x = -304.5, y = -940.31, z = 30.14 },
		SpawnPoint = { x = -304.5, y = -940.31, z = 30.1, h = 67.5 },
		DeletePoint = { x = -322.91, y = -971.12, z = 30.09 }
	},
	
		Garage_Market2 = {
		GaragePoint = { x =  -305.8, y = -943.84, z = 30.1 },
		SpawnPoint = { x =  -305.8, y = -943.84, z = 30.1, h = 67.5 },
		DeletePoint = { x = -322.91, y = -971.12, z = 30.09 }
	},
		Garage_Market3 = {
		GaragePoint = { x = 2547.51, y = 2612.42, z = 36.84},
		SpawnPoint = { x = 2547.51, y = 2612.42, z = 36.94, h = 21.87 },
		DeletePoint = { x = -276.564, y = -899.21, z = 30.08 }
	},
		Garage_Market4 = {
		GaragePoint = { x = 2311.62, y = 4894.1, z = 40.81},
		SpawnPoint = { x = 2311.62, y = 4894.1, z = 40.81, h = 47.95 },
		DeletePoint = { x = -276.564, y = -899.21, z = 30.08 }
	},
		Garage_Market5 = {
		GaragePoint = { x = 140.994, y = 6608.05, z = 30.84},
		SpawnPoint = { x = 140.994, y = 6608.05, z = 30.84, h = 0.0 },
		DeletePoint = { x = -276.564, y = -899.21, z = 30.08 }
	},
		Garage_Market6 = {
		GaragePoint = { x = -3138.65, y = 1082.48, z = 19.62},
		SpawnPoint = { x = -3138.65, y = 1082.48, z = 19.62, h = 82.36 },
		DeletePoint = { x = -276.564, y = -899.21, z = 30.08 }
	},
		Garage_Market7 = {
		GaragePoint = { x = -127.74, y = 1929.22, z = 195.9},
		SpawnPoint = { x = -127.74, y = 1929.22, z = 195.9, h = 1.02 },
		DeletePoint = { x = -276.564, y = -899.21, z = 30.08 }
	},
}

Config.CarPounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 406.85, y = -1644.58, z = 28.29 },
		SpawnPoint = { x = 406.85, y = -1644.58, z = 29.29, h = 228.53 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1709.85, y = 3780.97, z = 33.77 },
		SpawnPoint = { x = 1711.56, y = 3778.18, z = 34.53, h = 210.86 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -458.97, y = 6012.22, z = 30.49 },
		SpawnPoint = { x = -481.64, y = 6023.81, z = 31.34, h = 224.26 }
	}
}

-- End of Cars
-- Start of Boats

Config.BoatGarages = {
	--[[
	Garage_LSDock = {
		GaragePoint = { x = 1299.32, y = 4219.06, z = 33.91 },
		SpawnPoint = { x = 1290.28, y = 4201.25, z = 28.98, h = 174.87 },
		DeletePoint = { x = 1318.46, y = 4217.29, z = 30.87 }
	},
	Garage_SandyDock = {
		GaragePoint = { x = -3254.282, y = 981.922, z = 12.605 },
		SpawnPoint = { x = -3319.125, y = 995.717, z = 0.0, h = 206.89 },
		DeletePoint = { x = -3313.780, y = 935.845, z = 1 }
	}
	]]--
}

Config.BoatPounds = {
	--[[
	Pound_LSDock = {
		PoundPoint = { x = -3422.33, y = 958.82, z = 12.91 },
		SpawnPoint = { x = -3398.45, y = 932.1, z = 0.58, h = 169.09 }
	},
	Pound_SandyDock = {
		PoundPoint = { x = 1337.35, y = 4225.45, z = 33.92 },
		SpawnPoint = { x = 1342.76, y = 4231.28, z = 29.4, h = 268.55 }
	}
	]]--
}

-- End of Boats
-- Start of Aircrafts

Config.AircraftGarages = {
}

Config.AircraftPounds = {
--[[
	Pound_LSAirport = {
		PoundPoint = { x = -1243.0, y = -3391.92, z = 12.94 },
		SpawnPoint = { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
	}
	]]
}

-- End of Aircrafts
-- Start of Private Garages

Config.PrivateCarGarages = {
	-- Maze Bank Building Garages
	Garage_MazeBankBuilding = {
		Private = "MazeBankBuilding",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_OldSpiceWarm = {
		Private = "OldSpiceWarm",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_OldSpiceClassical = {
		Private = "OldSpiceClassical",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_OldSpiceVintage = {
		Private = "OldSpiceVintage",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_ExecutiveRich = {
		Private = "ExecutiveRich",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_ExecutiveCool = {
		Private = "ExecutiveCool",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_ExecutiveContrast = {
		Private = "ExecutiveContrast",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_PowerBrokerIce = {
		Private = "PowerBrokerIce",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_PowerBrokerConservative = {
		Private = "PowerBrokerConservative",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	Garage_PowerBrokerPolished = {
		Private = "PowerBrokerPolished",
		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
	},
	-- End of Maze Bank Building Garages
	-- Start of Lom Bank Garages
	Garage_LomBank = {
		Private = "LomBank",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBOldSpiceWarm = {
		Private = "LBOldSpiceWarm",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBOldSpiceClassical = {
		Private = "LBOldSpiceClassical",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBOldSpiceVintage = {
		Private = "LBOldSpiceVintage",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBExecutiveRich = {
		Private = "LBExecutiveRich",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBExecutiveCool = {
		Private = "LBExecutiveCool",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBExecutiveContrast = {
		Private = "LBExecutiveContrast",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBPowerBrokerIce = {
		Private = "LBPowerBrokerIce",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBPowerBrokerConservative = {
		Private = "LBPowerBrokerConservative",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	Garage_LBPowerBrokerPolished = {
		Private = "LBPowerBrokerPolished",
		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
	},
	-- End of Lom Bank Garages
	-- Start of Maze Bank West Garages
	Garage_MazeBankWest = {
		Private = "MazeBankWest",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWOldSpiceWarm = {
		Private = "MBWOldSpiceWarm",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWOldSpiceClassical = {
		Private = "MBWOldSpiceClassical",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWOldSpiceVintage = {
		Private = "MBWOldSpiceVintage",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWExecutiveRich = {
		Private = "MBWExecutiveRich",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWExecutiveCool = {
		Private = "MBWExecutiveCool",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWExecutiveContrast = {
		Private = "MBWExecutiveContrast",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWPowerBrokerIce = {
		Private = "MBWPowerBrokerIce",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWPowerBrokerConvservative = {
		Private = "MBWPowerBrokerConvservative",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	Garage_MBWPowerBrokerPolished = {
		Private = "MBWPowerBrokerPolished",
		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
	},
	-- End of Maze Bank West Garages
	-- Start of Intergrity Way Garages
	Garage_IntegrityWay = {
		Private = "IntegrityWay",
		GaragePoint = { x = -14.1, y = -614.93, z = 35.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 35.073 }
	},
	Garage_IntegrityWay28 = {
		Private = "IntegrityWay28",
		GaragePoint = { x = -14.1, y = -614.93, z = 35.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 35.073 }
	},
	Garage_IntegrityWay30 = {
		Private = "IntegrityWay30",
		GaragePoint = { x = -14.1, y = -614.93, z = 35.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 35.073 }
	},
	-- End of Intergrity Way Garages
	-- Start of Dell Perro Heights Garages
	Garage_DellPerroHeights = {
		Private = "DellPerroHeights",
		GaragePoint = { x = -1477.15, y = -517.17, z = 34.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 31.582 }
	},
	Garage_DellPerroHeightst4 = {
		Private = "DellPerroHeightst4",
		GaragePoint = { x = -1477.15, y = -517.17, z = 34.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 31.582 }
	},
	Garage_DellPerroHeightst7 = {
		Private = "DellPerroHeightst7",
		GaragePoint = { x = -1477.15, y = -517.17, z = 34.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 31.582 }
	},
	-- End of Dell Perro Heights Garages
	-- Start of Milton Drive Garages
	Garage_MiltonDrive = {
		Private = "MiltonDrive",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Modern1Apartment = {
		Private = "Modern1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Modern2Apartment = {
		Private = "Modern2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Modern3Apartment = {
		Private = "Modern3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Mody1Apartment = {
		Private = "Mody1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Mody2Apartment = {
		Private = "Mody2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Mody3Apartment = {
		Private = "Mody3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Vibrant1Apartment = {
		Private = "Vibrant1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Vibrant2Apartment = {
		Private = "Vibrant2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Vibrant3Apartment = {
		Private = "Vibrant3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Sharp1Apartment = {
		Private = "Sharp1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Sharp2Apartment = {
		Private = "Sharp2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Sharp3Apartment = {
		Private = "Sharp3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Monochrome1Apartment = {
		Private = "Monochrome1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Monochrome2Apartment = {
		Private = "Monochrome2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Monochrome3Apartment = {
		Private = "Monochrome3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Seductive1Apartment = {
		Private = "Seductive1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Seductive2Apartment = {
		Private = "Seductive2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Seductive3Apartment = {
		Private = "Seductive3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Regal1Apartment = {
		Private = "Regal1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Regal2Apartment = {
		Private = "Regal2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Regal3Apartment = {
		Private = "Regal3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Aqua1Apartment = {
		Private = "Aqua1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Aqua2Apartment = {
		Private = "Aqua2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	Garage_Aqua3Apartment = {
		Private = "Aqua3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
	},
	-- End of Milton Drive Garages
	-- Start of Single Garages
	Garage_RichardMajesticApt2 = {
		Private = "RichardMajesticApt2",
		GaragePoint = { x = -887.5, y = -349.58, z = 34.534 },
		SpawnPoint = { x = -886.03, y = -343.78, z = 33.534, h = 206.79 },
		DeletePoint = { x = -894.324, y = -349.326, z = 34.534 }
	},
	Garage_WildOatsDrive = {
		Private = "WildOatsDrive",
		GaragePoint = { x = -178.65, y = 503.45, z = 136.85 },
		SpawnPoint = { x = -189.98, y = 505.8, z = 133.48, h = 282.62 },
		DeletePoint = { x = -189.28, y = 500.56, z = 133.93 }
	},
	Garage_WhispymoundDrive = {
		Private = "WhispymoundDrive",
		GaragePoint = { x = 123.65, y = 565.75, z = 184.04 },
		SpawnPoint = { x = 130.11, y = 571.47, z = 182.42, h = 270.71 },
		DeletePoint = { x = 131.97, y = 566.77, z = 182.95 }
	},
	Garage_NorthConkerAvenue2044 = {
		Private = "NorthConkerAvenue2044",
		GaragePoint = { x = 348.18, y = 443.01, z = 146.7 },
		SpawnPoint = { x = 358.397, y = 437.064, z = 144.277, h = 285.911 },
		DeletePoint = { x = 352.05, y = 437.91, z = 147.1 }
	},
	Garage_NorthConkerAvenue2045 = {
		Private = "NorthConkerAvenue2045",
		GaragePoint = { x = 370.69, y = 430.76, z = 145.11 },
		SpawnPoint = { x = 392.88, y = 434.54, z = 142.17, h = 264.94 },
		DeletePoint = { x = 389.72, y = 429.95, z = 142.81 }
	},
	Garage_HillcrestAvenue2862 = {
		Private = "HillcrestAvenue2862",
		GaragePoint = { x = -688.71, y = 597.57, z = 143.64 },
		SpawnPoint = { x = -683.72, y = 609.88, z = 143.28, h = 338.06 },
		DeletePoint = { x = -685.259, y = 601.083, z = 143.365 }
	},
	Garage_HillcrestAvenue2868 = {
		Private = "HillcrestAvenue2868",
		GaragePoint = { x = -752.753, y = 624.901, z = 142.2 },
		SpawnPoint = { x = -749.32, y = 628.61, z = 141.48, h = 197.14 },
		DeletePoint = { x = -754.286, y = 631.581, z = 142.2 }
	},
	Garage_HillcrestAvenue2874 = {
		Private = "HillcrestAvenue2874",
		GaragePoint = { x = -859.01, y = 695.95, z = 148.93 },
		SpawnPoint = { x = -863.681, y = 698.72, z = 147.052, h = 341.77 },
		DeletePoint = { x = -855.66, y = 698.77, z = 148.81 }
	},
	Garage_MadWayneThunder = {
		Private = "MadWayneThunder",
		GaragePoint = { x = -1290.95, y = 454.52, z = 97.66 },
		SpawnPoint = { x = -1297.62, y = 459.28, z = 96.48, h = 285.652 },
		DeletePoint = { x = -1298.088, y = 468.952, z = 97.0 }
	},
	Garage_TinselTowersApt12 = {
		Private = "TinselTowersApt12",
		GaragePoint = { x = -616.74, y = 56.38, z = 43.736 },
		SpawnPoint = { x = -620.588, y = 60.102, z = 42.736, h = 109.316 },
		DeletePoint = { x = -621.128, y = 52.691, z = 43.735 }
	},
	-- End of Single Garages
	-- Start of VENT Custom Garages
	Garage_MedEndApartment1 = {
		Private = "MedEndApartment1",
		GaragePoint = { x = 240.23, y = 3102.84, z = 41.49 },
		SpawnPoint = { x = 233.58, y = 3094.29, z = 40.49, h = 93.91 },
		DeletePoint = { x = 237.52, y = 3112.63, z = 41.39 }
	},
	Garage_MedEndApartment2 = {
		Private = "MedEndApartment2",
		GaragePoint = { x = 246.08, y = 3174.63, z = 41.72 },
		SpawnPoint = { x = 234.15, y = 3164.37, z = 40.54, h = 102.03 },
		DeletePoint = { x = 240.72, y = 3165.53, z = 41.65 }
	},
	Garage_MedEndApartment3 = {
		Private = "MedEndApartment3",
		GaragePoint = { x = 984.92, y = 2668.95, z = 39.06 },
		SpawnPoint = { x = 993.96, y = 2672.68, z = 38.06, h = 0.61 },
		DeletePoint = { x = 994.04, y = 2662.1, z = 39.13 }
	},
	Garage_MedEndApartment4 = {
		Private = "MedEndApartment4",
		GaragePoint = { x = 196.49, y = 3027.48, z = 42.89 },
		SpawnPoint = { x = 203.1, y = 3039.47, z = 41.08, h = 271.3 },
		DeletePoint = { x = 192.24, y = 3037.95, z = 42.89 }
	},
	Garage_MedEndApartment5 = {
		Private = "MedEndApartment5",
		GaragePoint = { x = 1724.49, y = 4638.13, z = 42.31 },
		SpawnPoint = { x = 1723.98, y = 4630.19, z = 41.23, h = 117.88 },
		DeletePoint = { x = 1733.66, y = 4635.08, z = 42.24 }
	},
	Garage_MedEndApartment6 = {
		Private = "MedEndApartment6",
		GaragePoint = { x = 1670.76, y = 4740.99, z = 41.08 },
		SpawnPoint = { x = 1673.47, y = 4756.51, z = 39.91, h = 12.82 },
		DeletePoint = { x = 1668.46, y = 4750.83, z = 40.88 }
	},
	Garage_MedEndApartment7 = {
		Private = "MedEndApartment7",
		GaragePoint = { x = 15.24, y = 6573.38, z = 31.72 },
		SpawnPoint = { x = 16.77, y = 6581.68, z = 30.42, h = 222.6 },
		DeletePoint = { x = 10.45, y = 6588.04, z = 31.47 }
	},
	Garage_MedEndApartment8 = {
		Private = "MedEndApartment8",
		GaragePoint = { x = -374.73, y = 6187.06, z = 30.54 },
		SpawnPoint = { x = -377.97, y = 6183.73, z = 29.49, h = 223.71 },
		DeletePoint = { x = -383.31, y = 6188.85, z = 30.49 }
	},
	Garage_MedEndApartment9 = {
		Private = "MedEndApartment9",
		GaragePoint = { x = -24.6, y = 6605.99, z = 30.45 },
		SpawnPoint = { x = -16.0, y = 6607.74, z = 29.18, h = 35.31 },
		DeletePoint = { x = -9.36, y = 6598.86, z = 30.47 }
	},
	Garage_MedEndApartment10 = {
		Private = "MedEndApartment10",
		GaragePoint = { x = -365.18, y = 6323.95, z = 28.9 },
		SpawnPoint = { x = -359.49, y = 6327.41, z = 27.83, h = 218.58 },
		DeletePoint = { x = -353.47, y = 6334.57, z = 28.83 }
	}
	-- End of VENT Custom Garages
}

-- End of Private Garages