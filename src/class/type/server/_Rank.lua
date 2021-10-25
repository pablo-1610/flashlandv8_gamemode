--[[
  This file is part of FlashLand.
  Created at 25/10/2021 11:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---@class _Rank
---@field public id string
---@field public label string
---@field public weight number
---@field public permissions table<string>
_Rank = {}
_Rank.__index = _Rank

setmetatable(_Rank, {
    __call = function(_, id, label, weight)
        local self = setmetatable({}, _Rank)
        self.id = id
        self.label = label
        self.weight = weight
        self.permissions = {}
        return self
    end
})

function _Rank:hasPermission(query)
    for _, permission in pairs(self.permissions) do
        if (permission == query) then
            return true
        end
    end
    return false
end

function _Rank:addPermission(permission)
    table.insert(self.permissions, permission)
end

function _Ranks:addPermissions(permissions)
    for _, permission in pairs(permissions) do
        self:addPermissions(permission)
    end
end

function _Rank:deletePermission(query)
    if (not (self:hasPermission(query))) then
        _FlashLand.log(("Permission introuable dans %s: %s"):format(self.label, query))
        return
    end
    for index, permission in pairs(self.permissions) do
        if (permission == query) then
            table.remove(self.permissions, index)
            break
        end
    end
end