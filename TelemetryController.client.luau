--!strict


local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TelemetryController = {}
TelemetryController.__index = TelemetryController

function TelemetryController.new()
    return setmetatable({
        current = {
            speedKph = 0,
            rpm = 0,
            gear = 1,
            yawRate = 0,
        },
        smoothedSpeed = 0,
        smoothedRpm = 0,
    }, TelemetryController)
end

function TelemetryController:start()
    ReplicatedStorage.Remotes.Telemetry.OnClientEvent:Connect(function(telemetry)
        self.current = telemetry
    end)

    self.connection = RunService.RenderStepped:Connect(function(dt)
        local a = 1 - math.exp(-12 * dt)
        self.smoothedSpeed += ((self.current.speedKph or 0) - self.smoothedSpeed) * a
        self.smoothedRpm += ((self.current.rpm or 0) - self.smoothedRpm) * a
    end)
end

function TelemetryController:getSpeed(): number
    return self.smoothedSpeed
end

function TelemetryController:getRpm(): number
    return self.smoothedRpm
end

return TelemetryController
