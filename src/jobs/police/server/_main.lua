--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:41
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610


_FlashServer_Job:registerJob("police", "Police")
                :setMetadata(_FlashEnum_JOBMETADATA.PUBLIC_BLIP, {
    position = vector3(440.74, -982.77, 30.68),
    name = "Poste de police",
    color = 29,
    sprite = 60,
    shortRange = true,
})
                :setMetadata(_FlashEnum_JOBMETADATA.VEHICLES_INFOS, {
    zones = {
        vector3(440.74, -982.77, 30.68)
    }
})
