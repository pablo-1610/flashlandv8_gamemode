--[[
  This file is part of FlashLand.
  Created at 01/02/2022 21:29
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceive("job:outWeaponFromArmory", function(jobId, weapon)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (_FlashServer_Job:exists(jobId))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.JOB_NOT_EXISTS)
        return
    end
end)