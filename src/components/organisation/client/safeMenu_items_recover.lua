--[[
  This file is part of FlashLand.
  Created at 24/02/2022 19:31
  
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
_FlashClient_Organisation_Safe.drawer[4] = function(player)
    RageUI.Separator(("Organisation : ~r~%s"):format(_FlashClient_Organisation_Safe.intraVars.label))
    if (_FlashLand.countTable(_FlashClient_Organisation_Safe.intraVars.items) <= 0) then
        RageUI.Line()
        RageUI.Separator("~r~Aucun item dans le coffre")
    else
        RageUI.Separator(("Nombre d'item different : ~r~%s"):format(#_FlashClient_Organisation_Safe.intraVars.items))
        RageUI.Line()
        RageUI.Separator("~b~↓↓ ~s~ITEM(S) ~b~↓↓")
        for name, value in pairs(_FlashClient_Organisation_Safe.intraVars.items) do
            RageUI.Button((("~o~%s"):format(getItemLabel(name))), ("~y~Information : ~s~%s"):format(getItemDesc(name)), { RightLabel = ("~r~x%s"):format(value) }, (checkPerm("orga.safeRecoverItem")), {
                onSelected = function()
                    local input = _FlashClient_Utils.input_showBox("Nombre: ?", nil, 5, true)
                    local inputInt = tonumber(input)
                    if ((inputInt ~= nil) and (inputInt > 0) and (value >= inputInt)) then
                        _FlashLand.setIsWaitingForServer(true)
                        _FlashLand.toServer("orga:givePlayerItem", _FlashClient_Organisation_Safe.intraVars.name, name, inputInt)
                    end
                end,
            })
        end
    end
end