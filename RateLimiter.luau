--!strict


local RateLimiter = {}
RateLimiter.__index = RateLimiter

function RateLimiter.new(maxPerSecond: number)
    return setmetatable({
        maxPerSecond = maxPerSecond,
        buckets = {},
    }, RateLimiter)
end

function RateLimiter:allow(userId: number): boolean
    local now = os.clock()
    local bucket = self.buckets[userId]
    if not bucket or now - bucket.start >= 1 then
        self.buckets[userId] = {start = now, count = 1}
        return true
    end
    if bucket.count >= self.maxPerSecond then
        return false
    end
    bucket.count += 1
    return true
end

function RateLimiter:remove(userId: number)
    self.buckets[userId] = nil
end

return RateLimiter
