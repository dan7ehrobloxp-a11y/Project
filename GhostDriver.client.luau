--!strict


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local GhostDriver = {}
GhostDriver.__index = GhostDriver

function GhostDriver.new()
    return setmetatable({model = nil, connection = nil}, GhostDriver)
end

function GhostDriver:buildFromCharacter(character: Model)
    if self.model then self.model:Destroy() end
    local clone = character:Clone()
    clone.Name = "GhostDriver"
    clone.Parent = workspace

    for _, item in ipairs(clone:GetDescendants()) do
        if item:IsA("BasePart") then
            item.CanCollide = false
            item.CanTouch = false
            item.CanQuery = false
            item.CastShadow = false
            item.Material = Enum.Material.Neon
            item.Transparency = math.max(item.Transparency, 0.45)
            item.Color = Color3.fromRGB(0, 220, 255)
        elseif item:IsA("Script") or item:IsA("LocalScript") then
            item:Destroy()
        end
    end

    local humanoid = clone:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        humanoid.AutoRotate = false
    end

    self.model = clone
end

function GhostDriver:attachToSeat(seat: VehicleSeat)
    if not self.model then return end
    local root = self.model.PrimaryPart
    if not root then return end

    if self.connection then self.connection:Disconnect() end
    self.connection = RunService.RenderStepped:Connect(function()
        if seat.Parent and root.Parent then
            root.CFrame = seat.CFrame * CFrame.new(0, 0.8, 0)
        end
    end)
end

function GhostDriver:destroy()
    if self.connection then self.connection:Disconnect() end
    if self.model then self.model:Destroy() end
end

return GhostDriver
