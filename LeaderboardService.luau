--!strict


local OrderedDataStoreService = game:GetService("DataStoreService")

local LeaderboardService = {}
LeaderboardService.__index = LeaderboardService

function LeaderboardService.new(prefix: string)
    return setmetatable({prefix = prefix, stores = {}}, LeaderboardService)
end

function LeaderboardService:getStore(route: string)
    local store = self.stores[route]
    if not store then
        store = OrderedDataStoreService:GetOrderedDataStore(self.prefix .. "_" .. route)
        self.stores[route] = store
    end
    return store
end

function LeaderboardService:submit(route: string, userId: number, milliseconds: number): boolean
    if milliseconds <= 0 then return false end
    local store = self:getStore(route)
    local ok = pcall(function()
        store:UpdateAsync(tostring(userId), function(old)
            if not old or milliseconds < old then return milliseconds end
            return old
        end)
    end)
    return ok
end

return LeaderboardService
