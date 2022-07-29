dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

function shot(proj_id)
    local self = Entity.Current()
    local x, y, angle = self:transform()
    local prey = Entity(self.AnimalAIComponent.mGreatestPrey)
    local px, py = prey:transform()
    local prey_angle = math.atan2(py - y, px - x)
    local projectile = Entity(proj_id)
    local vel = projectile.VelocityComponent.mVelocity
    local speed = math.sqrt(vel.x ^ 2 + vel.y ^ 2)
    local proj_angle = math.atan2(vel.y, vel.x)
    proj_angle = proj_angle + angle - prey_angle
    projectile.VelocityComponent.mVelocity = {
        x = speed * math.cos(proj_angle),
        y = speed * math.sin(proj_angle)
    }
end
