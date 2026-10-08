--!strict


local Validator = require(game.ServerScriptService.Security.RemoteValidator)

local ok = Validator.input({
    throttle = 1,
    brake = 0,
    steer = -1,
    handbrake = false,
    driveMode = "RWD",
})

assert(ok == true)

local bad = Validator.input({
    throttle = 99,
    brake = 0,
    steer = 0,
    handbrake = false,
    driveMode = "RWD",
})

assert(bad == false)
print("[PASS] ValidationTests")
