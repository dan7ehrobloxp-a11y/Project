--!strict


local RunService = game:GetService("RunService")

local Speedometer = {}
Speedometer.__index = Speedometer

function Speedometer.new(label: TextLabel)
    return setmetatable({label = label, speed = 0}, Speedometer)
end

function Speedometer:setSpeed(speed: number)
    self.speed = speed
end

function Speedometer:start()
    self.connection = RunService.RenderStepped:Connect(function(dt)
        local alpha = 1 - math.exp(-14 * dt)
        self.display = (self.display or 0) + (self.speed - (self.display or 0)) * alpha
        self.label.Text = string.format("%03d", math.floor(self.display + 0.5))
    end)
end

return Speedometer
