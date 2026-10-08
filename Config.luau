--!strict


local Config = {
    Spawn = {
        DefaultVehicle = "ApexR",
        VehicleFolderName = "Vehicles",
        SpawnFolderName = "SpawnPoints",
    },

    World = {
        HighwayLanes = 6,
        HighwayLaneWidthStuds = 12,
        HighwaySegmentLengthStuds = 500,
        HighwaySegments = 24,
        DesertWidthStuds = 1800,
        MeetSizeStuds = Vector3.new(600, 1, 500),
    },

    UI = {
        Accent = Color3.fromRGB(0, 220, 255),
        Warning = Color3.fromRGB(255, 170, 40),
        Danger = Color3.fromRGB(255, 60, 70),
        Background = Color3.fromRGB(12, 14, 18),
    },

    Persistence = {
        DataStoreName = "DesertVelocity_PlayerData_v1",
        AutosaveSeconds = 120,
    },
}

return Config
