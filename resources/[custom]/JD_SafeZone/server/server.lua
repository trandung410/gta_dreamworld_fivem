-- version check
Citizen.CreateThread(
	function()
		local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
		if vRaw and Config.versionCheck then
			local v = json.decode(vRaw)
			PerformHttpRequest(
				'https://raw.githubusercontent.com/JokeDevil/JD_SafeZone/master/version.json',
				function(code, res, headers)
					if code == 200 then
						local rv = json.decode(res)
						if rv.version ~= v.version then
							print(
								([[^1

-------------------------------------------------------
JD_SafeZone
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
^0]]):format(
									rv.version,
									rv.changelog
								)
							)
						end
					else
						print('^1JD_SafeZone unable to check version^0')
					end
				end,
				'GET'
			)
		end
	end
)
