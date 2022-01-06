--[[
  This file is part of FlashLand.
  Created at 03/01/2022 16:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Bans
_FlashServer_Bans = {}

local list = {}

_FlashServer_Bans.exist = function(banIdentifier)
    return (list[banIdentifier] ~= nil)
end

_FlashServer_Bans.get = function(banIdentifier)
    if (not (_FlashServer_Bans.exist(banIdentifier))) then
        return nil
    end
    return (list[banIdentifier])
end

_FlashServer_Bans.getAll = function()
    return (list)
end

---@param ban _Ban
_FlashServer_Bans.add = function(ban)
    _FlashLand.log(("^2Ajout ^7d'un ^6BAN ^7identifier: ^3%s"):format(ban.identifier))
    list[ban.identifier] = ban
end

_FlashServer_Bans.remove = function(banIdentifier)
    _FlashLand.log(("^1Suppression ^7d'un ^6BAN ^7identifier: ^3%s"):format(list[banIdentifier].flashId))
    list[banIdentifier] = nil
end

_FlashLand.loadedComponent("ban")