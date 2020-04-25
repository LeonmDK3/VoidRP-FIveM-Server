
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

client_scripts {
    'config.lua',
    'tesmenu.lua',
    'main.lua'
} 

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    's_main.lua'
} 

files {
    'html/index.html',
    'html/style.css',
    'html/listener.js',
    'html/sound/notification.ogg',
    'html/fonts/pdown.ttf'
}


