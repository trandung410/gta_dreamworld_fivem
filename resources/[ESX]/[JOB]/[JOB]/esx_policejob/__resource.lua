resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Police Job'

version '1.3.0'

ui_page 'html/ui.html'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua'
}

files {
	'html/ui.html',
	'html/css/style.css',
	'html/js/script.js',
	'html/fonts/UVNBaiSau_R.ttf',
	
	--BUTTON
	'html/img/button/buy.png',
	'html/img/button/buy_hover.png',

	--CAR
	'html/img/police2.png',
	'html/img/r1custom.png',
	'html/img/pbus.png',
	'html/img/riot.png',
	'html/img/polmp4.png',
	'html/img/wmfenyrcop.png',

}	

dependencies {
	'es_extended',
}

client_script '12698.lua'