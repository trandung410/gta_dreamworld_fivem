fx_version 'cerulean'
game 'gta5'

author 		'PiterMcFlebor'
description 'Resource made by PiterMcFlebor'
version 	'1.0'

debug_mode  'yes'   -- set this to 'yes' to enable developer mode

shared_script 'extended.lua'

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/modules/*.webmod.lua',
    'server/modules/api/*.api.lua',
    'server/*.web.lua',
}

dependency 'es_extended'
