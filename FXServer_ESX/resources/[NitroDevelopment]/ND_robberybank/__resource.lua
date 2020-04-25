dependency 'essentialmode'
dependency 'es_extended'
dependency 'esx_doorlock'
dependency 'ND_blowtorch'
dependency 'ND_mhacking'
client_scripts {

	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/tr.lua',
	'locales/fr.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/tr.lua',
	'locales/fr.lua',
	'config.lua',
	'server/server.lua'
}
