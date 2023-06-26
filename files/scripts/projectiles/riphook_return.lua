local entity_id = GetUpdatedEntityID()
local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
ComponentSetValue2(velcomp, "air_friction", 7)
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local shooter = ComponentGetValue2(projcomp, "mWhoShot")
local selfhit = false
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
for i = 1, #vscs do
    local comp = vscs[i]
    local name = ComponentGetValue2(comp, "name")
    if name == "riphook_victim" then
        selfhit = ComponentGetValue2(comp, "value_int") == shooter
        break
    end
end
if not selfhit then
    EntityAddComponent2(entity_id, "HomingComponent", {
        target_who_shot = true,
        homing_targeting_coeff = 30.0,
        homing_velocity_multiplier = 0.99,
        detect_distance = 69000,
    })
end