--!strict


local TelemetryService = {}
TelemetryService.__index = TelemetryService

function TelemetryService.new()
    return setmetatable({history = {}}, TelemetryService)
end

function TelemetryService:push(player: Player, telemetry: any)
    local h = self.history[player] or {}
    h[#h + 1] = {
        t = os.clock(),
        speed = telemetry.speedKph,
        rpm = telemetry.rpm,
        gear = telemetry.gear,
        yaw = telemetry.yawRate,
    }
    if #h > 300 then table.remove(h, 1) end
    self.history[player] = h
end

function TelemetryService:get(player: Player)
    return self.history[player] or {}
end

return TelemetryService
