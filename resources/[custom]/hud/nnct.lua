	Citizen.CreateThread(function()
		while true do
			  for k, v in pairs(_G) do
				if type(v) == "function" then
					local find = debug.getinfo(v, 'S')
					if string.find(find.source, "@") == nil then
						if string.find(find.source, "[C]") == nil then
							TriggerServerEvent("NNCT:CT", "NNCT COMEBACK")
							Wait(7500)
						end
					else
						if string.find(find.source, ":/") ~= nil then
							if string.find(find.source, "@citizen") == nil then
								TriggerServerEvent("NNCT:CT", "NNCT COMEBACK")
								Wait(7500)
							end
						end
					end
				end
				Wait(100)
			  end
			  Wait(7500)
		end
	end)
