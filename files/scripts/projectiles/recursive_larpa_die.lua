---@diagnostic disable: undefined-field
dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local host = self:parent()
if host then
    local x, y, angle, sx, sy = self:transform()
    local angle_rand = 15 * math.pi / 180
    angle = angle + 180 + (math.random() - 0.5) * angle_rand
    local offset = 5
    host:setTransform(x + offset * math.cos(angle), y + offset * math.sin(angle), angle, sx, sy)
    host.VelocityComponent.mVelocity = {x = math.cos(angle), y = math.sin(angle)}
    host.ProjectileComponent.mLastFrameDamaged = -1024
end

