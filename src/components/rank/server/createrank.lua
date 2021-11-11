--[[
  This file is part of FlashLand.
  Created at 11/11/2021 00:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Ranks.create = function(id, label, weight)
    if (_FlashServer_Ranks.exists(id)) then
        _FlashLand.err(("Tentative de créer un rang existant (^3%s^7)"):format(id))
        return
    end
    _FlashServer_Database.insert("INSERT INTO flash_ranks (id, label, weight) VALUES(@id, @label, @weight)", {
        ["id"] = id,
        ["label"] = label,
        ["weight"] = weight
    })
    _FlashServer_Ranks.add(id, _Rank(id, label, weight))
end