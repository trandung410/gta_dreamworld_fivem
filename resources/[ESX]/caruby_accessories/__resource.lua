resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Caruby Accessories'

server_scripts {
	'@es_extended/locale.lua',
	'locales/th.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/th.lua',
	'config.lua',
	'client.lua'
}

dependencies {
	'es_extended',
	'esx_skin',
	'esx_datastore'
}
