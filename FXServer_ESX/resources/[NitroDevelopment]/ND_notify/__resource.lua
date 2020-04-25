resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'Nitro Development Framework Notification System'
author 'Nitro Development - https://github.com/NitroDevelopment'
version 'v1.0.0'

ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js',
	'html/css/style.css',
}

client_scripts {
	'client/main.lua'
}

exports {
	'DoShortHudText',
	'DoHudText',
	'DoLongHudText',
	'DoCustomHudText',
	'PersistentHudText',
}
