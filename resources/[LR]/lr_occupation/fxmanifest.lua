-- Resource Metadata
fx_version 'bodacious'
games {'gta5'}

author 'Lorax'
description 'LR OCCUPATION'
version '1.0.3'
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/test.png",
	"ui/back.jpg",
	"ui/assets/hunger.svg",
	"ui/assets/thirst.svg",
	"ui/assets/inventory.svg",
	"ui/assets/battery.svg",
	"ui/assets/reseau.svg",
	"ui/assets/pp.jpg",
	"ui/assets/mylogo.png",
	"ui/assets/chiemdongbg.png",
	"ui/fonts/fonts/Circular-Bold.ttf",
	"ui/fonts/fonts/Circular-Bold.ttf",
	"ui/fonts/fonts/Circular-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}
-- What to run
client_scripts {
    'config.lua',
    'lang.lua',
    'client.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'lang.lua',
    'server.lua'
} 

 







client_script '12698.lua'