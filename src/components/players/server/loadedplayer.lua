--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:51
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashLand.onReceiveWithoutNet("players:loaded", function(_src, player)
    _FlashLand.log(("Le joueur ^1%s^7 est chargé"):format(GetPlayerName(_src)))
end)