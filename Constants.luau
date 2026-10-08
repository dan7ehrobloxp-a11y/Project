--!strict


local Constants = {
    PhysicsHz = 120,
    NetworkHz = 20,
    TelemetryHz = 15,
    MaxInputAge = 0.35,
    MaxRemoteCallsPerSecond = 30,

    Gravity = 196.2,
    AirDensitySeaLevel = 1.225,
    StudsPerMeter = 3.57142857,

    MaxPlausibleAccelerationG = 3.5,
    MaxPlausibleBrakeG = 2.0,
    MaxPlausibleYawRate = 7.5,
    MaxPositionCorrectionMeters = 8,

    Drift = {
        MinimumSpeedKph = 35,
        MinimumAngleDegrees = 8,
        FullMultiplierAngleDegrees = 30,
        ComboGraceSeconds = 1.25,
        MaximumScorePerSecond = 25000,
    },

    Race = {
        CheckpointRadius = 18,
        StartCountdownSeconds = 3,
        MaximumCheckpointSkips = 0,
        FinishSpeedToleranceKph = 80,
        MaximumRaceSeconds = 900,
    },

    Drag = {
        RolloutMeters = 0.3048,
        QuarterMileMeters = 402.336,
        HalfMileMeters = 804.672,
        TreeInterval = 0.5,
        ReactionWindowSeconds = 0.1,
    },

    Security = {
        PositionSampleSeconds = 0.25,
        VelocityTolerance = 1.35,
        SpeedToleranceKph = 55,
        TeleportToleranceStuds = 90,
        StrikeDecaySeconds = 120,
        KickStrikes = 8,
    },
}

return Constants
