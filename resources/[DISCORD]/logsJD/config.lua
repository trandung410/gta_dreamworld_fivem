Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "ICteam" 							-- Bot Username
Config.avatar = "https://i.imgur.com/9NRAzos.png"				-- Bot Avatar
Config.communtiyName = "DreamWorld"					-- Icon top of the embed
Config.communtiyLogo = "https://i.imgur.com/9NRAzos.png"		-- Icon top of the embed
Config.FooterText = "2020 - 2021 © ICteam"						-- Footer text for the embed
Config.FooterIcon = "https://i.imgur.com/9NRAzos.png"			-- Footer icon for the embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.InlineFields = true			-- set to false if you don't want the player details next to each other

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = true					-- set to false to disable IP in the logs

-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.BaseColors ={		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "#A1A1A1",				-- Chat Message
	joins = "#3AF241",				-- Player Connecting
	leaving = "#F23A3A",			-- Player Disconnected
	deaths = "#000000",				-- Shooting a weapon
	shooting = "#2E66F2",			-- Player Died
	resources = "#EBEE3F",			-- Resource Stopped/Started	
}


Config.webhooks = {
	all = "DISCORD_WEBHOOK",
	chat = "https://discord.com/api/webhooks/854218284769738752/-vPGX1n386MZgR6wVdmSvBlrWZC7ae3hU1xGj1BpoSE-Bmi9xgMzcXroObYoTA_S9as5",
	joins = "https://discord.com/api/webhooks/854217646350270504/qwuzmHgXfAYqJnYkBeydHwK_XEP1tq3eyLRGNAegcwzjgNENTNt3LihFwE29PMx2gEY7",
	leaving = "https://discord.com/api/webhooks/854217689466929173/K53WhKG0Cw4s5u8TWyTjQ1PsKceO54No9I527mgX86cYOn-vrXHb8EVM45dxlgqFpcxa",
	deaths = "https://discord.com/api/webhooks/854909749497954304/8iEOJECHDgsUR7v8wG1lz4KxfJJBTm2d9a8PdatW5ufgQLG8Ds_wNE2wDIwavkZjDqsM",
	shooting = "https://discord.com/api/webhooks/854918807779934218/kyf1pZCVn80UPm4hcbro3zvM9hcJgvb4s1rm-6bIxP0xiGrpDpTmcMNSIcNrO-TjqWFp",
	resources = "https://discord.com/api/webhooks/854218056218050590/uRad9OGCA_9M2u35OQ62OI-lZidUno2Lye8Gxd5Atl6SGI5Op3f8eMp6weALNRldQxZO",
}

Config.TitleIcon = {		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "💬",				-- Chat Message
	joins = "📥",				-- Player Connecting
	leaving = "📤",			-- Player Disconnected
	deaths = "💀",				-- Shooting a weapon
	shooting = "🔫",			-- Player Died
	resources = "🔧",			-- Resource Stopped/Started	
}

Config.Plugins = {
	--["PluginName"] = {color = "#FFFFFF", icon = "🔗", webhook = "DISCORD_WEBHOOK"},
	-- ["ICteam"] = {color = "#03fc98", icon = "🔗", webhook = "https://discord.com/api/webhooks/854907048944730123/HeuSLoEXLfdNSf8VbGz2uE-xLM14dEYPVqf0Km4oGVS9cSAjSeG7qhxq0by27i3WSSuq"},
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.3.0"
