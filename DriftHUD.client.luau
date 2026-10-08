--!strict


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DriftHUD = {}
DriftHUD.__index = DriftHUD

function DriftHUD.new()
    return setmetatable({label = nil}, DriftHUD)
end

function DriftHUD:start(parentGui: ScreenGui)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromOffset(300, 100)
    label.Position = UDim2.new(0.5, -150, 0, 80)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBlack
    label.TextScaled = true
    label.Visible = false
    label.Parent = parentGui
    self.label = label

    ReplicatedStorage.Remotes.Telemetry.OnClientEvent:Connect(function(_, drift)
        if not drift then return end
        self.label.Visible = drift.active == true
        self.label.Text = string.format("DRIFT  %d\nx%.1f", math.floor(drift.score or 0), drift.combo or 1)
    end)
end

return DriftHUD
