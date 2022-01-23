--[[
  This file is part of FlashLand.
  Created at 05/01/2022 19:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Bans.addPlayerBan = function(source, day, reason, staffName, callback)
    if (not (_FlashServer_Players.exists(source))) then
        return callback(false)
    end
    ---@type _Player
    local player = _FlashServer_Players.get(source)
    if (_FlashServer_Bans.exist(player.identifier)) then
        return callback(false)
    end
    local timeForBan = (_FlashUtils.setCurrentTime() + (60 * 60 * 24 * day))
    _FlashServer_Database.insert("INSERT INTO flash_bans (identifier, name, date, time, reason, moderator) VALUES (@identifier, @name, @date, @time, @reason, @moderator)", {
        ["identifier"] = player.identifier,
        ["name"] = player.name,
        ["date"] = _FlashUtils.getCurrentTime(),
        ["time"] = timeForBan,
        ["reason"] = reason,
        ["moderator"] = staffName
    }, function()
        local ban = _Ban(player.identifier, player.name, _FlashUtils.getCurrentTime(), _FlashUtils.decodeTime(timeForBan), reason, staffName)
        _FlashServer_Bans.add(ban)
        player:kickPlayer((_FlashEnum_BAN.PLAYER_BAN):format(ban.reason, ban.date, ban.time, ban.moderator))
        callback(true)
    end)
end

RegisterCommand("ban", function(source, args)
    _FlashServer_Bans.addPlayerBan(tonumber(args[1]), 3, "Troll", "Dorian", function(succes)
        print(succes)
    end)
end)