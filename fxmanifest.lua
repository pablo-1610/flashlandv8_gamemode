--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:06
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

fx_version 'cerulean'
games { 'gta5' };

description "Main system of Flash Land RP"
author "Pablo_1610"
version '0.1'
repository 'https://github.com/PABLO-1610/flashland'

--[[
    Vendors
--]]

server_scripts {
    "src/vendors/MySQL/mysql-async.js"
}

client_scripts {
    "src/vendors/RageUI/RMenu.lua",
    "src/vendors/RageUI/menu/RageUI.lua",
    "src/vendors/RageUI/menu/Menu.lua",
    "src/vendors/RageUI/menu/MenuController.lua",
    "src/vendors/RageUI/components/*.lua",
    "src/vendors/RageUI/menu/elements/*.lua",
    "src/vendors/RageUI/menu/items/*.lua",
    "src/vendors/RageUI/menu/panels/*.lua",
    "src/vendors/RageUI/menu/windows/*.lua",
}

--[[
    FlashLand
--]]

loadscreen "src/web/loading/index.html"

files {
    "src/web/resources/img/flash.png"
}

shared_scripts {
    -- Infos
    "config.lua",
    -- Enum
    "src/class/enum/*.lua",
    -- Objects
    "src/class/type/shared/*.lua",
    -- Init
    "src/core/shared/main.lua",
    -- Modules
    "src/components/**/shared/*.lua",
    -- Addons
    "src/addons/**/shared/*.lua"
}

client_scripts {
    -- Objects
    "src/class/type/client/*.lua",
    -- Init
    "src/core/client/utils/*.lua",
    "src/core/client/main.lua",
    -- Modules
    "src/components/**/client/*.lua",
    -- Addons
    "src/addons/**/client/*.lua",
    -- Dev
    "src/dev/client.lua"
}

server_scripts {
    -- Objects
    "src/class/type/server/*.lua",
    -- Init
    "src/core/server/utils/*.lua",
    "src/core/server/main.lua",
    -- Modules
    "src/components/**/server/*.lua",
    -- Addons
    "src/addons/**/server/*.lua"
}