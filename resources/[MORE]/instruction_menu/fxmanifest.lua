fx_version 'adamant'

game 'gta5'

description 'Daily Reward HB'

version '1.0.0'

files {
	'html/ui.html',

	'html/main.js',
	
	'html/style.css',
	'html/img/*.png',
}

ui_page {
	'html/ui.html'
}

--[[server_scripts {
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
}]]

client_scripts {
	'client.lua'
}