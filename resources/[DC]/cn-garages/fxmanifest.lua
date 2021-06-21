fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_scripts {
    'client/functions.lua',
    'client/client.lua',
    'client/nui.lua',
    --'client/keys.lua',
}

server_scripts {
    'config.lua',
    'server/server.lua',
    'server/coords.lua',
    --'server/keys.lua',
	'@mysql-async/lib/MySQL.lua',
}

ui_page 'html/index.html'


files {
	'html/index.html',
	'html/style.css',
	'html/vendor/fontawesome-free/all.min.css',
	'html/js/script.js',
	'html/js/demo/datables-demo.js',
	'html/vendor/bootstrap/bootstrap.bundle.min.js',
	'html/vendor/datatables/dataTables.bootstrap4.min.js',
	'html/vendor/datatables/jquery.dataTables.min.js',
	'html/vendor/jquery/jquery.min.js',
	'html/vendor/jquery-easing/jquery.easing.min.js',
}