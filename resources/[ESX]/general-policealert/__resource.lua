--[[
	resource: scotty-policealert
	desc: แจ้งตำรวจ พร้อม shortcut ในการตั้ง GPS เพื่อไปยังจุดหมาย
	author: Scotty1944
	contact: https://steamcommunity.com/id/scotty1944/
]]

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description 'Scotty: Police Alert'

files {
	'html/main.html',
	'html/main.mp3',
	'html/main.png',
}

ui_page {
	'html/main.html',
}

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'config.lua',
	'server.lua'
}
