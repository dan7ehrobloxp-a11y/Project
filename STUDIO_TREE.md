# Required Studio hierarchy

ReplicatedStorage
├── Shared
│   ├── Types.luau
│   ├── Constants.luau
│   ├── Config.luau
│   ├── VehicleProfiles.luau
│   ├── TuningDefaults.luau
│   ├── MathUtil.luau
│   ├── Units.luau
│   ├── EngineModel.luau
│   ├── Transmission.luau
│   ├── TireModel.luau
│   ├── SuspensionModel.luau
│   ├── AeroModel.luau
│   ├── Differential.luau
│   ├── DriveMode.luau
│   ├── RaceRules.luau
│   └── NetSchema.luau
└── Remotes
    ├── VehicleInput (RemoteEvent)
    ├── VehicleAction (RemoteEvent)
    ├── RaceAction (RemoteEvent)
    ├── GarageAction (RemoteEvent)
    ├── Telemetry (RemoteEvent)
    └── State (RemoteEvent)

ServerScriptService
├── Bootstrap.server.luau
├── Services
│   ├── VehicleRegistry.luau
│   ├── VehiclePhysicsService.luau
│   ├── RaceService.luau
│   ├── DriftService.luau
│   ├── GarageService.luau
│   ├── EconomyService.luau
│   ├── GhostService.luau
│   ├── AvatarService.luau
│   ├── SpawnService.luau
│   ├── DragService.luau
│   ├── HighwayService.luau
│   └── PersistenceService.luau
├── Security
│   ├── MovementValidator.luau
│   ├── RemoteValidator.luau
│   ├── RateLimiter.luau
│   └── Sanity.luau
└── Tests
    ├── MathTests.server.luau
    ├── ConfigTests.server.luau
    └── ValidationTests.server.luau

StarterPlayer
└── StarterPlayerScripts
    ├── ClientBootstrap.client.luau
    └── Controllers
        ├── DrivingController.client.luau
        ├── VehicleCamera.client.luau
        ├── InputController.client.luau
        ├── HUDController.client.luau
        ├── GarageController.client.luau
        ├── DriftHUD.client.luau
        ├── DragHUD.client.luau
        ├── GhostDriver.client.luau
        └── PhotoMode.client.luau

Workspace
├── Vehicles
├── RaceTracks
├── SpawnPoints
├── CarMeet
├── DragStrip
├── DriftArena
└── Highway
