--!strict


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Config = require(ReplicatedStorage.Shared.Config)
local Constants = require(ReplicatedStorage.Shared.Constants)

local remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
remotes.Name = "Remotes"
remotes.Parent = ReplicatedStorage

local function remote(name: string): RemoteEvent
    local r = remotes:FindFirstChild(name)
    if not r then
        r = Instance.new("RemoteEvent")
        r.Name = name
        r.Parent = remotes
    end
    assert(r:IsA("RemoteEvent"))
    return r
end

local VehicleInput = remote("VehicleInput")
local VehicleAction = remote("VehicleAction")
local RaceAction = remote("RaceAction")
local GarageAction = remote("GarageAction")
local Telemetry = remote("Telemetry")
local State = remote("State")

local VehicleRegistry = require(script.Parent.Services.VehicleRegistry)
local VehiclePhysicsService = require(script.Parent.Services.VehiclePhysicsService)
local RaceService = require(script.Parent.Services.RaceService)
local DriftService = require(script.Parent.Services.DriftService)
local GarageService = require(script.Parent.Services.GarageService)
local EconomyService = require(script.Parent.Services.EconomyService)
local GhostService = require(script.Parent.Services.GhostService)
local PersistenceService = require(script.Parent.Services.PersistenceService)
local SpawnService = require(script.Parent.Services.SpawnService)
local DragService = require(script.Parent.Services.DragService)
local HighwayService = require(script.Parent.Services.HighwayService)
local RateLimiter = require(script.Parent.Security.RateLimiter)
local RemoteValidator = require(script.Parent.Security.RemoteValidator)
local MovementValidator = require(script.Parent.Security.MovementValidator)

local registry = VehicleRegistry.new()
local physics = VehiclePhysicsService.new(registry)
local races = RaceService.new()
local drift = DriftService.new()
local garage = GarageService.new(registry)
local CustomizationService = require(script.Parent.Services.CustomizationService)
local customization = CustomizationService.new(registry, economy)
local economy = EconomyService.new()
local ghosts = GhostService.new()
local persistence = PersistenceService.new(Config.Persistence.DataStoreName)
local spawner = SpawnService.new(registry, physics)
local drag = DragService.new()
local highway = HighwayService.new(races)
local limiter = RateLimiter.new(Constants.MaxRemoteCallsPerSecond)
local validator = MovementValidator.new()

physics:start()

VehicleInput.OnServerEvent:Connect(function(player, payload)
    if not limiter:allow(player.UserId) then return end
    local ok, input = RemoteValidator.input(payload)
    if not ok then return end

    local state = registry:getByPlayer(player)
    if not state then return end

    state.input.throttle = input.throttle
    state.input.brake = input.brake
    state.input.steer = input.steer
    state.input.handbrake = input.handbrake

    local allowed = garage:changeDriveMode(player, input.driveMode)
    if not allowed then
        state.input.driveMode = state.profile.allowedModes[1]
    end
end)

GarageAction.OnServerEvent:Connect(function(player, action, data)
    if not limiter:allow(player.UserId) then return end
    if action == "Tune" and typeof(data) == "table" then
        if typeof(data.key) == "string" and typeof(data.value) == "number" then
            garage:setTuning(player, data.key, data.value)
        end
    elseif action == "DriveMode" and typeof(data) == "string" then
        garage:changeDriveMode(player, data)
    elseif action == "Paint" and typeof(data) == "table" then
        if typeof(data.style) == "string" and typeof(data.primary) == "Color3" and typeof(data.secondary) == "Color3" then
            customization:setPaint(player, data.style, data.primary, data.secondary)
        end
    elseif action == "Wheels" and typeof(data) == "string" then
        customization:setWheels(player, data)
    elseif action == "BodyKit" and typeof(data) == "string" then
        customization:setBodyKit(player, data)
    elseif action == "Stance" and typeof(data) == "table" then
        if typeof(data.frontCamber) == "number" and typeof(data.rearCamber) == "number" and typeof(data.height) == "number" then
            customization:setStance(player, data.frontCamber, data.rearCamber, data.height)
        end
    end
end)

RaceAction.OnServerEvent:Connect(function(player, action, data)
    if not limiter:allow(player.UserId) then return end
    if action == "Join" and typeof(data) == "string" then
        races:join(player, data)
    elseif action == "Checkpoint" and typeof(data) == "number" then
        races:checkpoint(player, data)
    elseif action == "Leave" then
        races:leave(player)
    elseif action == "DragStage" and typeof(data) == "string" then
        drag:stage(player, data)
    end
end)

Players.PlayerAdded:Connect(function(player)
    persistence:load(player)
end)

Players.PlayerRemoving:Connect(function(player)
    persistence:save(player)
    persistence:remove(player)
    registry:unregister(player)
    drift:remove(player)
    ghosts:clear(player)
    customization:remove(player)
    validator:remove(player)
    limiter:remove(player)
end)

task.spawn(function()
    while true do
        task.wait(Config.Persistence.AutosaveSeconds)
        for _, player in Players:GetPlayers() do
            persistence:save(player)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1 / Constants.TelemetryHz)
        for player, state in pairs(registry.vehicles) do
            local root = state.model.PrimaryPart
            if root then
                validator:sample(player, root)
                local d = drift:update(player, state.telemetry, 1 / Constants.TelemetryHz)
                Telemetry:FireClient(player, state.telemetry, d)
            end
        end
    end
end)

State:FireAllClients("ServerReady", {
    physicsHz = Constants.PhysicsHz,
    networkHz = Constants.NetworkHz,
})
