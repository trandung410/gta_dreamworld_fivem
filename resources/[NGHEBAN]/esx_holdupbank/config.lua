Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}
Config.lockdown = 2000 --- minutes
Config.PoliceNumberRequired = 6
Config.TimerBeforeNewRob    = 3600 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 50 -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Config.Reward = math.random(700000, 1000000)
Config.Position = {
	{ x = 147.04908752441, y = -1044.94482, z = 29.368 },
	{ x = -2957.66, y = 481.4577, z = 15.6970},
	{ x = -107.0650, y =  6474.801, z = 31.6267 },
	{ x =  255.0010, y = 225.8558, z = 101.0056 }
}

Config.TimeRob = 1500 -----seconds
