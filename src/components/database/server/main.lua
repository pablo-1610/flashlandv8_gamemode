--[[
  This file is part of FlashLand.
  Created at 25/10/2021 10:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Database
_FlashServer_Database = {}

---safeParameters
---@param params table
---@return table
---@private
local function safeParameters(params)
    if nil == params then
        return { [''] = '' }
    end
    assert(type(params) == "table", "A table is expected")
    if next(params) == nil then
        return { [''] = '' }
    end
    return params
end

_FlashServer_Database.execute = function(query, params, func)
    _FlashLand.sql(query)
    exports[GetCurrentResourceName()]:mysql_execute(query, safeParameters(params), func)
end

_FlashServer_Database.query = function(query, params, func)
    _FlashLand.sql(query)
    exports[GetCurrentResourceName()]:mysql_fetch_all(query, safeParameters(params), func)
end

_FlashServer_Database.insert = function(query, params, func)
    _FlashLand.sql(query)
    exports[GetCurrentResourceName()]:mysql_insert(query, safeParameters(params), func)
end

_FlashLand.loadedComponent("database")