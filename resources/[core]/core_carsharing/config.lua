Config = {


	badParkingDelete = false, -- Delete the vehicle if left outside zone
	penaltyOutsideZone = 0, -- Amount to pay if vehicle is left ouside zone (keep 0 if no penalty)
	damagePenalty = 10, -- The price paid every time the vehicle gets damaged
	damagePercentForPenalty = 10, -- From what percent of cars health removed you get the penalty (1% being ultra sensitive / 100% means you have to break whole car)

	vehiclePlateText = "SHARING", -- IMPORTANT: Change this to any text with less then 8 characters

	vehicleSpawnRate = 20, -- Seconds to wait in zone until vehicle spawns

	vehicleUnlockFee = 100.0, -- The price paid to unlock a vehicle
	vehicleUnlockKey = 'G',    -- The key used to unlock vehicle

	licenseRequired = '', -- Keep empty if license is not required or us registered license on ESX

	--Blip information https://docs.fivem.net/docs/game-references/blips/
	ZoneBlipDisplay = 326,
	ZoneBlipColor = 3, 
	ZoneBlipText = "Carsharing zone",

	Zones = {

		-- Chu i
		{
			Center = vector3(-280.87,-985.5,31.08), -- Center of the zone
			Size = 25.0,        -- Size of the zone
			SpawnPoints = {     -- Spawn points must be inside the zone!

				{x = -275.66, y = -987.37, z = 31.08, h =251.62},
				{x = -280.87, y = -985.5, z = 31.08, h =247.18},
				{x = -286.53, y = -983.38, z = 31.08, h =243.36}

			}
		}


	},

	Vehicles = {

		{
			Display = "Asea", -- Display name of vehicle (Ex. BMW X5 2019)
			Model   = "asea", -- Model name of the car used to spawn vehicle
			Price   = 50.0,      -- Price per minute
		}

	},


	Text = {

		['primaryColor'] = 	{r = 51, g = 136, b = 255, a = 255}, -- Use RGB color picker
		['secondaryColor'] = {r = 220, g = 220, b = 220, a = 255}, -- Use RGB color picker

		['serviceName']  = "Carsharing",
		['vehicleUnlocked'] = "Vehicle has been unlocked! ~b~Drive safely",
		['noMoneyOrLicense'] = "You dont have enough money or a valid license!",
		['paid'] = "You have paid ~b~{price} $~w~ for your ride!",
		['badParking'] = "Vehicle has been removed due to parking outside of a zone",
		['penaltyPaid'] = "You paid ~b~{penaltyPrice} $~w~ for parking the vehicle outside of a zone",
		['damagePenalty'] = "You paid ~b~{penaltyPrice} $~w~ for damaging the vehicle",
		['pricePerMinute'] = "1 Minute | ${price}",
		['vehicleInfo'] = "Vehicle: {info}",
		['unlockText'] = "To unlock press [ G ] for ${price}",
		['zoneInfo'] = "While you are within the zone vehicles will appear!",
		['zoneTitle'] = "Carsharing Zone"
	
	}

}

-- Only change if you know what are you doing!
function SendTextMessage(msg)

		SetNotificationTextEntry('STRING')
		AddTextComponentString(msg)
		DrawNotification(0,1)

end
