--!strict


local Profiles = require(game.ReplicatedStorage.Shared.VehicleProfiles)

for id, profile in pairs(Profiles) do
    assert(typeof(profile.massKg) == "number", id .. " missing mass")
    assert(typeof(profile.engine.redlineRpm) == "number", id .. " missing redline")
    assert(#profile.transmission.ratios == profile.transmission.gears, id .. " gear mismatch")
    assert(#profile.allowedModes > 0, id .. " no drive modes")
end

print("[PASS] ConfigTests")
