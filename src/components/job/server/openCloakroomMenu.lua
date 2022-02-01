--[[
  This file is part of FlashLand.
  Created at 01/02/2022 20:30
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
---@param job _Job
function _FlashServer_Job:openCloakroomMenu(_src, player, job)
    if (not (player)) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    if (player.job._job ~= job) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.WRONG_JOB)
        return
    end
    local grade = player.job._grade.id
    local clothes = job.clothes.grades[grade]

    local additionalClothes = {}

    for _, data in pairs(job.clothes.additional) do
        local allowedGrades = data.grades
        for _, allowedGrade in pairs(allowedGrades) do
            if (allowedGrade == grade) then
                table.insert(additionalClothes, data)
            end
        end
    end

    _FlashLand.toClient("job:openCloakroomMenu", _src, job.id, clothes, additionalClothes)
end