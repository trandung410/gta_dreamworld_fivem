fx_version 'cerulean'
games { 'gta5' }

author 'Lorax'
description 'LR Society Data'
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