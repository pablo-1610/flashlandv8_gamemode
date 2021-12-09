--[[
  This file is part of FlashLand.
  Created at 09/12/2021 20:28
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("loaded", function()
    _FlashScheduler.scheduleRepeatingTask(function()
        for _src, _ in pairs(_FlashServer_Players.getAll()) do
            local playerCoords = GetEntityCoords(GetPlayerPed(_src))
            ---@param zone _Zone
            for _, zone in pairs(_FlashServer_Zones.getAll()) do
                local distance = #(playerCoords - zone.location)
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
                if (not zone:isSubscribed(_src) and distance <= zone.drawDist) then
                    zone:subscribe(_src)
                    goto continue
                end
                :: continue ::
            end
        end
    end, 2000, 1000)
end)