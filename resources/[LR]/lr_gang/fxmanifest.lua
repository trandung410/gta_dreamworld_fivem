fx_version 'cerulean'
games { 'gta5' }

author 'LORAX'
description 'LR GANG'
version '1.0.2'

-- What to run
client_scripts {
    'config.lua',
    'client/*.lua'
}
server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/*.lua'
}

ui_page 'build/index.html'

files {
    'build/index.html',
    'build/*.js'
}