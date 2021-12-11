--[[
  This file is part of FlashLand.
  Created at 11/12/2021 02:42
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("nationalBank:createPlayerBankAccount", function(_src, pin, label)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    _FlashLand.toInternal("nationalBank:playerBankAccountExistsInDb", _src, function(exists)
        if (exists) then
            return
        end
        _FlashServer_Database.insert("INSERT INTO flash_bankaccounts (type, owner, label, pin, balance) VALUES(@type, @owner, @label, @pin, @balance)", {
            ["@type"] = _FlashEnum_BANKACCOUNTTYPE.PERSONAL.id,
            ["@owner"] = ("player:%s"):format(player.flashId),
            ["@label"] = label,
            ["@pin"] = pin,
            ["@balance"] = 0,
        })
    end)
end)