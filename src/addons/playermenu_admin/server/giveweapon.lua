--[[
  This file is part of FlashLand.
  Created at 13/12/2021 22:22
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

_FlashLand.onReceive("staff:giveWeapon", function(targetSource, weaponName)
    local _src = source
    if (not (_FlashServer_Players.exists(_src))) then
        _FlashLand.err(("staff:giveWeapon sans player (%s)"):format(_src))
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(_src)
    if (not (player.rank:hasPermission("admin.giveweapon"))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _FlashEnum_GENERICMESSAGE.ACTION_NO_PERMISSION)
        player:serverResponded()
        return
    end
    if (not (_FlashServer_Players.exists(targetSource))) then
        player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.PLAYER_SELECTED_IS_INVALID)
        player:serverResponded()
        return
    end
    ---@type _Player
    local target = _FlashServer_Players.get(targetSource)
    local weaponData = _Static_Weapons[GetHashKey(weaponName:lower())]
    _FlashServer_Loadout.player_addWeapon(targetSource, weaponName, function(success)
        if (success) then
            target:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.INFO, (_Static_GenericMessages.PLAYER_MESSAGE_GIVE_WEAPON_SUCCESS):format(weaponData.label))
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.SUCCESS, (_Static_GenericMessages.STAFF_MESSAGE_GIVE_WEAPON_SUCCESS):format(weaponData.label, target:getName()))
            _FlashServer_Staff.updatePlayersForStaff()
            player:serverResponded()
        else
            player:sendSystemMessage(_FlashEnum_SYSTEMMESSAGE.ERROR, _Static_GenericMessages.STAFF_MESSAGE_GIVE_WEAPON_ERROR)
            player:serverResponded()
        end
    end)
end)