fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- Resource Information
name 'FN-DumpsterDiving'
description 'A script to allow players to search dumpsters for loot.'
author 'nexus'
version '1.0.0'

-- Dependencies
dependencies {
    'ox_target',
    'ox_inventory',
    'ox_lib',
}

-- Shared Scripts
shared_scripts {
    'Config.lua',
    '@ox_lib/init.lua'
}

-- Client Scripts
client_scripts {
    'Client.lua'
}

-- Server Scripts
server_scripts {
    'Server.lua'
}