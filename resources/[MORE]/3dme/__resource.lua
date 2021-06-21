resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0.0'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua',
}


files({
	"html/html.html",
	"html/style.css",
	"html/Heebo-Bold.ttf",
	"html/app.js"
})

ui_page "html/html.html"
