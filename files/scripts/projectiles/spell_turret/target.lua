local self = GetUpdatedEntityID()
local parent = EntityGetParent(self)
if parent == nil or parent == 0 then
    return
end
local x, y, angle = EntityGetTransform(parent)
local dist = 30
EntitySetTransform(self, x + dist * math.cos(angle), y + dist * math.sin(angle))
