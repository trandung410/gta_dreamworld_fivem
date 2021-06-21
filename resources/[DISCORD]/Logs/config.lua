Config                        		= {}
Config.Locale 				  		= 'en'
Config.green 				  		= 56108
Config.grey 				  		= 8421504
Config.red 					  		= 16711680
Config.orange 				  		= 16744192
Config.blue 				  		= 2061822
Config.purple 				  		= 11750815
-----------------------------

-- Youtube : Sam อะไรgunnnee --

-----------------------------

------------------------ Weapon Systems ------------------------
Config.webhook_reweapon2car		    = ""
Config.webhook_addweapon2car		= ""
Config.webhook_reweapon2home	    = ""
Config.webhook_addweapon2home		= ""

------------------------ Cars Systems ------------------------

Config.webhook_add2caritem        	= ""
Config.webhook_re2caritem           = ""
Config.webhook_add2carmoney     	= ""
Config.webhook_re2carmoney 	        = ""

------------------------ Home Systems ------------------------

Config.webhook_putmoneyinhome		= ""
Config.webhook_outmoneyinhome		= ""
Config.webhook_putiteminhome		= ""
Config.webhook_getiteminhome		= ""

------------------------ Garage Systems ------------------------

Config.webhook_addcar_garage  		= ""
Config.webhook_delcar_garage  		= ""
Config.webhook_addcar_pound   		= ""

------------------------ Tranfer Systems ------------------------
Config.webhook_gi_money               = "https://discord.com/api/webhooks/854217862469779467/yyIjkKem8a0atVDv_kWfSG1YG8lqvxkORHBb4GetoCwJjadyUZ5oGd1L9uXKNmUCZOqJ"
Config.webhook_gi_item                = "https://discord.com/api/webhooks/854217974584049695/HXW_R0Shjb1pTlym3kza0_MrtsRtBS3xstPNpqTU_EMY380Qf8-InRRwBpXXphk_2Wkw"
Config.webhook_gi_weapon            = "https://discord.com/api/webhooks/854218136357699614/AWMVFRSxmeMzbWYHCmrlcoaCcwT6EAEv8wOfj7vfSTBZSiRsHRq2W4evwL_4xNdlj1aX"


-------------------------   Vault ------------------------------

Config.webhook_addvault                = ""
Config.webhook_revault                 = ""

------------------------ Others Systems ------------------------

-- Config.webhook_chat                      = "https://discord.com/api/webhooks/854218284769738752/-vPGX1n386MZgR6wVdmSvBlrWZC7ae3hU1xGj1BpoSE-Bmi9xgMzcXroObYoTA_S9as5"
Config.webhook_chat                      = ""
Config.webhook_buycar                  = ""
Config.webhook_selldrugs              = ""
Config.webhook_transfer_money        = ""
Config.webhook_buyitem                  = ""
Config.webhook_re_money               = "https://discord.com/api/webhooks/854218492021571584/XP43ivDhKa-Cc_jOSnalLzfhrrxHQt8AVqlbw44zHZCo1xug6OL2Wy_12ywRWizSkiXX"
Config.webhook_re_item                = "https://discord.com/api/webhooks/854218421234827285/xIz1Ncyt7ZW8_Jp0h76JCaFZkguZrGLObeV5-GTPf9_TnTTmmTJ94p09avRIHpLNhOa1"
Config.webhook_Pickup                 = "https://discord.com/api/webhooks/854218664113995826/cBz6cFH_cFkUeIRYz7U_alfWfBArueKksTIxGEYi7ipOVWmmWxFuoc3Rh9qTAo7iYzT_"
Config.webhook_kill                  = ""  
Config.webhook_crafting             = ""
Config.webhook                        = ""
Config.webhook_player_join            = ""
Config.webhook_CS            = "https://discord.com/api/webhooks/854218587803615294/2AzEp4q3ARCPowx42-2GJ7J0F_jWJfzmLAOoo_fm-MHbmswaxzLbO2CUpBqPwQEtnM0v"









settings = {
	LogKills = true, -- Log when a player kill an other player.
	LogEnterPoliceVehicle = true, -- Log when an player enter in a police vehicle.
	LogEnterBlackListedVehicle = true, -- Log when a player enter in a blacklisted vehicle.
	LogPedJacking = true, -- Log when a player is jacking a car
	LogChatServer = true, -- Log when a player is talking in the chat , /command works too.
	LogLoginServer = true, -- Log when a player is connecting/disconnecting to the server.
	LogItemTransfer = true, -- Log when a player is giving an item.
	LogWeaponTransfer = true, -- Log when a player is giving a weapon.
	LogMoneyTransfer = true, -- Log when a player is giving money
	LogMoneyBankTransfert = true, -- Log when a player is giving money from bankaccount

}



blacklistedModels = {
	"APC",
	"BARRACKS",
	"BARRACKS2",
	"RHINO",
	"CRUSADER",
	"CARGOBOB",
	"SAVAGE",
	"TITAN",
	"LAZER",
	"LAZER",
}
