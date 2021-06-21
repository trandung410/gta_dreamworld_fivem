resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
server_script {
  "@mysql-async/lib/MySQL.lua",
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/de.lua',
  "server/server.lua",
  "config/config.lua"
}

client_script {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/de.lua',
  "client/client.lua",
  "client/animation.lua",
  "client/photo.lua",
  "config/config.lua"
}

ui_page "html/main.html"

files {
    'html/main.html',
    'html/js/*.js',
    'html/img/samsung-s10.png',
    'html/css/*.css',
    'html/sound/Phonecall.ogg',
    'html/sound/ring.ogg',
    'html/sound/Google_Event.ogg',
    'html/sound/message_tone.ogg',
    'html/sound/*.ogg',
    'html/fonts/font-1.ttf',
    'html/fonts/HalveticaNeue-Medium.ttf',
    'html/fonts/KeepCalm-Medium.ttf',
    'html/fonts/Azonix.otf',
    'html/fonts/keepcalm.otf',
    'html/fonts/SamsungSans-Bold.woff',
    'html/fonts/SamsungSans-Light.woff',
    'html/fonts/SamsungSans-Medium.woff',
    'html/fonts/SamsungSans-Regular.woff',
    'html/fonts/SamsungSans-Thin.woff',
    'html/img/backgrounds/default-qbus.png'
}