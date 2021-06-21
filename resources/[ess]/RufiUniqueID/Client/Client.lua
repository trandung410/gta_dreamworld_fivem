
local UIDS = nil
local UIDtoID = nil

RegisterNetEvent('RufiUID:GetInfo')
AddEventHandler('RufiUID:GetInfo', function(uids, ids)
	UIDS = uids
	UIDtoID = ids
	--MyUID = UIDS[GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))]
  
end)

exports('GetUIDfromID', function(ID)
  local id = ID
return UIDS[id]
end)


exports('GetIDfromUID', function(PUID)
  local id = PUID
return UIDtoID[id]
end)

CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('RufiUID:GetInfo')
			break
		end
	end
end)
