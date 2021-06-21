--[[
	resource: scotty-gachapon
	desc: ระบบสุ่มกาชาปอง
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

fx_version 'adamant'

game 'gta5'

author 'Scotty1944'
description 'Scotty: Gachapon'
version '1.3'

client_scripts {
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'config_sv.lua',
	'server.lua'
}

files {
	'stream/sarabun.gfx',
	
	'html/menu.html',
	'html/css/style.css',
	'html/css/scotty.css',
	'html/js/script.js',
	'html/js/scotty.js',
	'html/js/jquery-3.1.0.min.js',
	'html/js/jquery-ui.min.js',
	
	'html/sound/preview.mp3',
	'html/sound/roll.mp3',
	'html/sound/unbox.mp3',
	'html/sound/vc.mp3',
	'html/sound/vc2.mp3',
	
	'html/images/*',
	'html/images/vehicle/*.png',
}

ui_page {
	'html/menu.html'
}