fx_version 'adamant'
games {'gta5'}

client_scripts {
'@threads/threads.lua',
'@scaleforms/scaleforms.lua',
'GameEventTriggered.lua',
'HudColors.lua',
'Config.lua',
'nbk_cstyle_killfeed.lua'
}

server_script "sv.lua" --for the buggy OneSync damage detect 

dependencies {
    'threads',
    'scaleforms',
    'nbk_cstyle_killfeed_stream'
}