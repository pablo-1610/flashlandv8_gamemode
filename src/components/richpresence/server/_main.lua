--[[
  This file is part of FlashLand.
  Created at 28/10/2021 16:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_RichPresence
_FlashServer_RichPresence = {}

_FlashLand.onReceive("richpresence:getVersion", function()
    local _src = source
    local version = _FlashServer_Versioning.getCurrentVersion()
    _FlashLand.toClient("richpresence:cbVersion", _src, version)
end)

_FlashLand.loadedComponent("richPresence")