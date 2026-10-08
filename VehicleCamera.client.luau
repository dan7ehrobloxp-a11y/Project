--!strict


local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local VehicleCamera = {}
VehicleCamera.__index = VehicleCamera

function VehicleCamera.new()
    return setmetatable({distance = 16, height = 5, smooth = 7}, VehicleCamera)
end

function VehicleCamera:start()
    self.connection = RunService.RenderStepped:Connect(function(dt)
        local camera = Workspace.CurrentCamera
        local character = game.Players.LocalPlayer.Character
        local seat = character and character:FindFirstChildOfClass("Humanoid") and character.Humanoid.SeatPart
        if not seat or not seat:IsA("VehicleSeat") then return end

        local model = seat:FindFirstAncestorOfClass("Model")
        local root = model and model.PrimaryPart
        if not root then return end

        local target = root.CFrame
            * CFrame.new(0, self.height, self.distance)
            * CFrame.Angles(math.rad(-5), math.rad(180), 0)

        camera.CFrame = camera.CFrame:Lerp(target, 1 - math.exp(-self.smooth * dt))
    end)
end

return VehicleCamera
