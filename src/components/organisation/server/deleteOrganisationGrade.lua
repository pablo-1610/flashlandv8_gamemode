--[[
  This file is part of FlashLand.
  Created at 22/02/2022 16:45
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.deleteGrade = function(organisation, gradeId, callback)
    if (not (_FlashServer_Organisation.exist(organisation))) then
        return callback(false)
    end
    if (not (_FlashServer_Organisation.gradeExist(organisation, gradeId))) then
        return callback(false)
    end
    _FlashServer_Database.execute("DELETE FROM flash_orga_grades WHERE orgaId = @orgaId AND grade_id = @grade_id", {
        ["orgaId"] = organisation,
        ["grade_id"] = gradeId
    }, function()
        _FlashServer_Database.execute("DELETE FROM flash_orga_grades_permissions WHERE orga_name = @orga_name AND gradeId = @gradeId", {
            ["orga_name"] = organisation,
            ["gradeId"] = gradeId
        }, function()
            callback(true)
        end)
    end)
end