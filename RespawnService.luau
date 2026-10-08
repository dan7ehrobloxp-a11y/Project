--!strict


local RespawnService = {}
RespawnService.__index = RespawnService

function RespawnService.new(spawner)
    return setmetatable({spawner = spawner, cooldown = {}}, RespawnService)
end

function RespawnService:request(player: Player, vehicleId: string, spawnPart: BasePart): boolean
    local now = os.clock()
    if now - (self.cooldown[player] or 0) < 3 then
        return false
    end

    self.cooldown[player] = now
    self.spawner:despawn(player)
    return self.spawner:spawn(player, vehicleId, spawnPart) ~= nil
end

return RespawnService
