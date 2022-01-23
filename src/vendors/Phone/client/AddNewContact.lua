--[[
  This file is part of FlashLand.
  Created at 22/01/2022 22:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

RegisterNUICallback("AddNewContact", function(data, cb)
    print("kn je sace")
    table.insert(allInformationPhone.contacts, {
        name = data.ContactName,
        number = data.ContactNumber,
        iban = data.ContactIban
    })
    Citizen.Wait(100)
    cb(allInformationPhone.contacts)
    print(data.ContactName)
    if (allInformationPhone.messages[data.ContactNumber] ~= nil) then
        allInformationPhone.messages[data.ContactNumber].name = data.ContactName
    end
    --TriggerServerEvent('qb-phone:server:AddNewContact', data.ContactName, data.ContactNumber, data.ContactIban)
end)