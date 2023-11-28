fx_version "adamant"
game "gta5"
lua54 'yes'

author 'EXPLORE, MilyonJames'
description 'https://www.gta-explore.com'

client_scripts {
	"locales/*",
	'config.lua',
	'client/**/*.lua',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"locales/*",
	'config.lua',
	'server/*',
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_cs_tablet_hack.ytyp'

ui_page "client/hacking/ui/index.html"

files {
    "client/hacking/ui/**/*"
}