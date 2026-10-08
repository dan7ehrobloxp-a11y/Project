--!strict


local VehicleUpgradeService = {}
VehicleUpgradeService.__index = VehicleUpgradeService

local upgradeLimits = {
    EngineStage = {0, 5},
    TurboStage = {0, 5},
    GearboxStage = {0, 4},
    TireStage = {0, 4},
    BrakeStage = {0, 4},
    AeroStage = {0, 4},
    SuspensionStage = {0, 4},
}

function VehicleUpgradeService.new(economy)
    return setmetatable({economy = economy, upgrades = {}}, VehicleUpgradeService)
end

function VehicleUpgradeService:set(player: Player, category: string, stage: number): boolean
    local limit = upgradeLimits[category]
    if not limit or stage % 1 ~= 0 or stage < limit[1] or stage > limit[2] then
        return false
    end

    local data = self.upgrades[player] or {}
    data[category] = stage
    self.upgrades[player] = data
    return true
end

function VehicleUpgradeService:get(player: Player)
    return self.upgrades[player] or {}
end

function VehicleUpgradeService:remove(player: Player)
    self.upgrades[player] = nil
end

return VehicleUpgradeService
