local PlayerData = {}
ESX                           = nil

weaponblacklist = {
	"WEAPON_ADVANCEDRIFLE",
}
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
				local _source = source

		playerPed = GetPlayerPed(-1)
		Citizen.Wait(1000)
		if playerPed then
			if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' then 
				nothing, weapon = GetCurrentPedWeapon(playerPed, true)
				if isWeaponBlacklisted(weapon) then
					SetEntityAsMissionEntity( weapon, true, true )
					RemoveWeaponFromPed(playerPed, weapon)
					TriggerEvent("pNotify:SendNotification", {text = "Bạn không thể sử dụng súng này.", type = "error", timeout = 2000, layout = "bottomCenter"})
				end
			end
		end
	end
end)
function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) or model == 2210333304 then
			return true
		end
	end

	return false
end