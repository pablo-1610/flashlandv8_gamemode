--[[
  This file is part of FlashLand.
  Created at 15/12/2021 16:03
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local typesIndexes = {}
local typeSelected = 1

for k, v in pairs(_ConfigClient.Ammunation.categories) do
    table.insert(typesIndexes, ("~r~%s~s~"):format(v))
end

---@param player _LightPlayer
_FlashClient_Ammunation.drawer[2] = function(player)
    RageUI.List("Catégorie:", typesIndexes, typeSelected, nil, {}, true, {
        onListChange = function(index)
            typeSelected = index
        end
    })
    RageUI.Line()
    for k, v in pairs(_FlashClient_Ammunation.var.weapons) do
        if (v.type == typeSelected) then
            local hasWeapon = player.loadout:hasWeapon(v.weapon)
            local weaponData = _Static_Weapons[GetHashKey(v.weapon)]
            RageUI.Button((("%s%s"):format(hasWeapon and "~r~" or "", weaponData and weaponData.label or v.weapon)), nil, { RightLabel = ("%s →"):format(_FlashUtils.math_price_integer(v.price)) }, not (hasWeapon), {
                onSelected = function()
                    _FlashClient_Billing.submitBillingFromMenu(
                            "ammunation_pay",
                            _FlashEnum_BILLINGSTATICSENDER.AMMUNATION,
                            {
                                { ("Achat d'un %s"):format((weaponData and weaponData.label or v.weapon)), v.price }
                            },
                            { _FlashEnum_BILLINGPAYMENTMETHOD.CASH, _FlashEnum_BILLINGPAYMENTMETHOD.CARD },
                            { weapon = v.weapon, npcId = _FlashClient_Ammunation.var.deskNpcId },
                            _FlashClient_Ammunation.getMenus()[2],
                            function()

                            end
                    )
                end
            })
        end
    end
end