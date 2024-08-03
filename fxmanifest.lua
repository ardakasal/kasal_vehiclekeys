fx_version 'cerulean'
game 'gta5'

author 'Arda Kasal'
description 'Örnek bir FiveM kaynağı'
version '1.0.0'

-- Client ve server tarafındaki scriptler
client_scripts {
    'client.lua',
    'cl_utils.lua'
}

-- Paylaşılan scriptler
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
} 

server_scripts {
    'server.lua',
    'sv_utils.lua'
}


lua54 'yes'
