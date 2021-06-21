-- *** illegal hideout
-- ! by kapu

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local taker = {}
local owner = {}
local ownerName = {}
local captureTime = 30000
local start = false
local count = false
local reward = nil




RegisterNetEvent('pk_hideout:setHideoutOwner')
AddEventHandler('pk_hideout:setHideoutOwner', function(targetLocation)
  setOwner(source, targetLocation)
end)

RegisterNetEvent('pk_hideout:captureHideoutInterrupt')
AddEventHandler('pk_hideout:captureHideoutInterrupt', function(targetLocation)
  if (taker[targetLocation] == source) then taker[targetLocation] = nil end
end)

RegisterNetEvent('pk_hideout:reward')
AddEventHandler('pk_hideout:reward', function()
  local xPlayer = ESX.GetPlayerFromId(reward)
	if xPlayer ~= nil then
		if xPlayer.job.name == 'police' then
			xPlayer.addMoney(500)
		else
			xPlayer.addInventoryItem("marijuana", 1)
			-- xPlayer.addAccountMoney('black_money', 200)
			-- TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~You got a Share 200 black money')
		end
	end
end)

ESX.RegisterServerCallback('pk_hideout:captureHideout', function(source, cb, targetLocation)
  if owner[targetLocation] == source then cb('owned') return end
  if taker[targetLocation] == nil then 
    capture(source, targetLocation)
  end
  cb(taker[targetLocation], captureTime)
end)

function capture(source, targetLocation)
  taker[targetLocation] = source
  local takerName = ESX.GetPlayerFromId(taker[targetLocation]).getName()
  -- TriggerClientEvent('chat:addMessage', -1, {
    -- color = { 255, 0, 0},
    -- multiline = true,
    -- args = {"... illegal hideout is being captured by " .. takerName .. " ..."}
  -- })
	--if xPlayer.job.name ~= 'police' then
		TriggerClientEvent('chat:addMessage', -1, { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 123, 235, 0.6); border-radius: 3px;">{0} : {1}</div>',
						args = { '[HIDEOUT]',"Các điểm chiến lược đang được nắm bắt bởi " .. takerName .. " "}
      })
     --[[ TriggerClientEvent('chat:addMessage', playerId, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 255, 0, 0.6); border-radius: 3px;"> [BUX] {0}({1}) {2}({3})</div>',
        args = { "... จุดยุทธศาสตร์กำลังถูกยึดโดย " .. takerName .. " ..." }
      })]]
	--end
  CreateThread(function()
    local finishTime = GetGameTimer() + captureTime
    while finishTime > GetGameTimer() do
      Wait(0)
      if taker[targetLocation] ~= source then
        -- TriggerClientEvent('chat:addMessage', -1, {
          -- color = { 255, 0, 0},
          -- multiline = true,
          -- args = {"... " .. takerName .. " failed to capture the illegal hideout ..."}
        -- })
        TriggerClientEvent('chat:addMessage', -1, { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 123, 235, 0.6); border-radius: 3px;">{0} : {1}</div>',
					args = { '[HIDEOUT]',"" .. takerName .. " Không thu giữ được " }
		})
        return
      end
    end
    setOwner(taker[targetLocation], targetLocation)
    taker[targetLocation] = nil
  end)
end


function setOwner(source, targetLocation)
  owner[targetLocation] = source
  ownerName[targetLocation] = ESX.GetPlayerFromId(owner[targetLocation]).getName()
  reward = owner[targetLocation]
  -- TriggerClientEvent('chat:addMessage', -1, {
    -- color = { 255, 0, 0},
    -- multiline = true,
    -- args = {"!!! illegal hideout has been captured by " .. ownerName[targetLocation] .. " !!!"}
  -- })
	--if xPlayer.job.name ~= 'police' then
	TriggerClientEvent('chat:addMessage', -1, { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 123, 235, 0.6); border-radius: 3px;">{0} : {1}</div>',
						args = { '[HIDEOUT]',"Các điểm chiến lược đã bị chiếm bởi " .. ownerName[targetLocation] .. " " }
			})
	--end
	TriggerClientEvent("pk_hideout:set", -1, false)
	
end

function getOwner(targetLocation)
  return owner[targetLocation]
end

function getOwnership(targetLocation)
  return owner[targetLocation] == source
end

Citizen.CreateThread(function()
    while true do
		Wait(420000)
		TriggerEvent('pk_hideout:reward')
		TriggerClientEvent("pk_hideout:set", -1, false)
    end
end)