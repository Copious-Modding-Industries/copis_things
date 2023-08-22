local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
local projcomp = EntityGetFirstComponent(parent, "ProjectileComponent") --[[@cast projcomp number]]
local shooter = ComponentGetValue2(projcomp, "mWhoShot")
if EntityGetIsAlive(shooter) then
    --local velocity  = EntityGetFirstComponent(parent, "VelocityComponent") --[[@cast velocity number]]
    --local vx, vy = ComponentGetValue2( velocity, "mVelocity")
    --local vel = (vx*vx+vy*vy)^0.5
    local spec = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent")  --[[@cast spec number]]
    local px, py = EntityGetTransform(parent)
	local sx, sy = dofile_once("mods/copis_things/files/scripts/projectiles/wand_tip.lua")(shooter)
    local angle = math.atan2(sy-py, sx-px)
    local scale = (((sx-px)^2+(sy-py)^2)^0.5)
    ComponentSetValue2(spec, "count_min", scale/8)
    ComponentSetValue2(spec, "count_max", scale/8)
    ComponentSetValue2(spec, "randomize_position", 0, -0.5, scale, 0.5)
    EntitySetTransform(entity_id, px, py)
    EntitySetTransform(parent, px, py, angle)
else
    EntityKill(entity_id)
end