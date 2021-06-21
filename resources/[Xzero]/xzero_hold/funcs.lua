--[[
	code generated using luamin.js, Herrtt#3868
--]]


script_name = GetCurrentResourceName()
GetName = function(a)
	return script_name..a
end;
GetDelay = function(b)
	if b then
		local c = b[1]
		local d = b[2]
		if c and c > 0 and d and d > 0 then
			return c, d
		end
	end;
	return 0, 0
end;
RegisEvent = function(e, a, f)
	if e then
		RegisterNetEvent(a)
	end;
	AddEventHandler(a, f)
end;
HTL_FIND = function(a)
	if Config.Hold_Type_List then
		for g, h in ipairs(Config.Hold_Type_List) do
			if h.name == a then
				return h
			end
		end
	end;
	return nil
end;
C = {}
C.HA = function(i, j)
	local self = {}
	self.Hold_Type = i;
	self.Hold_IsMy = j;
	self.Vaild = nil;
	self.CFG = nil;
	self.IsVaild = function()
		if Config.Hold_Action and Config.Hold_Action[self.Hold_Type] then
			local k = Config.Hold_Action[self.Hold_Type]
			if k[self.Hold_IsMy] then
				self.CFG = k[self.Hold_IsMy]
				self.Vaild = true;
				return self.Vaild
			end
		end;
		self.Vaild = false;
		return self.Vaild
	end;
	self.getVaild = function()
		return self.Vaild
	end;
	self.IsVaild()
	return self
end;
C.xHO = function(a)
	local self = {}
	self.Hold_Type = a;
	self.Vaild = nil;
	self.CFG = nil;
	self.IsVaild = function()
		if Config.Hold_Option and Config.Hold_Option[self.Hold_Type] then
			self.CFG = Config.Hold_Option[self.Hold_Type]
			self.Vaild = true;
			return self.Vaild
		end;
		self.Vaild = false;
		return self.Vaild
	end;
	self.IsCheck_UseWeapon = function(l)
		local m, n = true, nil;
		if self.Vaild and self.CFG.UseWeapon and self.CFG.UseWeaponList and #self.CFG.UseWeaponList > 0 then
			local o, p = GetCurrentPedWeapon(l)
			local q = false;
			if o then
				for g, h in ipairs(self.CFG.UseWeaponList) do
					if GetHashKey(string.upper(h)) == p then
						n = string.upper(h)
						q = true;
						break
					end
				end
			end;
			if not q then
				m = false
			end
		end;
		return m, n
	end;
	self.IsCheck_Bypass_NeedInvate = function()
		if self.Vaild and self.CFG.Bypass_NeedInvate ~= nil then
			return self.CFG.Bypass_NeedInvate
		end;
		return false
	end;
	self.IsCheck_TargetIsCancel = function()
		if self.Vaild and self.CFG.Target_IsCancel ~= nil then
			return self.CFG.Target_IsCancel
		end;
		return Config.Hold_Target_IsCancel
	end;
	self.IsCheck_Request_Target_IsDead = function()
		if self.Vaild and self.CFG.Request_Target_IsDead ~= nil then
			return self.CFG.Request_Target_IsDead
		end;
		return Config.Hold_Target_IsDead
	end;
	self.IsVaild()
	return self
end;
C.xHJ = function(a)
	local self = {}
	self.Job = a;
	self.Vaild = nil;
	self.CFG = nil;
	self.IsVaild = function()
		if self.Job and Config.Hold_Job and Config.Hold_Job[self.Job] then
			self.CFG = Config.Hold_Job[self.Job]
			self.Vaild = true;
			return self.Vaild
		end;
		self.Vaild = false;
		return self.Vaild
	end;
	self.Get_Job = function()
		if self.Vaild then
			return self.Job
		end;
		return nil
	end;
	self.IsCheck_Bypass_NeedInvate = function()
		if self.Vaild and self.CFG.Bypass_NeedInvate ~= nil then
			return self.CFG.Bypass_NeedInvate
		end;
		return false
	end;
	self.IsCheck_TargetIsCancel = function()
		if self.Vaild and self.CFG.Target_IsCancel ~= nil then
			return self.CFG.Target_IsCancel
		end;
		return Config.Hold_Target_IsCancel
	end;
	self.IsCheck_Request_Target_IsDead = function()
		if self.Vaild and self.CFG.Request_Target_IsDead ~= nil then
			return self.CFG.Request_Target_IsDead
		end;
		return Config.Hold_Target_IsDead
	end;
	self.IsVaild()
	return self
end