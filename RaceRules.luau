--!strict


local RaceRules = {}

function RaceRules.isValidCheckpoint(current: number, requested: number): boolean
    return requested == current + 1
end

function RaceRules.isFinished(current: number, total: number): boolean
    return current >= total
end

function RaceRules.driftMultiplier(angleDeg: number): number
    local t = math.clamp((angleDeg - 8) / (30 - 8), 0, 1)
    return 1 + t * 4
end

return RaceRules
