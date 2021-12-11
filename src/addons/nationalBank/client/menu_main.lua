--[[
  This file is part of FlashLand.
  Created at 10/12/2021 23:14
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param player _Player
_FlashClient_NationalBank.drawer[1] = function(player)
    RageUI.Separator(("Bienvenue ~o~%s %s"):format(_FlashClient_Utils.generic_getSexDisplay(player.skin.sex), player.identity.lastname:upper()))
    RageUI.Button("Gérer mes comptes bancaires", nil, { RightLabel = "→"}, true, {}, _FlashClient_NationalBank.getMenus()[2])
    RageUI.Button("Demander un prêt", "La banque n'autorise pas les prêts pour le moment, nous développerons cette offre prochainement !", { RightLabel = "→"}, false, {})
end