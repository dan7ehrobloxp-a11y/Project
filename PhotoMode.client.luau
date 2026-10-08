--!strict


local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local PhotoMode = {}
PhotoMode.__index = PhotoMode

function PhotoMode.new()
    return setmetatable({enabled = false}, PhotoMode)
end

function PhotoMode:start()
    self.connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed or input.KeyCode ~= Enum.KeyCode.P then return end
        self.enabled = not self.enabled
        local camera = Workspace.CurrentCamera
        camera.FieldOfView = self.enabled and 55 or 70
    end)
end

return PhotoMode
