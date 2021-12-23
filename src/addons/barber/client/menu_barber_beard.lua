--[[
  This file is part of VibR1cy Tebex Store.
  Created at 22/12/2021 20:06
  
  Copyright (c) VibR1cy Tebex Store - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local indexBeardWaist = 1
local listBeardWaist = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
local currentIndexColor1 = 1
local minimalIndexColor1 = 1
local currentIndexColor2 = 1
local minimalIndexColor2 = 1

---@param player _Player
_FlashClient_Barber.drawer[3] = function(player, barberInformation)
    local maxIndex = _FlashClient_SkinChanger.getMaxValues()["beard_1"]
    local index = {}
    RageUI.List("Taille de la barbe", listBeardWaist, indexBeardWaist, nil, {}, true, {
        onListChange = function(Index)
            indexBeardWaist = Index
        end,
    })
    RageUI.Line()
    for i = 1, maxIndex do
        RageUI.Button(("Barbe %s"):format(i), nil, { RightLabel = ("~g~%s $"):format(barberInformation.haircutPrice) }, true, {
            onActive = function()
                SetPedHeadOverlay(PlayerPedId(), 1, i, (indexBeardWaist / 10) + 0.0)
            end,
            onSelected = function()
                SetPedHeadOverlay(PlayerPedId(), 1, i, (indexBeardWaist / 10) + 0.0)
                SetPedHeadOverlayColor(PlayerPedId(), currentIndexColor1, currentIndexColor2)
                _FlashClient_Billing.currentBillingParentMenu = _FlashClient_Barber.getMenus()[1]
                local elements = {}
                table.insert(elements, { "Barbe Moderne + Couleur", barberInformation.haircutPrice })
                _FlashClient_Billing.submitBillingFromMenu(
                        "barber_pay",
                        "Tattoo Expert",
                        elements,
                        { _FlashEnum_BILLINGPAYMENTMETHOD.CARD, _FlashEnum_BILLINGPAYMENTMETHOD.CASH },
                        { barberId = _FlashClient_Barber.var.barberId },
                        _FlashClient_Barber.getMenus()[1],
                        function()
                            local skin = {}
                            skin["beard_1"] = i
                            skin["beard_2"] = indexBeardWaist
                            skin["beard_3"] = currentIndexColor1
                            skin["beard_4"] = currentIndexColor2
                            _FlashClient_SkinChanger.applySkin(skin)
                            _FlashClient_Barber.var = {
                                barberId = nil
                            }
                        end
                )
            end,
        })
    end
    RageUI.ColourPanel("Barbe", RageUI.PanelColour.HairCut, minimalIndexColor1, currentIndexColor1, {
        onColorChange = function(MinimumIndex, CurrentIndex)
            minimalIndexColor1 = MinimumIndex
            currentIndexColor1 = CurrentIndex
        end,
    }, PanelIndex, {})
    RageUI.ColourPanel("Couleur 2", RageUI.PanelColour.HairCut, minimalIndexColor2, currentIndexColor2, {
        onColorChange = function(MinimumIndex, CurrentIndex)
            minimalIndexColor2 = MinimumIndex
            currentIndexColor2 = CurrentIndex
        end,
    }, PanelIndex, {})
    SetPedHeadOverlayColor(PlayerPedId(), currentIndexColor1, currentIndexColor2)
end