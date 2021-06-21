fx_version 'adamant'
games { 'gta5' }

server_scripts {
	-- Version
	'core/version.lua',
	-- Config
	'config.lua',
	-- Core
	'core/funcs.lua',
	'core/server.lua'
}

client_scripts {
	-- Version
	'core/version.lua',
    -- Config
	'config.lua',
	-- Core
	'core/funcs.lua',
	'core/client.lua'
}

ui_page "html/index.html"

files {
	'export/*.lua',
	'html/*',
	'html/sounds/*'
}

client_script '12698.lua'