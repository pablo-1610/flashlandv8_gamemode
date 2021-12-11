--[[
  This file is part of FlashLand.
  Created at 10/12/2021 13:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Task.doNpcUpdater = function()
    ---@param player _Player
    for _src, player in pairs(_FlashServer_Players.getAll()) do
        if (not (player.spawned)) then
            goto skipPlayer
        end
        local playerCoords = GetEntityCoords(GetPlayerPed(_src))
        ---@param npc _Npc
        for _, npc in pairs(_FlashServer_Npc.getAll()) do
            local distance = #(playerCoords - npc.position)
            -- Already subscribed and in npc draw distance
            if (npc:isSubscribed(_src) and distance <= npc.drawDist) then
                goto continue
            end
            -- Already subscribed and out of zone npc distance
            if (npc:isSubscribed(_src) and distance > npc.drawDist) then
                npc:unsubscribe(_src)
                goto continue
            end
            -- Not subscribed and in npc draw distance
            if (not npc:isSubscribed(_src) and distance <= npc.drawDist) then
                npc:subscribe(_src)
                goto continue
            end
            :: continue ::
        end
        :: skipPlayer ::
    end
end