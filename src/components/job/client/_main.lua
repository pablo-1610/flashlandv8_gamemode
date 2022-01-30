--[[
  This file is part of FlashLand.
  Created at 29/01/2022 21:32
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashClient_Job = {}
_FlashClient_Job.workMenu = {}

---hasMenu
---@param jobId string
---@return boolean
function _FlashClient_Job:hasMenu(jobId)
    return self.workMenu[jobId] ~= nil
end

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashClient_KeyBind.addKey("f6", "Ouvrir le menu de travail", function()
        ---@type _Player
        local player = _FlashClient_Cache.getPlayer()
        if (_FlashClient_Job:hasMenu(player.job._job.id)) then
            _FlashClient_Job.workMenu[player.job]()
        else
            _FlashClient_Job:openDefaultWorkMenu()
        end
    end)
end)
