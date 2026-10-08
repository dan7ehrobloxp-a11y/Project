# Desert Velocity — Roblox Automotive Game

A modular Roblox Luau automotive framework intended for direct Studio integration.

## Installation

1. Open Roblox Studio and create a new experience.
2. Create the folders shown in `STUDIO_TREE.md`.
3. Copy each `.luau` file into the matching Roblox container.
4. Copy the contents of `ReplicatedStorage/Shared/Config.luau`, `VehicleProfiles.luau`,
   and the other shared modules exactly as provided.
5. Run the server in Studio with **Start Server + 1 Player** before testing multiplayer.
6. Use the included test harnesses under `ServerScriptService/Tests` after the first boot.
7. Replace placeholder vehicle meshes with production models following `VEHICLE_MODEL_SPEC.md`.

## Important architecture

- Server owns race state, money, tuning authorization, checkpoint ordering, leaderboard writes,
  and anti-cheat decisions.
- The driver client owns local input and presentation.
- Vehicle assemblies can be network-owned by the driver for responsiveness, but network
  ownership is never treated as proof of legitimate movement.
- Persistent force/constraint objects should be created once per vehicle and updated rather than
  recreated every frame.
- Ghost Driver is visual-only and never receives gameplay authority.

## First playable milestone

The package is designed around a vertical slice:
spawn -> enter vehicle -> drive -> highway checkpoints -> finish -> drift -> garage/tuning ->
drag staging -> ghost driver -> car meet.

## Production note

Physics values are deliberately data-driven. Every vehicle should be tuned from telemetry
rather than hardcoded in controller logic.
