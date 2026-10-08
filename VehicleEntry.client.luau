--!strict


local Players = game:GetService("Players")

local VehicleEntry = {}
VehicleEntry.__index = VehicleEntry

function VehicleEntry.new()
    return setmetatable({lastSeat = nil}, VehicleEntry)
end

function VehicleEntry:update()
    local character = Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local seat = humanoid and humanoid.SeatPart

    if seat ~= self.lastSeat then
        self.lastSeat = seat
        if seat and seat:IsA("VehicleSeat") then
            self:onEntered(seat)
        else
            self:onExited()
        end
    end
end

function VehicleEntry:onEntered(seat: VehicleSeat)
    print("Entered vehicle:", seat:GetFullName())
end

function VehicleEntry:onExited()
    print("Exited vehicle")
end

return VehicleEntry
