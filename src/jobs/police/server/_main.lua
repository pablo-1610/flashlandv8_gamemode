--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

RegisterCommand("crJob", function()
    _FlashServer_Job:registerJob("police", "Police")
end)