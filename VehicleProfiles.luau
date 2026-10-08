--!strict


local Profiles = {}

local function profile(data)
    return data
end

Profiles.ApexR = profile({
    id = "ApexR",
    displayName = "Apex R",
    class = "Hypercar",
    massKg = 1450,
    wheelbaseM = 2.72,
    trackFrontM = 1.68,
    trackRearM = 1.64,
    cgHeightM = 0.34,
    engine = {
        displacementL = 4.0,
        cylinders = 8,
        idleRpm = 900,
        redlineRpm = 9000,
        peakTorqueNm = 760,
        peakTorqueRpm = 6500,
        peakPowerKw = 690,
        torqueCurve = {
            {rpm = 1000, multiplier = 0.55},
            {rpm = 2500, multiplier = 0.72},
            {rpm = 4000, multiplier = 0.88},
            {rpm = 5500, multiplier = 1.00},
            {rpm = 6500, multiplier = 1.00},
            {rpm = 7500, multiplier = 0.94},
            {rpm = 9000, multiplier = 0.72},
        },
        turbo = {count = 2, maxBoostPsi = 22, spool = 5.5, lag = 0.18},
    },
    transmission = {gears = 7, ratios = {3.10, 2.18, 1.55, 1.20, 0.96, 0.78, 0.64}, finalDrive = 3.42, shiftTime = 0.085},
    differential = {frontBias = 0.42, lock = 0.65},
    suspension = {frontSpring = 68000, rearSpring = 72000, frontDamper = 5200, rearDamper = 5600, travel = 0.11, antiRoll = 0.72},
    tires = {radiusM = 0.335, widthM = 0.305, mu = 1.65, pressurePsi = 31, heatGripGain = 0.06},
    aero = {cd = 0.30, frontalArea = 2.05, downforceCoeff = 1.25, balance = 0.46},
    steering = {maxAngleDeg = 31, response = 8.5, speedReduction = 0.70},
    allowedModes = {"AWD", "RWD"},
    stockTuning = require(script.Parent.TuningDefaults),
})

Profiles.NovaS = profile({
    id = "NovaS",
    displayName = "Nova S",
    class = "Supercar",
    massKg = 1390,
    wheelbaseM = 2.62,
    trackFrontM = 1.64,
    trackRearM = 1.61,
    cgHeightM = 0.37,
    engine = {
        displacementL = 3.8, cylinders = 6, idleRpm = 950, redlineRpm = 8500,
        peakTorqueNm = 620, peakTorqueRpm = 5000, peakPowerKw = 540,
        torqueCurve = {
            {rpm = 1000, multiplier = 0.48}, {rpm = 2500, multiplier = 0.73},
            {rpm = 4000, multiplier = 0.92}, {rpm = 5000, multiplier = 1.0},
            {rpm = 6500, multiplier = 0.96}, {rpm = 8500, multiplier = 0.76},
        },
        turbo = {count = 2, maxBoostPsi = 18, spool = 6, lag = 0.20},
    },
    transmission = {gears = 7, ratios = {3.22, 2.19, 1.63, 1.29, 1.03, 0.84, 0.69}, finalDrive = 3.55, shiftTime = 0.095},
    differential = {frontBias = 0.36, lock = 0.58},
    suspension = {frontSpring = 60000, rearSpring = 65000, frontDamper = 4800, rearDamper = 5000, travel = 0.12, antiRoll = 0.64},
    tires = {radiusM = 0.325, widthM = 0.285, mu = 1.55, pressurePsi = 30, heatGripGain = 0.05},
    aero = {cd = 0.32, frontalArea = 2.00, downforceCoeff = 0.95, balance = 0.45},
    steering = {maxAngleDeg = 33, response = 9, speedReduction = 0.72},
    allowedModes = {"RWD", "AWD"},
    stockTuning = require(script.Parent.TuningDefaults),
})

Profiles.TitanX = profile({
    id = "TitanX",
    displayName = "Titan X",
    class = "SUV",
    massKg = 2280,
    wheelbaseM = 2.98,
    trackFrontM = 1.70,
    trackRearM = 1.68,
    cgHeightM = 0.62,
    engine = {
        displacementL = 4.4, cylinders = 8, idleRpm = 750, redlineRpm = 7200,
        peakTorqueNm = 850, peakTorqueRpm = 3500, peakPowerKw = 470,
        torqueCurve = {
            {rpm = 900, multiplier = 0.58}, {rpm = 2000, multiplier = 0.82},
            {rpm = 3000, multiplier = 1.0}, {rpm = 4000, multiplier = 1.0},
            {rpm = 5500, multiplier = 0.88}, {rpm = 7200, multiplier = 0.64},
        },
        turbo = {count = 2, maxBoostPsi = 16, spool = 4.2, lag = 0.22},
    },
    transmission = {gears = 8, ratios = {3.10, 2.15, 1.52, 1.21, 1.00, 0.82, 0.68, 0.56}, finalDrive = 3.10, shiftTime = 0.13},
    differential = {frontBias = 0.48, lock = 0.72},
    suspension = {frontSpring = 82000, rearSpring = 86000, frontDamper = 6100, rearDamper = 6400, travel = 0.21, antiRoll = 0.54},
    tires = {radiusM = 0.39, widthM = 0.31, mu = 1.42, pressurePsi = 33, heatGripGain = 0.04},
    aero = {cd = 0.37, frontalArea = 2.75, downforceCoeff = 0.55, balance = 0.49},
    steering = {maxAngleDeg = 35, response = 6.5, speedReduction = 0.82},
    allowedModes = {"AWD", "RWD"},
    stockTuning = require(script.Parent.TuningDefaults),
})

Profiles.SlideK = profile({
    id = "SlideK",
    displayName = "Slide K",
    class = "Tuner",
    massKg = 1320,
    wheelbaseM = 2.55,
    trackFrontM = 1.57,
    trackRearM = 1.58,
    cgHeightM = 0.39,
    engine = {
        displacementL = 2.6, cylinders = 6, idleRpm = 950, redlineRpm = 9000,
        peakTorqueNm = 720, peakTorqueRpm = 6200, peakPowerKw = 570,
        torqueCurve = {
            {rpm = 1200, multiplier = 0.40}, {rpm = 3000, multiplier = 0.60},
            {rpm = 4500, multiplier = 0.78}, {rpm = 6200, multiplier = 1.0},
            {rpm = 7200, multiplier = 0.98}, {rpm = 9000, multiplier = 0.80},
        },
        turbo = {count = 1, maxBoostPsi = 31, spool = 4.8, lag = 0.28},
    },
    transmission = {gears = 6, ratios = {2.90, 1.95, 1.42, 1.10, 0.88, 0.72}, finalDrive = 4.10, shiftTime = 0.12},
    differential = {frontBias = 0.0, lock = 0.90},
    suspension = {frontSpring = 56000, rearSpring = 61000, frontDamper = 4500, rearDamper = 4800, travel = 0.14, antiRoll = 0.60},
    tires = {radiusM = 0.32, widthM = 0.275, mu = 1.48, pressurePsi = 29, heatGripGain = 0.07},
    aero = {cd = 0.34, frontalArea = 1.95, downforceCoeff = 0.38, balance = 0.43},
    steering = {maxAngleDeg = 40, response = 8.2, speedReduction = 0.60},
    allowedModes = {"RWD", "AWD"},
    stockTuning = require(script.Parent.TuningDefaults),
})

return Profiles
