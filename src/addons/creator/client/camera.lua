--[[
  This file is part of FlashLand.
  Created at 27/10/2021 17:10
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author Pablo_1610

local cameraPosition = vector3(683.78, 570.56, 130.46)
local camera

_FlashLand.onReceiveWithoutNet("creator:initCamera", function()
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(camera, cameraPosition)
    PointCamAtEntity(camera, PlayerPedId())
    SetCamActive(camera, true)
    SetCamFov(camera, 20.0)
    RenderScriptCams(1,0,0,0,0)
end)