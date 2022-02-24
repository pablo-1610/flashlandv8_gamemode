--[[
  This file is part of FlashLand.
  Created at 24/02/2022 19:32
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function getItemLabel(item)
    return ((_FlashClient_Cache.getCache("items")[item].label))
end

local function getItemDesc(item)
    return ((_FlashClient_Cache.getCache("items")[item].description))
end

local function checkPerm(permission)
    return (_FlashClient_Organisation.hasPermission(permission))
end

---@param player _Player
_FlashClient_Organisation_Safe.drawer[5] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Safe.intraVars.label))
    if (_FlashLand.countTable(player.inventory.content) <= 0) then
        RageUI.Line()
        RageUI.Separator("~r~Aucun item sur vous")
    else
        RageUI.Separator(("Nombre d'item different : ~r~%s"):format(_FlashLand.countTable(player.inventory.content)))
        RageUI.Line()
        RageUI.Separator("~b~↓↓ ~s~ITEM(S) ~b~↓↓")
        for name, value in pairs(player.inventory.content) do
            RageUI.Button((("~o~%s"):format(getItemLabel(name))), ("~y~Information : ~s~%s"):format(getItemDesc(name)), { RightLabel = ("~r~x%s"):format(value) }, (checkPerm("orga.safeDepositItem")), {
                onSelected = function()
                    local input = _FlashClient_Utils.input_showBox("Nombre: ?", nil, 5, true)
                    local inputInt = tonumber(input)
                    if ((inputInt ~= nil) and (inputInt > 0) and (value >= inputInt)) then
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("orga:removePlayerItem", _FlashClient_Organisation_Safe.intraVars.name, name, inputInt)
                    end
                end,
            })
        end
    end
end