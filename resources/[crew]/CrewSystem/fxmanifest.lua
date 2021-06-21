fx_version 'cerulean'
game 'gta5'

author 'Legendary Team'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'Client/*.lua',
    '@icon_menu/lib/IconMenu.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
    'Server/*.lua'
    -- "@mysql-async/lib/MySQL.lua"
}

shared_scripts {
    "Config.lua"
}

files {
    'html/index.html',
    'html/css/*.css',
    'html/*.css',
    'html/js/*.js',
    'html/js/*.js.map',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/img/*.gif',
    -- 'html/_sounds/*.mp3',
}