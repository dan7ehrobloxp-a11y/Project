--!strict


local Workspace = game:GetService("Workspace")
local Config = require(game.ReplicatedStorage.Shared.Config)

local Builder = {}

local function part(name: string, size: Vector3, cf: CFrame, material: Enum.Material, parent: Instance): Part
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.CFrame = cf
    p.Anchored = true
    p.Material = material
    p.Parent = parent
    return p
end

local function folder(name: string): Folder
    local f = Workspace:FindFirstChild(name)
    if not f then
        f = Instance.new("Folder")
        f.Name = name
        f.Parent = Workspace
    end
    return f
end

function Builder.buildHighway()
    local highway = folder("Highway")
    local width = Config.World.HighwayLanes * Config.World.HighwayLaneWidthStuds

    for i = 0, Config.World.HighwaySegments - 1 do
        local z = i * Config.World.HighwaySegmentLengthStuds
        part("Road_" .. i, Vector3.new(width, 1, Config.World.HighwaySegmentLengthStuds),
            CFrame.new(0, 0, -z), Enum.Material.Asphalt, highway)

        part("Median_" .. i, Vector3.new(8, 1.8, Config.World.HighwaySegmentLengthStuds),
            CFrame.new(0, 1, -z), Enum.Material.Concrete, highway)

        part("BarrierL_" .. i, Vector3.new(1, 2, Config.World.HighwaySegmentLengthStuds),
            CFrame.new(-width / 2 - 2, 1, -z), Enum.Material.Concrete, highway)

        part("BarrierR_" .. i, Vector3.new(1, 2, Config.World.HighwaySegmentLengthStuds),
            CFrame.new(width / 2 + 2, 1, -z), Enum.Material.Concrete, highway)
    end
end

function Builder.buildCarMeet()
    local meet = folder("CarMeet")
    part("MeetBase", Config.World.MeetSizeStuds, CFrame.new(0, -0.5, 300),
        Enum.Material.Asphalt, meet)

    for x = -250, 250, 50 do
        for z = 180, 420, 60 do
            local bay = part("DisplayBay", Vector3.new(42, 0.2, 52),
                CFrame.new(x, 0.1, z), Enum.Material.Concrete, meet)
            bay.Color = Color3.fromRGB(28, 30, 34)
        end
    end

    for x = -270, 270, 90 do
        local pole = part("StreetLight", Vector3.new(1, 18, 1),
            CFrame.new(x, 9, 300), Enum.Material.Metal, meet)
        local light = Instance.new("PointLight")
        light.Brightness = 2
        light.Range = 42
        light.Color = Color3.fromRGB(220, 235, 255)
        light.Parent = pole
    end
end

function Builder.buildDesert()
    local desert = folder("Desert")
    part("DesertGround", Vector3.new(Config.World.DesertWidthStuds, 2, Config.World.DesertWidthStuds),
        CFrame.new(0, -2, -5000), Enum.Material.Sand, desert)
end

Builder.buildHighway()
Builder.buildCarMeet()
Builder.buildDesert()

return Builder
