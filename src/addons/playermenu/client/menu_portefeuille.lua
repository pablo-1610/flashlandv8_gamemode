--[[
  This file is part of FlashLand.
  Created at 09/11/2021 21:04
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

---@param playerData _Player
local function showSelfIdentity(playerData)
    local mugshot, mugshotStr = _FlashClient_Utils.ped_getMugShot(PlayerPedId())
    _FlashClient_Utils.notifications_showAdvanced("Carte d'identité", ("~o~%s %s ~s~(~o~%s ans~s~)"):format(playerData.identity.firstname, playerData.identity.lastname, playerData.identity.age), "", mugshotStr, _FlashEnum_MESSAGEICONTYPE.ARROW, false)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[3] = function(player, closestData)
    RageUI.Separator(("Monnaie: %s"):format(_FlashUtils.math_price_integer(player.cash)))
    RageUI.Separator(("Job: ~g~%s~s~/~g~%s"):format(player.job._job.label, player.job._grade.label))
    RageUI.Line()

    RageUI.Button("Lister mes licences", nil, { RightLabel = "→" }, true, {
        -- TODO → License manager and show licenses
    })

    RageUI.Button("Regarder ma carte d'identité", nil, {}, true, {
        onSelected = function()
            showSelfIdentity(player)
        end
    })

    RageUI.Button("Montrer ma carte d'identité", nil, {}, (_FlashClient_Utils.proximity_canInteract(closestData)), {
        onSelected = function()
            _FlashLand.toServer("playerMenu:showIdCard", GetPlayerServerId(closestData[1]))
        end
    })

    RageUI.Button("Donner de l'argent", nil, {}, (_FlashClient_Utils.proximity_canInteract(closestData)), {
        onSelected = function()
            local amount = _FlashClient_Utils.input_showBox("Montant:", "", 20, true)
            if (amount ~= nil and tonumber(amount) ~= nil) then
                amount = tonumber(amount)
                isWaitingForServer = true
                _FlashLand.toServer("playerMenu:giveMoney", GetPlayerServerId(closestData[1]), amount)
            end
        end
    })
end