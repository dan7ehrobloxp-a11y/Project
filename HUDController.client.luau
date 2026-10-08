--!strict


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HUDController = {}
HUDController.__index = HUDController

function HUDController.new()
    return setmetatable({gui = nil, telemetry = nil}, HUDController)
end

function HUDController:start()
    local player = Players.LocalPlayer
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "DesertVelocityHUD"
    self.gui.ResetOnSpawn = false
    self.gui.Parent = player:WaitForChild("PlayerGui")

    self.speed = Instance.new("TextLabel")
    self.speed.Size = UDim2.fromOffset(240, 70)
    self.speed.Position = UDim2.new(1, -260, 1, -100)
    self.speed.BackgroundTransparency = 0.25
    self.speed.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
    self.speed.TextColor3 = Color3.fromRGB(0, 220, 255)
    self.speed.TextScaled = true
    self.speed.Font = Enum.Font.GothamBold
    self.speed.Text = "0 KM/H"
    self.speed.Parent = self.gui

    ReplicatedStorage.Remotes.Telemetry.OnClientEvent:Connect(function(telemetry)
        self.telemetry = telemetry
        self.speed.Text = string.format("%03d KM/H", math.floor(telemetry.speedKph or 0))
    end)
end

return HUDController
