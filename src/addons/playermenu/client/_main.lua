--[[
  This file is part of FlashLand.
  Created at 09/11/2021 19:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_PlayerMenu
_FlashClient_PlayerMenu = {}

_FlashClient_PlayerMenu.var = {
    selectedItem = nil,
    selectedWeapon = nil,
    selectedPlayer = nil,
    selectedReport = nil,
    selectedPlayerAction = nil,
    selectedBan = nil,
    selectedOrganisation = nil,
    selectedGradeOrganisation = nil,
    selectedPermission = nil
}

_FlashClient_KeyBind.addKey("f5", "Ouvrir le menu personnel", function()
    _FlashLand.toInternal("playerMenu:openMenu")
end)

_FlashClient_KeyBind.addKey("x", "Arreter l'animation en cour", function()
    if ( not (IsPedInAnyVehicle(PlayerPedId(), false))) then
        ClearPedTasksImmediately(PlayerPedId())
    end
end)