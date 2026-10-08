--!strict


local Sanity = {}

function Sanity.finiteVector(v: Vector3): boolean
    return v.X == v.X and v.Y == v.Y and v.Z == v.Z
end

function Sanity.finiteCFrame(cf: CFrame): boolean
    return Sanity.finiteVector(cf.Position)
        and cf.LookVector.X == cf.LookVector.X
        and cf.LookVector.Y == cf.LookVector.Y
        and cf.LookVector.Z == cf.LookVector.Z
end

return Sanity
