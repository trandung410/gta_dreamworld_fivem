Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_MICROSMG'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_STICKYBOMB'))
	end
end)