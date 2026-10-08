--!strict


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GarageController = {}
GarageController.__index = GarageController

function GarageController.new()
    return setmetatable({frame = nil}, GarageController)
end

function GarageController:start(parentGui: ScreenGui)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(520, 420)
    frame.Position = UDim2.new(0.5, -260, 0.5, -210)
    frame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
    frame.Visible = false
    frame.Parent = parentGui
    self.frame = frame
end

function GarageController:tune(key: string, value: number)
    ReplicatedStorage.Remotes.GarageAction:FireServer("Tune", {key = key, value = value})
end

function GarageController:setMode(mode: string)
    ReplicatedStorage.Remotes.GarageAction:FireServer("DriveMode", mode)
end

return GarageController
