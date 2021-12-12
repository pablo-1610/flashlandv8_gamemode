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

local function getItemWeight(item)
    return ((_FlashClient_Cache.getCache("items")[item].weight))
end

local function getItemIsUsable(item)
    return ((_FlashClient_Cache.getCache("items")[item].usable))
end

local function rd(num, numDeci)
    return tonumber(string.format("%." .. (numDeci or 0) .. "f", num))
end

local function getItemTotalWeight(item, player)
    local qty = (player.inventory.content[item])
    return (getItemWeight(item) * qty)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[16] = function(player)
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
            for _, data in pairs(_FlashUtils.table_sortAlphabetically(playerData.inventory.content)) do
                local draw = true
                local function displayItem()
                    local description, label = getItemDesc(data.name), getItemLabel(data.name)
                    local function roundInv()
                        local percent = getItemTotalWeight(data.name, player) * 100 / player.inventory:calcWeight()
                        return rd(percent, 1)
                    end
                    RageUI.Button(("[~o~x%s~s~] %s%s"):format(data.count, label, (isSpaceDisplayActive and (" " .. (("(~r~%s%%~s~)"):format(roundInv()))) or (""))), (
                            (description ~= nil and ("~o~Description: ~s~%s"):format(description))
                    ), { RightLabel = "→" }, true, {
                        onSelected = function()

                        end
                    })
                end
                if draw then
                    displayItem()
                end
            end
        end
    elseif actionIndex == 2 then
        if (_FlashLand.countTable(playerData.loadout.content) <= 0) then
            RageUI.Separator("La personne ne possède aucune arme !")
        else
            for _, name in pairs(playerData.loadout.content) do
                local weaponData = _Static_Weapons[GetHashKey(name:lower())]
                RageUI.Button(("~s~%s"):format(weaponData.label), nil, { RightLabel = "→" }, true, {
                    onSelected = function()

                    end
                })
            end
        end
    end
end