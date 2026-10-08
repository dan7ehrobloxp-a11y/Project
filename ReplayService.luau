--!strict


local ReplayService = {}
ReplayService.__index = ReplayService

function ReplayService.new()
    return setmetatable({sessions = {}}, ReplayService)
end

function ReplayService:start(player: Player)
    self.sessions[player] = {
        started = os.clock(),
        samples = {},
    }
end

function ReplayService:sample(player: Player, model: Model)
    local session = self.sessions[player]
    local root = model.PrimaryPart
    if not session or not root then return end

    session.samples[#session.samples + 1] = {
        t = os.clock() - session.started,
        cf = root.CFrame,
    }

    if #session.samples > 7200 then
        table.remove(session.samples, 1)
    end
end

function ReplayService:stop(player: Player)
    local session = self.sessions[player]
    self.sessions[player] = nil
    return session
end

return ReplayService
