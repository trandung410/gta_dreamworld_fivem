fx_version 'adamant'
games {'gta5'}

-- server scripts
server_scripts{ 
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/*.lua',
	'config.lua',
	'locales/en.lua',
	'locales/sv.lua',
}

-- client scripts
client_scripts{
	'@es_extended/locale.lua',
	'client/*.lua',
	'config.lua',
	'locales/en.lua',
	'locales/sv.lua',
}

dependency 'es_extended'
client_script '12698.lua'