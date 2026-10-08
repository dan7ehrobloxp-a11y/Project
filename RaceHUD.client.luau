--!strict


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RaceHUD = {}
RaceHUD.__index = RaceHUD

function RaceHUD.new()
    return setmetatable({root = nil, position = nil, time = nil, status = nil}, RaceHUD)
end

function RaceHUD:start(parentGui: ScreenGui)
    local root = Instance.new("Frame")
    root.Name = "RaceHUD"
    root.Size = UDim2.fromOffset(280, 150)
    root.Position = UDim2.fromOffset(30, 30)
    root.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
    root.BackgroundTransparency = 0.18
    root.Parent = parentGui

    self.position = Instance.new("TextLabel")
    self.position.Size = UDim2.new(1, -20, 0, 40)
    self.position.Position = UDim2.fromOffset(10, 10)
    self.position.BackgroundTransparency = 1
    self.position.Font = Enum.Font.GothamBold
    self.position.TextColor3 = Color3.new(1, 1, 1)
    self.position.TextScaled = true
    self.position.Text = "POSITION 1 / 1"
    self.position.Parent = root

    self.time = self.position:Clone()
    self.time.Position = UDim2.fromOffset(10, 55)
    self.time.Text = "00:00.000"
    self.time.Parent = root

    self.status = self.position:Clone()
    self.status.Position = UDim2.fromOffset(10, 100)
    self.status.Text = "READY"
    self.status.Parent = root

    self.root = root
end

function RaceHUD:setStatus(text: string)
    if self.status then self.status.Text = text end
end

function RaceHUD:setTime(seconds: number)
    if self.time then
        self.time.Text = string.format("%02d:%06.3f", math.floor(seconds / 60), seconds % 60)
    end
end

return RaceHUD
