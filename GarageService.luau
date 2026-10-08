--!strict


local VehicleProfiles = require(game.ReplicatedStorage.Shared.VehicleProfiles)

local GarageService = {}
GarageService.__index = GarageService

local limits = {
    boostPsi = {0, 40},
    springScale = {0.6, 1.6},
    damperScale = {0.5, 1.8},
    camberFront = {-8, 2},
    camberRear = {-8, 2},
    toeFront = {-1, 1},
    toeRear = {-1, 1},
    brakeBias = {0.40, 0.75},
    tireGrip = {0.85, 1.20},
    tirePressure = {18, 45},
    rideHeight = {-0.10, 0.10},
    downforceScale = {0.50, 1.50},
}

function GarageService.new(registry)
    return setmetatable({registry = registry}, GarageService)
end

function GarageService:setTuning(player: Player, key: string, value: number): boolean
    local state = self.registry:getByPlayer(player)
    local range = limits[key]
    if not state or not range or typeof(value) ~= "number" then return false end
    if value < range[1] or value > range[2] then return false end
    state.tuning[key] = value
    return true
end

function GarageService:changeDriveMode(player: Player, mode: string): boolean
    local state = self.registry:getByPlayer(player)
    if not state or typeof(mode) ~= "string" then return false end
    for _, allowed in ipairs(state.profile.allowedModes) do
        if allowed == mode then
            state.input.driveMode = mode
            return true
        end
    end
    return false
end

function GarageService:getProfile(vehicleId: string)
    return VehicleProfiles[vehicleId]
end

return GarageService
