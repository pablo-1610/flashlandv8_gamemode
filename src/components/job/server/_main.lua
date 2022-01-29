--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:32
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Job = {}
local list = {}

local baseGrades = {
    {"boss", "Boss", 1500},
    {"asociate", "Ascociate", 1000},
    {"junior", "Junior", 500},
}

local function retrieveGrades(id)
    if (not (_FlashServer_Utils.file_exists(("resources/flashland/src/jobs/%s/grades.json"):format(id)))) then
        CreateThread(function()
            _FlashServer_Utils.file_write(("resources/flashland/src/jobs/%s/grades.json"):format(id), json.encode(baseGrades))
        end)
        _FlashLand.log("[FlashLand] Job grades file not found, creating one...")
        return baseGrades
    else
        _FlashLand.log("[FlashLand] Job grades file found, loading...")
        local grades = _FlashServer_Utils.file_read(("resources/flashland/src/jobs/%s/grades.json"):format(id))
        return json.decode(grades)
    end
end

function _FlashServer_Job:exists(id)
    return (list[id] ~= nil)
end

function _FlashServer_Job:registerJob(id, label)
    if (self:exists(id)) then
        return nil
    end
    local grades = {}
    for _, data in pairs(retrieveGrades(id)) do
        table.insert(grades, _JobGrade(data[1], data[2], data[3]))
    end
    return _Job(id, label, grades)
end
