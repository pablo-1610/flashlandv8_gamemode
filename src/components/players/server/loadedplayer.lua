--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashLand.onReceiveWithoutNet("players:newLoadedPlayer", function(_src, player)
    _FlashLand.log(("Le joueur ^1%s^7 est désormais ^2connecté ^7et en jeu"):format(GetPlayerName(_src)))
    print(json.encode(_FlashServer_Utils.identifiers_getAll(_src)))
end)