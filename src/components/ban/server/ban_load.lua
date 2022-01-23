--[[
  This file is part of FlashLand.
  Created at 03/01/2022 18:26
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashServer_Database.query("SELECT * FROM flash_bans", {}, function(result)
        for _, data in pairs(result) do
            local currentTime = _FlashUtils.setCurrentTime()
            local banTime = tonumber(data.time)
            if (currentTime < banTime) then
                local ban = _Ban(data.identifier, data.name, data.date, _FlashUtils.decodeTime(data.time), data.reason, data.moderator)
                _FlashServer_Bans.add(ban)
            else
                _FlashLand.log((_FlashEnum_BAN.DELETE_BAN_FOR_EXPIRATION):format(data.name))
                _FlashServer_Database.execute("DELETE FROM flash_bans WHERE identifier = @identifier", {
                    ["identifier"] = data.identifier
                })
            end
        end
    end)
end)