--[[
  This file is part of FlashLand.
  Created at 12/12/2021 15:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Shop.drawer[2] = function(player)
    local currentCategory = _FlashClient_Shop.var.categories[_FlashClient_Shop.var.selectedCategory]
    --RageUI.Separator(("Catégorie: ~b~%s"):format(currentCategory.label))
    RageUI.Separator(("Total: %s"):format(_FlashUtils.math_price(_FlashClient_Shop.calculateTotalPrice())))
    RageUI.Line()
    for k, v in pairs(currentCategory.content) do
        RageUI.Button(("%s%s"):format(v.label, (_FlashClient_Shop.isItemInBasket(v.item) and (" (~b~x%s~s~)"):format(_FlashClient_Shop.getItemCount(v.item)) or "")), nil, { RightLabel = _FlashUtils.math_price(v.price) }, true, {
            onSelected = function()
                _FlashClient_Shop.addItemToBasket(v.item)
            end
        })
    end
end