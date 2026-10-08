--!strict


local MathUtil = require(script.Parent.MathUtil)

local EngineModel = {}

local function sampleCurve(curve: {{rpm: number, multiplier: number}}, rpm: number): number
    if rpm <= curve[1].rpm then return curve[1].multiplier end
    for i = 1, #curve - 1 do
        local a = curve[i]
        local b = curve[i + 1]
        if rpm <= b.rpm then
            local t = (rpm - a.rpm) / (b.rpm - a.rpm)
            return MathUtil.lerp(a.multiplier, b.multiplier, t)
        end
    end
    return curve[#curve].multiplier
end

function EngineModel.new(profile: any)
    local engine = profile.engine
    local state = {
        rpm = engine.idleRpm,
        boost = 0,
        throttle = 0,
        temperature = 0,
    }

    function state:step(throttle: number, targetRpm: number, dt: number): number
        self.throttle = math.clamp(throttle, 0, 1)
        self.rpm = math.max(engine.idleRpm, targetRpm)

        local turbo = engine.turbo
        local targetBoost = turbo.maxBoostPsi * self.throttle * math.clamp(self.rpm / engine.redlineRpm, 0, 1)
        self.boost = MathUtil.expApproach(self.boost, targetBoost, turbo.spool, dt)

        local curve = sampleCurve(engine.torqueCurve, self.rpm)
        local boostMultiplier = 1 + self.boost / 100
        local torque = engine.peakTorqueNm * curve * self.throttle * boostMultiplier
        return torque
    end

    return state
end

return EngineModel
