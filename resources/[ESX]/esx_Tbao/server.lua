TriggerEvent('es:addGroupCommand','tb','admin',function(source,args)
    Citizen.CreateThread(function()
        local str = ''
        local dem = 0
        for k,v in ipairs(args) do
           str = str .. v .. ' '
           dem = dem + 1
        end
        TriggerClientEvent('nui:on', -1, str)
        Citizen.Wait((dem+3)*2200)
        TriggerClientEvent('nui:off', -1)
      end)
end)

RegisterServerEvent('esx_Tbao:thongbao')
AddEventHandler('esx_Tbao:thongbao',function(text)
  Citizen.CreateThread(function()
    local dem = _demtext(text)
    TriggerClientEvent('nui:on', -1, text)
    Citizen.Wait((dem+3)*2200)
    TriggerClientEvent('nui:off', -1)
  end)
end)

-- TriggerEvent('es:addGroupCommand','testcuop','admin',function(source,args)
--   local str = "Dang co vu cuop o paffic"
--   TriggerEvent("esx_Tbao:thongbao",str)
-- end)

function _demtext(str)
  local dem = 0
  for i in string.gmatch(str, "%S+") do
    dem = dem + 1
  end
  return dem
end