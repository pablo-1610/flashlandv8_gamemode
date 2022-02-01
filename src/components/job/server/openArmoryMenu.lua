--[[
  This file is part of FlashLand.
  Created at 01/02/2022 21:16
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
---@param job _Job
function _FlashServer_Job:openArmoryMenu(_src, player, job)
    if (not (player)) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    if (player.job._job ~= job) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.WRONG_JOB)
        return
    end
    local weapons = job:getMetadata(_FlashEnum_JOBMETADATA.ARMORY_INFOS).weapons
    _FlashLand.toClient("job:openArmoryMenu", _src, job.id, weapons)
end