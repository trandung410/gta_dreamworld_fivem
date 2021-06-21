fx_version 'adamant'

game 'gta5'

description 'RC-RentCarService |ESX Framework'

server_scripts {
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/nui.lua',
	'config.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/Img/logo.png',
    'html/Img/check.png',
    'html/Img/close.png',
    'html/Img/motorcycle.png',
    'html/Img/sportcar.png'
}