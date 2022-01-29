--[[
  This file is part of FlashLand.
  Created at 29/01/2022 22:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param job _Job
local function initializeJob(job)
    -- Initialize job's public blip
    if (job:metadataExists(_FlashEnum_JOBMETADATA.PUBLIC_BLIP)) then
        local blipData = job:getMetadata(_FlashEnum_JOBMETADATA.PUBLIC_BLIP)
        _FlashServer_Blips.createPublic(blipData.position, blipData.sprite, blipData.color, _Config.genericBlipSize, blipData.name, blipData.shortrange)
    end
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    for jobId, job in pairs(_FlashServer_Job:getAll()) do
        initializeJob(job)
    end
end)