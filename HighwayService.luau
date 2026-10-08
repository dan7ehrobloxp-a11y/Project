--!strict


local HighwayService = {}
HighwayService.__index = HighwayService

function HighwayService.new(raceService)
    return setmetatable({raceService = raceService, routes = {}}, HighwayService)
end

function HighwayService:registerRoute(id: string, checkpoints: {BasePart})
    self.routes[id] = {id = id, checkpoints = checkpoints}
end

function HighwayService:getRoute(id: string)
    return self.routes[id]
end

return HighwayService
