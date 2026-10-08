--!strict


local MathUtil = require(script.Parent.MathUtil)

local TireModel = {}

function TireModel.calculate(loadN: number, slipRatio: number, slipAngleRad: number, mu: number): (number, number)
    local load = math.max(loadN, 0)
    local peak = mu * load

    local longitudinal = math.tanh(slipRatio * 7.5) * peak
    local lateral = math.tanh(math.tan(slipAngleRad) * 4.2) * peak

    local combined = math.sqrt(longitudinal * longitudinal + lateral * lateral)
    if combined > peak and combined > 0 then
        local scale = peak / combined
        longitudinal *= scale
        lateral *= scale
    end

    return longitudinal, lateral
end

function TireModel.slipRatio(wheelAngularSpeed: number, radiusM: number, forwardSpeed: number): number
    local wheelSpeed = wheelAngularSpeed * radiusM
    local denom = math.max(math.abs(forwardSpeed), 2)
    return (wheelSpeed - forwardSpeed) / denom
end

function TireModel.slipAngle(velocityLocal: Vector3, steerRad: number): number
    local forward = math.max(math.abs(velocityLocal.Z), 1)
    local velocityAngle = math.atan2(velocityLocal.X, -velocityLocal.Z)
    return MathUtil.wrapAngle(velocityAngle - steerRad)
end

return TireModel
