--!strict


local SurfaceProfiles = require(game.ReplicatedStorage.Shared.SurfaceProfiles)

local SurfaceService = {}

function SurfaceService.getFromPart(part: BasePart): (number, number)
    local name = part:GetAttribute("SurfaceType")
    if typeof(name) ~= "string" then
        name = "Asphalt"
    end
    local profile = SurfaceProfiles[name] or SurfaceProfiles.Asphalt
    return profile.grip, profile.rolling
end

return SurfaceService
