--[[
  This file is part of FlashLand.
  Created at 28/01/2022 13:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

RegisterNUICallback('EditContact', function(data, cb)
    for _, contact in pairs(allInformationPhone.contacts) do
        if ((contact.name == data.OldContactName) and (contact.number == data.OldContactNumber)) then
            contact.name = data.CurrentContactName
            contact.number = data.CurrentContactNumber
            contact.iban = data.CurrentContactIban
        end
    end
    if (allInformationPhone.messages[data.CurrentContactNumber] ~= nil) then
        allInformationPhone.messages[data.CurrentContactNumber].name = data.CurrentContactName
    end
    Wait(100)
    cb(allInformationPhone.contacts)
    _FlashLand.setIsWaitingForServer(true)
    _FlashLand.toServer("phone:editContact", data)
end)