--!strict


local Players = game:GetService("Players")
local Constants = require(game.ReplicatedStorage.Shared.Constants)

local RaceService = {}
RaceService.__index = RaceService

function RaceService.new()
    return setmetatable({races = {}, playerRace = {}}, RaceService)
end

function RaceService:createRace(id: string, checkpoints: {BasePart}, raceType: "Drag" | "Highway" | "Drift")
    self.races[id] = {
        id = id,
        checkpoints = checkpoints,
        raceType = raceType,
        players = {},
    }
    return self.races[id]
end

function RaceService:join(player: Player, id: string)
    local race = self.races[id]
    if not race or self.playerRace[player] then return false end
    race.players[player] = {
        checkpoint = 0,
        started = false,
        startTime = os.clock(),
        finished = false,
    }
    self.playerRace[player] = race
    return true
end

function RaceService:checkpoint(player: Player, index: number)
    local race = self.playerRace[player]
    if not race then return false end
    local state = race.players[player]
    if not state or state.finished then return false end
    if index ~= state.checkpoint + 1 then return false end
    state.checkpoint = index
    if index >= #race.checkpoints then
        state.finished = true
        state.finishTime = os.clock() - state.startTime
        return true, state.finishTime
    end
    return true
end

function RaceService:leave(player: Player)
    local race = self.playerRace[player]
    if race then
        race.players[player] = nil
        self.playerRace[player] = nil
    end
end

return RaceService
