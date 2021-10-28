--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:36
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Utils.identifiers_getAll = function(_src)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(_src)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

_FlashServer_Utils.identifiers_get = function(_src, type)
    return (_FlashServer_Utils.identifiers_getAll(_src)[type] or "")
end