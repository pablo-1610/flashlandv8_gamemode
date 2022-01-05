--[[
  This file is part of FlashLand.
  Created at 03/01/2022 18:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT * FROM flash_bans", {}, function(result)
        for _, data in pairs(result) do
            local ban = _Ban(data.identifier, data.flashId, data.name, data.moderator, data.date, data.reason)
            _FlashServer_Bans.add(ban)
        end
    end)
end)