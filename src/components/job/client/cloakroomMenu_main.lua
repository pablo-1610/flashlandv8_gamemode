--[[
  This file is part of FlashLand.
  Created at 01/02/2022 20:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_Job_CloakroomMenu.drawer[1] = function(player)
    RageUI.Button("Tenue civile", nil, {RightLabel = "→"}, true, {
        onSelected = function()
            _FlashClient_SkinChanger.applySkin(player.outfits[player.selectedOutfit])
        end
    })
    if (_FlashClient_Job_CloakroomMenu.intraVars.workClothes) then
        RageUI.Button("Tenue de travail", nil, {RightLabel = "→"}, true, {
            onSelected = function()
                _FlashClient_SkinChanger.applySkin(_FlashClient_Job_CloakroomMenu.intraVars.workClothes)
            end
        })
    end
    if (#_FlashClient_Job_CloakroomMenu.intraVars.additionalClothes > 0) then
        RageUI.Button("Tenues partagées", nil, {RightLabel = "→→"}, true, { }, _FlashClient_Job_CloakroomMenu.getMenus()[2])
    end
end