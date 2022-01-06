--[[
  This file is part of FlashLand.
  Created at 05/01/2022 19:46
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Bans.removeBan = function(identifier)
    _FlashServer_Database.execute("DELETE FROM flash_bans WHERE identifier = @identifier", {
        ["identifier"] = identifier
    }, function()
        _FlashServer_Bans.remove(identifier)
    end)
end