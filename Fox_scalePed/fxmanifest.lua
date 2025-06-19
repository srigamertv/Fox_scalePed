fx_version "cerulean"
lua54 'yes'

game "gta5"

name "um-ped-scale"
author "YourName"
version "1.0.0"
description "ped scale script for FiveM"

shared_scripts {
    'config.lua',
}

client_scripts {
	'@vrp/lib/utils.lua',
    'client/*.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
    'server/*.lua',
}
