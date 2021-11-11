--[[
  This file is part of FlashLand.
  Created at 11/11/2021 15:55
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerPermissionCommand = function(name, permission, handler, requieredArgs)
    RegisterCommand(name, function(_src, args)
        local cbMesage = function(success, message)
            if (_src == 0) then
                if(success) then
                    _FlashLand.suc(message)
                else
                    _FlashLand.errLog(message)
                end
            else
                if (_FlashServer_Players.exists(_src)) then
                    ---@type _Player
                    local player = _FlashServer_Players.get(_src)
                    player:sendSystemMessage((success and "success" or "error"), message)
                end
            end
        end
        if (_src == 0) then
            -- Console
            if (#args ~= #requieredArgs) then
                _FlashLand.errLog(_FlashServer_Commands.usage(name, requieredArgs))
                return
            end
            handler(false, args, player, cbMesage)
        else
            -- Player
            if (not (_FlashServer_Players.exists(_src))) then
                _FlashLand.err(("Tentative d'execution d'une cmd par un player inexistant (^3%s^7)"):format(_src))
                return
            end
            ---@type _Player
            local player = _FlashServer_Players.get(_src)
            if (not (player.rank:hasPermission(permission))) then
                player.sendSystemMessage("error", "Vous n'avez pas la permission d'executer cette commande")
                return
            end
            if (#args ~= #requieredArgs) then
                player.sendSystemMessage("error", _FlashServer_Commands.usage(name, requieredArgs, true))
                return
            end
            handler(true, args, player, cbMesage)
        end
    end)
end