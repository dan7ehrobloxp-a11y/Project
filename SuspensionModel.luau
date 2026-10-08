--!strict


local SuspensionModel = {}

function SuspensionModel.calculate(
    restLength: number,
    currentLength: number,
    velocityAlongAxis: number,
    springRate: number,
    damperRate: number
): (number, number)
    local compression = math.clamp((restLength - currentLength) / math.max(restLength, 0.001), -0.5, 1)
    local force = compression * springRate - velocityAlongAxis * damperRate
    return compression, math.max(force, 0)
end

return SuspensionModel
