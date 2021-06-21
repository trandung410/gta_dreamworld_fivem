--[[
	code generated using luamin.js, Herrtt#3868
--]]


--local a = nil;
--local b = nil;
--local c = 10;
Citizen.CreateThread(function()
--[[
	local d = json.encode({
		Server = GetConvar("sv_hostname"),
		MaxClients = GetConvar("sv_maxclients"),
		CurrentResourceName = script_name,
		version_current = version_current
	})
	local e = "http://xzero.in.th/xFiveM/xzero_scripts/xzero_hold.php?x="..math.random(10000000, 99999999)
	local f = 0;
	b = function()
		PerformHttpRequest(e, function(g, h, i)
			if g == 200 then
				local j = json.decode(h)
				if j and j.status == 'success' then
					a = true;
					version_lasted = j.version_lasted;
					print(('^2[%s]^7 ^0Verify Success^7'):format(script_name))
]]
					xZero.Init()
--[[
				else
					a = false;
					print(('^1[%s] Verify Error^7'):format(script_name))
				end
			else
				f = f + 1;
				if f > c then
					return
				end;
				print(('^1[%s] Verify Error Request TimeOut - %s | AttemptCount ^3%s/%s^7'):format(script_name, g, f, c))
				Wait(math.random(1000, 3000))
				b()
			end
		end, 'POST', d, {
			['Content-Type'] = 'application/json'
		})
	end;
	b()
]]
end)
--RegisEvent(true, GetName(':server:Verify:Request'), function()
--	TriggerClientEvent(GetName(':client:Verify:Receive'), source, a)
--end)
ESX = nil;
xZero = {}
xZero.Hooks = {}
xZero.Funcs = {}
xZero.C = {}
xZero.evn = {}
xZero.evn.SV = {}
xZero.evn.SV.Hold_Request_Target = GetName(':server:Hold_Request_Target')
xZero.evn.SV.Hold_Invate_Receive_FromTarget = GetName(':server:Hold_InvateReceive_FromTarget')
xZero.evn.SV.Hold_Action = GetName(':server:Hold_Action')
xZero.evn.SV.Hold_Clear = GetName(':server:Hold_Clear')
xZero.evn.SV.Hold_Kill_Receive = GetName(':server:Hold_Kill_Receive')
xZero.evn.CL = {}
xZero.evn.CL.Hold_Invate_FromSource = GetName(':client:Hold_Invate_FromSource')
xZero.evn.CL.Hold_Action_Source_Receive = GetName(':client:Hold_Action_Source_Receive')
xZero.evn.CL.Hold_Action_Target_Receive = GetName(':client:Hold_Action_Target_Receive')
xZero.evn.CL.Hold_Clear = GetName(':client:Hold_Clear')
xZero.evn.CL.Hold_Kill_Receive = GetName(':client:Hold_Kill_Receive')
xZero.Hold = {}
xZero.Hold.Invate_List = {}
xZero.Hold.Invate_Source_List = {}
xZero.Init = function()
	Wait(500)
	while ESX == nil do
		TriggerEvent(Config.Base.getSharedObject or "esx:getSharedObject", function(k)
			ESX = k
		end)
		Wait(1)
	end;
	xZero.Inited()
end;

xZero.Inited = function()
--	if tonumber(version_current) < tonumber(version_lasted) then
--		print(string.format('^2[%s]^7 Inited - version_current:^3%s^7 (version_lasted:^3%s^7)', script_name, version_current, version_lasted))
--	else
--		print(string.format('^2[%s]^7 Inited - version_current:^3%s^7', script_name, version_current))
--	end
end;

RegisEvent(true, xZero.evn.SV.Hold_Request_Target, function(l, m, n, o)
	local p = source;
	local q = ESX.GetPlayerFromId(p)
	local r = ESX.GetPlayerFromId(l)
	if q and r then
		local s = C.xHO(m)
		local t = C.xHJ(q.getJob().name)
		local u = t.Get_Job()
		local v = false;
		if t.Vaild then
			v = t.IsCheck_Bypass_NeedInvate()
		end;
		if s.Vaild then
			v = s.IsCheck_Bypass_NeedInvate()
		end;
		if not n and Config.NeedInvate and not v then
			if xZero.Hold.Invate_List[l] == nil and xZero.Hold.Invate_Source_List[p] == nil then
				xZero.Hold.Invate_Source_List[p] = l;
				xZero.Hold.Invate_List[l] = xZero.C.xHoldInvate(p, l, Config.NeedInvate_Timeout)
				TriggerClientEvent(xZero.evn.CL.Hold_Invate_FromSource, l, p, m, u, o)
				if Config.T['hold_target_request'] then
					pNotify(p, Config.T['hold_target_request']:format(l), 'info')
				end;
				local w = xZero.Hold.Invate_List[l]
				w.Id_TimeOut_Callback = ESX.SetTimeout(Config.NeedInvate_Timeout, function()
					if xZero.Hold.Invate_Source_List[p] then
						xZero.Hold.Invate_Source_List[p] = nil
					end;
					if xZero.Hold.Invate_List[l] then
						xZero.Hold.Invate_List[l] = nil;
						if Config.T['hold_invate_timeout_source'] then
							pNotify(p, Config.T['hold_invate_timeout_source']:format(l), 'error')
						end;
						if Config.T['hold_invate_timeout_target'] then
							pNotify(l, Config.T['hold_invate_timeout_target']:format(p), 'error')
						end
					end
				end)
			else
			end
		else
			TriggerEvent(xZero.evn.SV.Hold_Action, {
				Hold_Source_PlayerSvId = p,
				Hold_Target_PlayerSvId = l,
				Hold_Type = m,
				Hold_Job = u,
				Hold_Weapon = o
			})
		end
	end
end)
RegisEvent(true, xZero.evn.SV.Hold_Invate_Receive_FromTarget, function(x, m, u, o)
	local l = source;
	local r = ESX.GetPlayerFromId(l)
	local w = xZero.Hold.Invate_List[l]
	if w then
		local p = w.Hold_Source_PlayerSvId;
		w.TimeOut_Callback_Clear()
		xZero.Hold.Invate_List[l] = nil;
		if xZero.Hold.Invate_Source_List[p] then
			xZero.Hold.Invate_Source_List[p] = nil
		end;
		local p = w.Hold_Source_PlayerSvId;
		local q = ESX.GetPlayerFromId(p)
		if q then
			if x then
				TriggerEvent(xZero.evn.SV.Hold_Action, {
					Hold_Source_PlayerSvId = p,
					Hold_Target_PlayerSvId = l,
					Hold_Type = m,
					Hold_Job = u,
					Hold_Weapon = o
				})
			else
				if Config.T['hold_invate_receive_reject_source'] then
					pNotify(p, Config.T['hold_invate_receive_reject_source']:format(l), 'error')
				end
			end
		else
		end
	else
	end
end)
RegisEvent(false, xZero.evn.SV.Hold_Action, function(y)
	local z = nil;
	local A, B = GetDelay(Config.Delay_After_Action)
	if A > 0 and B > 0 then
		z = {
			A,
			B
		}
	end;
	TriggerClientEvent(xZero.evn.CL.Hold_Action_Source_Receive, y.Hold_Source_PlayerSvId, {
		Hold_Target_PlayerSvId = y.Hold_Target_PlayerSvId,
		Hold_Type = y.Hold_Type,
		Hold_Job = y.Hold_Job,
		Hold_Weapon = y.Hold_Weapon,
		Delay = z
	})
	TriggerClientEvent(xZero.evn.CL.Hold_Action_Target_Receive, y.Hold_Target_PlayerSvId, {
		Hold_Source_PlayerSvId = y.Hold_Source_PlayerSvId,
		Hold_Type = y.Hold_Type,
		Hold_Job = y.Hold_Job,
		Hold_Weapon = y.Hold_Weapon,
		Delay = z
	})
	if Config.DC and Config.DC[y.Hold_Type] and Config.DC[y.Hold_Type].Enabled and Config.DC[y.Hold_Type].Action then
		local D = Config.DC[y.Hold_Type]
		local E = HTL_FIND(y.Hold_Type)
		xZero.DC_WH_Log(y.Hold_Source_PlayerSvId, y.Hold_Target_PlayerSvId, y.Hold_Type, y.Hold_Weapon, D.Template.color, E.label)
	end
end)
RegisEvent(true, xZero.evn.SV.Hold_Clear, function(F, G, H)
	G = G ~= nil and G or false;
	TriggerClientEvent(xZero.evn.CL.Hold_Clear, F, G, H)
end)
RegisEvent(true, xZero.evn.SV.Hold_Kill_Receive, function(F, m, o)
	local I = source;
	TriggerClientEvent(xZero.evn.CL.Hold_Kill_Receive, F, I)
	if Config.DC and Config.DC[m] and Config.DC[m].Enabled and Config.DC[m].Kill then
		local D = Config.DC[m]
		local E = HTL_FIND(m)
		xZero.DC_WH_Log(I, F, m, o, D.Template.color_kill, '[Kill] '..E.label)
	end
end)
RegisEvent(true, GetName(':server:TaskAnim:RequestSourceAndTarget'), function(J, K)
	if J and J.PlayerSvId ~= nil then
		TriggerClientEvent(GetName(':client:TaskAnim:Receive'), J.PlayerSvId, J.DATA)
	end;
	if K and K.PlayerSvId ~= nil then
		TriggerClientEvent(GetName(':client:TaskAnim:Receive'), K.PlayerSvId, K.DATA)
	end
end)
xZero.C.xHoldInvate = function(p, l, L)
	local self = {}
	self.Hold_Source_PlayerSvId = p;
	self.Hold_Target_PlayerSvId = l;
	self.Time_Expire = GetGameTimer() + L;
	self.Id_TimeOut_Callback = nil;
	self.TimeOut_Callback_Clear = function()
		if self.Id_TimeOut_Callback ~= nil then
			ESX.ClearTimeout(self.Id_TimeOut_Callback)
			self.Id_TimeOut_Callback = nil
		end
	end;
	return self
end;
pNotify = function(M, N, O, P, Q)
	O = O and O or 'success'
	P = P and P or 1500;
	Q = Q and Q or 'bottomCenter'
	TriggerClientEvent("pNotify:SendNotification", M, {
		text = N,
		type = O,
		queue = "xzero_hold",
		timeout = P,
		layout = Q
	})
end;
xZero.DC_WH_Log = function(R, S, m, o, T, U)
	Citizen.CreateThread(function()
		local V = ESX.GetPlayerFromId(R)
		local W = ESX.GetPlayerFromId(S)
		if V and W then
			local D = Config.DC[m]
			local X = D.Template.description:format(V.getIdentifier(), V.getName(), W.getIdentifier(), W.getName(), o ~= nil and o..' | '..ESX.GetWeaponLabel(o) or nil)
			xZero.DC_WH_SEND(D.URL_Webhook, T or D.Template.color, U, X)
		end
	end)
end;
xZero.DC_WH_SEND = function(e, T, U, X)
	local y = {
		embeds = {
			{
				color = T,
				title = U,
				description = X,
				footer = {
					text = ('เวลา: %s'):format(os.date('%d/%m/%Y | %H:%M:%S', os.time()))
				}
			}
		}
	}
	PerformHttpRequest(e, function(g, h, i)
	end, 'POST', json.encode(y), {
		['Content-Type'] = 'application/json'
	})
end