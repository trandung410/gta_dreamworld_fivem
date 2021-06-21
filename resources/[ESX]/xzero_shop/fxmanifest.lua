fx_version 'adamant'
games { 'gta5' }

ui_page "html/index.html"

files {
	'html/*',
	'html/css/*',
	'html/js/*',
	'html/images/*',
	
	-- fontawesome
	'html/fontawesome/*',
	'html/fontawesome/css/*',
	'html/fontawesome/webfonts/*'
}

server_scripts {
	-- Version
	'version.lua',
	-- Config
	'config.lua',
	'config_discord.lua',
	
	'functions.lua',
	'server/server.lua',
}

client_scripts {
	-- Version
	'version.lua',
	-- Config
    'config.lua',
	
	'functions.lua',
	'client/client.lua',
}
 







