-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'IC'
description 'littleCommand'
version '1.0.0'

server_scripts {
    'config.lua',
    'server/commandChecker.lua',
    'server/webhook.lua',
    'server/main.lua'
}

server_only 'yes'