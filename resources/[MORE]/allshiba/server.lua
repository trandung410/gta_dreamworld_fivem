ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- RegisterCommand("clearserver", function(source, args, rawCommand)
-- 	if source == 0 then 
-- 		TriggerClientEvent("esx:showNotification", -1, "Phương tiện không có người sẽ bị xóa sau 1 phút")
-- 		Wait(60000)
-- 		local objects = GetAllObjects()
-- 		local peds = GetAllPeds()
-- 		local vehicles = GetAllVehicles()
-- 		for k, v in pairs(objects) do 
-- 			DeleteEntity(v)
-- 		end
-- 		for k, v in pairs(peds) do 
-- 			DeleteEntity(v)
-- 		end
-- 		for k, v in pairs(vehicles) do 
-- 			local hasStart = GetIsVehicleEngineRunning(v)
-- 			if not hasStart then 
-- 				DeleteEntity(v)
-- 			end
-- 		end
-- 	end
-- end, true)

TriggerEvent('es:addGroupCommand', 'clearserver', 'admin', function(source, args, user)
	TriggerClientEvent("esx:showNotification", -1, "Phương tiện không có người sẽ bị xóa sau 1 phút")
	Wait(60000)
	local vehs = GetAllVehicles()
    local peds = GetAllPeds()
    local entitys = GetAllObjects()
    for _, entity in ipairs(vehs) do 
        if GetPedInVehicleSeat(entity, 1) ~= 0 then
            DeleteEntity(entity)
        end
    end
    for _, entity in ipairs(peds) do 
        DeleteEntity(entity)
    end
    for _, entity in ipairs(entitys) do 
        DeleteEntity(entity)
    end
	Wait(1000)
	TriggerClientEvent("esx:showNotification", -1, "~g~Xoá thành công")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Không đủ quyền hạn.' } })
end, { help = 'Clear lag'})