--[[
  This file is part of FlashLand.
  Created at 12/12/2021 01:24
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local function getItemsList()
    return (_FlashClient_Cache.getCache("items"))
end

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[17] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPlayerAction ~= nil) then
        local players = _FlashClient_Staff.getPlayerList()
        local playerData = players[_FlashClient_PlayerMenu.var.selectedPlayerAction]
        if (getItemsList ~= nil) then
            perm = "admin.giveitem"
            for name, data in pairs(getItemsList()) do
                RageUI.Button(("%s"):format(data.label), ("~o~Description : ~s~%s"):format(data.description), {}, (checkPerm(perm)), {
                    onSelected = function()
                        local input = _FlashClient_Utils.input_showBox("Combien:", "", 10, true)
                        if (input ~= nil and tonumber(input) ~= nil and tonumber(input) > 0) then
                            input = tonumber(input)
                            _FlashLand.toServer("staff:giveItem", playerData.sId, name, input)
                        end
                    end,
                })
            end
        end
    end
end