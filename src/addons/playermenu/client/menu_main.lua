--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _LightPlayer
_FlashClient_PlayerMenu.drawer[1] = function(player)
    RageUI.Separator(("Rang: %s%s"):format(player.rank.baseColor, player.rank.label))
    RageUI.Button("Inventaire", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[2])
    RageUI.Button("Équipement", nil, {RightLabel = "→"}, true, {}, _FlashClient_PlayerMenu.getMenus()[12])
    RageUI.Button("Portefeuille", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[3])
    RageUI.Button("Animations", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[4])
    RageUI.Button("Divers", nil, {RightLabel = "→"}, true, { }, _FlashClient_PlayerMenu.getMenus()[7])
    RageUI.Button("Mon véhicule", nil, {RightLabel = "→"}, _FlashClient_Utils.ped_isDriver(PlayerPedId()), { }, _FlashClient_PlayerMenu.getMenus()[6])
    RageUI.Button("Administration", nil, {RightLabel = "→"}, (player.rank:hasPermission("admin.open")), {}, _FlashClient_PlayerMenu.getMenus()[5])
    RageUI.Separator("~c~FlashLandRP © 2022")
end