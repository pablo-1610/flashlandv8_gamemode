--[[
  This file is part of FlashLand.
  Created at 10/12/2021 16:25
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Task.doBlipUpdater = function()
    ---@param player _Player
    for _src, player in pairs(_FlashServer_Players.getAll()) do
        if (not (player.spawned)) then
            goto skipPlayer
        end
        local playerCoords = GetEntityCoords(GetPlayerPed(_src))
        ---@param blip _Blip
        for _, blip in pairs(_FlashServer_Blips.getAll()) do
            local distance = #(playerCoords - npc.position)
            if (blip.restricted) then
                -- Player is subscribed but no longer allowed
                if (blip:isSubscribed(_src) and not (blip:isAllowed(_src))) then
                    blip:unsubscribe(_src)
                    goto continue
                end
                -- Blip is everywhere but player is not subscribed
                if (blip:isEverywhere() and not (blip:isSubscribed(_src))) then
                    blip:subscribe(_src)
                    goto continue
                end
                -- Blip is not everywhere but player is subscribed and no longer in drawDist
                if (not (blip:isEverywhere()) and blip:isSubscribed(_src) and distance > blip.drawDist) then
                    blip:unsubscribe(_src)
                    goto continue
                end
                -- Blip is not everywhere but player is not subscribed and in drawDist
                if (not (blip:isEverywhere()) and not (blip:isSubscribed(_src)) and distance <= blip.drawDist) then
                    blip:subscribe(_src)
                    goto continue
                end
                goto continue
            end
            -- Blip is everywhere and player is not subscribed
            if (blip:isEverywhere() and not (blip:isSubscribed(_src))) then
                blip:subscribe(_src)
                goto continue
            end
            -- Blip is not everywhere and player is subscribed but not in range
            if (not (blip:isEverywhere()) and blip:isSubscribed(_src) and not (distance <= blip.drawDist)) then
                blip:unsubscribe(_src)
                goto continue
            end
            :: continue ::
        end
        :: skipPlayer ::
    end
end