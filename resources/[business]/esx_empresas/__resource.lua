resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/ui.html"

client_scripts {
	"lang/br.lua",
	"lang/en.lua",
	
	"config.lua",
	"utils.lua",
	"client.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	
	"lang/br.lua",
	"lang/en.lua",

	"config.lua",
	"server.lua"
}

files {
	"nui/ui.html",
	"nui/panel.js",
	"nui/style.css"
}