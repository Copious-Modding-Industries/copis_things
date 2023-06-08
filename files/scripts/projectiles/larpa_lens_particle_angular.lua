local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local px, py, pr, psx, psy = EntityGetTransform(parent_id)
EntitySetTransform(entity_id, px, py, math.random() * 2 * math.pi, psx, psy)

local pec = EntityGetFirstComponent(entity_id, "ParticleEmitterComponent")
if pec then
    local radius = ComponentGetValue2(pec, "x_pos_offset_max")
    local speed = ComponentGetValue2(pec, "y_vel_max")
    local force_const = (speed^2/radius)/radius
    ComponentSetValue2(pec, "attractor_force", force_const)
    ComponentSetValue2(pec, "friction", force_const / 60)
end