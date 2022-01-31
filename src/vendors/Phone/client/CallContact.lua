--[[
  This file is part of FlashLand.
  Created at 28/01/2022 13:13
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local cancelCall = function()
    _FlashLand.toServer("phone:CanCelCall", )
    TriggerServerEvent('qb-phone:server:CancelCall', allInformationPhone.call.TargetData)
    if (allInformationPhone.call.CallType == "ongoing") then
        -- TODO -> quit instance vocal for join default instance vocal
    end

    allInformationPhone.call.CallType = nil
    allInformationPhone.call.InCall = false
    allInformationPhone.call.AnsweredCall = false
    allInformationPhone.call.TargetData = {}
    allInformationPhone.call.CallId = nil

    if (not (_FlashClient_Phone.phoneIsOpen()) then
        StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_to_call", 2.5)
        _FlashClient_Phone.deletePhone()
    end

    _FlashLand.toServer("phone:TargetStartCall", false)

    if (not (_FlashClient_Phone.phoneIsOpen()) then
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Téléphone",
                content = "Appel terminé",
                icon = "fas fa-phone-volume",
                timeout = 3500,
                color = "#e84118",
            },
        })
    else
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Téléphone",
                text = "Appel terminé",
                icon = "fas fa-phone-volume",
                color = "#e84118",
            },
        })

        SendNUIMessage({
            action = "SetupHomeCall",
            CallData = PhoneData.CallData,
        })

        SendNUIMessage({
            action = "CancelOutgoingCall",
        })
    end
end

local function generateCallId(caller, target)
    local CallId = math.ceil(((tonumber(caller) + tonumber(target)) / 100 * 1))
    return CallId
end

local function callContact(callData, anonymousCall)
    local repeatCount = 0
    allInformationPhone.call.CallType = "outgoing"
    allInformationPhone.call.InCall = true
    allInformationPhone.call.TargetData = CallData
    allInformationPhone.call.AnsweredCall = false
    allInformationPhone.call.CallId = generateCallId(allInformationPhone.informations.number, callData.number)

    print(AnonymousCall)

    _FlashLand.toServer("phone:playerStartCallToOtherPlayer", PhoneData.CallData, AnonymousCall)
    _FlashLand.toServer("phone:TargetStartCall", true)

    for i = 1, (_ConfigPhone.maxCallRepeat + 1), 1 do
        if (not (allInformationPhone.call.AnsweredCall)) then
            if ((repeatCount + 1) ~= (_ConfigPhone.maxCallRepeat + 1)) then
                if (allInformationPhone.call.InCall) then
                    repeatCount = (repeatCount + 1)
                    SendNUIMessage({
                        action = "playSound",
                        transactionFile = _ConfigPhone.ringingName,
                        transactionVolume = 0.1
                    })
                else
                    break
                end
                Citizen.Wait(2000)
            else
                cancelCall()
                break
            end
        else
            break
        end
    end
end

RegisterNUICallback("CallContact", function(data, cb)
    _FlashLand.onReceive("phone:playerIsCallInformation", function(isOnline, isCall)
        local status = {
            IsOnline = isOnline,
            CanCall = isCall,
            InCall = allInformationPhone.call.InCall,
        }
        cb(status)
         if ((isCall) and (not (status.InCall)) and (data.ContactData.number ~= allInformationPhone.informations.number)) then
            callContact(data.ContactData, data.Anonymous)
         end
    end)
    _FlashLand.setIsWaitingForServer(true)
    _FlashLand.toServer("phone:playerStartCall", data.ContactData.number)
end)

_FlashLand.onReceive("phone:targetGetCall", function(targetNumber, callId, anonymousCall)
    local repeatCount = 0
    local callData = {
        number = targetNumber,
        name = _FlashServer_Phone.getNumberInContactPhone(targetNumber, allInformationPhone.contacts),
        anonymous = anonymousCall
    }

    print(anonymousCall)

    if (anonymousCall) then
        callData.name = "Anonyme"
    end

    allInformationPhone.call.CallType = "incoming"
    allInformationPhone.call.InCall = true
    allInformationPhone.call.AnsweredCall = false
    allInformationPhone.call.TargetData = callData
    allInformationPhone.call.CallId = callId

    _FlashLand.toServer("phone:TargetStartCall", true)

    SendNUIMessage({
        action = "SetupHomeCall",
        CallData = allInformationPhone.call,
    })

    for i = 1, (_ConfigPhone.maxCallRepeat + 1), 1 do
        if (not (allInformationPhone.call.AnsweredCall)) then
            if ((repeatCount + 1) ~= (_ConfigPhone.maxCallRepeat + 1)) then
                if (allInformationPhone.call.InCall) then
                    repeatCount = (repeatCount + 1)
                    SendNUIMessage({
                        action = "playSound",
                        transactionFile = _ConfigPhone.ringingName,
                        transactionVolume = 0.2
                    })

                    if (not (_FlashClient_Phone.playerIsCall())) then
                        SendNUIMessage({
                            action = "IncomingCallAlert",
                            CallData = allInformationPhone.call.TargetData,
                            Canceled = false,
                            AnonymousCall = callData.anonymous,
                        })
                    end
                else
                    SendNUIMessage({
                        action = "IncomingCallAlert",
                        CallData = allInformationPhone.call.TargetData,
                        Canceled = true,
                        AnonymousCall = callData.anonymous,
                    })
                    _FlashLand.toServer("phone:targetMissingCall", "missed", callData)
                    break
                end
                Citizen.Wait(2000)
            else
                SendNUIMessage({
                    action = "IncomingCallAlert",
                    CallData = allInformationPhone.call.TargetData,
                    Canceled = true,
                    AnonymousCall = AnonymousCall,
                })
                _FlashLand.toServer("phone:targetMissingCall", "missed", callData)
                break
            end
        else
            _FlashLand.toServer("phone:targetMissingCall", "missed", callData)
            break
        end
    end
end)

_FlashLand.onReceive("phone:addRecentCall", function(callData, callDate, callType)
    table.insert(allInformationPhone.recentCall, {
        name = _FlashClient_Phone.getNumberInContactPhone(callData.number, allInformationPhone.contacts),
        time = callDate,
        type = callType,
        number = callData.number,
        anonymous = data.anonymousCall
    })
    SendNUIMessage({
        action = "playSound",
        transactionFile = _ConfigPhone.alertSound,
        transactionVolume = 0.2
    })
    _ConfigPhone.applications["phone"].Alerts = (_ConfigPhone.applications["phone"].Alerts + 1)
    SendNUIMessage({
        action = "RefreshAppAlerts",
        AppData = _ConfigPhone.applications
    })
end)