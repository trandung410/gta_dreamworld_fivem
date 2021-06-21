Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
rt = nil
Garages = {}
Garages.__index = Garages

function Garages:Create()
	
	local obj = {}
	setmetatable(obj, Garages)
	obj.garages = {}
	obj.blips = {}
	obj.PlayerData = ESX.GetPlayerData()
	obj.curAction = nil
	obj.shouldShowHelp = true
	obj.curGarage = nil
	obj.curGarageType = ''
	obj.isUIOpen = false
	obj.allHousing = nil
	return obj
end

function Garages:AddGarage(type, name, data)
	self.garages[name] = data
	if data.Gang == nil then
		local blip = AddBlipForCoord(data.GaragePoint.x, data.GaragePoint.y, data.GaragePoint.z)
		if data.Type == 14 then 
			SetBlipSprite(blip, 356)
		else
			SetBlipSprite(blip, Config.Blip[type].Spire)
		end
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, Config.Blip[type].Color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('CUSTOM_STRING')
		AddTextComponentSubstringPlayerName(name)
		EndTextCommandSetBlipName(blip)
		table.insert(self.blips, blip)
	elseif data.Gang == self.PlayerData.job.name then 
		local blip = AddBlipForCoord(data.GaragePoint.x, data.GaragePoint.y, data.GaragePoint.z)
		if data.Type == 14 then 
			SetBlipSprite(blip, 356)
		else
			SetBlipSprite(blip, Config.Blip[type].Spire)
		end
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, Config.Blip[type].Color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('CUSTOM_STRING')
		AddTextComponentSubstringPlayerName(name)
		EndTextCommandSetBlipName(blip)
		table.insert(self.blips, blip)
	end
end

function Garages:CheckPos()
	for k, v in pairs(self.garages) do 
		if not v.Gang or v.Gang == self.PlayerData.job.name then
			if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) <= 1.0 then 
				self.curGarage = k
				self.curAction = 'GaragePoint'
				self.curGarageType = ''
				return
			elseif GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) <= 4.0 then
				self.curGarage = k
				self.curAction = 'DeletePoint'
				self.curGarageType = ''
				return
			end
		end
	end
	--self.curGarage = nil
	self.curAction = nil
	return
end

function Garages:DrawMarker()
	for k, v in pairs(self.garages) do 
		if not v.Gang or v.Gang == self.PlayerData.job.name then
			if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) <= 20.0 then 
				DrawMarker(6, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 2.0, 2.0, 2.0, 22, 199, 154, 150, false, false, 2, nil, nil, false)
			end
			if v.Type and v.Type == 14 then 
				if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) <= 100.0 and IsPedInAnyVehicle(self.ped, false) then
					DrawMarker(6, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 30.0, 30.0, 30.0, 189, 32, 0, 150, false, false, 2, nil, nil, false)
				end
			else
				if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) <= 20.0 and IsPedInAnyVehicle(self.ped, false) then
					DrawMarker(6, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 8.0, 8.0, 8.0, 189, 32, 0, 150, false, false, 2, nil, nil, false)
				end
			end
		end
	end
end

function Garages:EventHandler()
	RegisterNetEvent("esx:playerLoaded")
	AddEventHandler("esx:playerLoaded", function(xPlayer)
		self.PlayerData = xPlayer
	end)
	RegisterNetEvent("esx:setJob")
	AddEventHandler("esx:setJob", function(job)
		self.PlayerData.job = job
	end)
	RegisterNetEvent("esx:setJob2")
	AddEventHandler("esx:setJob2", function(job)
		self.PlayerData.job2 = job

	end)
	RegisterNUICallback('escape', function(data, cb)
		self.isUIOpen = false
		self.shouldShowHelp = true
		SetNuiFocus(false, false)
		SendNUIMessage({
			type = "close",
		})
	end)
	RegisterNUICallback('spawnVehicle', function(data)
		self:SpawnVehicle(data.vehicle, data.plate)
	end)
	RegisterNUICallback('returnVehicle', function(data)
		self:ReturnVehicle(data.vehicle, data.plate)
	end)
	RegisterNUICallback("changeName", function(data, cb)
		TriggerServerEvent("esx_advancedgarage:changeName", data.plate, data.newName)
		hasAlreadyEnteredMarker = false
	end)
	RegisterNUICallback("deleteVehicle", function(data, cb)
		TriggerServerEvent("lr_garage:server:deleteVehicle", data.plate)
	end)
	RegisterNUICallback("Unimpound", function(data, cb)
		print(json.encode(data))
		ESX.TriggerServerCallback("lr_garage:callback:getImpoundData", function(result)
			cb(result)
		end, data)
	end)
	RegisterNUICallback("unimpoundVehice", function(data, cb)
		print(json.encode(data))
		ESX.TriggerServerCallback("lr_garage:callback:unimpound", function(result)
			if result == true then 
				self:SpawnVehicle(data.vehicle, data.plate)
			end
		end, data.plate)
	end)
	AddEventHandler("lr_garage:allhousingGarage", function(coords)
		self.allHousing = coords
		self:OpenGarage()
	end)
end

function Garages:SpawnVehicle(vehicle, plate)
	print(json.encode(vehicle.door))
	TriggerServerEvent("lr_garage:server:removeOldVehicle", plate)
	ESX.ShowNotification("Phương tiện của bạn đang được chuẩn bị, vui lòng chờ ...")
	Wait(3000)
	if not self.allHousing then
		if ESX.Game.IsSpawnPointClear(self.garages[self.curGarage].SpawnPoint, 3.0) then
			ESX.Game.SpawnVehicle(vehicle.model, {
				x = self.garages[self.curGarage].SpawnPoint.x,
				y = self.garages[self.curGarage].SpawnPoint.y,
				z = self.garages[self.curGarage].SpawnPoint.z
			}, self.garages[self.curGarage].SpawnPoint.h, function(cbVeh)
				ESX.Game.SetVehicleProperties(cbVeh, vehicle)
				SetVehRadioStation(cbVeh, "OFF")
				TaskWarpPedIntoVehicle(self.ped, cbVeh, -1)
				TriggerServerEvent("lr_garage:server:setState", plate, false)

			end)
		else
			ESX.ShowNotification("Có phương tiện đang đậu tại chỗ gọi xe, vui lòng thử lại")
		end
	else
		ESX.Game.SpawnVehicle(vehicle.model, {
			x = self.allHousing.x,
			y = self.allHousing.y,
			z = self.allHousing.z
		}, self.allHousing.w, function(cbVeh)
			ESX.Game.SetVehicleProperties(cbVeh, vehicle)
			SetVehRadioStation(cbVeh, "OFF")
			TaskWarpPedIntoVehicle(self.ped, cbVeh, -1)
			self.allHousing = nil
			TriggerServerEvent("lr_garage:server:setState", plate, false)

		end)
	end
end

function Garages:ReturnVehicle(vehicle, plate)
	if ESX.Game.IsSpawnPointClear(self.garages[self.curGarage].SpawnPoint, 3.0) then
		ESX.TriggerServerCallback("lr_garage:server:returnVehicle", function(canReturn)
			if canReturn then 
				ESX.ShowNotification(("Bạn đã trả ~g~%s$~w~ để chuộc phương tiện ~y~[%s]~w~"):format(Config.ReturnPrice, plate))
				self:SpawnVehicle(vehicle, plate)
			else
				ESX.ShowNotification("Bạn không có đủ "..Config.ReturnPrice)
			end
		end)
	else
		ESX.ShowNotification("Có phương tiện đang đậu tại chỗ gọi xe, vui lòng thử lại")
	end
	
end

function Garages:OpenGarage(_type)
	ESX.TriggerServerCallback("lr_garage:server:getOwnedVehicles", function(result)
		if #result == 0 then 
			ESX.ShowNotification("Bạn không có phương tiện nào")
			self.shouldShowHelp = true
		else
			local data = {}
			for k, v in pairs(result) do 
				if _type ~= nil then
					if tonumber(v.type) == tonumber(_type) then
						print(v.plate)
						local vehModel = v.vehicle.model
						local vehName = v.customName or GetDisplayNameFromVehicleModel(vehModel)
						local vehPlate = v.plate
						local imgSrc = Config.ImgSrc[GetDisplayNameFromVehicleModel(vehModel):lower()] or "https://lorraxs.com/vehicles_img/default.png"
						table.insert(data, {value = v, vehicle = v.vehicle, name = vehName, plate = vehPlate, stored = v.stored, imgSrc = imgSrc, soluong = v.soluong, impound = v.impound})
					end
				else
					if tonumber(v.type) ~= 14 and tonumber(v.type) ~= 15 and tonumber(v.type) ~= 16 and tonumber(v.type) ~= 19 then
						local vehModel = v.vehicle.model
						local vehName = v.customName or GetDisplayNameFromVehicleModel(vehModel)
						local vehPlate = v.plate
						local imgSrc = Config.ImgSrc[GetDisplayNameFromVehicleModel(vehModel):lower()] or "https://lorraxs.com/vehicles_img/default.png"
						table.insert(data, {value = v, vehicle = v.vehicle, name = vehName, plate = vehPlate, stored = v.stored, imgSrc = imgSrc, soluong = v.soluong, impound = v.impound})
					end
				end
			end
			SetNuiFocus(true, true)
			SendNUIMessage({
				type = "shop",
				result = data,
				pos = "getVehicle",
			})
			self.isUIOpen = true
		end
	end, self.curGarageType)
end

function Garages:ParkVehicle()
	local veh = GetVehiclePedIsIn(self.ped, false)
	if GetPedInVehicleSeat(veh, -1) ~= self.ped then 
		return
	end
	local vehProps = ESX.Game.GetVehicleProperties(veh)
	local vehPlate = GetVehicleNumberPlateText(veh)
	ESX.TriggerServerCallback("lr_garages:server:parkVehicle", function(result)
		if result == true then 
			ESX.Game.DeleteVehicle(veh)
			if self.garages[self.curGarage].Type == 14 then 
				ESX.Game.Teleport(PlayerPedId(), self.garages[self.curGarage].TelePoint)
			end
			ESX.ShowNotification(("Phương tiện ~y~[%s]~w~ đã được cất vào GARAGE"):format(vehPlate))
		else
			ESX.ShowNotification("Đây ~r~KHÔNG~w~ phải phương tiện của bạn")
		end
	end, vehPlate, vehProps)
end

function Garages:MainThread()
	Citizen.CreateThread(function()
		while true do 
			self.ped = PlayerPedId()
			self.player = PlayerId()
			coroutine.yield(0)
			self.pedCoords = GetEntityCoords(self.ped)
			self:CheckPos()
			self:DrawMarker()
			if self.curGarage ~= nil and self.curAction ~= nil then 
				if self.shouldShowHelp then 
					ESX.ShowHelpNotification(Config.HelpNotification[self.curAction])
					if IsControlJustReleased(0, 38)  then 
						if self.curAction == 'GaragePoint' and not self.isUIOpen then 
							self.shouldShowHelp = false
							self:OpenGarage(self.garages[self.curGarage].Type)
						elseif self.curAction == 'DeletePoint' then
							self:ParkVehicle()
						end
					end
				end
			end
		end
	end)
end

Citizen.CreateThread(function()
	while ESX == nil do 
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Wait(0)
	end
	while not ESX.IsPlayerLoaded() do 
		Wait(0)
	end
	rt = Garages:Create()
	for k, v in pairs(Config.Garages) do 
		rt:AddGarage('default', k, v)
	end
	rt:EventHandler()
	rt:MainThread()
end)


-- RegisterCommand("test", function()
-- 	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
-- 	SetVehicleTyreBurst(veh, 0 , true , 1000.0)
-- end)

