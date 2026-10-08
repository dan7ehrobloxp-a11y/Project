--!strict


local Catalog = {
    Wheels = {
        Street5 = {diameter = 19, width = 10.5, offset = 0.02, cost = 1500},
        Aero10 = {diameter = 20, width = 11.0, offset = 0.01, cost = 3500},
        DriftDeep = {diameter = 18, width = 10.0, offset = 0.04, cost = 2200},
        TrackMono = {diameter = 20, width = 12.0, offset = 0.00, cost = 5000},
    },

    BodyKits = {
        Stock = {frontBumper = "Stock", rearBumper = "Stock", sideSkirt = "Stock", hood = "Stock", spoiler = "Stock", diffuser = "Stock", cost = 0},
        Street = {frontBumper = "Street", rearBumper = "Street", sideSkirt = "Street", hood = "Street", spoiler = "Street", diffuser = "Street", cost = 12000},
        Track = {frontBumper = "Track", rearBumper = "Track", sideSkirt = "Track", hood = "Vented", spoiler = "GT", diffuser = "Track", cost = 28000},
        Wide = {frontBumper = "Wide", rearBumper = "Wide", sideSkirt = "Wide", hood = "Vented", spoiler = "Ducktail", diffuser = "Wide", cost = 34000},
    },

    Tires = {
        Street = {grip = 1.00, heatRange = {50, 95}, wetGrip = 0.78, cost = 1000},
        Sport = {grip = 1.10, heatRange = {60, 105}, wetGrip = 0.72, cost = 3500},
        SemiSlick = {grip = 1.24, heatRange = {70, 115}, wetGrip = 0.55, cost = 7000},
        Drift = {grip = 1.04, heatRange = {55, 110}, wetGrip = 0.62, cost = 4500},
        Drag = {grip = 1.35, heatRange = {45, 90}, wetGrip = 0.35, cost = 9000},
    },

    Paint = {
        Gloss = {roughness = 0.22, metallic = 0.15},
        Metallic = {roughness = 0.18, metallic = 0.85},
        Satin = {roughness = 0.38, metallic = 0.25},
        Matte = {roughness = 0.62, metallic = 0.05},
        Chrome = {roughness = 0.06, metallic = 1.00},
    },
}

return Catalog
