

            --- BEFORE STARTING PLEASE READ THIS MESSAGE
            --[[This file is the Events config, Here you can configure your blacklisted and protected events]]

            --BLACKLISTED EVENTS are going to trigger as soon a cheater tries to do something, whatever they do...
            --PROTECTED EVENTS are going to trigger when they try to call an eventhandler with a value higher than the capvalue , or if is a -1 for jail events

            -- AntiFakeNameMessage is working separately and is going to detect if a player tries to spam messages with a diffrent name


RS.BlacklistedTriggersDetection = true -- Detect triggers that you have blacklisted in TABLES/BlacklistedEvents.lua
RS.AntiFakeNameMessage = true -- Detects if a player tries to send a message using a fake name or someone's else name

RS.ClearTriggersProtection = true -- Detects weird stuff and/or spamming
    RS.ClearTriggersProtectionChecker = true -- Detects strings or numbers
    RS.ClearTriggersProtectionStringProtection = true -- Detects blacklisted strings
    RS.ClearTriggersProtectionValueProtection = true -- Detects Value Cap
    
    RS.ClearTriggersProtectionAntiSpam = true -- Detects spamming
        RS.ClearTriggersProtectionAntiSpammer = 15 -- How many triggers a user can do in X seconds
        RS.ClearTriggersProtectionAntiSpammerResetTime = 10000 -- 10 seconds

LynxBlacklistedEvents = {
    "redst0nia:checking",
    "hentailover:xdlol",
    "antilynx8:anticheat",
    "antilynxr6:detection",
    "antilynx8r4a:anticheat",
    "antilynxr4:detect",
    "ynx8:anticheat",
    "lynx8:anticheat",
    "adminmenu:allowall",
    "h:xd",
    "HCheat:TempDisableDetection",
    "FAC:EzExec",
}

-- DO NOT ADD GETSHAREDOBJECT HERE!

-- capvalue = nil (No capvalue check for this event)

LynxProtectedEvents = {
    ["esx_fueldelivery:pay"] = {capvalue = 1000},
    -- ["esx_carthief:pay"] = {capvalue=1000},
    ["esx_godirtyjob:pay"] = {capvalue=1000},
    ["esx_pizza:pay"] = {capvalue=1000},
    ["esx_ranger:pay"] = {capvalue=1000},
    ["esx_garbagejob:pay"] = {capvalue=1000},
    ["esx_gopostaljob:pay"] = {capvalue=1000},
    ["esx_slotmachine:sv:2"] = {capvalue=1000},
    ["esx_dmvschool:pay"] = {capvalue=1000},
    ["esx_tankerjob:pay"] = {capvalue=1000},
    ["AdminMenu:giveBank"] = {capvalue=1000},
    ["AdminMenu:giveCash"] = {capvalue=1000},
    ["LegacyFuel:PayFuel"] = {capvalue=1000},
    ["esx_society:billing"] = {capvalue=100000},
    ["js:jailuser"] = {capvalue=-1}, -- USE -1 FOR JAIL EVENTS
    ["ljail:jailplayer"] = {capvalue=nil}, -- USE NIL IF YOU DON'T HAVE A CAPVALUE
    ["esx_jailer:sendToJail"] = {capvalue=nil}, -- USE NIL IF YOU DON'T HAVE A CAPVALUE
    ["esx_jail:sendToJail"] = {capvalue=-1}, -- USE -1 FOR JAIL EVENTS
    ["esx-qalle-jail:jailPlayer"] = {capvalue=-1}, -- USE -1 FOR JAIL EVENTS
}

LynxProtectedEventsGlobalStrings = { -- This table will include strings that are detected on ALL PROTECTED EVENTS
    "Mod Menu",
    "You got fucked",
    "ATG",
    "on top",
    "anticheat",
    "cheat"
}
