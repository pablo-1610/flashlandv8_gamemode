--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:06
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

resource_type 'gametype' { name = 'flashland' }
fx_version 'adamant'
game 'gta5'

description "Main system of Flash Land RP"
author "Pablo_1610"
version '0.1'
repository 'https://github.com/PABLO-1610/flashland'

--[[
    Vendors
--]]

server_scripts {
    -- MySQL
    "src/vendors/MySQL/mysql-async.js",
}

client_scripts {
    -- RageUI
    "src/vendors/RageUI/RMenu.lua",
    "src/vendors/RageUI/menu/RageUI.lua",
    "src/vendors/RageUI/menu/Menu.lua",
    "src/vendors/RageUI/menu/MenuController.lua",
    "src/vendors/RageUI/components/*.lua",
    "src/vendors/RageUI/menu/elements/*.lua",
    "src/vendors/RageUI/menu/items/*.lua",
    "src/vendors/RageUI/menu/panels/*.lua",
    "src/vendors/RageUI/menu/windows/*.lua",
    -- Bob74
    "src/vendors/Bob74/lib/common.lua",
    "src/vendors/Bob74/lib/observers/interiorIdObserver.lua",
    "src/vendors/Bob74/lib/observers/officeSafeDoorHandler.lua",
    "src/vendors/Bob74/client.lua",
    "src/vendors/Bob74/gtav/base.lua",
    "src/vendors/Bob74/gtav/ammunations.lua",
    "src/vendors/Bob74/gtav/bahama.lua",
    "src/vendors/Bob74/gtav/floyd.lua",
    "src/vendors/Bob74/gtav/franklin.lua",
    "src/vendors/Bob74/gtav/franklin_aunt.lua",
    "src/vendors/Bob74/gtav/graffitis.lua",
    "src/vendors/Bob74/gtav/pillbox_hospital.lua",
    "src/vendors/Bob74/gtav/lester_factory.lua",
    "src/vendors/Bob74/gtav/michael.lua",
    "src/vendors/Bob74/gtav/north_yankton.lua",
    "src/vendors/Bob74/gtav/red_carpet.lua",
    "src/vendors/Bob74/gtav/simeon.lua",
    "src/vendors/Bob74/gtav/stripclub.lua",
    "src/vendors/Bob74/gtav/trevors_trailer.lua",
    "src/vendors/Bob74/gtav/ufo.lua",
    "src/vendors/Bob74/gtav/zancudo_gates.lua",
    "src/vendors/Bob74/gta_online/apartment_hi_1.lua",
    "src/vendors/Bob74/gta_online/apartment_hi_2.lua",
    "src/vendors/Bob74/gta_online/house_hi_1.lua",
    "src/vendors/Bob74/gta_online/house_hi_2.lua",
    "src/vendors/Bob74/gta_online/house_hi_3.lua",
    "src/vendors/Bob74/gta_online/house_hi_4.lua",
    "src/vendors/Bob74/gta_online/house_hi_5.lua",
    "src/vendors/Bob74/gta_online/house_hi_6.lua",
    "src/vendors/Bob74/gta_online/house_hi_7.lua",
    "src/vendors/Bob74/gta_online/house_hi_8.lua",
    "src/vendors/Bob74/gta_online/house_mid_1.lua",
    "src/vendors/Bob74/gta_online/house_low_1.lua",
    "src/vendors/Bob74/dlc_high_life/apartment1.lua",
    "src/vendors/Bob74/dlc_high_life/apartment2.lua",
    "src/vendors/Bob74/dlc_high_life/apartment3.lua",
    "src/vendors/Bob74/dlc_high_life/apartment4.lua",
    "src/vendors/Bob74/dlc_high_life/apartment5.lua",
    "src/vendors/Bob74/dlc_high_life/apartment6.lua",
    "src/vendors/Bob74/dlc_heists/carrier.lua",
    "src/vendors/Bob74/dlc_heists/yacht.lua",
    "src/vendors/Bob74/dlc_executive/apartment1.lua",
    "src/vendors/Bob74/dlc_executive/apartment2.lua",
    "src/vendors/Bob74/dlc_executive/apartment3.lua",
    "src/vendors/Bob74/dlc_finance/office1.lua",
    "src/vendors/Bob74/dlc_finance/office2.lua",
    "src/vendors/Bob74/dlc_finance/office3.lua",
    "src/vendors/Bob74/dlc_finance/office4.lua",
    "src/vendors/Bob74/dlc_finance/organization.lua",
    "src/vendors/Bob74/dlc_bikers/cocaine.lua",
    "src/vendors/Bob74/dlc_bikers/counterfeit_cash.lua",
    "src/vendors/Bob74/dlc_bikers/document_forgery.lua",
    "src/vendors/Bob74/dlc_bikers/meth.lua",
    "src/vendors/Bob74/dlc_bikers/weed.lua",
    "src/vendors/Bob74/dlc_bikers/clubhouse1.lua",
    "src/vendors/Bob74/dlc_bikers/clubhouse2.lua",
    "src/vendors/Bob74/dlc_bikers/gang.lua",
    "src/vendors/Bob74/dlc_import/garage1.lua",
    "src/vendors/Bob74/dlc_import/garage2.lua",
    "src/vendors/Bob74/dlc_import/garage3.lua",
    "src/vendors/Bob74/dlc_import/garage4.lua",
    "src/vendors/Bob74/dlc_import/vehicle_warehouse.lua",
    "src/vendors/Bob74/dlc_gunrunning/bunkers.lua",
    "src/vendors/Bob74/dlc_gunrunning/yacht.lua",
    "src/vendors/Bob74/dlc_smuggler/hangar.lua",
    "src/vendors/Bob74/dlc_doomsday/facility.lua",
    "src/vendors/Bob74/dlc_afterhours/nightclubs.lua",
    "src/vendors/Bob74/dlc_casino/casino.lua",
    "src/vendors/Bob74/dlc_casino/penthouse.lua",
}

--ui_page "src/vendors/Phone/web/index.html"

files {
    --Phone
    'src/vendors/Phone/web/*.html',
    'src/vendors/Phone/web/js/*.js',
    'src/vendors/Phone/web/img/*.png',
    'src/vendors/Phone/web/css/*.css',
    'src/vendors/Phone/web/fonts/*.ttf',
    'src/vendors/Phone/web/fonts/*.otf',
    'src/vendors/Phone/web/fonts/*.woff',
    'src/vendors/Phone/web/img/backgrounds/*.png',
    'src/vendors/Phone/web/img/apps/*.png',
}

--[[
    FlashLand
--]]

loadscreen "src/web/loading/index.html"

shared_scripts {
    -- Static
    "static/**/*.lua",
    -- Config
    "config/global.lua",
    -- Enum
    "src/class/enum/*.lua",
    -- Objects
    "src/class/type/shared/*.lua",
    -- Init
    "src/core/shared/utils/*.lua",
    "src/core/shared/main.lua",
    -- Modules
    "src/components/**/shared/*.lua",
    -- Addons
    "src/addons/**/shared/*.lua",
    -- Dev
    "src/dev/shared.lua",
    --Phone
    "src/vendors/Phone/shared/*.lua",
}

client_scripts {
    -- Config
    "config/client.lua",
    -- Objects
    "src/class/type/client/*.lua",
    -- Web
    "src/web/core/*.lua",
    -- Init
    "src/core/client/utils/*.lua",
    "src/core/client/main.lua",
    -- Modules
    "src/components/**/client/*.lua",
    -- Addons
    "src/addons/**/client/*.lua",
    -- Dev
    "src/dev/client.lua",
    -- Phone
    "src/vendors/Phone/client/*.lua",
}

server_scripts {
    -- Environment
    "config/env/environment.lua",
    -- Webhooks
    "config/webhook.lua",
    -- Config
    "config/server.lua",
    -- Objects
    "src/class/type/server/*.lua",
    -- Init
    "src/core/server/utils/*.lua",
    "src/core/server/main.lua",
    -- Modules
    "src/components/**/server/*.lua",
    -- Addons
    "src/addons/**/server/*.lua",
    -- Dev
    "src/dev/server.lua",
    -- Phone
    "src/vendors/Phone/server/*.lua",
}