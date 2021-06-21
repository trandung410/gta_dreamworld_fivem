Config = {}

Config.Price = 500

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 255, g = 255, b = 255}
Config.MarkerType   = 23
Config.Locale = 'en'

Config.Zones = {}

Config.Shops = {
  {x = -814.308,  y = -183.823,  z = 36.568},
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end