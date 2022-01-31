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

local permissionsList = {}

for _, permission in pairs(_Config.StaffPermission) do
    table.insert(permissionsList, permission)
end

local function getPlayerHasPermission(actualPermissionRank, permissionSelected)
    for _, rankPermission in pairs(actualPermissionRank) do
        if (permissionSelected == rankPermission) then
            return (true)
        end
    end
    return (false)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[26] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPermission ~= nil) then
        local ranks = _FlashClient_Staff.getRankList()
        local rankData = ranks[_FlashClient_PlayerMenu.var.selectedPermission]
        RageUI.Separator(("Rang : %s%s"):format(rankData.baseColor, rankData.label))
        RageUI.Line()
        perm = "admin.deleteGrade"
        RageUI.Button("Supprimer le grade", nil, {}, (checkPerm(perm)), {
            onSelected = function()
                RageUI.GoBack()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("staff:deleteRank", rankData.id)
                _FlashClient_PlayerMenu.var.selectedPermission = nil
            end,
        })
        RageUI.Line()
        for _, permData in pairs(permissionsList) do
            RageUI.Checkbox(("Perm : %s"):format(permData.label), ("~y~Information : ~s~%s"):format(permData.description), (getPlayerHasPermission(rankData.permissions, permData.perm)), {}, {
                onChecked = function()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("staff:addPermissionForRank", rankData.id, permData.perm)
                end,
                onUnChecked = function()
                    _FlashLand.setIsWaitingForServer(true)
                    _FlashLand.toServer("staff:removePermissionForRank", rankData.id, permData.perm)
                end
            })
        end
    end
end