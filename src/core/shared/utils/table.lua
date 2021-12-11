--[[
  This file is part of FlashLand.
  Created at 20/11/2021 11:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610
---
_FlashUtils.table_pairByKeys = function(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0
    local iter = function()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

_FlashUtils.table_sortAlphabetically = function(curTable)
    local ret = {}
    for k, v in _FlashUtils.table_pairByKeys(curTable) do
        table.insert(ret, { name = k, count = v })
    end
    return (ret)
end

_FlashUtils.table_count = function(curTable)
    local count = 0
    for _, _ in pairs(curTable) do
        count = count + 1
    end
    return (count)
end