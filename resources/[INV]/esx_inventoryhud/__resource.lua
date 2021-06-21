resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "ESX Inventory HUD"

version "1.1"

ui_page "html/ui.html"

client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/trunk.lua",
  "client/property.lua",
  "client/player.lua",
  "client/society.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}

server_scripts {
  "@es_extended/locale.lua",
  "server/main.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/bullet.png",
  -- ICONS
  "html/img/items/vine.png",
  "html/img/items/washed_stone.png",
  "html/img/items/stone.png",
  "html/img/items/contract.png",
  "html/img/items/alive_chicken.png",
  "html/img/items/jus_raisin.png",
  "html/img/items/grand_cru.png",
  "html/img/items/raisin.png",
  "html/img/items/fish.png",
  "html/img/items/fishingrod.png",
  "html/img/items/bait.png",
  "html/img/items/bandage.png",
  "html/img/items/firstaidkit.png",
  "html/img/items/beer.png",
  "html/img/items/binoculars.png",
  "html/img/items/bread.png",
  "html/img/items/weed.png",
  "html/img/items/cigarette.png",
  "html/img/items/clip.png",
  "html/img/items/cocacola.png",
  "html/img/items/coffee.png",
  "html/img/items/coke.png",
  "html/img/items/coke_pooch.png",
  "html/img/items/meth.png",
  "html/img/items/meth_pooch.png",
  "html/img/items/opium.png",
  "html/img/items/opium_pooch.png",
  "html/img/items/weed_pooch.png",
  "html/img/items/gold.png",
  "html/img/items/icetea.png",
  "html/img/items/sandwich.png",
  "html/img/items/papers.png",
  "html/img/items/hamburger.png",
  "html/img/items/wine.png",
  "html/img/items/cash.png",
  "html/img/items/chocolate.png",
  "html/img/items/iron.png",
  "html/img/items/jewels.png",
  "html/img/items/medikit.png",
  "html/img/items/tequila.png",
  "html/img/items/whisky.png",
  "html/img/items/limonade.png",
  "html/img/items/phone.png",
  "html/img/items/vodka.png",
  "html/img/items/water.png",
  "html/img/items/cupcake.png",
  "html/img/items/drpepper.png",
  "html/img/items/energy.png",
  "html/img/items/croquettes.png",
  "html/img/items/bolpistache.png",
  "html/img/items/bolnoixcajou.png",
  "html/img/items/bolcacahuetes.png",
  "html/img/items/fixkit.png",
  "html/img/items/bolchips.png",
  "html/img/items/black_chip.png",
  "html/img/items/black_money.png",
  "html/img/items/gym_membership.png",
  "html/img/items/bulletproof.png",
  "html/img/items/wool.png",
  "html/img/items/suppressor.png",
  "html/img/items/yusuf.png",
  "html/img/items/grip.png",
  "html/img/items/flashlight.png",
  "html/img/items/bitcoin.png",
  "html/img/items/meat.png",
  "html/img/items/leather.png",
  "html/img/items/lighter.png",
  "html/img/items/hifi.png",
  "html/img/items/highrim.png",
  "html/img/items/lowradio.png",
  "html/img/items/airbag.png",
  "html/img/items/battery.png",
  "html/img/items/highradio.png",
  "html/img/items/stockrim.png",
  "html/img/items/WEAPON_APPISTOL.png",
  "html/img/items/WEAPON_SNSPISTOL.png",
  "html/img/items/WEAPON_ASSAULTRIFLE.png",
  "html/img/items/WEAPON_ASSAULTSHOTGUN.png",
  "html/img/items/WEAPON_BOTTLE.png",
  "html/img/items/WEAPON_BULLPUPRIFLE.png",
  "html/img/items/WEAPON_CARBINERIFLE.png",
  "html/img/items/WEAPON_COMBATMG.png",
  "html/img/items/WEAPON_BAT.png",
  "html/img/items/WEAPON_COMBATPISTOL.png",
  "html/img/items/WEAPON_CROWBAR.png",
  "html/img/items/WEAPON_GOLFCLUB.png",
  "html/img/items/WEAPON_KNIFE.png",
  "html/img/items/WEAPON_MICROSMG.png",
  "html/img/items/WEAPON_NIGHTSTICK.png",
  "html/img/items/WEAPON_HAMMER.png",
  "html/img/items/WEAPON_PISTOL.png",
  "html/img/items/WEAPON_PUMPSHOTGUN.png",
  "html/img/items/WEAPON_SAWNOFFSHOTGUN.png",
  "html/img/items/WEAPON_SMG.png",
  "html/img/items/WEAPON_STUNGUN.png",
  "html/img/items/WEAPON_SPECIALCARBINE.png",
  "html/img/items/WEAPON_KNUCKLE.png",
  "html/img/items/WEAPON_FLASHLIGHT.png",
  "html/img/items/WEAPON_REVOLVER.png",
  "html/img/items/WEAPON_DAGGER.png",
  "html/img/items/WEAPON_PETROLCAN.png",
  "html/img/items/WEAPON_PISTOL50.png",
  "html/img/items/WEAPON_DBSHOTGUN.png",
  "html/img/items/WEAPON_SWITCHBLADE.png",
  "html/img/items/WEAPON_ADVANCEDRIFLE.png",
  "html/img/items/WEAPON_MINIGUN.png",
  "html/img/items/WEAPON_RAILGUN.png",
  "html/img/items/WEAPON_FIREWORK.png",
  "html/img/items/WEAPON_BZGAS.png",
  "html/img/items/WEAPON_FLAREGUN.png",
  "html/img/items/WEAPON_SMOKEGRENADE.png",
  "html/img/items/WEAPON_ASSAULTSMG.png",
  "html/img/items/WEAPON_BALL.png",
  "html/img/items/WEAPON_COMPACTRIFLE.png",
  "html/img/items/WEAPON_FLARE.png",
  "html/img/items/WEAPON_MG.png",
  "html/img/items/WEAPON_SNIPERRIFLE.png",
  "html/img/items/WEAPON_STICKYBOMB.png",
  "html/img/items/WEAPON_VINTAGEPISTOL.png",
  "html/img/items/WEAPON_BULLPUPSHOTGUN.png",
  "html/img/items/WEAPON_COMPACTLAUNCHER.png",
  "html/img/items/WEAPON_GRENADE.png",
  "html/img/items/WEAPON_HEAVYSHOTGUN.png",
  "html/img/items/WEAPON_HEAVYSNIPER.png",
  "html/img/items/WEAPON_HOMINGLAUNCHER.png",
  "html/img/items/WEAPON_MACHETE.png",
  "html/img/items/WEAPON_MOLOTOV.png",
  "html/img/items/WEAPON_MUSKET.png",
  "html/img/items/WEAPON_SNOWBALL.png",
  "html/img/items/WEAPON_HATCHET.png",
  "html/img/items/WEAPON_FIREEXTINGUISHER.png",
  "html/img/items/WEAPON_RPG.png",
  "html/img/items/WEAPON_AUTOSHOTGUN.png",
  "html/img/items/WEAPON_BATTLEAXE.png",
  "html/img/items/WEAPON_COMBATPDW.png",
  "html/img/items/WEAPON_GRENADELAUNCHER.png",
  "html/img/items/WEAPON_GUSENBERG.png",
  "html/img/items/WEAPON_HEAVYPISTOL.png",
  "html/img/items/WEAPON_MACHINEPISTOL.png",
  "html/img/items/WEAPON_MARKSMANPISTOL.png",
  "html/img/items/WEAPON_MARKSMANRIFLE.png",
  "html/img/items/WEAPON_PIPEBOMB.png",
  "html/img/items/WEAPON_MINISMG.png",
  "html/img/items/WEAPON_PROXMINE.png",
  "html/img/items/WEAPON_WRENCH.png",
  "html/img/items/WEAPON_POOLCUE.png",
  "html/img/items/*.png"
}
