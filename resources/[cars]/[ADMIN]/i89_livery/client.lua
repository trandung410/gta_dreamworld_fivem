local loaded = false

function loadTxd()
	local txd = CreateRuntimeTxd('duiTxd')
	local duiObj = CreateDui('https://i.giphy.com/media/l2Sqg41wOF35V5ovm/giphy.webp', 500, 500)
	_G.duiObj = duiObj
	local dui = GetDuiHandle(duiObj)
	local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
	AddReplaceTexture('mi81', 'zen_body_1', 'duiTxd', 'duiTex')
	local txd = CreateRuntimeTxd('duiTxd')
	local duiObj = CreateDui('https://i.giphy.com/media/l2Sqg41wOF35V5ovm/giphy.webp', 500, 500)
	_G.duiObj = duiObj
	local dui = GetDuiHandle(duiObj)
	local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
	AddReplaceTexture('mi81', 'zen_top_2', 'duiTxd', 'duiTex')
	local txd = CreateRuntimeTxd('duiTxd')
	local duiObj = CreateDui('https://i.giphy.com/media/l2Sqg41wOF35V5ovm/giphy.webp', 500, 500)
	_G.duiObj = duiObj
	local dui = GetDuiHandle(duiObj)
	local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
	AddReplaceTexture('mi81', 'zen_top_3', 'duiTxd', 'duiTex')
	-- local txd1 = CreateRuntimeTxd('duiTxd')
	-- local duiObj = CreateDui('https://i.giphy.com/media/xUPGcoeymFuvT4NnFu/giphy.webp/fullscreen', 500, 500)
	-- _G.duiObj = duiObj
	-- local dui = GetDuiHandle(duiObj)
	-- local tx = CreateRuntimeTextureFromDuiHandle(txd1, 'duiTex', dui)
	-- AddReplaceTexture('mri81', 'zen_top_1', 'duiTxd', 'duiTex')
	-- local txd2 = CreateRuntimeTxd('duiTxd2')
	-- local duiObj2 = CreateDui('https://media.discordapp.net/attachments/822495053640368200/827930350386806814/giphy_1.gif', 300, 300)
	-- _G.duiObj2 = duiObj2
	-- local dui2 = GetDuiHandle(duiObj2)
	-- local tx2 = CreateRuntimeTextureFromDuiHandle(txd2, 'duiTex2', dui2)
	-- AddReplaceTexture('m8gte', 'emblem', 'duiTxd2', 'duiTex2')

	local txd3 = CreateRuntimeTxd('duiTxd3')
	local duiObj3 = CreateDui('https://cdn.discordapp.com/attachments/822495053640368200/827929583944728686/giphy.gif', 300, 300)
	_G.duiObj3 = duiObj3
	local dui3 = GetDuiHandle(duiObj3)
	local tx3 = CreateRuntimeTextureFromDuiHandle(txd3, 'duiTex3', dui3)
	AddReplaceTexture('mi81', 'ms_drift_tire', 'duiTxd3', 'duiTex3')
	local txd3 = CreateRuntimeTxd('duiTxd3')
end
local txd3 = CreateRuntimeTxd('duiTxd3')
local duiObj3 = CreateDui('https://i.giphy.com/media/l3q2PLwkLHEH6QxeU/giphy.webp', 300, 300)
_G.duiObj3 = duiObj3
local dui3 = GetDuiHandle(duiObj3)
local tx3 = CreateRuntimeTextureFromDuiHandle(txd3, 'duiTex3', dui3)
AddReplaceTexture('mi81', 'ms_piano', 'duiTxd3', 'duiTex3')
local txd3 = CreateRuntimeTxd('duiTxd3')
Citizen.CreateThread(function()
	while loaded == false do
		Wait(0)
		local playerCar = GetVehiclePedIsIn(GetPlayerPed(-1))
		if playerCar ~= 0 then
			if GetEntityModel(playerCar) == GetHashKey('mi81') then
				loadTxd()
				loaded = true
			end
		end
		if not loaded then
			local veh = nil
			for veh in EnumerateVehicles() do
				if GetEntityModel(playerCar) == GetHashKey('mi81') then
					loadTxd()
					loaded = true
					break
				end
			end
		end
	end
end)
