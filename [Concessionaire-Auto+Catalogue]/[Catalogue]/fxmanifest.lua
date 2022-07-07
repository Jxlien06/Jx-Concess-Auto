fx_version 'adamant'
game 'gta5'
Author 'Jxlien'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/sv_catalogue.lua',
}

client_scripts {
	'client/cl_catalogue.lua',
	'dependencies/pmenu.lua'
}
