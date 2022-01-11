--[[
  This file is part of FlashLand.
  Created at 11/01/2022 18:20
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

---@class _FlashServer_Organisation
_FlashServer_Organisation = {}

local list = {}

_FlashServer_Organisation.exist = function(id)
    return (list[id] ~= nil)
end

_FlashServer_Organisation.getAll = function()
    return (list)
end

_FlashServer_Organisation.get = function(id)
    if (not (_FlashServer_Organisation.exist(id))) then
        return
    end
    return (list[id])
end

_FlashServer_Organisation.getAllAmount = function()
    return (#list)
end

_FlashServer_Organisation.getNextId = function()
    return (_FlashServer_Organisation.getAllAmount() + 1)
end

_FlashServer_Organisation.add = function(orga)
    _FlashLand.log(("^1Ajout ^7d'une ^6ORGANISATION ^7name: ^3%s"):format(orga.job))
    list[orga.id] = orga
end

_FlashServer_Organisation.remove = function(id)
    _FlashLand.log(("^1Suppression ^7d'une ^6ORGANISATION ^7name: ^3%s"):format(list[id].job))
    list[id] = nil
end

_FlashLand.loadedComponent("organisation")