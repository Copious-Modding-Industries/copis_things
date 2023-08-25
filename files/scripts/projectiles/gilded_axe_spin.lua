local entity_id = GetUpdatedEntityID()
local sprite    = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent")
local velocity  = EntityGetFirstComponent(entity_id, "VelocityComponent")
if sprite and velocity then
    local rot = ComponentGetValue2(sprite, "rotation")
    local vx, vy = ComponentGetValue2( velocity, "mVelocity")
    local vel = (vx*vx+vy*vy)^0.5
    local add = (GameGetFrameNum()/3)%(2*math.pi)*((vel^0.8)/100)
    ComponentSetValue2(sprite, "rotation", rot+add)
end
