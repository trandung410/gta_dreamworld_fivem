
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

loadscreen 'index.html'

loadscreen_manual_shutdown "yes"

client_script "client.lua"

files {
    'index.html',
    'stylesheet.css',
    'config.js',
    'app.js',
    'config.css',
    'imgs/bg.jpg',
    'imgs/logo.png',
    'music/music.ogg'
}
