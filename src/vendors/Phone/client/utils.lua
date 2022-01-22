--[[
  This file is part of FlashLand.
  Created at 22/01/2022 19:53
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local phone = nil

_FlashClient_Phone.setAnimationPhone = function(anim)
    local animation = anim
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        animation = 'anim@cellphone@in_car@ps'
    end
    _FlashClient_Utils.animation_load("cellphone@")
    TaskPlayAnim(PlayerPedId(), "cellphone@", animation, 3.0, 3.0, -1, 50, 0, false, false, false)
end

_FlashClient_Phone.setPhoneProp = function()
    _FlashClient_Phone.deletePhone()
    local hash = GetHashKey("prop_npc_phone_02")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end
    local phoneProp = CreateObject(hash, 1.0, 1.0, 1.0, 1, 1, 0)
    local bone = GetPedBoneIndex(PlayerPedId(), 28422)
    AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    phone = phoneProp
end

_FlashClient_Phone.deletePhone = function()
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(phone))
    phone = nil
end