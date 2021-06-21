Config = {}
Config.Locale = 'en'

Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.0, y = 2.0, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}

Config.BlipPlasticSurgery = {
	Sprite = 480,
	Color = 47,
	Display = 2,
	Scale = 1.0
}

Config.Price = 2000 -- Edit to your liking.

Config.EnableUnemployedOnly = false -- If true it will only show Blips to Unemployed Players | false shows it to Everyone.
Config.EnableBlips = true -- If true then it will show blips | false does the Opposite.
Config.EnablePeds = false -- If true then it will add Peds on Markers | false does the Opposite.

Config.Locations = {
	{ x = 68.29, y = -959.77, z = 28.8, heading = 332.72 },
	--{ x = -567.97, y = -679.49, z = 31.36, heading = 140.89 },
	--{ x = -881.1, y = -2181.26, z = 7.93, heading = 316.59 },
	--{ x = 992.01, y = -1397.76, z = 30.36, heading = 271.54 },
	--{ x = 478.91, y = -107.62, z = 62.16, heading = 145.23 }
}

Config.Zones = {}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
