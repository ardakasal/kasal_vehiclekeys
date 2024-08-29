fx_version 'cerulean'
game 'gta5'
lua54 'yes'


author 'Arda Kasal <ardakasall@gmail.com>'
description 'Advanced vehicle key system with multi-framework support.'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua', 
    'config.lua',
}

client_scripts {
    'client.lua',
    'utils/client_u.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'utils/server_u.lua'
}


