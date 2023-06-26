local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
if ComponentGetValue2(projcomp, "friendly_fire") then
    local shooter = ComponentGetValue2(projcomp, "mWhoShot")

    local hitfxs = EntityGetComponent(entity_id, "HitEffectComponent") or {}
    for i=1,#hitfxs do
        if ComponentGetValue2(hitfxs[i], "value_string") == "mods/copis_things/files/entities/misc/effect_riphook_hit.xml" then
            EntityRemoveComponent(entity_id, hitfxs[i])
            break
        end
    end

    -- Halve damage and set hit frames to 1 in 42
    local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice"}
    ComponentSetValue2(projcomp, "damage_every_x_frames", 42)
    ComponentSetValue2(projcomp, "damage", ComponentGetValue2(projcomp,"damage")/2)
    for i=1,#damage_types do
        ComponentObjectSetValue2(projcomp, "damage_by_type", damage_types[i], ComponentObjectGetValue2(projcomp,"damage_by_type",damage_types[i])/2)
    end

    local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
    ComponentSetValue2(velcomp, "gravity_y", 0)
    EntitySetName(entity_id, "riphook_hit")

    -- Add all components to the hook in question
    EntityAddComponent2(entity_id, "VariableStorageComponent", {
        name = "riphook_victim",
        value_int = shooter
    })
    EntityAddComponent2(entity_id, "LuaComponent", {
        execute_every_n_frame=1,
        script_source_file = "mods/copis_things/files/scripts/projectiles/riphook_handler.lua"
    })
    -- TODO: fake bleeding particle emitter on axe entity + get the victim's blood material and splatter a bit of it
end