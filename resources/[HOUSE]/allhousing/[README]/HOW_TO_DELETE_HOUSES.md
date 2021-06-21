How to:

Remove house:
Either add the following to the client.lua and server.lua and fire the command to delete the nearest house,
or remove the houses directly from the database.
Houses that are defined in the config.lua must also be removed from the config file manually.

REMOVAL COMMAND:
NOTE: Don't leave this on your server. This completely deletes the closest house to the player and all corresponding data.
Server/script must be restarted for this to take effect.

-- Add to client side:
RegisterCommand('delhouse', function(...)  
  local closestDist,closest
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  for _,thisHouse in pairs(Houses) do
    local dist = Vdist(plyPos,thisHouse.Entry.xyz)
    if not closestDist or dist < closestDist then
      closest = thisHouse
      closestDist = dist
    end
  end
  if closest and closestDist and closestDist < 50.0 then
    TriggerServerEvent("Allhousing:FullDeleteHouse",closest)
  end
end)

RegisterNetEvent("Allhousing:DelHouse")
AddEventHandler("Allhousing:DelHouse", function(house_id)
  local house = Houses[house_id]
  if house.Blip then
    RemoveBlip(house.Blip)
  end
  Houses[house_id] = nil
end)

-- Add to server side:
RegisterNetEvent("Allhousing:FullDeleteHouse")
AddEventHandler("Allhousing:FullDeleteHouse",function(house)
  MySQL.Async.execute("DELETE FROM allhousing WHERE id=@id",{['@id'] = house.Id})
  TriggerClientEvent("Allhousing:DelHouse",-1,house.Id)
  Houses[house.Id] = nil
end)