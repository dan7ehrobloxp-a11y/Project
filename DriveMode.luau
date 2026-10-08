--!strict


local DriveMode = {}

function DriveMode.distribution(mode: "RWD" | "FWD" | "AWD", frontBias: number): (number, number)
    if mode == "RWD" then
        return 0, 1
    elseif mode == "FWD" then
        return 1, 0
    end
    local f = math.clamp(frontBias, 0, 1)
    return f, 1 - f
end

return DriveMode
