shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    'config.lua',
    'client/client.lua',
}
server_scripts {
    'server/server.lua',
    'server/config.lua'
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/your_sound_file.ogg'  -- Replace with your actual sound file name.
}
