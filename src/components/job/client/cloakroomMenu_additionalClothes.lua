--[[
  This file is part of FlashLand.
  Created at 01/02/2022 20:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_Job_CloakroomMenu.drawer[2] = function(player)
    local clothes = _FlashClient_Job_CloakroomMenu.intraVars.additionalClothes
    for _, clothesData in pairs(clothes) do
        local label = clothesData.label
        RageUI.Button(label, nil, {RightLabel = "→"}, true, {
            onSelected = function()
                _FlashClient_SkinChanger.applySkin(clothesData.outfit)
            end
        })
    end
end