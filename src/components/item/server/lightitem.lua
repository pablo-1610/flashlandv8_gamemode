--[[
  This file is part of FlashLand.
  Created at 09/11/2021 20:46
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Items.getAllLight = function()
    local items = {}
    ---@param item _Item
    for id, item in pairs(_FlashServer_Items.getAll()) do
        items[id] = _LightItem(item.id, item.label, item.description, item.weight, item:getIsUsable())
        print(("%s utilisable ? → %s"):format(id, json.encode(item:getIsUsable())))
    end
    return (items)
end

_FlashLand.onReceive("item:requestLightItems", function()
    local _src = source
    _FlashLand.toClient("cache:setCache", _src, "items", _FlashServer_Items.getAllLight())
end)