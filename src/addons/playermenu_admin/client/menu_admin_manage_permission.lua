--[[
  This file is part of FlashLand.
  Created at 12/01/2022 19:30
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[25] = function(player)
    local perm = nil
    RageUI.Separator("Gestion des groups")
    RageUI.Line()
    perm = "admin.accessRankManagerAndManageRank"
    for rankId, data in pairs(_FlashClient_Staff.getRankList()) do
        RageUI.Button(("%s -> %s"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm))), ("%s%s"):format(data.baseColor, data.label)), nil, {}, (checkPerm(perm) and ((player.rank.id == "fonda") or (not (data.id == player.rank.id)))), {
            onSelected = function()
                _FlashClient_PlayerMenu.var.selectedPermission = rankId
            end,
        }, _FlashClient_PlayerMenu.getMenus()[26])
    end
end