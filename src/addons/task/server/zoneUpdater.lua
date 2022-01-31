--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Task.doZoneUpdater = function()
    ---@param player _Player
    for _src, player in pairs(_FlashServer_Players.getAll()) do
        if (not (player.spawned)) then
            goto skipPlayer
        end
        local playerCoords = GetEntityCoords(GetPlayerPed(_src))
        ---@param zone _Zone
        for _, zone in pairs(_FlashServer_Zones.getAll()) do
            local distance = #(playerCoords - zone.location)
            -- Disable restricted for the moment
            if (zone.restricted) then
                -- Subscribed and in zone draw distance and allowed
                if (zone:isSubscribed(_src) and zone:isAllowed(_src) and distance <= zone.drawDistance) then
                    goto continue
                end
                -- Subscribed and in zone draw distance but not allowed
                if (zone:isSubscribed(_src) and distance <= zone.drawDistance and not (zone:isAllowed(_src))) then
                    zone:unsubscribe(_src)
                    goto continue
                end
                -- Not subscribed and in zone draw distance and allowed
                if (not (zone:isSubscribed(_src)) and zone:isAllowed(_src) and distance <= zone.drawDistance) then
                    zone:subscribe(_src)
                    goto continue
                end
                -- Subscribed and not in zone draw distance but allowed
                if (zone:isSubscribed(_src) and not (distance <= zone.drawDistance) and zone:isAllowed(_src)) then
                    zone:unsubscribe(_src)
                    goto continue
                end
                goto continue
            end
            -- Already subscribed and in zone draw distance
            if (zone:isSubscribed(_src) and distance <= zone.drawDist) then
                goto continue
            end
            -- Already subscribed and out of zone draw distance
            if (zone:isSubscribed(_src) and distance > zone.drawDist) then
                zone:unsubscribe(_src)
                goto continue
            end
            -- Not subscribed and in zone draw distance
            if (not (zone:isSubscribed(_src)) and distance <= zone.drawDist) then
                zone:subscribe(_src)
                goto continue
            end
            :: continue ::
        end
        :: skipPlayer ::
    end
end