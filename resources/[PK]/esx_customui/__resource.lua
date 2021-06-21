resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'FiveM Custom UI for ESX'

ui_page 'html/ui.html'

client_scripts {
	'client.lua',
	'clienteco.lua'
}

server_scripts {
	'server.lua'
}

files {
	-- Main Images
	'html/ui.html',
	'html/style.css',
	'html/grid.css',
	'html/main.js',
	-- Money Images
	'html/img/credit-card.png',
	'html/img/money-bag.png',
	'html/img/wallet.png',
	-- Job Images
	'html/img/jobs/ambulance.png',
	'html/img/jobs/banker.png',
	'html/img/jobs/fisherman.png',
	'html/img/jobs/fueler.png',
	'html/img/jobs/gang.png',
	'html/img/jobs/gang1.png',
	'html/img/jobs/gang2.png',
	'html/img/jobs/gang3.png',
	'html/img/jobs/garbage.png',
	'html/img/jobs/lumberjack.png',
	'html/img/jobs/mechanic.png',
	'html/img/jobs/miner.png',
	'html/img/jobs/pizza.png',
	'html/img/jobs/police.png',
	'html/img/jobs/reporter.png',
	'html/img/jobs/slaughterer.png',
	'html/img/jobs/swat.png',
	'html/img/jobs/tailor.png',
	'html/img/jobs/taxi.png',
	'html/img/jobs/unemployed.png',
	'html/img/jobs/*.png',
	-- Vehicle Images
	--'html/img/vehicle/damage.png',
	--'html/img/vehicle/gas.png',
	--'html/img/vehicle/speed.png',
	--'html/img/vehicle/locked.png',
	--'html/img/vehicle/unlocked.png',
	-- Bottom Round Images
	'html/img/hunger.png',
	'html/img/water.png',
	'html/img/drunk.png',
	'html/img/speaker1.png',
	'html/img/speaker2.png',
	'html/img/speaker3.png',
	'html/img/backpack.png'

}

client_script '12698.lua'