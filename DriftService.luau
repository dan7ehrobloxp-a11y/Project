--!strict


local Constants = require(game.ReplicatedStorage.Shared.Constants)
local RaceRules = require(game.ReplicatedStorage.Shared.RaceRules)

local DriftService = {}
DriftService.__index = DriftService

function DriftService.new()
    return setmetatable({states = {}}, DriftService)
end

function DriftService:update(player: Player, telemetry: any, dt: number)
    local speed = telemetry.speedKph or 0
    local lateral = math.abs(telemetry.lateralG or 0)
    local yaw = math.abs(telemetry.yawRate or 0)
    local angle = math.deg(math.atan2(lateral, math.max(speed / 100, 0.2))) + math.deg(math.min(yaw * 0.02, 0.35))
    local active = speed >= Constants.Drift.MinimumSpeedKph and angle >= Constants.Drift.MinimumAngleDegrees

    local s = self.states[player] or {score = 0, combo = 1, active = false, grace = 0}
    if active then
        local multiplier = RaceRules.driftMultiplier(angle)
        s.score += math.min(speed * multiplier * dt * 8, Constants.Drift.MaximumScorePerSecond * dt)
        s.combo = math.min(s.combo + dt * 0.65, 10)
        s.grace = Constants.Drift.ComboGraceSeconds
        s.active = true
    else
        s.grace -= dt
        if s.grace <= 0 then
            s.combo = math.max(1, s.combo - dt * 2)
            s.active = false
        end
    end
    s.angle = angle
    self.states[player] = s
    return s
end

function DriftService:remove(player: Player)
    self.states[player] = nil
end

return DriftService
