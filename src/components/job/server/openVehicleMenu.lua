--[[
  This file is part of FlashLand.
  Created at 30/01/2022 19:47
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
---@param job _Job
function _FlashServer_Job:openVehicleMenu(_src, player, job, outPossibilities, zoneId)
    if (not (player)) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    if (player.job._job ~= job) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.WRONG_JOB)
        return
    end
    _FlashLand.toClient("job:openVehicleMenu", _src, job.id, job:getVehicles(), outPossibilities, zoneId)
end