# Desert Velocity — Production Engineering Specification

## 1. Physics target

The vehicle model is designed around stable, understandable forces rather than a fake
speed multiplier. The chassis is a rigid assembly. Tire force is computed from normal load,
slip ratio and slip angle. Aerodynamic drag follows 0.5*rho*Cd*A*v^2 and downforce follows
the same dynamic-pressure basis.

Roblox uses studs, while the tuning data is expressed in metric units. `Units.luau` provides
the conversion boundary. Never mix metric wheel radius with raw Roblox studs inside equations.

## 2. Suspension

The current framework uses raycast wheel contacts. The production vehicle should create one
persistent raycast/contact definition per wheel. Spring force is proportional to compression
and damper force opposes compression velocity.

SUV profiles intentionally have:
- greater wheel travel;
- higher CG;
- higher mass;
- softer anti-roll behavior;
- lower peak tire friction.

This produces visibly different weight transfer instead of merely lowering acceleration.

## 3. Tires

The combined-grip limiter prevents the tire from simultaneously producing unlimited braking,
cornering and drive force. The model is intentionally game-oriented and should be calibrated
with telemetry.

For production:
- add tire temperature;
- add wear;
- add surface friction;
- add wet/sand/painted-road coefficients;
- add wheel-load sensitivity;
- add tire compound profiles.

## 4. Powertrain

Engine torque is sampled from a data table. Turbo boost approaches a target through a
first-order response. Transmission ratios multiply engine torque and final drive.

Production engine swaps should be profile IDs, not client-submitted arbitrary values.

Recommended engine-swap data:
- engineId;
- mass delta;
- torque curve;
- redline;
- idle;
- turbo characteristics;
- thermal capacity;
- ECU limiter;
- audio profile.

## 5. Drive modes

FWD sends all drive torque to the front axle. RWD sends all drive torque to the rear.
AWD uses a configurable front bias.

Drive mode is validated on the server against the vehicle profile.

## 6. Drifting

A drift begins only after minimum speed and minimum angle are reached. Score grows with:
- speed;
- angle;
- multiplier;
- combo duration.

The score is server-side. The client receives telemetry for presentation.

A production drift system should add:
- tire smoke density;
- tire temperature;
- steering correction quality;
- transition bonus;
- proximity bonus;
- clipping-zone bonus;
- tandem multiplier;
- wall-touch penalty.

## 7. Drag racing

The Christmas tree must be synchronized from server time. Do not let the client decide when
the light becomes green.

The recommended sequence is:
pre-stage -> stage -> amber 1 -> amber 2 -> amber 3 -> green.

Reaction time is measured from the authoritative green timestamp to the first valid
forward movement beyond the rollout threshold.

False starts should be recorded when movement begins before green.

## 8. Highway racing

Routes consist of ordered checkpoints. A player cannot finish simply by touching the last
checkpoint. The server requires the complete ordered sequence.

Production routes should add:
- route ID;
- weather variant;
- traffic density;
- speed traps;
- shortcut risk;
- drafting zones;
- sector timing;
- restart zones.

## 9. Draft mechanics

A draft system should use a cone behind the lead vehicle and compare relative velocity.
Only vehicles traveling within an appropriate heading window should receive slipstream.

Recommended limits:
- maximum draft range: 40 m;
- cone half-angle: 12 degrees;
- minimum speed: 80 kph;
- diminishing returns at low relative velocity.

Draft acceleration should be capped to prevent multiplayer slingshots.

## 10. Anti-cheat

Never trust:
- client speed;
- client checkpoint index;
- client finish time;
- client cash;
- client vehicle ownership claims;
- client tuning cost;
- client drift score.

The movement validator tracks:
- displacement;
- observed velocity;
- reported assembly velocity;
- impossible teleport distances;
- repeated implausible samples.

A strike should be evidence for investigation, not immediate punishment after one noisy frame.

## 11. Network ownership

The driver can own the physical assembly for responsiveness. The server still owns:
- race progression;
- economy;
- unlocks;
- tuning limits;
- leaderboard submissions;
- anti-cheat;
- official timers.

For high-value competitive events, consider server-side replay validation.

## 12. Ghost Driver

The ghost driver is intentionally separate from gameplay. It can use the player's avatar
appearance, but it has:
- no collision;
- no touch;
- no query;
- no scripts;
- no seat authority;
- no remote permissions.

For a true ghost-racing mode, record transform samples on the server and interpolate them
on the client. Never replay arbitrary client-created instances.

## 13. Avatar integration

Use `Players:GetHumanoidDescriptionFromUserIdAsync` and
`Players:CreateHumanoidModelFromDescriptionAsync`. Use explicit
`Enum.AssetTypeVerification.Always` when generating the avatar model.

Avatar cosmetics are presentation data. They should not become a path to loading arbitrary
instances.

## 14. Garage

Garage actions should be command based:
Tune, Paint, Wheel, BodyKit, EngineSwap, Transmission, Suspension, Differential,
DriveMode, SaveBuild.

Every command is validated against:
- ownership;
- unlock;
- allowed range;
- currency;
- compatibility;
- rate limit.

## 15. Stance

Stance controls should be visual plus handling data:
- front camber;
- rear camber;
- toe;
- ride height;
- wheel offset.

Do not physically move the entire chassis downward without checking collision clearance.

## 16. Map

The map should be segmented into performance zones.

Zone A — Car Meet:
- 20+ display bays;
- lighting;
- photo spots;
- dyno;
- tuning bay;
- wrap area;
- drift circle;
- social seating.

Zone B — Highway:
- six lanes;
- central barrier;
- emergency shoulders;
- signs;
- lighting;
- overpasses;
- desert scenery.

Zone C — Drag:
- staging lanes;
- Christmas tree;
- timing beams;
- shutdown area;
- spectator stands.

Zone D — Drift:
- open asphalt;
- clipping points;
- tire walls;
- scoring gates;
- elevation changes.

## 17. Performance budget

Avoid thousands of unique physical parts. Decorative assets should use:
- MeshParts;
- streaming;
- simplified collision;
- low-frequency shadows;
- pooled effects.

Vehicle physics should update at a stable fixed simulation cadence while network state is
replicated at a lower rate.

## 18. Visual design

Use a restrained automotive UI:
- dark graphite base;
- cyan performance accent;
- white telemetry;
- amber warning;
- red critical.

The HUD should show:
speed, RPM, gear, mode, traction state, drift score, race position.

## 19. Audio

Each vehicle should have:
- idle loop;
- low RPM;
- high RPM;
- throttle lift;
- limiter;
- gear shift;
- turbo spool;
- blow-off;
- tire scrub;
- tire squeal;
- brake;
- wind.

Audio pitch should derive from engine RPM rather than vehicle speed.

## 20. Camera

Camera modes:
- chase;
- hood;
- bumper;
- cockpit;
- cinematic;
- photo mode.

Chase camera should damp translation and rotation separately. Do not parent the camera
directly to the chassis.

## 21. Lighting

Night meet lighting should combine:
- area-like emissive fixtures;
- local point lights;
- cool street lighting;
- warm building lighting;
- subtle bloom;
- ambient fill.

Avoid hundreds of high-range dynamic lights.

## 22. Surface system

Each road segment can carry an attribute:
SurfaceType = Asphalt / Concrete / Sand / Painted / Wet.

Tire grip is multiplied by the surface coefficient on the server.

## 23. Production physics constraint pooling

The sample physics service creates the force objects during vehicle initialization.
A final production build should maintain those objects for the vehicle lifetime and update
their forces each step. Never create/destroy force objects in the Heartbeat loop.

## 24. Testing

Run:
- single-player physics tests;
- two-player race tests;
- vehicle swap tests;
- respawn tests;
- data-loss tests;
- exploit simulation;
- high-speed collision tests;
- checkpoint abuse tests;
- remote spam tests.

Use Studio's server/client test modes.

## 25. Integration order

1. Shared modules.
2. Remotes.
3. Server services.
4. Vehicle template.
5. Spawn system.
6. Client controllers.
7. Highway route.
8. Drag strip.
9. Drift arena.
10. Garage UI.
11. Avatar ghost.
12. Persistence.
13. Audio/VFX.
14. Optimization.
15. Multiplayer QA.

## 26. Vehicle tuning workflow

Use a telemetry sheet with:
- 0–60 mph;
- 0–100 mph;
- 60–130 mph;
- quarter-mile;
- top speed;
- 100–0 braking;
- skidpad lateral G;
- drift initiation speed.

Do not balance vehicles by subjective feel alone.

## 27. Reality target

Realistic does not mean frustrating. Preserve:
- mass;
- inertia;
- traction;
- weight transfer;
- braking;
- drivetrain differences;
- turbo lag;
- steering geometry.

Do not reproduce catastrophic real-world failure modes unless explicitly designed as an
optional simulation mode.

## 28. Ghost comparison

The included ghost is deliberately closer to a holographic avatar presentation than a
gameplay clone. For the final version, use:
- avatar description matching;
- neon edge/highlight treatment;
- transparency;
- animated idle;
- transform interpolation;
- optional ghost car trail;
- race-time delta display.

The ghost must remain collisionless and non-authoritative.

## 29. Code standards

All Luau source uses `--!strict`.

Public functions should type their arguments and returns. Data structures are represented
with exported types where they cross module boundaries.

Do not use `_G` for gameplay state.

Do not store critical state in client-only modules.

## 30. Final acceptance checklist

- [ ] Every vehicle has a valid PrimaryPart.
- [ ] Every vehicle has four wheel attachments.
- [ ] Every profile has matching transmission gear count.
- [ ] All remotes validate payload types.
- [ ] All tuning values are range checked.
- [ ] Race checkpoints are ordered server-side.
- [ ] Drag green light is server timed.
- [ ] Drift score is server calculated.
- [ ] Economy is server controlled.
- [ ] DataStore calls are protected with pcall.
- [ ] Ghost driver is non-collidable.
- [ ] Vehicle forces are persistent.
- [ ] Decorative map parts use simplified collision.
- [ ] Studio multiplayer test passes.
