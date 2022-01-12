--[[
  This file is part of FlashLand.
  Created at 11/01/2022 21:02
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[21] = function(player)
    local perm = nil
    if (_FlashLand.countTable(_FlashClient_Staff.getOrganisationList()) <= 0) then
        RageUI.Separator("~g~Aucun ~s~report actif !")
    else
        perm = "admin.organisation"
        for key, data in pairs(_FlashClient_Staff.getOrganisationList()) do
            RageUI.Button(("%sOrganisation : ~b~%s"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), data.jobLabel), nil, { RightLabel = "→" }, (checkPerm(perm)), {
                onSelected = function()
                    _FlashClient_PlayerMenu.var.selectedOrganisation = key
                end,
            }, _FlashClient_PlayerMenu.getMenus()[22])
        end
    end
end