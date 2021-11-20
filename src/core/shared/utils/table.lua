--[[
  This file is part of FlashLand.
  Created at 20/11/2021 11:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashUtils.table_sortAlphabetically = function(curTable)
    local ret = {}
    for k, v in _FlashClient_Utils.table_pairByKeys(curTable) do
        table.insert(ret, { name = k, count = v })
    end
    return (ret)
end

