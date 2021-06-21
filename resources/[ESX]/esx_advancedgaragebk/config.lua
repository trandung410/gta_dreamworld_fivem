Config = {}
Config.Locale = 'en'

Config.PriceChangName = 100000
Config.PriceBillAdd = 20000
Config.KickPossibleCheaters = true -- If true it will kick the player that tries store a vehicle that they changed the Hash or Plate.
Config.UseCustomKickMessage = true -- If KickPossibleCheaters is true you can set a Custom Kick Message in the locales.

Config.UseDamageMult = false -- If true it costs more to store a Broken Vehicle.
Config.DamageMult = 85 -- Higher Number = Higher Repair Price.

Config.CarPoundPrice      = 1000 -- Car Pound Price.
Config.CarPoundPriceColdown = 5 -- tỉ lệ nhân thêm bao nhiêu tiền
Config.TimeColdownReturnCar = 600 -- giây

Config.BoatPoundPrice     = 30000 -- Boat Pound Price.
Config.AircraftPoundPrice = 75000 -- Aircraft Pound Price.

Config.PolicingPoundPrice  = 10000 -- Policing Pound Price.
Config.AmbulancePoundPrice = 10000 -- Ambulance Pound Price.

Config.UseCarGarages        = true -- Allows use of Car Garages.
Config.UseBoatGarages       = false -- Allows use of Boat Garages.
Config.UseAircraftGarages   = false -- Allows use of Aircraft Garages.
Config.UsePrivateCarGarages = false -- Allows use of Private Car Garages.
Config.UseJobCarGarages     = true -- Allows use of Job Garages.

Config.DontShowPoundCarsInGarage = false -- If set to true it won't show Cars at the Pound in the Garage.
Config.ShowVehicleLocation       = true -- If set to true it will show the Location of the Vehicle in the Pound/Garage in the Garage menu.
Config.UseVehicleNamesLua        = true -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

Config.ShowGarageSpacer1 = false -- If true it shows Spacer 1 in the List.
Config.ShowGarageSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowGarageSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.ShowPoundSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.MarkerType   = 1
Config.DrawDistance = 20.0

Config.BlipGarage = {
	Sprite = 290,
	Color = 38,
	Display = 2,
	Scale = 0.9
}
--[[ 
Config.BlipGaragePrivate = {
	Sprite = 290,
	Color = 53,
	Display = 2,
	Scale = 1.0
}
 ]]
Config.BlipPound = {
	Sprite = 67,
	Color = 64,
	Display = 2,
	Scale = 0.9
}

Config.BlipJobPound = {
	Sprite = 67,
	Color = 49,
	Display = 2,
	Scale = 0.9
}

Config.PointMarker = {
	r = 0, g = 255, b = 0,     -- Green Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 5.0, y = 5.0, z = 1.0  -- Big Size Circle
}

Config.PoundMarker = {
	r = 0, g = 0, b = 100,     -- Blue Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

-- Start of Jobs

Config.PolicePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
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

Config.AmbulancePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
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
		GaragePoint = { x = 215.800, y = -810.057, z = 29.727 },
		DeletePoint = { x = 211.92, y = -798.78, z = 29.646 },
		SpawnPoint = {
			{ x = 221.21, y = -806.81, z = 29.5722, h = 248.96 },
			{ x = 220.86, y = -806.54, z = 29.77, h = 248.96 },
			{ x = 222.18, y = -804.19, z = 29.77, h = 248.45 },
			{ x = 222.66, y = -801.64, z = 29.77, h = 249.0 },
			{ x = 223.75, y = -799.05, z = 29.77, h = 248.52 },
			{ x = 230.98, y = -810.28, z = 29.77, h = 68.77 },
			{ x = 232.15, y = -807.81, z = 29.77, h = 69.69},
			{ x = 233.04, y = -805.26, z = 29.77, h = 68.42},
			{ x = 233.76, y = -802.79, z = 29.77, h = 69.35 },
			{ x = 234.99, y = -800.17, z = 29.77, h = 69.21},
			{ x = 224.93, y = -796.68, z = 29.77, h = 247.49},
		}
	},
	garage7069 = {
		GaragePoint = { x = -3149.89, y = 1108.52, z = 19.85 },
		DeletePoint = { x = -3134.86, y = 1123.9, z = 19.69 },
		SpawnPoint = {
			{ x = -3142.12, y = 1117.12, z = 20.7, h = 278.41 },
			{ x = -3143.58, y = 1113.52, z = 20.7, h = 278.41  },
			{ x = -3144.37, y = 1109.89, z = 20.7, h = 278.41  },
		}
	},
	garage5152 = {
		GaragePoint = { x = -1522.44, y = -451.89, z = 34.59 },
		DeletePoint = { x = -1533.5, y = -442.8, z = 34.44 },
		SpawnPoint = {
			{ x = -1535.89, y = -434.33, z = 35.44, h = 230.2 },
			{ x = -1533.57, y = -431.61, z = 35.44, h = 230.2  },
			{ x = -1529.72, y = -430.47, z = 35.44, h = 230.2  },
		}
	},
	Garage_Sandy = {
		GaragePoint = { x = 1737.59, y = 3710.2, z = 33.14 },
		SpawnPoint = {{ x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 }},
		DeletePoint = { x = 1722.66, y = 3713.74, z = 33.21 }
	},
	Garage_Paleto = {
		GaragePoint = { x = 105.359, y = 6613.586, z = 31.3973 },
		SpawnPoint = {{ x = 128.7822, y = 6622.9965, z = 30.7828, h = 315.01 }},
		DeletePoint = { x = 126.3572, y = 6608.4150, z = 30.8565 }
	},
	--[[ Garage_xetai = {
		GaragePoint = { x = 844.61, y = -2945.37, z = 4.9 },
		SpawnPoint = { 
			{x = 852.61, y = -2943.21, z = 4.9, h = 14.09}, 
			{x = 862.81, y = -2943.48, z = 4.9, h = 14.09}, 
			{x = 873.58, y = -2943.81, z = 4.9, h = 14.09}, 

		},
		DeletePoint = { x = 843.59, y = -2926.47, z = 4.9 } -- z = 44.67
	},  ]]
	
	--[[ Garage_CarCasino = {
		GaragePoint = { x = 853.53, y = -47.76, z = 78.76-0.9 },
		SpawnPoint = {{ x = 861.96, y = -38.93, z = 78.76-0.9, h = 326.28 }},
		DeletePoint = { x = 855.97, y = -34.59, z = 78.67-0.9 }
	} ]]
	--[[Garage_Gangster = {
		GaragePoint = { x = -2700.1533203125, y = -90.232521057129, z = 17.225671768188-0.9 },
		SpawnPoint = { x = -2688.41, y = -61.28,z = 16.21,  h = 220.76 },
		DeletePoint = { x = -2689.7253417969, y =-61.199848175049, z = 16.181518554688-0.9 }
	},
	Garage_HongHung = {
		GaragePoint = { x= -2095.87, y = -475.31,z = 12.10-0.9},
		SpawnPoint =  { x = -2108.09, y = -492.89, z = 12.10-0.9, h = 305.09},
		DeletePoint = { x = -2108.09, y = -492.89, z = 12.10-0.9,}
	},
	Garage_Biker = {
		GaragePoint = { x = -20.184381484985,y = -672.04931640625, z = 32.338069915771-0.9},
		SpawnPoint =  { x = -20.184381484985,y = -672.04931640625, z = 32.338069915771-0.9, h = 305.09},
		DeletePoint = { x = -35.77872467041,y = -671.69311523438,z = 32.338077545166,}
	} ]]
}

Config.CarPounds = {
	Pound_LosSantos1 = {
		PoundPoint = { x = 241.29, y = -768.01, z = 29.77 },
		SpawnPoint = {
			{ x = 245.6, y = -772.49, z = 29.77, h = 67.81 },
			{ x = 244.5, y = -775.05, z = 29.77, h = 67.51 },
			{ x = 243.55, y = -777.59, z = 29.77, h = 67.81 },
			{ x = 242.28, y = -780.07, z = 29.77, h = 67.81 },
			{ x = 241.42, y = -782.41, z = 29.77, h = 67.81 },
			{ x = 233.75, y = -771.09, z = 29.77, h = 248.49 },
			{ x = 232.75, y = -773.68, z = 29.77, h = 248.49},
			{ x = 231.76, y = -776.37, z = 29.77, h = 248.49},
			{ x = 230.93, y = -778.99, z = 29.77, h = 249.64 },
			{ x = 230.02, y = -781.56, z = 29.77, h = 249.21},
			{ x = 240.34, y = -785.09, z = 29.77, h = 68.54}
		}
		
	},

	Pound_LosSantos = {
		PoundPoint = { x = 408.61, y = -1625.47, z = 28.29 },
		SpawnPoint = {{ x = 405.64, y = -1643.4, z = 27.61, h = 229.54 }}
	},

	--[[ Pound_LosSanto = {
		PoundPoint = { x = 843.46, y = -2903.43, z = 4.9 },
		SpawnPoint = {
			{ x = 848.47, y = -2910.8, z = 4.9, h = 177.98 },
			{ x = 856.98, y = -2911.11, z = 4.9, h = 177.98 },

		}
	}, ]]

	Pound_Sandy = {
		PoundPoint = { x = 1651.38, y = 3804.84, z = 37.65 },
		SpawnPoint = {{ x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }}
	},
	Pound_Paleto = {
		PoundPoint = { x = -234.82, y = 6198.65, z = 30.94 },
		SpawnPoint = {{ x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }}
	},
	Pound_7069 = {
		PoundPoint = { x = -3154.1789550781, y = 1067.4802246094, z = 20.682502746582-0.99 },
		SpawnPoint = {{ x = -3146.677734375, y = 1068.80859375, z = 20.612329483032, h = 259.08001708984 }}
	},
	Pound_5152 = {
		PoundPoint = { x = -1511.6655273438, y = -444.5885925293, z = 35.591938018799-0.99 },
		SpawnPoint = {{ x = -1522.2749023438, y = -442.39294433594, z = 35.442031860352, h = 214.79965209961 }}
	},
	--[[ Pound_Gangster = {
		PoundPoint = { x = -2687.4599609375,y = -77.579742431641,z = 17.225652694702-0.9 },
		SpawnPoint = {{ x = -2703.0070800781, y = -71.239669799805,z = 17.225652694702,  h = 306.87 }}
		
	},
	Pound_HongHung = {
		PoundPoint = { x = -2075.98, y = -475.66,z = 12.20-0.9},
		SpawnPoint =  { x = -2108.09, y = -492.89, z = 12.10-0.9,}
		
	},
	Pound_Biker = {
		PoundPoint = {  x = -18.068302154541,y = -702.88250732422,z = 32.338104248047-0.9},
		SpawnPoint =  { x = -18.068302154541,y = -702.88250732422,z = 32.338104248047-0.9,}
		
	},
	Pound_Biker1 = {
		PoundPoint = {  x = 241.08,y = -767.59,z = 30.78-0.9},
		SpawnPoint =  { x = 241.08,y = -767.59,z = 30.78-0.9,}
		
	}    ]]
}
 
-- End of Cars
-- Start of Boats

Config.BoatGarages = {
	Garage_LSDock = {
		GaragePoint = { x = -735.87, y = -1325.08, z = 0.6 },
		SpawnPoint = { x = -718.87, y = -1320.18, z = -0.47477427124977, h = 45.0 },
		DeletePoint = { x = -731.15, y = -1334.71, z = -0.47477427124977 }
	},
	Garage_SandyDock = {
		GaragePoint = { x = 1333.2, y = 4269.92, z = 30.5 },
		SpawnPoint = { x = 1334.61, y = 4264.68, z = 29.86, h = 87.0 },
		DeletePoint = { x = 1323.73, y = 4269.94, z = 29.86 }
	},
	Garage_PaletoDock = {
		GaragePoint = { x = -283.74, y = 6629.51, z = 6.3 },
		SpawnPoint = { x = -290.46, y = 6622.72, z = -0.47477427124977, h = 52.0 },
		DeletePoint = { x = -304.66, y = 6607.36, z = -0.47477427124977 }
	}
}

Config.BoatPounds = {
	Pound_LSDock = {
		PoundPoint = { x = -738.67, y = -1400.43, z = 4.0 },
		SpawnPoint = { x = -738.33, y = -1381.51, z = 0.12, h = 137.85 }
	},
	Pound_SandyDock = {
		PoundPoint = { x = 1299.36, y = 4217.93, z = 32.91 },
		SpawnPoint = { x = 1294.35, y = 4226.31, z = 29.86, h = 345.0 }
	},
	Pound_PaletoDock = {
		PoundPoint = { x = -270.2, y = 6642.43, z = 6.36 },
		SpawnPoint = { x = -290.38, y = 6638.54, z = -0.47477427124977, h = 130.0 }
	}
}

-- End of Boats
-- Start of Aircrafts

Config.AircraftGarages = {
	Garage_LSAirport = {
		GaragePoint = { x = -1617.14, y = -3145.52, z = 12.99 },
		SpawnPoint = { x = -1657.99, y = -3134.38, z = 12.99, h = 330.11 },
		DeletePoint = { x = -1642.12, y = -3144.25, z = 12.99 }
	},
	--[[Garage_SandyAirport = {
		GaragePoint = { x = 1723.84, y = 3288.29, z = 40.16 },
		SpawnPoint = { x = 1710.85, y = 3259.06, z = 40.69, h = 104.66 },
		DeletePoint = { x = 1714.45, y = 3246.75, z = 40.07 }
	},]]
	Garage_GrapeseedAirport = {
		GaragePoint = { x = 2152.83, y = 4797.03, z = 40.19 },
		SpawnPoint = { x = 2122.72, y = 4804.85, z = 40.78, h = 115.04 },
		DeletePoint = { x = 2082.36, y = 4806.06, z = 40.07 }
	},
	Garage_casino = {
		GaragePoint = { x= 887.37, y = -63.08, z = 78.76-0.9},
		SpawnPoint =  { x = 905.15, y = -49.37, z = 78.76-0.9, h = 321.55},
		DeletePoint = { x = 905.15, y = -49.37, z = 78.76-0.9,}
	},
	Garage_Gangster = {
		GaragePoint = { x= -2704.17, y = -76.93, z = 17.23-0.9},
		SpawnPoint =  { x = -2712.32, y = -75.07, z = 20.99-0.9, h = 309.79},
		DeletePoint = { x = -2704.29, y = -87.40, z = 20.99-0.9,}
	},
	Garage_HongHung = {
		GaragePoint = { x= -2330.86, y = -658.44,z = 13.42-0.9},
		SpawnPoint =  { x = -2321.55, y = -658.36,z = 13.48, h = 271.34},
		DeletePoint = { x = -2321.55, y = -658.36,z = 13.48-0.9,}
	},
	Garage_Biker = {
		GaragePoint = { x = -22.9, y = -706.17118896484, z = 256.58322021484-0.9},
		SpawnPoint =  { x = -22.9, y = -706.17118896484, z = 256.58322021484, h = 271.34},
		DeletePoint = { x = -22.9, y = -706.17118896484, z = 256.58322021484-0.9,}
	}
}

Config.AircraftPounds = {
	Pound_LSAirport = {
		PoundPoint = { x = -1243.0, y = -3391.92, z = 12.94 },
		SpawnPoint = { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
	},
	Pound_casino = {
		PoundPoint = { x = 898.55, y = -72.17, z = 78.76-0.9},
		SpawnPoint =  { x = 905.15, y = -49.37, z = 78.76-0.9, h = 321.55}
	},
	Pound_HongHung = {
		PoundPoint = { x = -2331.30, y = -653.66,z = 13.42-0.9},
		SpawnPoint =  { x = -2321.55, y = -658.36,z = 13.48, h = 271.34}
	},
	Pound_Biker = {
		PoundPoint = { x = -1.51,y = -687.43,z = 254.74-0.9},
		SpawnPoint =  { x = -14.617944717407, y = -702.28118896484, z = 255.11322021484, h = 271.34}
	}
}

-- End of Aircrafts
-- Start of Private Garages

Config.PrivateCarGarages = {
	-- Maze Bank Building Garages
	--[[ Garage_MazeBankBuilding = {
		Private = "MazeBankBuilding",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_OldSpiceWarm = {
		Private = "OldSpiceWarm",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_OldSpiceClassical = {
		Private = "OldSpiceClassical",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_OldSpiceVintage = {
		Private = "OldSpiceVintage",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_ExecutiveRich = {
		Private = "ExecutiveRich",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_ExecutiveCool = {
		Private = "ExecutiveCool",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_ExecutiveContrast = {
		Private = "ExecutiveContrast",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_PowerBrokerIce = {
		Private = "PowerBrokerIce",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_PowerBrokerConservative = {
		Private = "PowerBrokerConservative",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	Garage_PowerBrokerPolished = {
		Private = "PowerBrokerPolished",
		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
	},
	-- End of Maze Bank Building Garages
	-- Start of Lom Bank Garages
	Garage_LomBank = {
		Private = "LomBank",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBOldSpiceWarm = {
		Private = "LBOldSpiceWarm",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBOldSpiceClassical = {
		Private = "LBOldSpiceClassical",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBOldSpiceVintage = {
		Private = "LBOldSpiceVintage",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBExecutiveRich = {
		Private = "LBExecutiveRich",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBExecutiveCool = {
		Private = "LBExecutiveCool",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBExecutiveContrast = {
		Private = "LBExecutiveContrast",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBPowerBrokerIce = {
		Private = "LBPowerBrokerIce",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBPowerBrokerConservative = {
		Private = "LBPowerBrokerConservative",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	Garage_LBPowerBrokerPolished = {
		Private = "LBPowerBrokerPolished",
		GaragePoint = { x = -1545.17, y = -566.24, z = 24.85 },
		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
		DeletePoint = { x = -1538.564, y = -576.049, z = 24.708 }
	},
	-- End of Lom Bank Garages
	-- Start of Maze Bank West Garages
	Garage_MazeBankWest = {
		Private = "MazeBankWest",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWOldSpiceWarm = {
		Private = "MBWOldSpiceWarm",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWOldSpiceClassical = {
		Private = "MBWOldSpiceClassical",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWOldSpiceVintage = {
		Private = "MBWOldSpiceVintage",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWExecutiveRich = {
		Private = "MBWExecutiveRich",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWExecutiveCool = {
		Private = "MBWExecutiveCool",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWExecutiveContrast = {
		Private = "MBWExecutiveContrast",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWPowerBrokerIce = {
		Private = "MBWPowerBrokerIce",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWPowerBrokerConvservative = {
		Private = "MBWPowerBrokerConvservative",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	Garage_MBWPowerBrokerPolished = {
		Private = "MBWPowerBrokerPolished",
		GaragePoint = { x = -1368.14, y = -468.01, z = 30.6 },
		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
		DeletePoint = { x = -1362.065, y = -471.982, z = 30.5 }
	},
	-- End of Maze Bank West Garages
	-- Start of Intergrity Way Garages
	Garage_IntegrityWay = {
		Private = "IntegrityWay",
		GaragePoint = { x = -14.1, y = -614.93, z = 34.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 34.073 }
	},
	Garage_IntegrityWay28 = {
		Private = "IntegrityWay28",
		GaragePoint = { x = -14.1, y = -614.93, z = 34.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 34.073 }
	},
	Garage_IntegrityWay30 = {
		Private = "IntegrityWay30",
		GaragePoint = { x = -14.1, y = -614.93, z = 34.86 },
		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
		DeletePoint = { x = -37.575, y = -620.391, z = 34.073 }
	},
	-- End of Intergrity Way Garages
	-- Start of Dell Perro Heights Garages
	Garage_DellPerroHeights = {
		Private = "DellPerroHeights",
		GaragePoint = { x = -1477.15, y = -517.17, z = 33.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 30.582 }
	},
	Garage_DellPerroHeightst4 = {
		Private = "DellPerroHeightst4",
		GaragePoint = { x = -1477.15, y = -517.17, z = 33.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 30.582 }
	},
	Garage_DellPerroHeightst7 = {
		Private = "DellPerroHeightst7",
		GaragePoint = { x = -1477.15, y = -517.17, z = 33.74 },
		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
		DeletePoint = { x = -1452.612, y = -508.782, z = 30.582 }
	},
	-- End of Dell Perro Heights Garages
	-- Start of Milton Drive Garages
	Garage_MiltonDrive = {
		Private = "MiltonDrive",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Modern1Apartment = {
		Private = "Modern1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Modern2Apartment = {
		Private = "Modern2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Modern3Apartment = {
		Private = "Modern3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Mody1Apartment = {
		Private = "Mody1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Mody2Apartment = {
		Private = "Mody2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Mody3Apartment = {
		Private = "Mody3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Vibrant1Apartment = {
		Private = "Vibrant1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Vibrant2Apartment = {
		Private = "Vibrant2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Vibrant3Apartment = {
		Private = "Vibrant3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Sharp1Apartment = {
		Private = "Sharp1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Sharp2Apartment = {
		Private = "Sharp2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Sharp3Apartment = {
		Private = "Sharp3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Monochrome1Apartment = {
		Private = "Monochrome1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Monochrome2Apartment = {
		Private = "Monochrome2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Monochrome3Apartment = {
		Private = "Monochrome3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Seductive1Apartment = {
		Private = "Seductive1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Seductive2Apartment = {
		Private = "Seductive2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Seductive3Apartment = {
		Private = "Seductive3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Regal1Apartment = {
		Private = "Regal1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Regal2Apartment = {
		Private = "Regal2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Regal3Apartment = {
		Private = "Regal3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Aqua1Apartment = {
		Private = "Aqua1Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Aqua2Apartment = {
		Private = "Aqua2Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	Garage_Aqua3Apartment = {
		Private = "Aqua3Apartment",
		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
	},
	-- End of Milton Drive Garages
	-- Start of Single Garages
	Garage_RichardMajesticApt2 = {
		Private = "RichardMajesticApt2",
		GaragePoint = { x = -887.5, y = -349.58, z = 33.534 },
		SpawnPoint = { x = -886.03, y = -343.78, z = 33.534, h = 206.79 },
		DeletePoint = { x = -894.324, y = -349.326, z = 33.534 }
	},
	Garage_WildOatsDrive = {
		Private = "WildOatsDrive",
		GaragePoint = { x = -178.65, y = 503.45, z = 135.85 },
		SpawnPoint = { x = -189.98, y = 505.8, z = 133.48, h = 282.62 },
		DeletePoint = { x = -189.28, y = 500.56, z = 132.93 }
	},
	Garage_WhispymoundDrive = {
		Private = "WhispymoundDrive",
		GaragePoint = { x = 123.65, y = 565.75, z = 183.04 },
		SpawnPoint = { x = 130.11, y = 571.47, z = 182.42, h = 270.71 },
		DeletePoint = { x = 131.97, y = 566.77, z = 181.95 }
	},
	Garage_NorthConkerAvenue2044 = {
		Private = "NorthConkerAvenue2044",
		GaragePoint = { x = 348.18, y = 443.01, z = 146.7 },
		SpawnPoint = { x = 358.397, y = 437.064, z = 144.277, h = 285.911 },
		DeletePoint = { x = 351.383, y = 438.865, z = 145.66 }
	},
	Garage_NorthConkerAvenue2045 = {
		Private = "NorthConkerAvenue2045",
		GaragePoint = { x = 370.69, y = 430.76, z = 144.11 },
		SpawnPoint = { x = 392.88, y = 434.54, z = 142.17, h = 264.94 },
		DeletePoint = { x = 389.72, y = 429.95, z = 141.81 }
	},
	Garage_HillcrestAvenue2862 = {
		Private = "HillcrestAvenue2862",
		GaragePoint = { x = -688.71, y = 597.57, z = 142.64 },
		SpawnPoint = { x = -683.72, y = 609.88, z = 143.28, h = 338.06 },
		DeletePoint = { x = -685.259, y = 601.083, z = 142.365 }
	},
	Garage_HillcrestAvenue2868 = {
		Private = "HillcrestAvenue2868",
		GaragePoint = { x = -752.753, y = 624.901, z = 141.2 },
		SpawnPoint = { x = -749.32, y = 628.61, z = 141.48, h = 197.14 },
		DeletePoint = { x = -754.286, y = 631.581, z = 141.2 }
	},
	Garage_HillcrestAvenue2874 = {
		Private = "HillcrestAvenue2874",
		GaragePoint = { x = -859.01, y = 695.95, z = 147.93 },
		SpawnPoint = { x = -863.681, y = 698.72, z = 147.052, h = 341.77 },
		DeletePoint = { x = -855.66, y = 698.77, z = 147.81 }
	},
	Garage_MadWayneThunder = {
		Private = "MadWayneThunder",
		GaragePoint = { x = -1290.95, y = 454.52, z = 96.66 },
		SpawnPoint = { x = -1297.62, y = 459.28, z = 96.48, h = 285.652 },
		DeletePoint = { x = -1298.088, y = 468.952, z = 96.0 }
	},
	Garage_TinselTowersApt12 = {
		Private = "TinselTowersApt12",
		GaragePoint = { x = -616.74, y = 56.38, z = 42.736 },
		SpawnPoint = { x = -620.588, y = 60.102, z = 42.736, h = 109.316 },
		DeletePoint = { x = -621.128, y = 52.691, z = 42.735 }
	},
	-- End of Single Garages
	-- Start of VENT Custom Garages
	Garage_MedEndApartment1 = {
		Private = "MedEndApartment1",
		GaragePoint = { x = 240.23, y = 3102.84, z = 41.49 },
		SpawnPoint = { x = 233.58, y = 3094.29, z = 41.49, h = 93.91 },
		DeletePoint = { x = 237.52, y = 3112.63, z = 41.39 }
	},
	Garage_MedEndApartment2 = {
		Private = "MedEndApartment2",
		GaragePoint = { x = 246.08, y = 3174.63, z = 41.72 },
		SpawnPoint = { x = 234.15, y = 3164.37, z = 41.54, h = 102.03 },
		DeletePoint = { x = 240.72, y = 3165.53, z = 41.65 }
	},
	Garage_MedEndApartment3 = {
		Private = "MedEndApartment3",
		GaragePoint = { x = 984.92, y = 2668.95, z = 39.06 },
		SpawnPoint = { x = 993.96, y = 2672.68, z = 39.06, h = 0.61 },
		DeletePoint = { x = 994.04, y = 2662.1, z = 39.13 }
	},
	Garage_MedEndApartment4 = {
		Private = "MedEndApartment4",
		GaragePoint = { x = 196.49, y = 3027.48, z = 42.89 },
		SpawnPoint = { x = 203.1, y = 3039.47, z = 42.08, h = 271.3 },
		DeletePoint = { x = 192.24, y = 3037.95, z = 42.89 }
	},
	Garage_MedEndApartment5 = {
		Private = "MedEndApartment5",
		GaragePoint = { x = 1724.49, y = 4638.13, z = 42.31 },
		SpawnPoint = { x = 1723.98, y = 4630.19, z = 42.23, h = 117.88 },
		DeletePoint = { x = 1733.66, y = 4635.08, z = 42.24 }
	},
	Garage_MedEndApartment6 = {
		Private = "MedEndApartment6",
		GaragePoint = { x = 1670.76, y = 4740.99, z = 41.08 },
		SpawnPoint = { x = 1673.47, y = 4756.51, z = 40.91, h = 12.82 },
		DeletePoint = { x = 1668.46, y = 4750.83, z = 40.88 }
	},
	Garage_MedEndApartment7 = {
		Private = "MedEndApartment7",
		GaragePoint = { x = 15.24, y = 6573.38, z = 31.72 },
		SpawnPoint = { x = 16.77, y = 6581.68, z = 31.42, h = 222.6 },
		DeletePoint = { x = 10.45, y = 6588.04, z = 31.47 }
	},
	Garage_MedEndApartment8 = {
		Private = "MedEndApartment8",
		GaragePoint = { x = -374.73, y = 6187.06, z = 30.54 },
		SpawnPoint = { x = -377.97, y = 6183.73, z = 30.49, h = 223.71 },
		DeletePoint = { x = -383.31, y = 6188.85, z = 30.49 }
	},
	Garage_MedEndApartment9 = {
		Private = "MedEndApartment9",
		GaragePoint = { x = -24.6, y = 6605.99, z = 30.45 },
		SpawnPoint = { x = -16.0, y = 6607.74, z = 30.18, h = 35.31 },
		DeletePoint = { x = -9.36, y = 6598.86, z = 30.47 }
	},
	Garage_MedEndApartment10 = {
		Private = "MedEndApartment10",
		GaragePoint = { x = -365.18, y = 6323.95, z = 28.9 },
		SpawnPoint = { x = -359.49, y = 6327.41, z = 28.83, h = 218.58 },
		DeletePoint = { x = -353.47, y = 6334.57, z = 28.83 }
	} ]]
	-- End of VENT Custom Garages
}

-- End of Private Garages
