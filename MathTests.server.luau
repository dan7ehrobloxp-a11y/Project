--!strict


local MathUtil = require(game.ReplicatedStorage.Shared.MathUtil)

assert(MathUtil.clamp01(-1) == 0)
assert(MathUtil.clamp01(2) == 1)
assert(math.abs(MathUtil.lerp(0, 10, 0.5) - 5) < 1e-6)
assert(MathUtil.sign(-4) == -1)
assert(MathUtil.sign(0) == 0)
print("[PASS] MathTests")
