--[[
  This file is part of FlashLand.
  Created at 18/12/2021 13:58
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local currentIndexColor1 = 1
local minimalIndexColor1 = 1
local currentIndexColor2 = 1
local minimalIndexColor2 = 1

---@param player _Player
_FlashClient_Barber.drawer[2] = function(player, barberInformation)
    local maxIndex = _FlashClient_SkinChanger.getMaxValues()["hair_1"]
    local index = {}
    for i = 1, maxIndex do
        RageUI.Button(("Coupe de cheveux %s"):format(i), nil, { RightLabel = ("~g~%s $"):format(barberInformation.price) }, true, {
            onActive = function()
                SetPedComponentVariation(PlayerPedId(), 2, i)
            end,
            onSelected = function()
                local skin = {}
                skin["hair_1"] = i
                skin["hair_color_1"] = currentIndexColor1
                skin["hair_color_2"] = currentIndexColor2
                _FlashClient_Billing.currentBillingParentMenu = _FlashClient_Barber.getMenus()[1]
                local elements = {}
                table.insert(elements, { "Coiffure Moderne + Couleur", barberInformation.price })
                _FlashClient_Billing.submitBillingFromMenu(
                        "barber_pay",
                        "Tattoo Expert",
                        elements,
                        { _FlashEnum_BILLINGPAYMENTMETHOD.CARD, _FlashEnum_BILLINGPAYMENTMETHOD.CASH },
                        function()
                            SetPedComponentVariation(PlayerPedId(), 2, i)
                            SetPedHairColor(PlayerPedId(), currentIndexColor1, currentIndexColor2)
                        end,
                        { barberId = _FlashClient_Barber.var.barberId, skin = skin },
                        _FlashClient_Barber.getMenus()[1],
                        function()
                            _FlashClient_Barber.var = {
                                barberId = nil
                            }
                        end
                )
            end,
        })
    end
    RageUI.ColourPanel("Cheveux", RageUI.PanelColour.HairCut, minimalIndexColor1, currentIndexColor1, {
        onColorChange = function(MinimumIndex, CurrentIndex)
            minimalIndexColor1 = MinimumIndex
            currentIndexColor1 = CurrentIndex
        end,
    }, PanelIndex, {})
    RageUI.ColourPanel("Méches", RageUI.PanelColour.HairCut, minimalIndexColor2, currentIndexColor2, {
        onColorChange = function(MinimumIndex, CurrentIndex)
            minimalIndexColor2 = MinimumIndex
            currentIndexColor2 = CurrentIndex
        end,
    }, PanelIndex, {})
    SetPedHairColor(PlayerPedId(), currentIndexColor1, currentIndexColor2)
end