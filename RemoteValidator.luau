--!strict


local NetSchema = require(game.ReplicatedStorage.Shared.NetSchema)

local RemoteValidator = {}

function RemoteValidator.input(payload: any): (boolean, any?)
    if typeof(payload) ~= "table" then return false, nil end
    local okT, throttle = NetSchema.number(payload.throttle, 0, 1)
    local okB, brake = NetSchema.number(payload.brake, 0, 1)
    local okS, steer = NetSchema.number(payload.steer, -1, 1)
    local okH, handbrake = NetSchema.boolean(payload.handbrake)
    local okM, mode = NetSchema.driveMode(payload.driveMode)
    if not (okT and okB and okS and okH and okM) then return false, nil end

    return true, {
        throttle = throttle,
        brake = brake,
        steer = steer,
        handbrake = handbrake,
        driveMode = mode,
        clientTime = typeof(payload.clientTime) == "number" and payload.clientTime or 0,
    }
end

return RemoteValidator
