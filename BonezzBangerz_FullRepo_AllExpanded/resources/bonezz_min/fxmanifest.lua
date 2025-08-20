fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Bonezz'
description 'Bonezz Minimal: UC blips + safehouses + corrupt cops (lite) in ONE resource'
version '1.0.0'

shared_script 'config.lua'
client_scripts {
    'client.lua'
}
server_scripts {
    'server.lua'
}

dependencies {
    'qb-core',
    'qb-target'
}
