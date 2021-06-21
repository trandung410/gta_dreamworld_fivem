fx_version 'adamant'

author 'VisiBait (VB-SCRIPTS: https://discord.gg/YrbBzwu59q)'
description 'VB-AC: FiveM AntiCheat by VisiBait#0712 for the FiveM Community'
version 'v4.0: Remastered'

game 'gta5'

client_scripts {
    '@menuv/menuv.lua',
    'configs/client_config.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'configs/server_config.lua',
    'server/main.lua'
}

ui_page "html/index.html"

files {
    'html/*.html',
    'html/js/*.js'
}