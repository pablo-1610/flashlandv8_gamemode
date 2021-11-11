--[[
  This file is part of FlashLand.
  Created at 11/11/2021 00:38
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Players.messenger_system_error = function(_src, message)
    _FlashLand.toClient("utils:messenger_system_error", _src, message)
end

_FlashServer_Players.messenger_system_success = function(_src, message)
    _FlashLand.toClient("utils:messenger_system_success", _src, message)
end

_FlashServer_Players.messenger_system_info = function(_src, message)
    _FlashLand.toClient("utils:messenger_system_info", _src, message)
end

_FlashServer_Players.messenger_system_custom = function(_src, title, message)
    _FlashLand.toClient("utils:messenger_system_custom", _src, title, message)
end