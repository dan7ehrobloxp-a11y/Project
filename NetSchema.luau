--!strict


local NetSchema = {}

function NetSchema.number(value: any, min: number, max: number): (boolean, number?)
    if typeof(value) ~= "number" or value ~= value then
        return false, nil
    end
    if value < min or value > max then
        return false, nil
    end
    return true, value
end

function NetSchema.boolean(value: any): (boolean, boolean?)
    if typeof(value) ~= "boolean" then return false, nil end
    return true, value
end

function NetSchema.driveMode(value: any): (boolean, "RWD" | "FWD" | "AWD"?)
    if value == "RWD" or value == "FWD" or value == "AWD" then
        return true, value
    end
    return false, nil
end

return NetSchema
