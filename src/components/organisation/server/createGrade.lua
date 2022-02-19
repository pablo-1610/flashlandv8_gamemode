--[[
  This file is part of FlashLand.
  Created at 19/01/2022 21:52
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashServer_Organisation.createGrade = function(orgaName, gradeId, gradeName, gradeLabel, callback)
    if (not (_FlashServer_Organisation.exist(orgaName))) then
        return callback(false, nil)
    end
    if (_FlashServer_Organisation.gradeExist(orgaName, gradeId)) then
        return callback(false, nil)
    end
    _FlashServer_Database.insert("INSERT INTO flash_orga_grades (orgaId, grade_id, grade_name, grade_label) VALUES (@orgaId, @grade_id, @grade_name, @grade_label)", {
        ["orgaId"] = orgaName,
        ["grade_id"] = gradeId,
        ["grade_name"] = gradeName,
        ["grade_label"] = gradeLabel
    }, function()
        local orgaGrade = _OrgaGrade(orgaName, gradeName, gradeLabel, gradeId)
        _FlashServer_Organisation.addOrgaGrade(orgaGrade.jobName, orgaGrade)
        callback(true, orgaGrade)
    end)
end