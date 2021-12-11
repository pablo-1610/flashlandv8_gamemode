--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:05
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local animationType = { _FlashEnum_ANIMATIONTYPE.EXPRESSION, _FlashEnum_ANIMATIONTYPE.PROCESS, _FlashEnum_ANIMATIONTYPE.ANIMATION, _FlashEnum_ANIMATIONTYPE.ANIMATION_AND_PROP }
local animationIndex = 1

_FlashClient_PlayerMenu.drawer[4] = function()
    RageUI.List("Type : ", animationType, animationIndex, "", {}, true, {
        onListChange = function(Index)
            animationIndex = Index
        end,
    })
    RageUI.Line()
    if animationIndex == 1 then
        for _, anim in pairs(_Static_Animation.expression) do
            RageUI.Button(("%s"):format(anim.label), nil, {}, true, {
                onSelected = function()
                    _FlashClient_Utils.ped_expression(PlayerPedId(), anim.name, 0)
                end
            })
        end
    elseif animationIndex == 2 then
        for _, process in pairs(_Static_Animation.process) do
            RageUI.Button(("Démarche %s"):format(process.label), nil, {}, true, {
                onSelected = function()
                    _FlashClient_Utils.process_load(process.name)
                    _FlashClient_Utils.ped_process(PlayerPedId(), process.name, 0.4)
                end
            })
        end
    elseif animationIndex == 3 then

    elseif animationIndex == 4 then

    end
end