--[[
  This file is part of FlashLand.
  Created at 13/12/2021 21:19
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

_FlashServer_Utils.file_directoryExists = function(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

_FlashServer_Utils.file_directoryCreate = function(path)
    os.execute(("mkdir %s"):format(path))
end

_FlashServer_Utils.file_exists = function(file)
    local f = io.open(file, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

_FlashServer_Utils.file_append = function(file, text)
    local f = io.open(file, "a")
    f:write(text)
    f:close()
end

_FlashServer_Utils.file_read = function(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

_FlashServer_Utils.file_write = function(file, text)
    local f = io.open(file, "w")
    f:write(text)
    f:close()
end