--[[
  This file is part of FlashLand.
  Created at 28/10/2021 16:23
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Players.kick = function(_src, author, reason)
    DropPlayer(_src, ("Vous avez été expulsé de FlashLand !\n\nPar: %s\n\nRaison: %s"):format(author, reason))
end