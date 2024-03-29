--[[
  This file is part of FlashLand.
  Created at 26/10/2021 22:43
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashLand.onReceiveWithoutNet("players:newPlayer", function(_src)
    local instance = _FlashServer_Instances.setOnRandomInstance(_src)
    _FlashLand.log(("Le joueur ^1%s^7 est nouveau (instance: ^3%s^7)"):format(GetPlayerName(_src), instance))
    _FlashLand.toClient("creator:init", _src)
end)