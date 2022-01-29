--[[
  This file is part of FlashLand.
  Created at 11/01/2022 19:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT * FROM flash_orga", {}, function(result)
        for row, data in pairs(result) do
            local orga = _Orga(data.name, data.label, json.decode(data.boss), json.decode(data.safe), json.decode(data.spawn_vehicle), json.decode(data.del_vehicle), json.decode(data.blip))
            _FlashServer_Organisation.add(orga)
        end
    end)
    Wait(150)
    _FlashServer_Organisation.loadGrade()
end)