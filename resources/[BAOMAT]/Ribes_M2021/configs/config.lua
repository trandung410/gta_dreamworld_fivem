RS = {}
RC = {}

RS.version = "M3121" -- ChocoHax Ribes Version
RS.DebugMode = false -- Prevent players from getting kicked - Show Debug Text (Use this only during tests or troubleshooting)

RS.SeclyWhitelistedResources = { -- Put here resources that have to be Whitelisted from being secly injected
    "t1ger_drugbusiness",
    "t1ger_bankrobbery",
    "t1ger_truckrobbery"
}

--//Logs//--

RS.ConsoleLogs = true -- Get detection info on your Server Console
--------------------------------
RS.GeneralDiscordWebhookLink = "https://discord.com/api/webhooks/827846098798379018/LTfBZGxa5F6Ln0xYuHCOSJyd_rWSuFcmOLHVZgByhodv1NR3pB8hnPe3iOO8fbVse62i" -- ChocoHax Detection Logs Webhook Link

RS.ConnectionLogs = true -- Connection Logs Masterswitch
RS.ConnectionLogsWebhookLink = "https://discord.com/api/webhooks/827850568760164383/rDStDkEyeeK25bYc3UCW0-AdbcEeHzIcTyvKAi5cYg2apUF14G0A9WeRx9Z934eP7EQO" -- Webhook Link ^^

RS.DisconnectionLogs = true -- Disconnection Logs Masterswitch
RS.DisconnectionLogsWebhookLink = "https://discord.com/api/webhooks/827850657855176704/_7TZMMparlPRt_NOcQfYom_myv-ErFVV1Eu5cV4mfG2jg563lQhFG9lSGFHmo33Px8JR" -- Webhook Link ^^

-- Separated Logs (Use it only if you want to have diffrent webhook link logs otherwise leave it empty)

RS.EntitiesDiscordWebhookLink = "https://discord.com/api/webhooks/827850788582719498/q4z5Eoa7OqqzkMrPDpkP3GegdNdmvsaAsbQ82-YL8elQsh0Cu-PpIxDChVVIQ7mPxRGp"
RS.WeaponsDiscordWebhookLink = "https://discord.com/api/webhooks/827850849996374038/NbUmBeKU2uCiY83mxr6vueI0xG7QmPAuEBT2Mul-FRrbZzwNNpLp-7iv6J1SgqLexWfu"
RS.ExplosionsDiscordWebhookLink = "https://discord.com/api/webhooks/827850923413995570/sWNXPuIQ1-JMQE0Znyt1UvkvvGCAHrMvNDKOLhdcph_yMYvxhM9tmFUBWcT3-QP__Rmo"
RS.SeclyDiscordWebhookLink = "https://discord.com/api/webhooks/827851000819875863/4rLFTYfY0WjcKHB_5stEPwz8m4BhDfZbEHcxEee4KblHQqapR23LaucIb3bmVnNCqrBf"
RS.EventsDiscordWebhookLink = "https://discord.com/api/webhooks/827851065713754142/MDqNnq49g23-Hq-fB1yjPXxsHXQp-Cc6VqxlEEvtvqudZ3zBZEO9AgE3r6QHA1ZlOlTB"

--//General Stuff//--

RS.AntiXSSInjection = true -- Detects if the player tries to use XSS scripts to attack your server

--------------------------------

--//Client Side Stuff//--
RC.AntiSpectate = true
RC.AntiBlips = false
RC.ResourceChecker = false -- (it can be useful but really heavy with a loaded servers, not use if you have more than 50 players)
RC.AntiASIMenu = true -- Experimental (Useful and light) (IT MAY NOT WORK CORRECTLY ON SOME SERVERS!!)

--//Anti Resource Restart//-- (Yea... he's back) (Detects Start/Stop/Restart)
RC.AntiResourceRestart = false
RS.AntiResourceRestartCooldown = 10000 -- If you are going to restart a resource, the anticheat gets disabled for 10 seconds (Set on 0 if you don't want a cooldown)

--//Health Checker//-- (FALSE POSTIVE WARNING, DO NOT USE IF YOUR SERVER IS NOT COMPATIBLE WITH THIS CHECKER)
RC.AntiGodModeMasterSwitch = true -- Masterswitch
RC.AntiGodModeKick = true
RC.AntiGodModeBan = false

RC.AntiGodMode = true -- METHOD 1 (Faster,Simple)
RC.AntiSemiGodMode = true -- METHOD 2 (Reliable,Less False Positives)
    RC.AntiSemiGodModeWarns = 5 -- The player gets kicked/banned after 5 SEMI-godmode detections (Default: 5 == 50 seconds)

RC.AntiGodModeHealthCheck = true -- METHOD 3
    RC.AntiGodModeMaxHealth = 200 -- MAX PLAYER HEALTH

--------------------------------

--//Screenshots//--
RC.ScreenshotsMasterSwitch = true
RC.ScreenshotsDiscordWebhookLinkStorage = "https://discord.com/api/webhooks/827851144809676840/xYe1IzddR3t_cV0dLQBv0IF461911sSNu3e6O4hO8VBSoSDUuWvpERnJoGXScxvCStah" -- Leave it blank if you want to use ChocoHax's Webhook Link (Storage, this webhook may be vulnerable, do not use this webhook for any kind of use except for screenshots storage)
RS.ScreenshotsDiscordWebhookLink = "https://discord.com/api/webhooks/827851234425831465/D6vXnFesLoLmd2SSvc7-dfSSLtPQFdTF9Lph0lEd3-NuEkon3e6uDYAYDjQXkL4iHBLM" -- Screenshot Logs (SERVER ONLY, KEEP THIS SECRET)

RC.ScreenshotsDetectionOnKeyPress = true
RC.ScreenshotsDetectionOnKeyPressKeys = {121,122} -- DO NOT USE MORE THAN 5 KEYS (PERFORMANCE IMPACT)
--------------------------------

--//ChocoHax AI//-- ONLY FREE API (PRO will be available on the next release)
RS.ChocoHaxAI = true --(This feature requires RC.ScreenshotsDetectionOnKeyPress enabled)
RS.ChocoHaxAIKick = true
RS.ChocoHaxAIBan = false
RS.ChocoHaxAIAPIKey = "f74994a9ac88957" -- Register your API FREE KEY from https://ocr.space/OCRAPI (BECAREFUL TO THE RATE LIMIT)
RS.ChocoHaxAIEndpoint = 1 -- 1 = FREE , 2 = PRO USA , 3 = PRO EUROPE , 4 = PRO ASIA (Do not use PRO ENDPOINTS if you don't own a PRO KEY)
RS.ChocoHaxAIDiscordWebhookLink = "https://discord.com/api/webhooks/828158934275325973/LUfOv9KWxo_8mAWpNEl5ew3snpIpI832e4MALCRBVVzrQHNLNhHvLxZgPJNKWe3QXIQW" -- (BECAREFUL TO THE RATE LIMIT)
RS.ChocoHaxAIDetectionWords = {"Fallout Menu","Fallout","Cheat","Eulen","Weapon Menu","Self Menu","Vehicle Menu","God Mode","Semi God Mode",
"Aimbot","Teleport to waypoint","Fast Run","Infinite Stamina","Infinite Ammo","Nuke","Destroy ESX","Lua Executor",
"Super Jump","Give All Weapons","Remove all weapons","AntiAim","Trigger Bot","Trigger bot","Aim bot",
"Explode Everyone","Give Money","Lynx Revolution","Lynx Menu","Atomic","Noclip","Unknowncheats","Watermalone","Brutan","Dopamine",
"Tiago Menu","Lua options","Self Options","Absolute","Matrix","Troll Menu","Troll Features","Panic Button","Kill menu","Destroy Menu","34ByTe Community",
"Powerfulsokin","Falcon","Cage Players","Rage bot","Unlimited ammo","One shot","All players","Skull Revolution"}
--------------------------------

--//Connection Checks//--
    --//Identifiers Checker//-- Detects players connecting without some identifiers, you can force players to have steam/discord/fivem connected to their accounts
    RS.IdentifiersChecker = true
        RS.IdentifiersCheckerForceSteam = true -- Steam
            RS.IdentifiersCheckerForceSteamKickMessage = "You're not allowed to join this server without Steam"

        RS.IdentifiersCheckerForceDiscord = false -- Discord
            RS.IdentifiersCheckerForceDiscordKickMessage = "You're not allowed to join this server without Discord"

        RS.IdentifiersCheckerForceRockstar = true -- Rockstar License
            RS.IdentifiersCheckerForceRockstarKickMessage = "You're not allowed to join this server without a Rockstar License"

        RS.IdentifiersCheckerForceXbox = false -- Xbox License
            RS.IdentifiersCheckerForceXboxKickMessage = "You're not allowed to join this server without a Xbox License"

        RS.IdentifiersCheckerForceLive = false -- Live License
            RS.IdentifiersCheckerForceLiveKickMessage = "You're not allowed to join this server without a Live License"

        RS.IdentifiersCheckerForceFiveM = false -- FiveM Account License
            RS.IdentifiersCheckerForceFiveMKickMessage = "You're not allowed to join this server without a FiveM account"

    --//Blacklisted Names//-- Detects players using a name that's not allowed on your server
    RS.BlacklistedNamesMasterSwitch = true
    RS.BlacklistedNamesKickMessage = "Your name is blacklisted on this server"
    RS.BlacklistedNames = {"administrator", "admin", "adm1n", "adm!n", "admln", "moderator", "owner", "nigger", "n1gger", "moderator", "eulencheats", "lynxmenu", "atgmenu", "hacker", "bastard", "hamhaxia", "333gang", "ukrp", "eguk", "n1gger", "n1ga", "nigga", "n1gga", "nigg3r",
    "nig3r", "shagged", "4dm1n", "4dmin", "m0d3r4t0r", "n199er", "n1993r", "rustchance.com", "rustchance", "hellcase.com", "hellcase", "youtube.com", "youtu.be", "youtube", "twitch.tv", "twitch", "anticheat.gg", "anticheat", "fucking",
    "chocohax", "civilgamers.com", "civilgamers", "csgoempire.com", "csgoempire", "g4skins.com", "g4skins", "gameodds.gg", "duckfuck.com", "crysishosting.com", "crysishosting", "key-drop.com", "key-drop.pl", "skinhub.com", "skinhub",
    "casedrop.eu", "casedrop", "cs.money", "rustypot.com","rampage.lt", "?", "xcasecsgo.com", "xcasecsgo", "csgocases.com",
    "csgocases", "K9GrillzUK.co.uk", "moat.gg", "princevidz.com", "princevidz", "pvpro.com", "Pvpro", "ez.krimes.ro", "loot.farm", "arma3fisherslife.net", "arma3fisherslife", "egamers.io", "ifn.gg", "key-drop", "sups.gg", "tradeit.gg",
    "§", "csgotraders.net", "csgotraders", "hurtfun.com", "hurtfun", "gamekit.com", "t.tv", "yandex.ru", "yandex", "csgofly.com", "csgofly", "pornhub.com", "pornhub","cs.deals","twat", "STRESS.PW"}
    --------------------------------

--//Chat Control//--
RS.ChatControlMasterSwitch = true
    RS.ChatControlAntiSpam = true -- Detect if a players spam messages
    RS.ChatControlMaxMessages = 5 -- How many messages can a player write before getting blocked
    RS.ChatControlMSecondsBetweenMaxMessages = 5000 -- How many seconds needs the player to wait for being able to talk again

    RS.BlacklistedWords = true -- Detect/Warn
    RS.BlacklistedWordsKick = false -- Detect/Warn/Kick
    RS.BlacklistedWordsBan = false -- Detect/Warn/Ban (Requires RS.BlacklistedWordsKick on true)
--------------------------------

--//BanSystem//--
RS.BanSystem = true
RS.KickMessage = "Liên hệ Admin server!"
--------------------------------

--//ClearPedTasksImmediately//-- Detects players that tries to kick everyone out of the vehicles (or stuff like that)
RS.ClearPedTasksImmediatelyMasterSwitch = true -- Detect/Warn
RS.ClearPedTasksImmediatelyKick = true -- Detect/Warn/Kick
RS.ClearPedTasksImmediatelyBan = true -- Detect/Warn/Ban (Requires RS.ClearPedTasksImmediatelyKick on true)
--------------------------------


--//Permissions//--
RS.AdminMenu = {"chocohaxadministrator"}
RS.Bypass = {"chocohaxadministrator","chocohaxmoderator"}
RS.Spectate = {"chocohaxadministrator","chocohaxmoderator"}
RS.Blips = {"chocohaxadministrator","chocohaxmoderator"}
--------------------------------