# Vehicle model contract

Every driveable model must contain:

VehicleModel
├── Chassis (BasePart, PrimaryPart)
├── Seat (VehicleSeat)
├── Wheels
│   ├── FL
│   ├── FR
│   ├── RL
│   └── RR
├── WheelVisuals
├── Suspension
│   ├── FL
│   ├── FR
│   ├── RL
│   └── RR
├── Aero
│   ├── FrontWing
│   └── RearWing
├── Exhaust
└── Attachments
    ├── COM
    ├── FL
    ├── FR
    ├── RL
    └── RR

Rules:
- Chassis is the only required physical root.
- Decorative meshes should normally have CanCollide=false and CanTouch=false.
- Wheels used for the raycast suspension model should be positioned at tire centers.
- Wheel radius is data-driven, not inferred from visual mesh bounds.
- The COM attachment is placed at the intended center of mass.
- All models must have a VehicleId attribute matching VehicleProfiles.
