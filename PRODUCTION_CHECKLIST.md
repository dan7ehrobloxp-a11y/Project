# Production checklist — 50-page expansion

## Vehicle physics
- [ ] Replace visual wheel meshes with four correctly aligned raycast attachment points.
- [ ] Verify center of mass at the intended physical location.
- [ ] Verify wheelbase against profile in meters.
- [ ] Verify tire radius against actual mesh.
- [ ] Verify suspension travel visually and physically.
- [ ] Verify anti-roll behavior with one-wheel bump tests.
- [ ] Verify braking transfer under full braking.
- [ ] Verify throttle lift behavior.
- [ ] Verify RWD power oversteer.
- [ ] Verify AWD launch traction.
- [ ] Verify FWD torque steer if enabled.
- [ ] Verify high-speed aero stability.

## Tuning
- [ ] Every slider has a server-side min/max.
- [ ] Every upgrade has an ownership requirement.
- [ ] Every purchase has a server-side cost check.
- [ ] Client cannot submit an arbitrary engine profile.
- [ ] Client cannot submit arbitrary gear count.
- [ ] Client cannot change mass.
- [ ] Client cannot disable race validation.

## Map
- [ ] Six-lane highway has readable lane lines.
- [ ] Shoulders are wide enough for recovery.
- [ ] Median is collision-safe.
- [ ] Barriers are continuous.
- [ ] Desert terrain does not create accidental launch ramps.
- [ ] Car meet has low-speed collision geometry.
- [ ] Drag shutdown area is long enough for braking.
- [ ] Drift arena has runoff.
- [ ] Streetlights use pooled or limited dynamic lights.

## Multiplayer
- [ ] Test 2 players.
- [ ] Test 8 players.
- [ ] Test 20 players.
- [ ] Test player leaving during race.
- [ ] Test vehicle destruction during race.
- [ ] Test respawn during race.
- [ ] Test simultaneous checkpoint touches.
- [ ] Test remote spam.
- [ ] Test invalid tuning values.
- [ ] Test invalid race IDs.
- [ ] Test impossible movement.
- [ ] Test data saving after disconnect.

## UI
- [ ] Garage supports controller navigation.
- [ ] Garage supports mouse and touch.
- [ ] Drag tree is readable at all resolutions.
- [ ] Drift score is visible but not obstructive.
- [ ] Speedometer supports three-digit and four-digit speeds.
- [ ] Race timer is deterministic.
- [ ] Photo mode hides unnecessary HUD.

## Ghost
- [ ] Avatar appearance matches current player.
- [ ] Ghost cannot collide.
- [ ] Ghost cannot trigger checkpoints.
- [ ] Ghost cannot sit in vehicles.
- [ ] Ghost cannot receive remote actions.
- [ ] Ghost is removed when the player leaves the race.
- [ ] Ghost transform is interpolated client-side.
