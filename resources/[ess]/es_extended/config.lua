Config                      = {}
Config.Locale               = 'en'

Config.Accounts             = { 'bank', 'black_money','vcoin' }
Config.AccountLabels        = { 
    bank = _U('bank'), 
    black_money = _U('black_money'),
    vcoin = "Kim Cương"
 }

Config.EnableSocietyPayouts = true -- pay from the society account that the player is employed at? Requirement: esx_society
Config.ShowDotAbovePlayer   = false
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)

Config.PaycheckInterval     = 10 * 60000
Config.MaxPlayers           = GetConvarInt('sv_maxclients', 255) -- set this value to 255 if you're running OneSync

Config.EnableDebug          = true
Config.TimeToRemovePickup = 60000
