--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Loadout
---@field public id number
---@field public type number
---@field public capacity number
---@field public content table
_Loadout = {}
_Loadout.__index = _Loadout

setmetatable(_Loadout, {
    __call = function(_, id, type, capacity, content)
        local self = setmetatable({}, _Loadout)
        self.id = id
        self.type = type
        self.capacity = capacity
        self.content = content
        -- Validator
        -- TODO → Validator
        --[[
        for type, qty in pairs(content) do
            if (_FlashServer_Items.exists(type)) then
                self.content[type] = qty
            end
        end
        --]]
        return self
    end
})

function _Loadout:destroy()
    _FlashServer_Loadout.remove(self.id)
end

function _Loadout:hasWeapon(weaponName)
    for _, name in pairs(self.content) do
        if (name == weaponName) then
            return (true)
        end
    end
    return (false)
end

function _Loadout:addWeapon(weaponName)
    if (self:hasWeapon(weaponName)) then
        return
    end
    table.insert(self.content, weaponName)
    self:save()
end

function _Loadout:save()
    local currentId, currentCapacity, currentContent = self.id, self.capacity, json.encode(self.content)
    _FlashServer_Database.execute("UPDATE flash_loadout SET loadout_capacity = @loadout_capacity,loadout_content = @loadout_content WHERE loadout_owner = @loadout_owner", {
        ["loadout_capacity"] = currentCapacity,
        ["loadout_content"] = currentContent,
        ["loadout_owner"] = currentId
    })
end