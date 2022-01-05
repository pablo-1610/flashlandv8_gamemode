--[[
  This file is part of FlashLand.
  Created at 05/01/2022 18:00
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[20] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedBan ~= nil) then
        local bans = _FlashClient_Staff.getBanList()
        local banData = bans[_FlashClient_PlayerMenu.var.selectedBan]
        RageUI.Separator(("Nom : ~b~%s~s~"):format(banData.name))
        RageUI.Separator(("Ban le : ~b~%s~s~"):format(banData.date))
        RageUI.Separator(("Ban par : ~o~%s~s~"):format(banData.moderator))
        RageUI.Line()
        RageUI.Separator("↓ Raison ↓")
        RageUI.Separator(("~y~%s"):format(banData.reason))
        RageUI.Line()
        perm = "admin.unban"
        RageUI.Button(("%sUnban"):format(_FlashClient_Utils.menu_crossIndicatorIfTrue(not (checkPerm(perm)))), nil, { RightLabel = "→" }, (checkPerm(perm)), {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:unBanPlayer", banData.identifier)
                _FlashClient_PlayerMenu.var.selectedBan = nil
            end,
        })
    end
end