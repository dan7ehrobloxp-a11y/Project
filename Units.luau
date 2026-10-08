--!strict


local Units = {}

function Units.kphToMps(kph: number): number
    return kph / 3.6
end

function Units.mpsToKph(mps: number): number
    return mps * 3.6
end

function Units.studsToMeters(studs: number): number
    return studs / 3.57142857
end

function Units.metersToStuds(meters: number): number
    return meters * 3.57142857
end

function Units.rpmToRadPerSecond(rpm: number): number
    return rpm * math.pi / 30
end

function Units.radPerSecondToRpm(rad: number): number
    return rad * 30 / math.pi
end

return Units
