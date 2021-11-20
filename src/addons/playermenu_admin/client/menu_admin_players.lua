--[[
  This file is part of FlashLand.
  Created at 17/11/2021 14:44
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local sortTypes = { _FlashEnum_ADMINSORTTYPE.RANK_WEIGHT, _FlashEnum_ADMINSORTTYPE.SERVER_ID }
local sortIndex = 1

local showRanks = true

local function getSelectedSortType()
    return (sortTypes[sortIndex])
end

local function getSortedPlayers(players, sortType)
    local keys = {}
    for key, _ in pairs(players) do
        table.insert(keys, key)
    end
    if (sortType == _FlashEnum_ADMINSORTTYPE.SERVER_ID) then
        table.sort(keys, function(keyLhs, keyRhs)
            ---@type _Player
            local playerA = players[keyLhs]
            ---@type _Player
            local playerB = players[keyRhs]
            return playerA.sId < playerB.sId
        end)
    elseif (sortType == _FlashEnum_ADMINSORTTYPE.RANK_WEIGHT) then
        table.sort(keys, function(keyLhs, keyRhs)
            ---@type _Player
            local playerA = players[keyLhs]
            ---@type _Player
            local playerB = players[keyRhs]
            return playerA.rank.weight > playerB.rank.weight
        end)
    elseif (sortType == _FlashEnum_ADMINSORTTYPE.ALPHABETICALLY) then
        keys = _FlashUtils.table_sortAlphabetically(keys)
    end

    return (keys)
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[9] = function(player, closestData, isStaffModeActive)
    RageUI.List("Trier par:", sortTypes, sortIndex, nil, {}, true, {
        onListChange = function(index)
            sortIndex = index
        end
    }, nil)

    --[[
    RageUI.Checkbox("Affichage des rangs", nil, showRanks, {}, {
        onSelected = function(checked)
            showRanks = checked
        end
    })
    --]]

    RageUI.Line()

    local players = _FlashClient_Staff.getPlayerList()
    local sortedPlayers = getSortedPlayers(players, getSelectedSortType())

    for _, key in ipairs(sortedPlayers) do
        ---@type _Player
        local otherPlayer = players[key]

        local isSelf = otherPlayer.flashId == player.flashId
        local isHigher = otherPlayer.rank.weight > player.rank.weight
        print(json.encode(isSelf))

        RageUI.Button(("%s%s"):format(
                (showRanks and (otherPlayer.rank.id ~= _Config.startRank and ("(%s%s~s~) "):format(otherPlayer.rank.baseColor, otherPlayer.rank.label) or "") or ""),
                otherPlayer.name
        ), (isSelf and "~r~Accès refusé~s~: Vous ne pouvez pas intéragir avec vous même." or (isHigher and ("~r~Accès refusé~s~: Ce joueur possède un grade (%s%s~s~) qui est supérieur au votre."):format(otherPlayer.rank.baseColor, otherPlayer.rank.label) or "Appuyez pour intéragir.")),
                { RightLabel = ("~b~%s ~s~%s"):format(otherPlayer.sId, "→") },
                (player.rank.weight >= otherPlayer.rank.weight and not isSelf),
                {
                    onSelected = function()
                        -- TODO → Interact with player
                    end
                }
        )
    end
end