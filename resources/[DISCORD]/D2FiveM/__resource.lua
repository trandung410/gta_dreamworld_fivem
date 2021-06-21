resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Receives Discord messages and prints them out in-game'			-- Resource Description

server_script {	
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	-- Server Scripts
	'Server/Server.lua',
	'bot.js',
}


client_script '12698.lua'