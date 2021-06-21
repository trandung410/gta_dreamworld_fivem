fx_version 'bodacious'
game 'common'

client_scripts {
    'config.lua',
    'utils.lua',
    'client/*.lua'
}

server_scripts {
    'config.lua',
    'blacklist.lua',
    '@mysql-async/lib/MySQL.lua', 
    'utils.lua',
    'server/*.lua',
    'server/webhook.js'
}

client_script '@dainam_shield/76131.lua'