--!strict


local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DrivingController = {}
DrivingController.__index = DrivingController

function DrivingController.new(input)
    return setmetatable({input = input, accumulator = 0}, DrivingController)
end

function DrivingController:start()
    self.remote = ReplicatedStorage.Remotes.VehicleInput
    self.connection = RunService.RenderStepped:Connect(function(dt)
        self.input:update()
        self.accumulator += dt
        if self.accumulator >= 1 / 20 then
            self.accumulator = 0
            self.remote:FireServer({
                throttle = self.input.throttle,
                brake = self.input.brake,
                steer = self.input.steer,
                handbrake = self.input.handbrake,
                driveMode = self.input.mode,
                clientTime = os.clock(),
            })
        end
    end)
end

function DrivingController:destroy()
    if self.connection then self.connection:Disconnect() end
end

return DrivingController
