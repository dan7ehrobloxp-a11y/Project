--!strict


local Constants = require(game.ReplicatedStorage.Shared.Constants)

local DragService = {}
DragService.__index = DragService

function DragService.new()
    return setmetatable({sessions = {}}, DragService)
end

function DragService:create(id: string, startPart: BasePart, finishPart: BasePart)
    self.sessions[id] = {
        id = id,
        start = startPart,
        finish = finishPart,
        racers = {},
        state = "Idle",
    }
    return self.sessions[id]
end

function DragService:stage(player: Player, id: string)
    local s = self.sessions[id]
    if not s then return false end
    s.racers[player] = {staged = true, launchTime = nil, finishTime = nil}
    return true
end

function DragService:green(id: string)
    local s = self.sessions[id]
    if not s then return end
    s.state = "Green"
    s.greenTime = os.clock()
    for _, racer in pairs(s.racers) do
        racer.launchTime = nil
    end
end

function DragService:recordFinish(player: Player)
    for _, s in pairs(self.sessions) do
        local racer = s.racers[player]
        if racer and s.state == "Green" and not racer.finishTime then
            racer.finishTime = os.clock()
            racer.elapsed = racer.finishTime - s.greenTime
            return racer.elapsed
        end
    end
    return nil
end

return DragService
