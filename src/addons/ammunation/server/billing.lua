--[[
  This file is part of FlashLand.
  Created at 15/12/2021 16:15
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local function validateWeapon(weapon)
    for _, weaponData in pairs(_ConfigServer.Ammunation.weapons) do
        if (weapon == weaponData.weapon) then
            return (true)
        end
    end
    return (false)
end

local function getWeaponData(weapon)
    for _, weaponData in pairs(_ConfigServer.Ammunation.weapons) do
        if (weapon == weaponData.weapon) then
            return (weaponData)
        end
    end
    return (nil)
end

_FlashServer_Billing.registerBillEvent("ammunation_pay", function(_src, method, total, args)
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.PLAYER_NOT_EXISTS)
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    ---@type _Npc
    local npc = _FlashServer_Npc.get(args.npcId)
    if (not (validateWeapon(args.weapon))) then
        _FlashServer_Warden.violation(_src, _FlashEnum_WARDENVIOLATION.ARGS_OUT_OF_DELIMITATION)
        return
    end
    local weapon = args.weapon
    _FlashServer_Loadout.player_addWeapon(_src, weapon, function(success)
        if (success) then
            npc:sayForAll("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
            _FlashLand.toClient("utils:notifications_showAdvanced", _src, "Ammunation", _Static_GenericMessages.SUCCESS, _Static_GenericMessages.WEAPON_BOUGHT, _FlashEnum_CHARACTERPICTURE.AMMUNATION, _FlashEnum_MESSAGEICONTYPE.DOLLAR)
        else
            local weaponData = getWeaponData(weapon)
            player.cash = player.cash + weaponData.price
            player:sendData()
        end
    end)
end)

-- npc:sayForAll("GENERIC_THANKS", "Speech_Params_Force_Shouted_Critical")