Config = {}
Config.ESX = true
Config.BotToken = "NzU2NDI3NDQwODM3ODg2MDIx.X2Rr8w.J6PZJznwoBdPYiEOfpUehUsWTpg"
Config.WebHook =
    "https://discord.com/api/webhooks/828523794821808138/dSrC3egTal4ymTF_bNC9qiBh6_bdhhxt3AMhXmSD5vAysjIE6AGpxxC91DazI0j5FnK7"
Config.ChannelID = "828523775695650826"
Config.ReplyUserName = "Dream World"
Config.AvatarURL = "https://media.discordapp.net/attachments/747459831925047336/826749063600406538/aaaaa-removebg.png?width=534&height=480"
Config.Prefix = "!"
Config.WaitEveryTick = 5000 
Config.WaitInRateLimit = 600 
Config.EnableRestrictID = false
Config.RestrictIDS = {'ID 1', 'ID 2'}

Config.IdentifierToBan = 'steam' -- You can use discord/steam/license Identifiers For ban.
Config.RestrictBanToID = false -- if you want to only specified discord ids to have access to ban system enable this and add the ids in id list
Config.AllowedDiscordIdsToBan = {'ID 1', 'ID 2'}
Config.BanString = 'You Have been Banned From This Server.Contact Admin'


-- Announce Leave And Joins
Config.AnnounceJoins = true -- Announce a Player join to the server
Config.AnnounceLeaves = true -- Announce a Player Left from the server

-- Whitelist  
Config.EnableWhitelist = false --  you may use whitelist commands to add or remove someone from whitelist
Config.WhitelistIdentifier = 'steam' -- you can use discord/steam/license identifiers for whitelist option. If you change the identifier type please make sure to reset the Whitelists.json
Config.RestrictWhitelistToID = false -- if you want to only specified discord ids to have access to whitelist add or removal enable this
Config.AllowedDiscordIdsToWhitelist = {'ID 1', 'ID 2'}
Config.WhitelistString = 'You are not Whitelisted, In Order to be Whitelisted Please Join Our Discord: Your Discord Link'

-- Your Server Name 
Config.ServerName = 'Dream World'

Config.EnableDiscordScreenshot = true -- requires https://github.com/jaimeadf/discord-screenshot
Config.ScreenshotDetails = {
    encoding = 'png',
    quality = 1,
}