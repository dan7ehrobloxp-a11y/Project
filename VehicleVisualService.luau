--!strict


local VehicleVisualService = {}
VehicleVisualService.__index = VehicleVisualService

function VehicleVisualService.new()
    return setmetatable({}, VehicleVisualService)
end

local function setColor(root: Instance, color: Color3)
    for _, item in ipairs(root:GetDescendants()) do
        if item:IsA("BasePart") and item.Name:lower():find("paint") then
            item.Color = color
        end
    end
end

function VehicleVisualService:applyPaint(model: Model, primary: Color3, secondary: Color3)
    local body = model:FindFirstChild("Body")
    if body then
        setColor(body, primary)
    else
        setColor(model, primary)
    end

    local accents = model:FindFirstChild("Accents")
    if accents then
        setColor(accents, secondary)
    end
end

function VehicleVisualService:setHeadlights(model: Model, enabled: boolean)
    local lights = model:FindFirstChild("Lights")
    if not lights then return end

    for _, item in ipairs(lights:GetDescendants()) do
        if item:IsA("Light") then
            item.Enabled = enabled
        end
    end
end

function VehicleVisualService:setBrakeLights(model: Model, enabled: boolean)
    local lights = model:FindFirstChild("BrakeLights")
    if not lights then return end

    for _, item in ipairs(lights:GetDescendants()) do
        if item:IsA("BasePart") then
            item.Transparency = enabled and 0 or 0.25
        end
    end
end

return VehicleVisualService
