--[[
  This file is part of FlashLand.
  Created at 28/01/2022 12:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

RegisterNUICallback("DeleteContact", function(data, cb)
    for index, contact in pairs(allInformationPhone.contacts) do
        if ((contact.name == data.CurrentContactName) and (contact.number == data.CurrentContactNumber)) then
            table.remove(allInformationPhone.contacts, index)
            if (_FlashClient_Phone.phoneIsOpen()) then
                SendNUIMessage({
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = "Téléphone",
                        text = "Contact supprimé",
                        icon = "fas fa-phone-volume",
                        color = "#04b543",
                        timeout = 1500,
                    },
                })
            else
                SendNUIMessage({
                    action = "Notification",
                    NotifyData = {
                        title = "Téléphone",
                        content = "Contact supprimé",
                        icon = "fas fa-phone-volume",
                        timeout = 3500,
                        color = "#04b543",
                    },
                })
            end
            break
        end
    end
    Wait(100)
    cb(allInformationPhone.contacts)
    if (allInformationPhone.messages[data.CurrentContactNumber] ~= nil) then
        allInformationPhone.messages[data.CurrentContactNumber].name = data.CurrentContactNumber
    end
    _FlashLand.setIsWaitingForServer(true)
    _FlashLand.toServer("phone:deleteContact", data)
end)