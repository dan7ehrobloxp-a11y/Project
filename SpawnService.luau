--!strict


local ServerStorage = game:GetService("ServerStorage")
local VehicleProfiles = require(game.ReplicatedStorage.Shared.VehicleProfiles)

local SpawnService = {}
SpawnService.__index = SpawnService

function SpawnService.new(registry, physics)
    return setmetatable({registry = registry, physics = physics}, SpawnService)
end

function SpawnService:spawn(player: Player, vehicleId: string, spawnPart: BasePart)
    local templates = ServerStorage:FindFirstChild("VehicleTemplates")
    if not templates then return nil end
    local template = templates:FindFirstChild(vehicleId)
    local profile = VehicleProfiles[vehicleId]
    if not template or not profile or not template:IsA("Model") then return nil end

    local model = template:Clone()
    model:PivotTo(spawnPart.CFrame)
    model.Parent = workspace:FindFirstChild("Vehicles") or workspace

    local state = self.registry:register(player, model, vehicleId)
    self.physics:add(state)
    return model
end

function SpawnService:despawn(player: Player)
    local state = self.registry:getByPlayer(player)
    if not state then return end
    self.physics:remove(state)
    self.registry:unregister(player)
    if state.model then state.model:Destroy() end
end

return SpawnService
