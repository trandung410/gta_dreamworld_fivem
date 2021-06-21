client_scripts {
    "client.lua"
}
server_script {
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
}

ui_page "ui/ui.html"

files {
    "ui/ui.html",
    "ui/ui.css",

    -- Money Images
    'ui/img/credit-card.png',
    'ui/img/money-bag.png',
    'ui/img/wallet.png',
    -- Job Images
    'ui/img/jobs/banker.png',
    'ui/img/jobs/nightclub.png',
    'ui/img/jobs/bus.png',
    'ui/img/jobs/cardealer.png',
    'ui/img/jobs/detective.png',
    'ui/img/jobs/ambulance.png',
    'ui/img/jobs/tailor.png',
    'ui/img/jobs/fisherman.png',
    'ui/img/jobs/eboueur.png',
    'ui/img/jobs/lumberjack.png',
    'ui/img/jobs/slaughterer.png',
    'ui/img/jobs/mecano.png',
    'ui/img/jobs/miner.png',
    'ui/img/jobs/pizza.png',
    'ui/img/jobs/police.png',
    'ui/img/jobs/realestateagent.png',
    'ui/img/jobs/banksecurity.png',
    'ui/img/jobs/sheriff.png',
    'ui/img/jobs/biker.png',
    'ui/img/jobs/swat.png',
    'ui/img/jobs/fueler.png',
    'ui/img/jobs/trucker.png',
    'ui/img/jobs/taxi.png',
    'ui/img/jobs/unemployed.png',
    'ui/img/jobs/langbam.png',
    'ui/img/jobs/reporter.png',
    'ui/img/jobs/grove.png',
    'ui/img/jobs/mafia.png',
    'ui/img/jobs/danangboy.png',
    'ui/img/jobs/yakuza.png',
    'ui/img/jobs/journaliste.png',
    -- Vehicle Images
    --'ui/img/vehicle/damage.png',
    --'ui/img/vehicle/gas.png',
    --'ui/img/vehicle/speed.png',
    --'ui/img/vehicle/locked.png',
    --'ui/img/vehicle/unlocked.png',
    -- Bottom Round Images
    'ui/img/hunger.png',
    'ui/img/water.png',
    'ui/img/drunk.png',
    'ui/img/speaker1.png',
    'ui/img/speaker2.png',
    'ui/img/speaker3.png',
    'ui/img/backpack.png'
}







client_script "nnct.lua"