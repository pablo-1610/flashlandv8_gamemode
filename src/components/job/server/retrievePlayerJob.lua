--[[
  This file is part of FlashLand.
  Created at 29/01/2022 22:35
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

function _FlashServer_Job:retrievePlayerJob(flashId, cb)
    _FlashServer_Database.query("SELECT * FROM flash_players_job WHERE flashId = @flashId", {
        ["@flashId"] = flashId
    }, function(result)
        if (result[1]) then
            cb(result[1].job, result[1].job_grade)
        else
            cb(_ConfigServer.Start.job.default, nil)
        end
    end)
end