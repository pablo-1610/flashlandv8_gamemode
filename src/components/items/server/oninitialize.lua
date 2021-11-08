--[[
  This file is part of FlashLand.
  Created at 08/11/2021 22:08
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT * FROM flash_item", {}, function(result)
        for _, row in pairs(result) do
            local item = _Item(row.item_id, row.item_label, row.item_description, row.item_weight)
            _FlashServer_Items.add(item)
        end
    end)
end)