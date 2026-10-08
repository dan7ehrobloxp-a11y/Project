--!strict


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CustomizationController = {}
CustomizationController.__index = CustomizationController

function CustomizationController.new()
    return setmetatable({preview = nil}, CustomizationController)
end

function CustomizationController:setPaint(style: string, primary: Color3, secondary: Color3)
    ReplicatedStorage.Remotes.GarageAction:FireServer("Paint", {
        style = style,
        primary = primary,
        secondary = secondary,
    })
end

function CustomizationController:setWheels(wheelId: string)
    ReplicatedStorage.Remotes.GarageAction:FireServer("Wheels", wheelId)
end

function CustomizationController:setBodyKit(kitId: string)
    ReplicatedStorage.Remotes.GarageAction:FireServer("BodyKit", kitId)
end

function CustomizationController:setStance(front: number, rear: number, height: number)
    ReplicatedStorage.Remotes.GarageAction:FireServer("Stance", {
        frontCamber = front,
        rearCamber = rear,
        height = height,
    })
end

return CustomizationController
