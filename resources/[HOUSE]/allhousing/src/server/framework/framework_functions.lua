GetESX = function()
  while not ESX do
    TriggerEvent("esx:getSharedObject", function(obj)
      ESX = obj
    end)
    Wait(0)
  end
end

GetFramework = function()
  if Config.UsingESX then
    GetESX()
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerData = function(source)
  if Config.UsingESX then
    local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Wait(0); end
    return xPlayer
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerCash = function(source)
  if Config.UsingESX then
    return GetPlayerData(source).getMoney()
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerBank = function(source)
  if Config.UsingESX then
    if Config["UsingESX_V1.2.0"] then
      return GetPlayerData(source).getAccount(Config.BankAccountName).money
    else
      return GetPlayerData(source).getBank()
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerJobName = function(source)
  if Config.UsingESX then
    return GetPlayerData(source).getJob().name
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerJobRank = function(source)
  if Config.UsingESX then
    return GetPlayerData(source).getJob().grade
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerIdentifier = function(source,ignoreKash)
  if Config.UsingESX then
    if not ignoreKash and Config.UsingKashacters then
      return KashCache[source]
    else
      return GetPlayerData(source).identifier
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end

TakePlayerBank = function(source,val)
  if Config.UsingESX then
    GetPlayerData(source).removeAccountMoney(Config.BankAccountName,val)
  else
    -- NON-ESX USERS ADD HERE
  end
end

TakePlayerDirty = function(source,val)
  if Config.UsingESX then
    GetPlayerData(source).removeAccountMoney(Config.DirtyAccountName,val)
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerDirty = function(source,val)
  if Config.UsingESX then
    return GetPlayerData(source).getAccount(Config.DirtyAccountName,val).money
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerWeapon = function(source,name)
  if Config.UsingESX then
    local loadout = GetPlayerData(source).getLoadout()
    for k,v in pairs(loadout) do
      if v.name == name then
        return v.name,v.ammo,v.label,v.components
      end
    end
    return false,0
  else
    -- NON-ESX USERS ADD HERE
  end
end

AddPlayerWeapon = function(source,name,ammo)
  if Config.UsingESX then
    GetPlayerData(source).addWeapon(name,ammo)
  else
    -- NON-ESX USERS ADD HERE
  end
end

TakePlayerWeapon = function(source,name,ammo)
  if Config.UsingESX then
    GetPlayerData(source).removeWeapon(name)
  else
    -- NON-ESX USERS ADD HERE
  end
end

AddPlayerCash = function(source,value)
  if Config.UsingESX then
    GetPlayerData(source).addMoney(value)
  else
    -- NON-ESX USERS ADD HERE
  end
end

TakePlayerCash = function(source,val)
  if Config.UsingESX then
    GetPlayerData(source).removeMoney(val)
  else
    -- NON-ESX USERS ADD HERE
  end
end

TakePlayerItem = function(source,itemName,count)
  if Config.UsingESX then
    GetPlayerData(source).removeInventoryItem(itemName,(count or 1))
  else
    -- NON-ESX USERS ADD HERE
  end
end

AddOfflineCash = function(identifier,val)
  if Config.UsingESX then
    MySQL.Async.execute("UPDATE users SET money=money+@addCash WHERE identifier=@identifier",{['@identifier'] = identifier,['@addCash'] = val})
  else
    -- NON-ESX USERS ADD HERE
  end
end

AddOfflineBank = function(identifier,val)
  if Config.UsingExtendedMode then
    MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier=@identifier',{
      ['@identifier'] = identifier
    },function(res)
      if res and res[1] then
        local accounts = json.decode(res[1].account)
        accounts.bank = accounts.bank + tonumber(val)

        MySQL.Async.execute("UPDATE users SET accounts = @accounts WHERE identifier=@identifier",{
          ['@identifier'] = identifier,
          ['@accounts'] = json.encode(accounts)
        })
      end
    end)
  elseif Config.UsingESX then
    if Config.UsingKashacters then
      local charId  = identifier:sub(1,1)
      local kashId  = "Char"..charId..":"..identifier:sub(3)
      local steamId = "steam:"..identifier:sub(3)

      MySQL.Async.fetchAll("SELECT * FROM user_lastcharacter WHERE steamid=@steamid",{['@steamid'] = steamId},function(res)
        if res and res[1] and tonumber(res[1].charid) == tonumber(charId) then
          if Config["UsingESX_V1.2.0"] then
            MySQL.Async.execute("UPDATE user_accounts SET money = money + @add WHERE identifier=@identifier AND name=@name",{
              ['@add'] = tonumber(val),
              ['@identifier'] = steamId,
              ['@name'] = Config.BankAccountName
            })
          else
            MySQL.Async.execute("UPDATE users SET bank = bank + @add WHERE identifier=@identifier",{
              ['@add'] = tonumber(val),
              ['@identifier'] = steamId
            })
          end
        else
          if Config["UsingESX_V1.2.0"] then
            MySQL.Async.execute("UPDATE user_accounts SET money = money + @add WHERE identifier=@identifier AND name=@name",{
              ['@add'] = tonumber(val),
              ['@identifier'] = kashId,
              ['@name'] = Config.BankAccountName
            })
          else
            MySQL.Async.execute("UPDATE users SET bank = bank + @add WHERE identifier=@identifier",{
              ['@add'] = tonumber(val),
              ['@identifier'] = kashId
            })
          end
        end
      end)
    else
      local steamId = identifier
      if Config["UsingESX_V1.2.0"] then
        MySQL.Async.execute("UPDATE user_accounts SET money = money + @add WHERE identifier=@identifier AND name=@name",{
          ['@add'] = tonumber(val),
          ['@identifier'] = steamId,
          ['@name'] = Config.BankAccountName
        })
      else
        MySQL.Async.execute("UPDATE users SET bank = bank + @add WHERE identifier=@identifier",{
          ['@add'] = tonumber(val),
          ['@identifier'] = steamId
        })
      end
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end

CanPlayerAfford = function(source,val)
  if GetPlayerCash(source) >= val then
    return true
  elseif GetPlayerBank(source) >= val then
    return true
  else
    return false
  end
end

GetPlayerByIdentifier = function(identifier)
  local charId
  if Config.UsingESX then
    if Config.UsingKashacters then
      charId = identifier:sub(1,1)
      if Config["UsingESX_V1.2.0"] then
        identifier = identifier:sub(3)
      else
        identifier = "steam:"..identifier:sub(3)
      end
    end

    local player = ESX.GetPlayerFromIdentifier(identifier)
    local start = GetGameTimer()
    while GetGameTimer() - start < 1000 and not player do
      player = ESX.GetPlayerFromIdentifier(identifier)
      Wait(0)
    end

    if not player then 
      return false
    else
      if Config.UsingKashacters then
        if KashCharacters[player.source] and tonumber(charId) == tonumber(KashCharacters[player.source]) then
          return player
        else
          return false
        end
      else
        return player
      end
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end

AddPlayerBank = function(source,val)
  if Config.UsingESX then
    if Config["UsingESX_V1.2.0"] then
      GetPlayerData(source).addAccountMoney(Config.BankAccountName,val)
    else
      GetPlayerData(source).addBank(val)
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end  

AddPlayerItem = function(source,name,count)
  if Config.UsingESX then
    GetPlayerData(source).addInventoryItem(name,count)
  else
    -- NON-ESX USERS ADD HERE
  end
end  

AddPlayerDirtyMoney = function(source,val)
  if Config.UsingESX then
    if Config.DirtyAccountName then
      GetPlayerData(source).addAccountMoney(Config.DirtyAccountName,val)
    else
      _print("[AddPlayerDirtyMoney]","No dirty account set in config.lua")
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end    

GetPlayerSource = function(player)
  if Config.UsingESX then
    return player.source
  else
    -- NON-ESX USERS ADD HERE
  end
end  

GetPlayerItemCount = function(source,item)
  if Config.UsingESX then
    return GetPlayerData(source).getInventoryItem(item).count
  else
    -- NON-ESX USERS ADD HERE    
  end
end 

GetPlayerItemData = function(source,item)
  if Config.UsingESX then
    return GetPlayerData(source).getInventoryItem(item)
  else
    -- NON-ESX USERS ADD HERE    
  end
end    

GetCharacterName = function(source)
  if Config.UsingESX then
    local data = GetPlayerData(source) 
    return (data.name)
  else
    -- NON-ESX USERS ADD HERE 
  end
end

AddSocietyMoney = function(account,money)
  TriggerEvent("esx_addonaccount:getSharedAccount",account,function(acc)
    if acc and type(acc) == "table" then
      acc.addMoney(tonumber(money))
    else
      print(string.format("Society not found for %s",account))
    end
  end)
end

CanPlayerCarry = function(source,name,count)
  if Config.UsingESX then
    if Config["UsingESX_V1.2.0"] then
      return GetPlayerData(source).canCarryItem(name,count)
    else
      local player = GetPlayerData(source)
      local itemData = player.getInventoryItem(name)
      if itemData.limit and itemData.limit ~= -1 and itemData.count and itemData.count + count > itemData.limit then
        return false
      else
        return true
      end
    end
  else
    -- NON-ESX USERS ADD HERE  
  end
end

NotifyJobs = function(job,msg,pos)
  TriggerClientEvent("Allhousing:NotifyJob",-1,job,msg,pos)
end

NotifyPlayer = function(source,msg)
  TriggerClientEvent("Allhousing:NotifyPlayer",source,msg)
end

RegisterNetEvent("Allhousing:NotifyJobs")
AddEventHandler("Allhousing:NotifyJobs",NotifyJobs)