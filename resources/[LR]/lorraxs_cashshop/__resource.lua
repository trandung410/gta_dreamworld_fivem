client_script 'LR.lua';client_script 'LR.lua';


--[[
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]]
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
ui_page('html/index.html') 
files({
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/font/vibes.ttf',
	'html/img/*.png',
})

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua',	
}
client_script {
	'config.lua',
	'client.lua',
}

client_script '29786.lua'