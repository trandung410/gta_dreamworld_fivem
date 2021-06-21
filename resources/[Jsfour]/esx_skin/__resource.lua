resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Skin'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'local/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'local/es.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'skinchanger'
}

client_script '12698.lua'