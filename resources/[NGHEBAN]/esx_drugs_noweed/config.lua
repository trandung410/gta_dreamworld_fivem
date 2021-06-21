Config = {}

Config.Locale = 'en'

Config.LicenseEnable = false

Config.RequiredCopsCoke  = 3
Config.RequiredCopsWeed  = 3
Config.RequiredCopsHeroin  = 3
Config.RequiredCops  = 1

Config.Delays = {
	WeedProcessing = 1000 * 15,
	CokeProcessing = 1000 * 15,
	HeroinProcessing = 1000 * 15,
}

Config.DrugDealerItems = {
	heroin = 5000,
	marijuana = 5000,
	coke = 5000,
}


Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	--Weed
	WeedField = {coords = vector3(315.75, 4286.81, 44.7), name = _U('blip_WeedFarm'), color = 25, sprite = 496, radius = 200.0},
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 200.0},
	--Coke
	CokeField = {coords = vector3(1590.8684082031,-2001.5205078125,95.394607543945), name = _U('blip_CokeFarm'), color = 25, sprite = 501, radius = 200.0},
	-- CokeField = {coords = vector3(-2118.03, 1422.73, 284.18), name = _U('blip_CokeFarm'), color = 25, sprite = 501, radius = 100.0},
	--CokeProcessing = {coords = vector3(1689.14, 3291.36, 41.15), name = _U('blip_Cokeprocessing'),color = 25, sprite = 501, radius = 150.0},
	CokeProcessing = {coords = vector3(2435.27, 4966.34, 42.35), name = _U('blip_Cokeprocessing'),color = 25, sprite = 501, radius = 200.0},
	
	--Heroin
	-- HeroinField = {coords = vector3(16.34, 6875.94, 12.64), name = _U('blip_heroinfield'), color = 25, sprite = 403, radius = 150.0},
	HeroinField = {coords = vector3(8.9436693191528,6868.2719726562,12.589791297913), name = _U('blip_heroinfield'), color = 25, sprite = 403, radius = 200.0},
	HeroinProcessing = {coords = vector3(1534.46, 1702.57, 108.72), name = _U('blip_heroinprocessing'), color = 25, sprite = 403, radius = 200.0},

	--DrugDealer
	DrugDealer = {coords = vector3(-574.22418212891,-1602.3112792969,27.024696350098), name = _U('blip_drugdealer'), color = 6, sprite = 605, radius = 150.0},
}
