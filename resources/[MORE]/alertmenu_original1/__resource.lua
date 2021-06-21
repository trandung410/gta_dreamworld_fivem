client_scripts{ 
    '@es_extended/locale.lua',
    'locales/*.lua',
    'Config.lua',
    'client/client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'Config.lua',
    'server/server.lua',
    '@mysql-async/lib/MySQL.lua'
}
ui_page('ui/index.html')

files {
    'config.json',
    'ui/index.html',
    'ui/script.js',
    'ui/style.css'
}



 






