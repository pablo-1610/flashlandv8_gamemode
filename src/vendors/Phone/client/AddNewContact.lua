--[[
  This file is part of FlashLand.
  Created at 22/01/2022 22:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

RegisterNUICallback("AddNewContact", function(data, cb)
    table.insert(allInformationPhone.contacts, {
        name = data.ContactName,
        number = data.ContactNumber,
        iban = data.ContactIban
    })
    Wait(100)
    cb(allInformationPhone.contacts)
    if (_FlashClient_Phone.phoneIsOpen()) then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Téléphone",
                text = "Contact ajouté",
                icon = "fas fa-phone-volume",
                color = "#04b543",
                timeout = 1500,
            },
        })
    end
    if (allInformationPhone.messages[data.ContactNumber] ~= nil) then
        allInformationPhone.messages[data.ContactNumber].name = data.ContactName
    end
    _FlashLand.setIsWaitingForServer(true)
    _FlashLand.toServer("phone:saveNewContact", data)
end)