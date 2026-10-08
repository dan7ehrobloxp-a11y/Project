--!strict


local Players = game:GetService("Players")

local SessionService = {}
SessionService.__index = SessionService

function SessionService.new()
    return setmetatable({sessions = {}}, SessionService)
end

function SessionService:create(player: Player)
    self.sessions[player] = {
        joinedAt = os.time(),
        lastVehicle = nil,
        currentRace = nil,
    }
    return self.sessions[player]
end

function SessionService:get(player: Player)
    return self.sessions[player]
end

function SessionService:remove(player: Player)
    self.sessions[player] = nil
end

return SessionService
