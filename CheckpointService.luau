--!strict


local CheckpointService = {}
CheckpointService.__index = CheckpointService

function CheckpointService.new()
    return setmetatable({routes = {}}, CheckpointService)
end

function CheckpointService:register(routeId: string, parts: {BasePart})
    self.routes[routeId] = {
        parts = parts,
        count = #parts,
    }
end

function CheckpointService:contains(routeId: string, index: number, position: Vector3): boolean
    local route = self.routes[routeId]
    local part = route and route.parts[index]
    if not part then return false end
    local localPosition = part.CFrame:PointToObjectSpace(position)
    return math.abs(localPosition.X) <= part.Size.X * 0.5
        and math.abs(localPosition.Y) <= part.Size.Y * 0.5 + 8
        and math.abs(localPosition.Z) <= part.Size.Z * 0.5
end

return CheckpointService
