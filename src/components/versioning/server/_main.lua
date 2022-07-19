--[[
  This file is part of FlashLand.
  Created at 09/11/2021 00:38
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Versioning
_FlashServer_Versioning = {}

local version = _Config.version

_FlashServer_Versioning.getCurrentVersion = function()
    return (version)
end

_FlashLand.loadedComponent("versioning")