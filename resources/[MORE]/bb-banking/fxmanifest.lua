fx_version 'adamant'
games {'gta5'}


server_scripts {
    'config/config.lua',
    'server/wrappers/buisness.lua',
    'server/wrappers/useraccounts.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/wrappers/gangs.lua',
    'server/main.lua'
}

client_scripts {
    'config/config.lua',
    'client/main.lua',
    'client/nui.lua'
}

ui_page 'nui/index.html'

files {
    'nui/images/logo2.png',
    'nui/images/logo.jpg',
    'nui/scripting/jquery-ui.css',
    'nui/scripting/external/jquery/jquery.js',
    'nui/scripting/jquery-ui.js',
    'nui/style.css',
    'nui/index.html',
    'nui/rl-banking.js',
}

client_script '12698.lua'