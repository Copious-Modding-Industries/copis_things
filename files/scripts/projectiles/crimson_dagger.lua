local entity_id = GetUpdatedEntityID()
local sprite    = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent")
local velocity  = EntityGetFirstComponent(entity_id, "VelocityComponent")
if sprite and velocity then
    local vx, vy = ComponentGetValue2( velocity, "mVelocity")
    local rot = math.atan2(vy, vx)
    ComponentSetValue2(sprite, "rotation", rot)
end
