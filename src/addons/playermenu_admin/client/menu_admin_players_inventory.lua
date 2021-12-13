--[[
  This file is part of FlashLand.
  Created at 11/12/2021 18:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local isSpaceDisplayActive = false
local actionList = { "Item", "Arme" }
local actionIndex = 1

local function getItemLabel(item)
    return ((_FlashClient_Cache.getCache("items")[item].label))
end

local function getItemDesc(item)
    return ((_FlashClient_Cache.getCache("items")[item].description))
end

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[16] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPlayer ~= nil) then
        local players = _FlashClient_Staff.getPlayerList()
        local playerData = players[_FlashClient_PlayerMenu.var.selectedPlayer]
        RageUI.List("Type : ", actionList, actionIndex, nil, {}, true, {
            onListChange = function(Index)
                actionIndex = Index
            end,
        })

        RageUI.Line()
        if actionIndex == 1 then
            if (_FlashLand.countTable(playerData.inventory.content) <= 0) then
                RageUI.Separator("La personne ne possède aucun item !")
            else
                perm = "admin.removeplayeritem"
                for _, data in pairs(_FlashUtils.table_sortAlphabetically(playerData.inventory.content)) do
                    RageUI.Button(("[~o~x%s~s~] %s"):format(data.count, getItemLabel(data.name)), (
                            (getItemDesc(data.name) ~= nil and ("~o~Description: ~s~%s"):format(getItemDesc(data.name)))
                    ), { RightLabel = "→" }, (checkPerm(perm)), {
                        onSelected = function()
                            local input = _FlashClient_Utils.input_showBox("Combien:", "", 10, true)
                            if (input ~= nil and tonumber(input) ~= nil and tonumber(input) > 0) then
                                ---RageUI.GoBack()
                                input = tonumber(input)
                                _FlashLand.setIsWaitingForServer(true)
                                _FlashLand.toServer("staff:removePlayerItem", playerData.sId, data.name, input)
                            end
                        end,
                    })
                end
            end
        elseif actionIndex == 2 then
            if (_FlashLand.countTable(playerData.loadout.content) <= 0) then
                RageUI.Separator("La personne ne possède aucune arme !")
            else
                perm = "admin.removeplayerweapon"
                for _, name in pairs(playerData.loadout.content) do
                    local weaponData = _Static_Weapons[GetHashKey(name:lower())]
                    RageUI.Button(("~s~%s"):format(weaponData.label), nil, { RightLabel = "→" }, (checkPerm(perm)), {
                        onSelected = function()
                            _FlashLand.setIsWaitingForServer(true)
                            _FlashLand.toServer("staff:removePlayerWeapon", playerData.sId, name)
                        end,
                    })
                end
            end
        end
    end
end