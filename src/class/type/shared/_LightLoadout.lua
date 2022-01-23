--[[
  This file is part of FlashLand.
  Created at 09/11/2021 22:09
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _LightLoadout
---@field public id number
---@field public type number
---@field public capacity number
---@field public content table
_LightLoadout = {}
_LightLoadout.__index = _LightLoadout

setmetatable(_LightLoadout, {
    __call = function(_, id, type, capacity, content)
        local self = setmetatable({}, _LightLoadout)
        self.id = id
        self.type = type
        self.capacity = capacity
        self.content = content
        return self
    end
})

function _LightLoadout:calcWeight()
    -- TODO → Calc loadout
end

function _LightLoadout:hasWeapon(weapon)
    weapon = weapon:lower()
    for _, w in pairs(self.content) do
        if w:lower() == weapon then
            return true
        end
    end
    return false
end