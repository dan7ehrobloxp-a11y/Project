--!strict


local EconomyService = {}
EconomyService.__index = EconomyService

function EconomyService.new()
    return setmetatable({balances = {}}, EconomyService)
end

function EconomyService:set(player: Player, amount: number)
    self.balances[player.UserId] = math.max(0, math.floor(amount))
end

function EconomyService:get(player: Player): number
    return self.balances[player.UserId] or 0
end

function EconomyService:add(player: Player, amount: number)
    if amount <= 0 then return false end
    self:set(player, self:get(player) + amount)
    return true
end

function EconomyService:spend(player: Player, amount: number): boolean
    if amount <= 0 or self:get(player) < amount then return false end
    self:set(player, self:get(player) - amount)
    return true
end

return EconomyService
