--!strict


local Players = game:GetService("Players")

local AvatarService = {}

function AvatarService.getDescription(player: Player): HumanoidDescription?
    local ok, description = pcall(function()
        return Players:GetHumanoidDescriptionFromUserIdAsync(player.UserId)
    end)
    if ok and description then
        return description
    end
    return nil
end

function AvatarService.createModel(player: Player, parent: Instance): Model?
    local description = AvatarService.getDescription(player)
    if not description then return nil end

    local ok, model = pcall(function()
        return Players:CreateHumanoidModelFromDescriptionAsync(
            description,
            Enum.HumanoidRigType.R15,
            Enum.AssetTypeVerification.Always
        )
    end)
    if not ok or not model then return nil end

    model.Name = "Avatar_" .. player.UserId
    model.Parent = parent
    return model
end

return AvatarService
