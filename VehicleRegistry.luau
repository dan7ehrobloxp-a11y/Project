--!strict


local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local VehicleProfiles = require(game.ReplicatedStorage.Shared.VehicleProfiles)

local VehicleRegistry = {}
VehicleRegistry.__index = VehicleRegistry

function VehicleRegistry.new()
    return setmetatable({
        vehicles = {},
        byModel = {},
    }, VehicleRegistry)
end

function VehicleRegistry:register(player: Player, model: Model, vehicleId: string)
    local profile = VehicleProfiles[vehicleId]
    if not profile then error("Unknown vehicle profile: " .. vehicleId) end
    local primary = model.PrimaryPart
    assert(primary, "Vehicle requires PrimaryPart")

    local state = {
        id = HttpService:GenerateGUID(false),
        player = player,
        model = model,
        profile = profile,
        input = {throttle = 0, brake = 0, steer = 0, handbrake = false, driveMode = profile.allowedModes[1]},
        tuning = table.clone(profile.stockTuning),
        telemetry = {},
    }

    self.vehicles[player] = state
    self.byModel[model] = state

    if primary.Anchored == false then
        pcall(function()
            primary:SetNetworkOwner(player)
        end)
    end

    model:SetAttribute("OwnerUserId", player.UserId)
    model:SetAttribute("VehicleId", vehicleId)
    return state
end

function VehicleRegistry:getByPlayer(player: Player)
    return self.vehicles[player]
end

function VehicleRegistry:getByModel(model: Model)
    return self.byModel[model]
end

function VehicleRegistry:unregister(player: Player)
    local state = self.vehicles[player]
    if state then
        self.byModel[state.model] = nil
        self.vehicles[player] = nil
    end
end

return VehicleRegistry
