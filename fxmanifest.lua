shared_script "@Load/protected.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "MonkeyGG-PumpkinHunt"
description "Um simples script de caça a aboboras de halloween, feito para a comunidade!"
author "MASQUEICOJR"
version "1.0.0.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"@vrp/lib/utils.lua",
	'client/*.lua'
}

server_scripts {
	"@vrp/config/Global.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"@vrp/lib/utils.lua",
	'server/*.lua'
}
