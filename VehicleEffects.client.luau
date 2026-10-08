--!strict


local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local VehicleEffects = {}
VehicleEffects.__index = VehicleEffects

function VehicleEffects.new()
    return setmetatable({particles = {}, lastSmoke = 0}, VehicleEffects)
end

function VehicleEffects:bind(model: Model)
    self.model = model
    self.lastSmoke = 0

    for _, item in ipairs(model:GetDescendants()) do
        if item:IsA("ParticleEmitter") then
            self.particles[item.Name] = item
        end
    end
end

function VehicleEffects:update(dt: number, driftActive: boolean, throttle: number)
    if not self.model then return end
    self.lastSmoke += dt

    local smoke = self.particles.TireSmoke
    if smoke then
        smoke.Enabled = driftActive
        smoke.Rate = driftActive and math.clamp(15 + throttle * 40, 0, 60) or 0
    end

    local exhaust = self.particles.Exhaust
    if exhaust then
        exhaust.Rate = math.clamp(throttle * 35, 0, 35)
    end
end

function VehicleEffects:start()
    self.connection = RunService.RenderStepped:Connect(function(dt)
        self:update(dt, false, 0)
    end)
end

return VehicleEffects
