--!strict


local UserInputService = game:GetService("UserInputService")

local InputController = {}
InputController.__index = InputController

function InputController.new()
    return setmetatable({
        throttle = 0,
        brake = 0,
        steer = 0,
        handbrake = false,
        mode = "AWD",
    }, InputController)
end

function InputController:start()
    self.began = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then self.throttle = 1 end
        if input.KeyCode == Enum.KeyCode.S then self.brake = 1 end
        if input.KeyCode == Enum.KeyCode.Space then self.handbrake = true end
        if input.KeyCode == Enum.KeyCode.One then self.mode = "RWD" end
        if input.KeyCode == Enum.KeyCode.Two then self.mode = "AWD" end
        if input.KeyCode == Enum.KeyCode.Three then self.mode = "FWD" end
    end)

    self.ended = UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then self.throttle = 0 end
        if input.KeyCode == Enum.KeyCode.S then self.brake = 0 end
        if input.KeyCode == Enum.KeyCode.Space then self.handbrake = false end
    end)
end

function InputController:update()
    local left = UserInputService:IsKeyDown(Enum.KeyCode.A)
    local right = UserInputService:IsKeyDown(Enum.KeyCode.D)
    self.steer = (right and 1 or 0) - (left and 1 or 0)
end

function InputController:destroy()
    if self.began then self.began:Disconnect() end
    if self.ended then self.ended:Disconnect() end
end

return InputController
