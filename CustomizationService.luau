--!strict


local Catalog = require(game.ReplicatedStorage.Shared.CustomizationCatalog)

local CustomizationService = {}
CustomizationService.__index = CustomizationService

local function validColor(c: any): boolean
    return typeof(c) == "Color3"
end

function CustomizationService.new(registry, economy)
    return setmetatable({
        registry = registry,
        economy = economy,
        builds = {},
    }, CustomizationService)
end

function CustomizationService:setPaint(player: Player, paintType: string, primary: Color3, secondary: Color3): boolean
    if not Catalog.Paint[paintType] or not validColor(primary) or not validColor(secondary) then
        return false
    end
    local build = self.builds[player] or {}
    build.paint = {
        type = paintType,
        primary = primary,
        secondary = secondary,
    }
    self.builds[player] = build
    return true
end

function CustomizationService:setWheels(player: Player, wheelId: string): boolean
    local wheel = Catalog.Wheels[wheelId]
    if not wheel then return false end
    local build = self.builds[player] or {}
    build.wheelId = wheelId
    self.builds[player] = build
    return true
end

function CustomizationService:setBodyKit(player: Player, kitId: string): boolean
    if not Catalog.BodyKits[kitId] then return false end
    local build = self.builds[player] or {}
    build.bodyKit = kitId
    self.builds[player] = build
    return true
end

function CustomizationService:setStance(player: Player, frontCamber: number, rearCamber: number, height: number): boolean
    if frontCamber < -8 or frontCamber > 2 then return false end
    if rearCamber < -8 or rearCamber > 2 then return false end
    if height < -0.10 or height > 0.10 then return false end

    local build = self.builds[player] or {}
    build.frontCamber = frontCamber
    build.rearCamber = rearCamber
    build.rideHeight = height
    self.builds[player] = build
    return true
end

function CustomizationService:get(player: Player)
    return self.builds[player] or {}
end

function CustomizationService:remove(player: Player)
    self.builds[player] = nil
end

return CustomizationService
