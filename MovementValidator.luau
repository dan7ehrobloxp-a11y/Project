--!strict


local Players = game:GetService("Players")
local Constants = require(game.ReplicatedStorage.Shared.Constants)
local Units = require(game.ReplicatedStorage.Shared.Units)

local MovementValidator = {}
MovementValidator.__index = MovementValidator

function MovementValidator.new()
    return setmetatable({samples = {}, strikes = {}}, MovementValidator)
end

function MovementValidator:remove(player: Player)
    self.samples[player] = nil
    self.strikes[player] = nil
end

function MovementValidator:sample(player: Player, root: BasePart): boolean
    if not root or not root:IsDescendantOf(workspace) then return false end
    local now = os.clock()
    local previous = self.samples[player]
    self.samples[player] = {position = root.Position, time = now, velocity = root.AssemblyLinearVelocity}

    if not previous then return true end
    local dt = math.max(now - previous.time, 1 / 240)
    local displacement = (root.Position - previous.position).Magnitude
    local observedSpeed = Units.studsToMeters(displacement / dt)
    local reportedSpeed = Units.studsToMeters(root.AssemblyLinearVelocity.Magnitude)
    local plausible = reportedSpeed < 140 and observedSpeed < reportedSpeed * Constants.Security.VelocityTolerance + 45

    if displacement > Constants.Security.TeleportToleranceStuds then
        plausible = false
    end

    if not plausible then
        self.strikes[player] = (self.strikes[player] or 0) + 1
    else
        self.strikes[player] = math.max((self.strikes[player] or 0) - 0.02, 0)
    end

    return plausible
end

return MovementValidator
