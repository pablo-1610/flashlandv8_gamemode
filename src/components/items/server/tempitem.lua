--[[
  This file is part of FlashLand.
  Created at 08/11/2021 23:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Items.registerItem = function(id, label, description, weight, onUse)
    if (_FlashServer_Items.exists(id)) then
        _FlashLand.err("Tentative d'enregistrer un item deja existant")
        return
    end
    ---@type _Item
    local item = _Item(id, label, description, weight, onUse)
    _FlashServer_Items.add(item)
end