--!strict


local MathUtil = {}

function MathUtil.clamp01(x: number): number
    return math.clamp(x, 0, 1)
end

function MathUtil.sign(x: number): number
    if x > 0 then return 1 end
    if x < 0 then return -1 end
    return 0
end

function MathUtil.lerp(a: number, b: number, t: number): number
    return a + (b - a) * math.clamp(t, 0, 1)
end

function MathUtil.expApproach(current: number, target: number, response: number, dt: number): number
    local alpha = 1 - math.exp(-math.max(response, 0) * dt)
    return current + (target - current) * alpha
end

function MathUtil.safeUnit(v: Vector3): Vector3
    local m = v.Magnitude
    if m < 1e-6 then return Vector3.zero end
    return v / m
end

function MathUtil.wrapAngle(rad: number): number
    return (rad + math.pi) % (2 * math.pi) - math.pi
end

function MathUtil.smoothstep(a: number, b: number, x: number): number
    if a == b then return 0 end
    local t = math.clamp((x - a) / (b - a), 0, 1)
    return t * t * (3 - 2 * t)
end

function MathUtil.round(x: number, decimals: number): number
    local p = 10 ^ decimals
    return math.floor(x * p + 0.5) / p
end

return MathUtil
