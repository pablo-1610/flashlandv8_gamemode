--[[
  This file is part of FlashLand.
  Created at 10/12/2021 14:18
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashClient_Npc
_FlashClient_Npc = {}

local list = {}

_FlashClient_Npc.getAmount = function()
    return (_FlashUtils.table_count(list))
end

_FlashClient_Npc.getAll = function()
    return (list)
end

_FlashClient_Npc.remove = function(lightNpcId)
    if (_FlashClient_Npc.exists(lightNpcId) and list[lightNpcId].handler) then
        _FlashClient_Npc.deleteNpc(list[lightNpcId].handler)
    end
    list[lightNpcId] = nil
end

_FlashClient_Npc.set = function(lightNpcId, lightNpc)
    if (_FlashClient_Npc.exists(lightNpcId)) then
        lightNpc.handler = list[lightNpcId].handler
        list[lightNpcId] = lightNpc
        return
    end
    list[lightNpcId] = lightNpc
    _FlashClient_Npc.createNpc(lightNpc)
    _FlashClient_Npc.tryInvokeDrawer()
end

_FlashClient_Npc.setHandler = function(lightNpcId, handler)
    if (_FlashClient_Npc.exists(lightNpcId)) then
        list[lightNpcId].handler = handler
    end
end

_FlashClient_Npc.hasHandler = function(lightNpcId)
    if (not (_FlashClient_Npc.exists(lightNpcId))) then
        return (false)
    end
    return (list[lightNpcId].handler ~= nil)
end

_FlashClient_Npc.getHandler = function(lightNpcId)
    if (not (_FlashClient_Npc.exists(lightNpcId))) then
        return (nil)
    end
    return (list[lightNpcId].handler)
end

_FlashClient_Npc.get = function(lightNpcId)
    return (list[lightNpcId])
end

_FlashClient_Npc.getNpcWithName = function()
    local npc = {}
    for k, v in pairs(list) do
        if (v.name) then
            npc[k] = v
        end
    end
    return (npc)
end

_FlashClient_Npc.exists = function(lightNpcId)
    return (list[lightNpcId] ~= nil)
end

_FlashLand.loadedComponent("npc")