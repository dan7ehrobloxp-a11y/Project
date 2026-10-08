--!strict


local Differential = {}

function Differential.applyLimitedSlip(inputTorque: number, leftSpeed: number, rightSpeed: number, lockFactor: number): (number, number)
    local average = (leftSpeed + rightSpeed) * 0.5
    local correction = (average - leftSpeed - (average - rightSpeed)) * 0.5
    local bias = math.clamp(lockFactor, 0, 1)
    return inputTorque * 0.5 + correction * bias, inputTorque * 0.5 - correction * bias
end

function Differential.distributeAxles(totalTorque: number, frontBias: number): (number, number)
    local front = math.clamp(frontBias, 0, 1)
    return totalTorque * front, totalTorque * (1 - front)
end

return Differential
