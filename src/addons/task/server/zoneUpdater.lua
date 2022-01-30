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
            if (zone.restricted) then
                --[[
                    Restricted zones
                --]]
                if (zone:isAllowed(_src)) then
                    if (not (zone:isSubscribed(_src)) and distance <= zone.drawDist) then
                        zone:subscribe(_src)
                        goto continue
                    end

                    if (zone:isSubscribed(_src) and distance > zone.drawDist) then
                        zone:unsubscribe(_src)
                        goto continue
                    end
                else
                    if (zone:isSubscribed(_src)) then
                        zone:unsubscribe(_src)
                        goto continue
                    end
                end
            end

            --[[
                Public zones
            --]]
            if (zone:isSubscribed(_src) and distance > zone.drawDist) then
                zone:unsubscribe(_src)
                goto continue
            end

            if (not (zone:isSubscribed(_src)) and distance <= zone.drawDist) then
                zone:subscribe(_src)
                goto continue
            end

            :: continue ::
        end
        :: skipPlayer ::
    end
end