resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'ND_Ping'
description 'Allow Players To Ping Eachother Their Location'
author 'NitroDevelopment - https://github.com/Nitro Development'
version 'v1.0.0'
url 'https://github.com/NitroDevelopment/ND_ping/'

client_scripts {
    'config.lua',
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

dependencies {
	'ND_notify',
}
