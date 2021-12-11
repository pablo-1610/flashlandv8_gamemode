--[[
  This file is part of FlashLand.
  Created at 10/12/2021 22:53

  Copyright (c) FlashLand - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Npc
_FlashServer_Npc = {}

local list = {}

---@param npc _Npc
_FlashServer_Npc.set = function(id, npc)
    list[id] = npc
end

---@param npc _Npc
_FlashServer_Npc.add = function(npc)
    _FlashServer_Npc.set(npc.id, npc)
end

_FlashServer_Npc.get = function(npcId)
    return (list[npcId])
end

_FlashServer_Npc.getAll = function()
    return (list)
end

_FlashServer_Npc.getAmount = function()
    return (#list)
end

_FlashServer_Npc.getNextId = function()
    return (_FlashServer_Npc.getAmount() + 1)
end

_FlashServer_Npc.exists = function(npcId)
    return (list[npcId] ~= nil)
end