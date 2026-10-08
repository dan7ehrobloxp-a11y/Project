--!strict


local DragHUD = {}
DragHUD.__index = DragHUD

function DragHUD.new()
    return setmetatable({gui = nil, lights = {}}, DragHUD)
end

function DragHUD:create(parentGui: ScreenGui)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(90, 300)
    frame.Position = UDim2.new(0.5, -45, 0.2, 0)
    frame.BackgroundTransparency = 0.2
    frame.Parent = parentGui

    for i = 1, 5 do
        local light = Instance.new("Frame")
        light.Size = UDim2.fromOffset(50, 50)
        light.Position = UDim2.fromOffset(20, 10 + (i - 1) * 55)
        light.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        light.Parent = frame
        self.lights[i] = light
    end

    self.gui = frame
    return frame
end

function DragHUD:set(index: number, color: Color3)
    local light = self.lights[index]
    if light then light.BackgroundColor3 = color end
end

return DragHUD
