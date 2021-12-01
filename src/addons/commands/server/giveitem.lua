--[[
  This file is part of FlashLand.
  Created at 11/11/2021 16:01
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Commands.registerPermissionCommand("giveitem", "admin.giveitem", function(isPlayer, args, player, cbMesage)
    local targetId = tonumber(args[1])
    local itemId = args[2]:lower()
    local quantity = tonumber(args[3])
    if (not (targetId)) then
        cbMesage(false, "L'id indique est invalide")
        return
    end
    if (not (quantity)) then
        cbMesage(false, "La quantite est invalide")
        return
    end
    if (not (_FlashServer_Players.exists(targetId))) then
        cbMesage(false, "Le joueur cible n'est pas connecte")
        return
    end
    ---@type _Player
    local player = _FlashServer_Players.get(targetId)
    if (not (_FlashServer_Items.exists(itemId))) then
        cbMesage(false, "Cet item n'existe pas")
        return
    end
    ---@type _Item
    local item = _FlashServer_Items.get(itemId)
    _FlashServer_Inventory.player_addItem(targetId, itemId, quantity, function(success)
        if (success) then
            player:sendSystemMessage("info", ("Le staff vous a donné x~o~%s %s"):format(quantity, item.label))
            cbMesage(true, ("Don de %s %s a %s"):format(quantity, item.label, GetPlayerName(targetId)))
        else
            cbMesage(false, "Impossible de donner l'item, pas assez de place dans l'inventaire ?")
        end
    end)

end, { "id", "item", "quantite" })