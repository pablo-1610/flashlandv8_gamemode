--[[
  This file is part of FlashLand.
  Created at 11/11/2021 13:56
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local function getItemLabel(item)
    return ((_FlashClient_Cache.getCache("items")[item].label))
end

local function getItemIsUsable(item)
    return ((_FlashClient_Cache.getCache("items")[item].usable))
end

local function getItemWeight(item)
    return ((_FlashClient_Cache.getCache("items")[item].weight) * 1.00)
end

---@param player _Player
local function getItemTotalWeight(item, player)
    local qty = (player.inventory.content[item])
    return (getItemWeight(item) * qty)
end

local function showItemInfos(item, player)
    local mugshot, mugshotStr = _FlashClient_Utils.ped_getMugShot(PlayerPedId())
    _FlashClient_Utils.notifications_showAdvanced("Inventaire", ("~o~%s"):format(getItemLabel(item)), ("~s~Poids occupé: ~o~%sg~n~~s~Poids unitaire: ~o~%sg~n~~s~Utilisable: ~s~%s"):format(getItemTotalWeight(item, player), getItemWeight(item), (getItemIsUsable(item) and "~g~Oui" or "~r~Non")), mugshotStr, _FlashEnum_MESSAGEICONTYPE.ARROW)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[8] = function(player, closestData)
    local selectedItem = _FlashClient_PlayerMenu.var.selectedItem
    if (not (player.inventory.content[selectedItem])) then
        RageUI.Separator("~r~Vous ne possédez pas cet item")
        RageUI.Line()
        RageUI.Button("Revenir en arrière", nil, {RightLabel = "→"}, true, {
            onSelected = function()
                RageUI.GoBack()
            end
        })
    else
        local itemLabel = getItemLabel(selectedItem)
        _FlashClient_PlayerMenu.getMenus()[8].Subtitle = ("Inventaire — %s"):format(itemLabel)
        RageUI.Button(("Sélection: ~o~%s ~s~[~o~x%s~s~]"):format(itemLabel, player.inventory.content[selectedItem]), nil, {}, true, {})
        RageUI.Line()
        RageUI.Button("Inspecter", nil, {}, true, {
            onSelected = function()
                showItemInfos(selectedItem, player)
            end
        })
        RageUI.Button("Utiliser", nil, {}, getItemIsUsable(selectedItem), {
            onSelected = function()
                _FlashLand.setIsWaitingForServer(true)
                _FlashLand.toServer("inventory:useItem", selectedItem)
            end
        })
        RageUI.Button(("%sDonner"):format(_FlashClient_Utils.menu_tooFarIndicatorIfTrue(not (_FlashClient_Utils.proximity_canInteract(closestData)))), nil, {}, _FlashClient_Utils.proximity_canInteract(closestData), {
            onSelected = function()
                local amount = _FlashClient_Utils.input_showBox("Quantité:", "", 20, true)
                if (amount ~= nil and tonumber(amount) ~= nil and tonumber(amount) > 0) then
                    amount = tonumber(amount)
                    isWaitingForServer = true
                    _FlashLand.toServer("playerMenu:giveItem", GetPlayerServerId(closestData[1]), selectedItem, amount)
                end
            end
        })
    end
end