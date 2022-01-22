--[[
  This file is part of FlashLand.
  Created at 22/01/2022 22:19
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

RegisterNUICallback('RemoveSuggestion', function(data, cb)
    if (allInformationPhone.suggestedContacts ~= nil) then
        for k, v in pairs(allInformationPhone.suggestedContacts) do
            if (data.name[1] == v.name[1] and data.name[2] == v.name[2]) and data.number == v.number and data.bank == v.bank then
                table.remove(allInformationPhone.suggestedContacts, k)
            end
        end
    end
end)