--[[
  This file is part of FlashLand.
  Created at 12/12/2021 13:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Shop.drawer[1] = function(player, categories)
    RageUI.Separator(("Points de fidelité: ~y~%i"):format(_FlashClient_Shop.var.points))
    RageUI.Line()
    for categoryId, v in pairs(_FlashClient_Shop.var.categories) do
        RageUI.Button(v.label, nil, { RightLabel = "→" }, true, {
            onActive = function()
                _FlashClient_Shop.var.selectedCategory = categoryId
            end
        }, _FlashClient_Shop.getMenus()[2])
    end
end