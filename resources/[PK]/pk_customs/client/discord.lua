Citizen.CreateThread(function()
    while true do
        -- Replace the functions below with your own ID and asset-names
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(756427440837886021)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('dreamworld')

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Dream World | DEV')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Dream World | DEV')
        
        
        
        -- Showname implementation with new Native
        -- Old script: https://github.com/Parow/showname
        
        -- Amount of online players (Don't touch)
        local playerCount = #GetActivePlayers()
        
        -- Your own playername (Don't touch)
        local playerName = GetPlayerName(PlayerId())

        -- Set here the amount of slots you have (Edit if needed)
        local maxPlayerSlots = "128"

        -- Sets the string with variables as RichPresence (Don't touch)
        SetRichPresence(string.format("%s - %s/%s", playerName, playerCount, maxPlayerSlots))
        
        -- It updates every one minute just in case.
		Citizen.Wait(120000)
	end
end)