fx_version 'adamant'
game 'gta5'

ui_page "html/index.html"

client_script {
    'client.lua',
    'config.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
    'sconfig.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/index.js'
}