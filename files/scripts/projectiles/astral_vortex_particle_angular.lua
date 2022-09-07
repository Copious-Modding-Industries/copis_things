dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local parent = self:parent()
if parent ~= nil then
    local x, y, angle, sx, sy = parent:transform()
    angle = math.random() * 2 * math.pi
    -- angle = 0
    self:setTransform(x, y, angle, sx, sy)

    local pec = self.ParticleEmitterComponent
    local radius = pec.x_pos_offset_max
    local speed = pec.y_vel_max
    local f = speed ^ 2 / radius
    local force_const = f / radius
    pec.attractor_force = force_const
    pec.friction = force_const / 60
end