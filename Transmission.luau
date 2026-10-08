--!strict


local MathUtil = require(script.Parent.MathUtil)

local Transmission = {}

function Transmission.new(profile: any)
    local data = profile.transmission
    local state = {
        gear = 1,
        clutch = 1,
        shiftTimer = 0,
    }

    function state:ratio(): number
        return data.ratios[self.gear] or 0
    end

    function state:step(dt: number, rpm: number, throttle: number, speedMps: number): number
        self.shiftTimer = math.max(0, self.shiftTimer - dt)
        if self.shiftTimer > 0 then
            self.clutch = MathUtil.expApproach(self.clutch, 0, 25, dt)
            return 0
        end

        self.clutch = MathUtil.expApproach(self.clutch, 1, 18, dt)

        if throttle > 0.65 and rpm > 0.94 * 9000 and self.gear < data.gears then
            self.gear += 1
            self.shiftTimer = data.shiftTime
        elseif throttle < 0.12 and rpm < 1800 and self.gear > 1 then
            self.gear -= 1
            self.shiftTimer = data.shiftTime * 0.8
        elseif speedMps < 4 and throttle > 0.8 and self.gear > 1 then
            self.gear = 1
        end

        return self:ratio() * data.finalDrive * self.clutch
    end

    return state
end

return Transmission
