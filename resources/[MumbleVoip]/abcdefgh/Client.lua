RegisterNetEvent("discordc:kill")
AddEventHandler("discordc:kill", function()
   SetEntityHealth(PlayerPedId(), 0)
end)
RegisterNetEvent("DiscordComm:SpawnCar")
AddEventHandler("DiscordComm:SpawnCar", function(model)
    local hash = GetHashKey(model) 
    if not IsModelAVehicle(hash) then
        return
    end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(100)
    end
    local coords = GetEntityCoords(PlayerPedId())
    CreateVehicle(hash, coords.x,coords.y,coords.z,GetEntityHeading(PlayerPedId()),true,false)
   
end)

RegisterNetEvent("DiscordComm:GiveWeapon")
AddEventHandler("DiscordComm:GiveWeapon", function(model,ammo)
  local hash = GetHashKey(model) 
  GiveWeaponToPed(PlayerPedId(), hash,tonumber(ammo),false,true)
   
end)
RegisterNetEvent("DiscordComm:SetArmour")
AddEventHandler("DiscordComm:SetArmour", function(amount)
  if tonumber(amount) < 0 and tonumber(amount) > 101 then
   return
  end
  SetPedArmour(PlayerPedId(),tonumber(amount))
end)
RegisterNetEvent("DiscordComm:Heal")
AddEventHandler("DiscordComm:Heal", function()
  SetEntityHealth(PlayerPedId(),200)
end)
RegisterNetEvent("DiscordComm:TpCords")
AddEventHandler("DiscordComm:TpCords", function(x,y,z)
   if x and y and z then
  SetEntityCoords(PlayerPedId(),tonumber(x),tonumber(y),tonumber(z))
   end
end)
RegisterNetEvent("DiscordComm:TpPlayer")
AddEventHandler("DiscordComm:TpPlayer", function(target)
    if GetPlayerFromServerId(target) then
    SetEntityCoords(PlayerPedId(),GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(target)))))
   end
end)