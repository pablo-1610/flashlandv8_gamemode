--[[
  This file is part of FlashLand.
  Created at 12/12/2021 13:13
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("shop:openShopMenu", function(_src, shopId, shopType, shopNpcId)
    local categories = _ConfigServer.Shops.categories
    for categoryId, category in pairs(categories) do
        for itemId, itemData in pairs(category.content) do
            ---@type _Item
            local item = _FlashServer_Items.get(itemData.item)
            categories[categoryId].content[itemId].label = item.label
        end
    end
    ---@type _Npc
    local deskNpc = _FlashServer_Npc.get(shopNpcId)
    deskNpc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    _FlashServer_Shops.getFidelityPoints(_src, function(points)
        if (points == nil) then
            points = 0
            _FlashServer_Shops.createFidelity(_src)
        end
        _FlashLand.toClient("shop:openMenu", _src, shopId, shopType, shopNpcId, categories, points)
    end)
end)