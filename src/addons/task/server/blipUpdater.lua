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
            local distance = #(playerCoords - blip.position)
            if (blip.restricted) then
                --[[
                    Restricted zones
                --]]
                if (blip:isAllowed(_src)) then
                    if (not (blip:isSubscribed(_src)) and blip:isEverywhere()) then
                        blip:subscribe(_src)
                        goto continue
                    end

                    if (not (blip:isSubscribed(_src)) and not (blip:isEverywhere()) and distance <= blip.drawDist) then
                        blip:subscribe(_src)
                        goto continue
                    end

                    if (blip:isSubscribed(_src) and not (blip:isEverywhere()) and distance > blip.drawDist) then
                        blip:unsubscribe(_src)
                        goto continue
                    end
                else
                    if (blip:isSubscribed(_src)) then
                        blip:unsubscribe(_src)
                        goto continue
                    end
                end
            end

            --[[
                Public zones
            --]]
            if (blip:isEverywhere() and not (blip:isSubscribed(_src))) then
                blip:subscribe(_src)
                goto continue
            end

            if (not (blip:isEverywhere()) and blip:isSubscribed(_src) and not (distance <= blip.drawDist)) then
                blip:unsubscribe(_src)
                goto continue
            end

            if (not (blip:isEverywhere()) and not (blip:isSubscribed(_src)) and distance <= blip.drawDist) then
                blip:subscribe(_src)
                goto continue
            end

            :: continue ::
        end
        :: skipPlayer ::
    end
end