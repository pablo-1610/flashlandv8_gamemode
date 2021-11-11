--[[
  This file is part of FlashLand.
  Created at 09/11/2021 20:55
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local isFilterActive, isSpaceDisplayActive = false, false
local currentFilterIndex = 1
local filterIndexes = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

local function sortAlphabetically(curTable)
    local ret = {}
    for k, v in _FlashClient_Utils.table_pairByKeys(curTable) do
        table.insert(ret, { name = k, count = v })
    end
    return (ret)
end

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
_FlashClient_PlayerMenu.drawer[2] = function(player)
    _FlashClient_PlayerMenu.getMenus()[2].Subtitle = ("Inventaire — ~o~%s~s~/~o~%s~s~kg"):format(player.inventory:calcWeight(), (player.inventory.capacity*1.00))
    if (_FlashLand.countTable(player.inventory.content) <= 0) then
        RageUI.Separator("Votre sac est vide")
        RageUI.Line()
        RageUI.Separator("Rendez-vous dans une ~g~superette ~s~!")
    else
        RageUI.Checkbox("Filtre alphabétique", nil, isFilterActive, {}, {
            onSelected = function(newState)
                isFilterActive = newState
            end
        })

        RageUI.Checkbox("Visualiser l'espace", nil, isSpaceDisplayActive, {}, {
            onSelected = function(newState)
                isSpaceDisplayActive = newState
            end
        })

        if (isFilterActive) then
            RageUI.List("Filtre:", filterIndexes, currentFilterIndex, nil, {}, true, {
                onListChange = function(index)
                    currentFilterIndex = index
                end
            })
        end

        RageUI.Line()

        for _, data in pairs(sortAlphabetically(player.inventory.content)) do
            local draw = true
            local function displayItem()
                local description, label = getItemDesc(data.name), getItemLabel(data.name)
                local function roundInv()
                    local percent = getItemTotalWeight(data.name, player)*100/player.inventory:calcWeight()
                    return rd(percent, 1)
                end
                RageUI.Button(("[~o~x%s~s~] %s%s"):format(data.count, label, (isSpaceDisplayActive and (" "..(("(~r~%s%%~s~)"):format(roundInv()))) or (""))), (
                        (description ~= nil and ("~o~Description: ~s~%s"):format(description))
                ), { RightLabel = "→" }, true, {
                    onSelected = function()
                        _FlashClient_PlayerMenu.var.selectedItem = data.name
                    end
                }, _FlashClient_PlayerMenu.getMenus()[8])
            end
            if (isFilterActive) then
                local filter = filterIndexes[currentFilterIndex]:lower()
                local match = (_FlashUtils.string_startsWith(getItemLabel(data.name):lower(), filter))
                if (not (match)) then
                    draw = false
                end
            end
            if draw then
                displayItem()
            end
        end
    end
end