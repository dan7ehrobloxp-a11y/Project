--!strict


local AeroModel = {}

function AeroModel.calculate(speedMps: number, airDensity: number, cd: number, area: number, downforceCoeff: number, scale: number): (number, number)
    local q = 0.5 * airDensity * speedMps * speedMps
    return q * cd * area, q * downforceCoeff * area * scale
end

return AeroModel
