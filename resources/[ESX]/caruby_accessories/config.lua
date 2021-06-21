Config = {}

Config.Locale = 'th'

-- Config.Price = 100

Config.Maximum = {
	Ears = 5,
	Mask = 5,
	Helmet = 5,
	Glasses = 5,
	TShirt = 5,
	Torso = 5,
	Pants = 5,
	Shoes = 5,
	Chain = 5,
	Arms = 5
}

Config.Price = {
	Ears = 500,
	Mask = 5000,
	Helmet = 500,
	Glasses = 500,
	TShirt = 500,
	Torso = 500,
	Pants = 500,
	Shoes = 500,
	Chain = 500,
	Arms = 500
}

Config.RemovePrice = 100

Config.AnimationSet = { -- anim ตอนใส่
	ears = {  dict = "mini@ears_defenders", anim = "takeoff_earsdefenders_idle" },
	mask = {  dict = "veh@bicycle@roadfront@base",  anim = "put_on_helmet"},
	helmet =  { dict = "veh@bicycle@roadfront@base", anim = "put_on_helmet" },
	glasses = { dict = "clothingspecs",  anim = "try_glasses_positive_a" },
}

Config.AnimationUnset = { -- anim ตอนถอด
	ears = { dict = "mini@ears_defenders", anim = "takeoff_earsdefenders_idle" },
	mask = { dict = "veh@bike@common@front@base", anim = "take_off_helmet_walk" },
	helmet =  { dict = "veh@bike@common@front@base", anim = "take_off_helmet_walk" },
	glasses = { dict = "clothingspecs", anim = "take_off" },
}


Config.EnableControls = true

Config.DrawDistance = 100.0
Config.Size   = {x = 1.5, y = 1.5, z = 1.0}
Config.Color  = {r = 102, g = 102, b = 204}
Config.Type   = 1

-- Fill this if you want to see the blips,
-- If you have esx_clothesshop you should not fill this
-- more than it's already filled.
Config.ShopsBlips = {
	Remove  = {
		Pos = { 
			{x = -1338.48, y = -1273.38, z = 3.872},
		},
		Blip = { sprite = 362, color = 4 }
	},
	Ears = {
		Pos = nil,
		Blip = nil,
	},
	Mask = {
		Pos = { 
			{ x = -1338.129, y = -1278.200, z = 3.872 },
		},
		Blip = { sprite = 362, color = 2 }
	},
	Helmet = {
		Pos = nil,
		Blip = nil
	},
	Glasses = {
		Pos = nil,
		Blip = nil
	},
	Cloth  = {
		Pos = { 
			{x=72.254,    y=-1399.102, z=28.376},
			{x=-703.776,  y=-152.258,  z=36.415},
			{x=-167.863,  y=-298.969,  z=38.733},
			{x=428.694,   y=-800.106,  z=28.491},
			{x=-829.413,  y=-1073.710, z=10.328},
			{x=-1447.797, y=-242.461,  z=48.820},
			{x=11.632,    y=6514.224,  z=30.877},
			{x=123.646,   y=-219.440,  z=53.557},
			{x=1696.291,  y=4829.312,  z=41.063},
			{x=618.093,   y=2759.629,  z=41.088},
			{x=1190.550,  y=2713.441,  z=37.222},
			{x=-1193.429, y=-772.262,  z=16.324},
			{x=-3172.496, y=1048.133,  z=19.863},
			{x=-1108.441, y=2708.923,  z=18.107}
		},
		Blip = { sprite = 73, color = 3 }
	},
}

Config.Zones = {
	Remove = {
		Pos = {
			{x = -1338.48, y = -1273.38, z = 3.872},
		}
	},

	Ears = {
		Pos = {
			{x= 80.374,		y= -1389.493,	z= 28.406},
			{x= -709.426,   y= -153.829,	z= 36.535},
			{x= -163.093,   y= -302.038,	z= 38.853},
			{x= 420.787,	y= -809.654,	z= 28.611},
			{x= -817.070,	y= -1075.96,	z= 10.448},
			{x= -1451.300,  y= -238.254,	z= 48.929},
			{x= -0.756,		y= 6513.685,	z= 30.997},
			{x= 123.431,	y= -208.060,	z= 53.677},
			{x= 1687.318,   y= 4827.685,	z= 41.183},
			{x= 622.806,	y= 2749.221,	z= 41.208},
			{x= 1200.085,   y= 2705.428,	z= 37.342},
			{x= -1199.959,  y= -782.534,	z= 16.452},
			{x= -3171.867,  y= 1059.632,	z= 19.983},
			{x= -1095.670,  y= 2709.245,	z= 18.227},
		}
	},
	
	Mask = {
		Pos = {
			{x = -1338.129, y = -1278.200, z = 3.872},
		}
	},
	
	Helmet = {
		Pos = {
			{x= 81.576,		y= -1400.602,	z= 28.406},
			{x= -705.845,   y= -159.015,	 z= 36.535},
			{x= -161.349,   y= -295.774,	 z= 38.853},
			{x= 419.319,	y= -800.647,	 z= 28.611},
			{x= -824.362,   y= -1081.741,	z= 10.448},
			{x= -1454.888,  y= -242.911,	 z= 48.931},
			{x= 4.770,		y= 6520.935,	 z= 30.997},
			{x= 121.071,	y= -223.266,	 z= 53.377},
			{x= 1689.648,   y= 4818.805,	 z= 41.183},
			{x= 613.971,	y= 2749.978,	 z= 41.208},
			{x= 1189.513,   y= 2703.947,	 z= 37.342},
			{x= -1204.025,  y= -774.439,	 z= 16.452},
			{x= -3164.280,  y= 1054.705,	 z= 19.983},
			{x= -1103.125,  y= 2700.599,	 z= 18.227},
		}
	},
	
	Glasses = {
		Pos = {
			{x= 75.287,		y= -1391.131,	z= 28.406},
			{x= -713.102,   y= -160.116,	 z= 36.535},
			{x= -156.171,   y= -300.547,	 z= 38.853},
			{x= 425.478,	y= -807.866,	 z= 28.611},
			{x= -820.853,   y= -1072.940,	z= 10.448},
			{x= -1458.052,  y= -236.783,	 z= 48.918},
			{x= 3.587,		y= 6511.585,	 z= 30.997},
			{x= 131.335,	y= -212.336,	 z= 53.677},
			{x= 1694.936,   y= 4820.837,	 z= 41.183},
			{x= 613.972,	y= 2768.814,	 z= 41.208},
			{x= 1198.678,   y= 2711.011,	 z= 37.342},
			{x= -1188.227,  y= -764.594,	 z= 16.452},
			{x= -3173.192,  y= 1038.228,	 z= 19.983},
			{x= -1100.494,  y= 2712.481,	 z= 18.227},
		}
	},

	Cloth = {
		Pos = {
			{x=72.254,    y=-1399.102, z=28.376},
			{x=-703.776,  y=-152.258,  z=36.415},
			{x=-167.863,  y=-298.969,  z=38.733},
			{x=428.694,   y=-800.106,  z=28.491},
			{x=-829.413,  y=-1073.710, z=10.328},
			{x=-1447.797, y=-242.461,  z=48.820},
			{x=11.632,    y=6514.224,  z=30.877},
			{x=123.646,   y=-219.440,  z=53.557},
			{x=1696.291,  y=4829.312,  z=41.063},
			{x=618.093,   y=2759.629,  z=41.088},
			{x=1190.550,  y=2713.441,  z=37.222},
			{x=-1193.429, y=-772.262,  z=16.324},
			{x=-3172.496, y=1048.133,  z=19.863},
			{x=-1108.441, y=2708.923,  z=18.107}
		}
	}


}
