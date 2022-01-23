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

local permissionDefinition = {}

for _, v in pairs(_ConfigClient.Permission) do
    table.insert(permissionDefinition, v)
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
        for i, permission in pairs(_FlashClient_Staff.getPermissionList()) do
            for _, v in pairs(permissionDefinition) do
                if (v.perm:lower() == ("%s"):format(permission:lower())) then
                    RageUI.Checkbox(("Perm : %s"):format(v.label), ("~y~Information : ~s~%s"):format(v.description), (getPlayerHasPermission(rankData.permissions, permission)), {}, {
                        onChecked = function()
                            _FlashLand.setIsWaitingForServer(true)
                            _FlashLand.toServer("staff:addPermissionForRank", rankData.id, permission)
                        end,
                        onUnChecked = function()
                            _FlashLand.setIsWaitingForServer(true)
                            _FlashLand.toServer("staff:removePermissionForRank", rankData.id, permission)
                        end
                    })
                end
            end
        end
    end
end