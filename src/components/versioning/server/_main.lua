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

local versionFile = ("./resources/%s/.git/ORIG_HEAD"):format(GetCurrentResourceName())
local version = "UKNOWN"

_FlashServer_Versioning.getCurrentVersion = function()
    return (version)
end

_FlashServer_Versioning.setVer = function()
    local file = io.open(versionFile, "r")
    local ver = nil
    if file then
        for line in file:lines() do
            ver = line
            break
        end
    end
    file:close();
    io.close();
    version = ver
end

_FlashServer_Versioning.setVer()
_FlashLand.loadedComponent("versioning")