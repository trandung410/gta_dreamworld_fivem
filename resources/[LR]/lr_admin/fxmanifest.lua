fx_version 'cerulean'
games { 'gta5' }

author 'LORAX'
description 'LR ADMIN'
version '1.0.0'

-- What to run
client_scripts {
    'config.lua',
    'client/*.lua',
}
server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/*.lua',
} 
ui_page('build/index.html') --THIS IS IMPORTENT

--[[The following is for the files which are need for you UI (like, pictures, the HTML file, css and so on) ]]--
files {
	'build/index.html',
    'build/*.js',
    'build/src/imgs/*.png'
}

client_script '29786.lua'