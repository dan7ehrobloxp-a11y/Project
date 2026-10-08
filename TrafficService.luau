--!strict


local RunService = game:GetService("RunService")

local TrafficService = {}
TrafficService.__index = TrafficService

function TrafficService.new()
    return setmetatable({
        vehicles = {},
        lanes = {},
        connection = nil,
    }, TrafficService)
end

function TrafficService:addLane(index: number, points: {BasePart})
    self.lanes[index] = points
end

function TrafficService:spawn(template: Model, laneIndex: number, startIndex: number)
    local points = self.lanes[laneIndex]
    if not points or not points[startIndex] then return nil end

    local model = template:Clone()
    model:PivotTo(points[startIndex].CFrame)
    model.Parent = workspace:FindFirstChild("Traffic") or workspace

    local state = {
        model = model,
        lane = laneIndex,
        index = startIndex,
        speed = 35 + math.random() * 18,
    }

    self.vehicles[model] = state
    return state
end

function TrafficService:step(dt: number)
    for model, state in pairs(self.vehicles) do
        local points = self.lanes[state.lane]
        if not model.Parent or not points then
            self.vehicles[model] = nil
            continue
        end

        local target = points[state.index + 1]
        if not target then
            state.index = 1
            target = points[1]
        end

        local root = model.PrimaryPart
        if not root then continue end

        local direction = (target.Position - root.Position)
        local distance = direction.Magnitude
        if distance < 8 then
            state.index += 1
        else
            local step = direction.Unit * math.min(state.speed * dt * 3.5714, distance)
            model:PivotTo(model:GetPivot() + step)
        end
    end
end

function TrafficService:start()
    self.connection = RunService.Heartbeat:Connect(function(dt)
        self:step(math.min(dt, 1 / 30))
    end)
end

function TrafficService:stop()
    if self.connection then
        self.connection:Disconnect()
        self.connection = nil
    end
end

return TrafficService
