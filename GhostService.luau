--!strict


local GhostService = {}
GhostService.__index = GhostService

function GhostService.new()
    return setmetatable({ghosts = {}}, GhostService)
end

function GhostService:record(player: Player, sample: any)
    local buffer = self.ghosts[player] or {}
    buffer[#buffer + 1] = {
        t = sample.t,
        cf = sample.cf,
        speed = sample.speed,
    }
    if #buffer > 3600 then
        table.remove(buffer, 1)
    end
    self.ghosts[player] = buffer
end

function GhostService:get(player: Player)
    return self.ghosts[player] or {}
end

function GhostService:clear(player: Player)
    self.ghosts[player] = nil
end

return GhostService
