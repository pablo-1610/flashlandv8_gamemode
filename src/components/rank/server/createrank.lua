--[[
  This file is part of FlashLand.
  Created at 11/11/2021 00:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Ranks.create = function(id, label, position, weight, color, permissions)
    if (_FlashServer_Ranks.exists(id)) then
        _FlashLand.err(("Tentative de créer un rang existant (^3%s^7)"):format(id))
        return
    end
    _FlashServer_Database.insert("INSERT INTO flash_ranks (position, id, label, weight, baseColor) VALUES(@position, @id, @label, @weight, @baseColor)", {
        ["position"] = position,
        ["id"] = id,
        ["label"] = label,
        ["weight"] = weight,
        ["baseColor"] = color
    })
    if (permissions ~= nil) then
        for _, perm in pairs(permissions) do
            _FlashServer_Database.insert("INSERT INTO flash_ranks_permissions (rankId, permission) VALUES (@rankId, @permission)", {
                ["rankId"] = id,
                ["permission"] = perm
            })
        end
    end
    local rank = _Rank(id, label, position, weight, permissions, color)
    _FlashServer_Ranks.add(rank)
end