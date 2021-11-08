--[[
  This file is part of FlashLand.
  Created at 27/10/2021 16:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@class _FlashServer_Instances
_FlashServer_Instances = {}

local public = 0

_FlashServer_Instances.getPublicInstance = function()
    return (public)
end

_FlashServer_Instances.setOnPublicInstance = function(_src)
    SetPlayerRoutingBucket(_src, public)
end

_FlashServer_Instances.setOnRandomInstance = function(_src)
    local instance = math.random(1, 800000)
    SetRoutingBucketEntityLockdownMode(instance, "strict")
    SetPlayerRoutingBucket(_src, public)
    return (instance)
end

_FlashServer_Instances.getPlayerInstance = function(_src)
    return (GetPlayerRoutingBucket(_src))
end

_FlashServer_Instances.setOnInstance = function(_src, instance)
    SetRoutingBucketEntityLockdownMode(instance, "strict")
    SetPlayerRoutingBucket(_src, instance)
end

_FlashLand.loadedComponent("instances")