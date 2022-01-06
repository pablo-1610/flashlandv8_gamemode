--[[
  This file is part of FlashLand.
  Created at 05/01/2022 19:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Bans.addBan = function(identifier, playerName, staffName, reason)
    _FlashServer_Database.insert("INSERT INTO flash_bans (identifier, name, moderator, date, reason) VALUES(@identifier, @name, @moderator, @date, @reason)", {
        ["identifier"] = identifier,
        ["name"] = playerName,
        ["moderator"] = staffName,
        ["date"] = _FlashUtils.setDay(),
        ["reason"] = reason,
    }, function()
        local ban = _Ban(identifier, playerName, staffName, _FlashUtils.setDay(), reason)
        _FlashServer_Bans.add(ban)
    end)
end