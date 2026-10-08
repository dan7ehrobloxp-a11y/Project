--!strict


local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local PersistenceService = {}
PersistenceService.__index = PersistenceService

function PersistenceService.new(name: string)
    return setmetatable({
        store = DataStoreService:GetDataStore(name),
        cache = {},
    }, PersistenceService)
end

function PersistenceService:load(player: Player)
    local ok, data = pcall(function()
        return self.store:GetAsync("u_" .. player.UserId)
    end)
    if ok and typeof(data) == "table" then
        self.cache[player] = data
    else
        self.cache[player] = {
            Cash = 25000,
            OwnedVehicles = {"ApexR", "SlideK", "NovaS", "TitanX"},
            Tuning = {},
            BestTimes = {},
        }
    end
    return self.cache[player]
end

function PersistenceService:save(player: Player)
    local data = self.cache[player]
    if not data then return false end
    local ok = pcall(function()
        self.store:UpdateAsync("u_" .. player.UserId, function()
            return data
        end)
    end)
    return ok
end

function PersistenceService:remove(player: Player)
    self.cache[player] = nil
end

return PersistenceService
