--[[
	code generated using luamin.js, Herrtt#3868
--]]


--local a = nil;
--RegisEvent(true, GetName(':client:Verify:Receive'), function(b)
--	a = b
--end)
Citizen.CreateThread(function()
--	local c = GetGameTimer()
--	while a == nil and GetGameTimer() - c <= 30 * 1000 do
--		TriggerServerEvent(GetName(':server:Verify:Request'))
--		Wait(300)
--	end;
	xZero.Init()
end)
ESX = nil;
xZero = {}
xZero.Hooks = {}
xZero.Threads = {}
xZero.Funcs = {}
xZero.C = {}
xZero.evn = {}
xZero.evn.CL = {}
xZero.evn.CL.Hold_MenuOpen = GetName(':client:Hold_MenuOpen')
xZero.evn.CL.Hold_Request_Target = GetName(':client:Hold_Request_Target_ToServer')
xZero.evn.CL.Hold_Invate_FromSource = GetName(':client:Hold_Invate_FromSource')
xZero.evn.CL.Hold_Action_Source_Receive = GetName(':client:Hold_Action_Source_Receive')
xZero.evn.CL.Hold_Action_Target_Receive = GetName(':client:Hold_Action_Target_Receive')
xZero.evn.CL.Hold_Clear = GetName(':client:Hold_Clear')
xZero.evn.CL.Hold_Kill_Receive = GetName(':client:Hold_Kill_Receive')
xZero.evn.SV = {}
xZero.evn.SV.Hold_Request_Target = GetName(':server:Hold_Request_Target')
xZero.evn.SV.Hold_Invate_Receive_FromTarget = GetName(':server:Hold_InvateReceive_FromTarget')
xZero.evn.SV.Hold_Clear = GetName(':server:Hold_Clear')
xZero.evn.SV.Hold_Kill_Receive = GetName(':server:Hold_Kill_Receive')
xZero.Hold = {}
xZero.Hold.IsMy = nil;
xZero.Hold.Type = nil;
xZero.Hold.Job = nil;
xZero.Hold.Weapon = nil;
xZero.Hold.xHoldP = {}
xZero.Hold.xHoldP['source'] = nil;
xZero.Hold.xHoldP['target'] = nil;
xZero.Hold.IsInvate = false;
xZero.Hold_Id_TimeOut_Callback = nil;
Hold_Prograss = false;
Hold_Request_Prograss = false;
Hold_Vaild_Distance = 10.0;
local d = false;
xZero.Init = function()
	Wait(500)
--	if a then
		while ESX == nil do
			TriggerEvent(Config.Base.getSharedObject or "esx:getSharedObject", function(e)
				ESX = e
			end)
			Wait(1)
		end;
		while ESX.GetPlayerData() == nil do
			Wait(1)
		end;
		xZero.Inited()
--	else
--		print('^1xZero_IsVerify:ERROR^7')
--	end
end;
xZero.Inited = function()
	print(('^2[%s]^7 Inited'):format(script_name))
	Citizen.CreateThread(xZero.Threads.KeyPress_OpenMenu)
	Citizen.CreateThread(xZero.Threads.DisabledControl)
	Citizen.CreateThread(xZero.Threads.Hold_Option)
	Citizen.CreateThread(xZero.Threads.Hold_Vaild)
end;
xZero.Threads.KeyPress_OpenMenu = function()
	if Config.Key_OpenMenu then
		while true do
			if IsControlJustPressed(0, Config.Key_OpenMenu) then
				TriggerEvent(xZero.evn.CL.Hold_MenuOpen)
				Wait(250)
			end;
			Wait(5)
		end
	end
end;
RegisEvent(true, xZero.evn.CL.Hold_MenuOpen, function()
	if not Hold_Request_Prograss and not Hold_Prograss and not xZero.Hold.IsInvate then
		ESX.UI.Menu.CloseAll()
		local f = {}
		if xZero.Hold.IsMy ~= nil then
			local g = C.xHO(xZero.Hold.Type)
			local h = C.xHJ(xZero.Hold.Job)
			if xZero.Hold.IsMy == 'source' then
				table.insert(f, {
					label = Config.T['hold_source_cancel']:format(xZero.Hold.xHoldP['target'].PlayerSvId),
					value = false
				})
			elseif xZero.Hold.IsMy == 'target' then
				if not Config.Hold_Target_IsCancel then
					return
				end;
				if g.Vaild and not g.IsCheck_TargetIsCancel() then
					return
				end;
				if h.Vaild and not h.IsCheck_TargetIsCancel() then
					return
				end;
				table.insert(f, {
					label = Config.T['hold_target_cancel']:format(xZero.Hold.xHoldP['source'].PlayerSvId),
					value = false
				})
			end
		else
			if Config.Hold_Type_List then
				for i, j in ipairs(Config.Hold_Type_List) do
					table.insert(f, {
						label = j.label,
						value = j.name
					})
				end
			end
		end;
		if f and #f > 0 then
			ESX.UI.Menu.Open('default', script_name, 'hold_menu', {
				title = Config.T['hold_menu_title'],
				align = Config.MenuAlign,
				elements = f
			}, function(k, l)
				l.close()
				if k.current and k.current.value ~= nil then
					TriggerEvent(xZero.evn.CL.Hold_Request_Target, k.current.value)
				end
			end, function(k, l)
				l.close()
			end)
		end
	end
end)
RegisEvent(false, xZero.evn.CL.Hold_Request_Target, function(m)
	local n = PlayerPedId()
	if not Hold_Request_Prograss then
		Hold_Request_Prograss = true;
		local o = math.random(100, 500)
		Wait(o)
		if IsPedInAnyVehicle(n, false) then
			Hold_Request_Prograss = false;
			if Config.T['player_isin_vehicle'] then
				pNotify(Config.T['player_isin_vehicle'], 'error')
			end;
			return
		end;
		local p = xZero.Hold.xHoldP['source']
		if xZero.Hold.IsMy and xZero.Hold.IsMy == 'target' and p then
			if IsPedInAnyVehicle(p.Get_PlayerPed(), false) then
				Hold_Request_Prograss = false;
				if Config.T['player_isin_vehicle'] then
					pNotify(Config.T['player_isin_vehicle'], 'error')
				end;
				return
			end
		end;
		if xZero.Hold.IsMy ~= nil then
			Hold_Request_Prograss = false;
			xZero.Hooks.Hold_Request_Cancel()
			return
		end;
		local q = HTL_FIND(m)
		if not xZero.Funcs.Zone_BlackList_Check(ESX.GetPlayerData().job.name) then
			Hold_Request_Prograss = false;
			pNotify(('พื้นที่นี้ไม่สามารถ %s ได้'):format(q.label), 'error')
			return
		end;
		local r, s = ESX.Game.GetClosestPlayer()
		if r > -1 and s <= Config.Hold_Request_Distance then
			xZero.Hold.xHoldP['target'] = xZero.C.xHoldP(GetPlayerServerId(r))
			local t = xZero.Hold.xHoldP['target']
			t.IsMy = 'target'
			if t.IsVaild() then
				local u = IsEntityDead(t.Get_PlayerPed())
				local v = true;
				if not IsPedInAnyVehicle(t.Get_PlayerPed(), false) or u then
					local h = C.xHJ(ESX.GetPlayerData().job.name)
					local g = C.xHO(m)
					v = Config.Hold_Target_IsDead;
					if h.Vaild then
						v = h.IsCheck_Request_Target_IsDead()
					end;
					if g.Vaild then
						v = g.IsCheck_Request_Target_IsDead()
					end;
					if u and not v then
						Hold_Request_Prograss = false;
						if Config.T['hold_target_isdead'] then
							pNotify(Config.T['hold_target_isdead']:format(q.label), 'error')
						end;
						return
					end;
					local w, x = g.IsCheck_UseWeapon(n)
					if not w then
						Hold_Request_Prograss = false;
						if Config.T['hold_option_useweapon'] then
							pNotify(Config.T['hold_option_useweapon'], 'error')
						end;
						return
					end;
					TriggerServerEvent(xZero.evn.SV.Hold_Request_Target, t.PlayerSvId, m, u, x)
					Wait(500)
					Hold_Request_Prograss = false
				else
					Hold_Request_Prograss = false;
					if Config.T['player_isin_vehicle'] then
						pNotify(Config.T['player_isin_vehicle'], 'error')
					end
				end
			else
				Hold_Request_Prograss = false;
				if Config.T['player_isin_vehicle'] then
					pNotify(Config.T['hold_target_invaild'], 'error')
				end
			end
		else
			Hold_Request_Prograss = false;
			if Config.T['hold_target_notfound'] then
				pNotify(Config.T['hold_target_notfound'], 'error')
			end
		end
	end
end)
xZero.Hooks.Hold_Request_Cancel = function()
	if xZero.Hold.IsMy ~= nil and not Hold_Prograss then
		Hold_Prograss = true;
		local g = C.xHO(xZero.Hold.Type)
		local h = C.xHJ(xZero.Hold.Job)
		if xZero.Hold.IsMy == 'target' then
			if not Config.Hold_Target_IsCancel then
				Hold_Prograss = false;
				return
			end;
			if g.Vaild and not g.IsCheck_TargetIsCancel() then
				Hold_Prograss = false;
				return
			end;
			if h.Vaild and not h.IsCheck_TargetIsCancel() then
				Hold_Prograss = false;
				return
			end
		end;
		local y = xZero.Hold.IsMy == 'source' and xZero.Hold.xHoldP['target'] or xZero.Hold.xHoldP['source']
		if y then
			local z = C.HA(xZero.Hold.Type, 'source')
			local A = C.HA(xZero.Hold.Type, 'target')
			local B = z.getVaild() and z.CFG.Cancel_TaskAnim and z.CFG.Cancel_TaskAnim or nil;
			local D = A.getVaild() and A.CFG.Cancel_TaskAnim and A.CFG.Cancel_TaskAnim or nil;
			if B or D then
				local E = {
					PlayerSvId = xZero.Hold.xHoldP['source'].PlayerSvId,
					DATA = {
						Clear_Task_After = true,
						Clear_DetachEntity_After = true,
						TaskAnimDATA = B
					}
				}
				local F = {
					PlayerSvId = xZero.Hold.xHoldP['target'].PlayerSvId,
					DATA = {
						Clear_Task_After = true,
						Clear_DetachEntity_After = true,
						TaskAnimDATA = D
					}
				}
				TriggerServerEvent(GetName(':server:TaskAnim:RequestSourceAndTarget'), E, F)
				Wait(1000)
			end;
			y.Hold_Clear(true, GetPlayerServerId(PlayerId()))
		end;
		TriggerEvent(xZero.evn.CL.Hold_Clear)
		Hold_Prograss = false
	end
end;
RegisEvent(true, xZero.evn.CL.Hold_Invate_FromSource, function(G, m, H, x)
	if xZero.Hold.IsMy == nil and not xZero.Hold.IsInvate then
		xZero.Hold.IsInvate = true;
		if IsEntityDead(PlayerPedId()) or d then
			xZero.Hooks.Hold_Invate_Confirm(G, m, H, x, true)
			return
		end;
		xZero.Hold_Id_TimeOut_Callback = ESX.SetTimeout(Config.NeedInvate_Timeout, function()
			if xZero.Hold.IsInvate then
				xZero.Hold.IsInvate = false;
				xZero.Hold_Id_TimeOut_Callback = nil;
				ESX.UI.Menu.CloseAll()
			end
		end)
		ESX.UI.Menu.CloseAll()
		local I = {
			{
				label = Config.T['hold_invate_accept']:format(G),
				value = true
			},
			{
				label = Config.T['hold_invate_reject'],
				value = false
			}
		}
		ESX.UI.Menu.Open('default', script_name, 'hold_invate_menu', {
			title = Config.T['hold_invate_title'],
			align = Config.NeedInvate_MenuAlign,
			elements = I
		}, function(k, l)
			l.close()
			if k.current and k.current.value then
				xZero.Hooks.Hold_Invate_Confirm(G, m, H, x, true)
			else
				xZero.Hooks.Hold_Invate_Confirm(G, m, H, x, false)
			end
		end, function(k, l)
			l.close()
			xZero.Hooks.Hold_Invate_Confirm(G, m, H, x, false)
		end)
	end
end)
xZero.Hooks.Hold_Invate_Confirm = function(G, m, H, x, J)
	if xZero.Hold.IsInvate then
		xZero.Hold.IsInvate = false;
		if xZero.Hold_Id_TimeOut_Callback ~= nil then
			ESX.ClearTimeout(xZero.Hold_Id_TimeOut_Callback)
			xZero.Hold_Id_TimeOut_Callback = nil
		end;
		TriggerServerEvent(xZero.evn.SV.Hold_Invate_Receive_FromTarget, J, m, H, x)
	end
end;
RegisEvent(true, xZero.evn.CL.Hold_Action_Source_Receive, function(K)
	local q = HTL_FIND(K.Hold_Type)
	if K.Delay then
		local L = math.random(K.Delay[1], K.Delay[2])
		if Config.T['hold_action_delay_source'] then
			pNotify(Config.T['hold_action_delay_source']:format(K.Hold_Target_PlayerSvId), 'info', L)
		end;
		Wait(L)
	end;
	if xZero.Hold.IsMy == nil then
		local t = xZero.Hold.xHoldP['target']
		local M = t and IsEntityDead(t.Get_PlayerPed()) and 0 or nil;
		if t and t.PlayerSvId == K.Hold_Target_PlayerSvId and t.IsVaild(M) then
			xZero.Hold.xHoldP['source'] = xZero.C.xHoldP(GetPlayerServerId(PlayerId()))
			local p = xZero.Hold.xHoldP['source']
			p.Hold_IsMy = 'source'
			p.Hold_Action(K.Hold_Type)
			xZero.Hold.IsMy = 'source'
			xZero.Hold.Type = K.Hold_Type;
			xZero.Hold.Job = K.Hold_Job or nil;
			xZero.Hold.Weapon = K.Hold_Weapon or nil;
			if Config.T['hold_action_success_source'] then
				pNotify(Config.T['hold_action_success_source']:format(q.label, K.Hold_Target_PlayerSvId), 'success')
			end
		else
			xZero.Funcs.Hold_Clear_ByAction(K.Hold_Target_PlayerSvId, true)
		end
	else
		xZero.Funcs.Hold_Clear_ByAction(K.Hold_Target_PlayerSvId, false)
	end
end)
RegisEvent(true, xZero.evn.CL.Hold_Action_Target_Receive, function(K)
	local q = HTL_FIND(K.Hold_Type)
	if K.Delay then
		local L = math.random(K.Delay[1], K.Delay[2])
		if Config.T['hold_action_delay_target'] then
			pNotify(Config.T['hold_action_delay_target']:format(K.Hold_Source_PlayerSvId), 'info', L)
		end;
		Wait(L)
	end;
	if xZero.Hold.IsMy == nil then
		xZero.Hold.xHoldP['source'] = xZero.C.xHoldP(K.Hold_Source_PlayerSvId)
		local p = xZero.Hold.xHoldP['source']
		p.Hold_IsMy = 'source'
		xZero.Hold.xHoldP['target'] = xZero.C.xHoldP(GetPlayerServerId(PlayerId()))
		local t = xZero.Hold.xHoldP['target']
		t.Hold_IsMy = 'target'
		local N = IsEntityDead(t.Get_PlayerPed())
		local M = N and 0 or nil;
		if p.IsVaild(M) then
			if N then
				local O = GetEntityCoords(p.Get_PlayerPed())
				SetEntityCoords(t.Get_PlayerPed(), O.x, O.y, O.z)
			end;
			t.Hold_Action(K.Hold_Type, p.Get_PlayerPed())
			xZero.Hold.IsMy = 'target'
			xZero.Hold.Type = K.Hold_Type;
			xZero.Hold.Job = K.Hold_Job or nil;
			xZero.Hold.Weapon = K.Hold_Weapon or nil;
			if Config.T['hold_action_success_target'] then
				pNotify(Config.T['hold_action_success_target']:format(q.label, K.Hold_Source_PlayerSvId), 'success')
			end
		else
			xZero.Funcs.Hold_Clear_ByAction(K.Hold_Source_PlayerSvId, true)
		end
	else
		xZero.Funcs.Hold_Clear_ByAction(K.Hold_Source_PlayerSvId, false)
	end
end)
RegisEvent(true, xZero.evn.CL.Hold_Clear, function(P, Q)
	local b = false;
	if P and xZero.Hold.IsMy ~= nil then
		local y = xZero.Hold.IsMy == 'source' and xZero.Hold.xHoldP['target'] or xZero.Hold.xHoldP['source']
		if y and y.PlayerSvId == Q then
			b = true
		end
	end;
	if P == nil or not P or b then
		xZero.Funcs.Anim_Clear()
		xZero.Hold.IsMy = nil;
		xZero.Hold.Type = nil;
		xZero.Hold.Job = nil;
		xZero.Hold.Weapon = nil;
		xZero.Hold.xHoldP['source'] = nil;
		xZero.Hold.xHoldP['target'] = nil;
		xZero.Hold.IsInvate = false;
		xZero.Hold_Id_TimeOut_Callback = nil;
		ESX.UI.Menu.CloseAll()
	end
end)
RegisEvent(true, GetName(':client:TaskAnim:Receive'), function(K)
	if K then
		local R = PlayerPedId()
		if not IsEntityDead(R) then
			if K.Delay_After and K.Delay_After > 0 then
				Wait(K.Delay_After)
			end;
			if K.Clear_Task_After then
				ClearPedSecondaryTask(R)
			end;
			if K.Clear_DetachEntity_After then
				DetachEntity(R, true, false)
			end;
			if K.TaskAnimDATA then
				local S = K.TaskAnimDATA;
				ESX.Streaming.RequestAnimDict(S.animDictionary, function()
					TaskPlayAnim(R, S.animDictionary, S.animationName, S.blendInSpeed, S.blendOutSpeed, S.duration, S.flag, S.playbackRate, S.lockX, S.lockY, S.lockZ)
				end)
			end;
			if K.Delay_Before and K.Delay_Before > 0 then
				Wait(K.Delay_Before)
			end;
			if K.Clear_Task_Before then
				ClearPedSecondaryTask(R)
			end
		end
	end
end)
RegisEvent(false, 'playerSpawned', function()
	d = false;
	xZero.Funcs.Hold_Cancel_Now()
end)
RegisEvent(false, Config.Base.onPlayerSpawn or "esx:onPlayerSpawn", function()
	d = false;
	Wait(300)
	xZero.Funcs.Hold_Cancel_Now()
end)
RegisEvent(false, Config.Base.onPlayerDeath or "esx:onPlayerDeath", function()
	d = true;
	xZero.Funcs.Hold_Cancel_Now()
end)
xZero.Threads.DisabledControl = function()
	while true do
		Wait(0)
		local T = true;
		local U = xZero.Hold.IsMy and Config.Hold_DisabledControl[xZero.Hold.IsMy] or nil;
		if U and U.Enabled and U.Keys then
			for V, W in ipairs(U.Keys) do
				DisableControlAction(0, W, true)
			end
		else
			Wait(1000)
		end
	end
end;
xZero.Threads.Hold_Option = function()
	local X = 0;
	if Config.Text_Font then
		RegisterFontFile(Config.Text_Font)
		X = RegisterFontId(Config.Text_Font)
	end;
	while true do
		Wait(5)
		if xZero.Hold.IsMy and xZero.Hold.IsMy == 'source' and xZero.Hold.Type and Config.Hold_Option then
			local Y = Config.Hold_Option[xZero.Hold.Type]
			if Y and Y.Kill then
				if Y.Kill_Alert then
					local Z = GetEntityCoords(PlayerPedId()) + vector3(0.0, 0.0, 0.5)
					xZero.Funcs.DrawText3D(Z, Y.Kill_Alert, Config.Text_Size or 0.75, X)
				end;
				if IsControlJustPressed(0, Y.Kill_Key) and not Hold_Prograss then
					Hold_Prograss = true;
					local y = xZero.Hold.xHoldP['target']
					if y and y.IsVaild() and not IsEntityDead(y.Get_PlayerPed()) then
						TriggerServerEvent(xZero.evn.SV.Hold_Kill_Receive, y.PlayerSvId, xZero.Hold.Type, xZero.Hold.Weapon)
						Wait(500)
					end;
					Hold_Prograss = false
				end
			else
				Wait(1500)
			end
		else
			Wait(1500)
		end
	end
end;
xZero.Threads.Hold_Vaild = function()
	while true do
		Wait(2000)
		local n = PlayerPedId()
		if xZero.Hold.IsMy then
			local _ = false;
			local y = xZero.Hold.IsMy == 'source' and xZero.Hold.xHoldP['target'] or xZero.Hold.xHoldP['source']
			if y and y.IsVaild(0) then
				local a0 = Hold_Vaild_Distance;
				if a0 ~= 0 and (IsEntityDead(n) or IsPedInAnyVehicle(n, false)) then
					a0 = 0
				end;
				local a1 = y.Get_PlayerPed()
				if a0 ~= 0 and (IsEntityDead(a1) or IsPedInAnyVehicle(a1, false)) then
					a0 = 0
				end;
				if a0 ~= 0 and not y.IsVaild(a0) then
					IsClear = true
				end
			else
				_ = true
			end;
			if _ then
				Wait(math.random(1, 300))
				xZero.Funcs.Hold_Cancel_Now()
			end
		end
	end
end;
RegisEvent(true, xZero.evn.CL.Hold_Kill_Receive, function(Q)
	local y = xZero.Hold.xHoldP['source']
	if xZero.Hold.IsMy and xZero.Hold.IsMy == 'target' and xZero.Hold.Type and y and y.PlayerSvId == Q then
		local R = PlayerPedId()
		local g = C.xHO(xZero.Hold.Type)
		if g.Vaild and g.CFG.Kill and not IsEntityDead(R) then
			SetEntityHealth(R, 0)
		end
	end
end)
xZero.C.xHoldP = function(a2)
	local self = {}
	self.PlayerSvId = a2;
	self.PlayerId = nil;
	self.Hold_IsMy = nil;
	self.Get_PlayerId = function()
		self.PlayerId = GetPlayerFromServerId(self.PlayerSvId) or nil;
		return self.PlayerId
	end;
	self.Get_PlayerPed = function()
		return GetPlayerPed(self.PlayerId) or nil
	end;
	self.IsVaild = function(a3)
		self.Get_PlayerId()
		if self.PlayerId ~= nil and self.PlayerId ~= -1 then
			local a1 = self.Get_PlayerPed()
			if a1 ~= nil and a1 ~= -1 then
				local a4 = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(a1))
				local a5 = a3 ~= nil and a3 or Config.Hold_Request_Distance;
				if a5 == 0 or a4 <= a5 then
					return true
				end
			end
		end;
		return false
	end;
	self.Hold_Clear = function(P, Q)
		TriggerServerEvent(xZero.evn.SV.Hold_Clear, self.PlayerSvId, P, Q)
	end;
	self.Hold_Action = function(m, a6)
		local a7 = Config.Hold_Action[m]
		if self.Hold_IsMy and a7 then
			a7 = a7[self.Hold_IsMy]
			if a7 then
				if a7.AttachEntity and a6 then
					local a8 = a7.AttachEntity;
					AttachEntityToEntity(self.Get_PlayerPed(), a6, a8.boneIndex, a8.xPos, a8.yPos, a8.zPos, a8.xRot, a8.yRot, a8.zRot, a8.p9, a8.useSoftPinning, a8.collision, a8.isPed, a8.vertexIndex, a8.fixedRot)
				end;
				if a7.TaskAnim then
					local a8 = a7.TaskAnim;
					ESX.Streaming.RequestAnimDict(a8.animDictionary, function()
						TaskPlayAnim(self.Get_PlayerPed(), a8.animDictionary, a8.animationName, a8.blendInSpeed, a8.blendOutSpeed, a8.duration, a8.flag, a8.playbackRate, a8.lockX, a8.lockY, a8.lockZ)
					end)
				end
			end
		end;
		return false
	end;
	self.Get_PlayerId()
	return self
end;
xZero.Funcs.Hold_Cancel_Now = function()
	if xZero.Hold.IsMy then
		local y = xZero.Hold.IsMy == 'source' and xZero.Hold.xHoldP['target'] or xZero.Hold.xHoldP['source']
		if y then
			y.Hold_Clear(true, GetPlayerServerId(PlayerId()))
		end;
		TriggerEvent(xZero.evn.CL.Hold_Clear)
	end
end;
xZero.Funcs.Hold_Clear_ByAction = function(a2, a9)
	Citizen.CreateThread(function()
		Wait(math.random(100, 200))
		TriggerServerEvent(xZero.evn.SV.Hold_Clear, a2, true, GetPlayerServerId(PlayerId()))
	end)
	if a9 then
		TriggerEvent(xZero.evn.CL.Hold_Clear)
	end
end;
xZero.Funcs.Zone_BlackList_Check = function(aa)
	if Config.Zone_BlackList and #Config.Zone_BlackList > 0 then
		for V, ab in ipairs(Config.Zone_BlackList) do
			if ab.enabled then
				local ac = GetEntityCoords(PlayerPedId())
				local ad = GetDistanceBetweenCoords(ac.x, ac.y, ac.z, ab.x, ab.y, ab.z)
				if ad <= ab.distance then
					local ae = false;
					if aa and ab.job_allow and #ab.job_allow > 0 then
						for V, af in ipairs(ab.job_allow) do
							if af == aa then
								ae = true;
								break
							end
						end
					end;
					if not ae then
						return false
					end
				end
			end
		end
	end;
	return true
end;
xZero.Funcs.Anim_Clear = function(ag)
	local ah = ag ~= nil and ag or PlayerPedId()
	ClearPedTasksImmediately(ah)
	DetachEntity(ah, true, false)
end;
xZero.Funcs.DrawText3D = function(ai, aj, ak, al)
	local am, an, ao = World3dToScreen2d(ai.x, ai.y, ai.z)
	if am then
		local ap = GetGameplayCamCoords()
		local aq = GetDistanceBetweenCoords(ap.x, ap.y, ap.z, ai.x, ai.y, ai.z, 1)
		local ar = ak / aq * 2;
		local as = 1 / GetGameplayCamFov() * 100;
		ar = ar * as;
		SetTextScale(0.0 * ar, 0.55 * ar)
		SetTextFont(al or 0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(aj)
		DrawText(an, ao)
	end
end;
pNotify = function(at, au, av, aw)
	exports.pNotify:SendNotification({
		text = tostring(at) or '',
		type = au or 'info',
		timeout = av or 1500,
		layout = aw or "bottomCenter",
		queue = 'xzero_hold'
	})
end