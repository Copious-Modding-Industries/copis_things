local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
local projectile_file = nil
for i=1, #vscs do
    if ComponentGetValue( vscs[i], "name" ) == "projectile_file" then
        projectile_file = ComponentGetValue2( vscs[i], "value_string" )
        break
    end
end

if projectile_file then
    local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]

    -- Larpa Projectile
    local larpad = EntityLoad( projectile_file, x, y )
    local l_projcomp = EntityGetFirstComponent(larpad, "ProjectileComponent") --[[@cast l_projcomp number]]
    local l_velcomp = EntityGetFirstComponent(larpad, "VelocityComponent") --[[@cast l_velcomp number]]
    local l_damage_by_type = ComponentObjectGetMembers(projcomp, "damage_by_type") --[[@cast l_damage_by_type table]]
    local l_damage_critical = ComponentObjectGetMembers(projcomp, "damage_critical") --[[@cast l_damage_critical table]]
    local l_proj = ComponentGetMembers(l_projcomp) --[[@cast l_proj table]]

    local shooter = ComponentGetValue2(projcomp, "mWhoShot")
    local herd_id = ComponentGetValue2(projcomp, "mShooterHerdId")
    local c = ComponentObjectGetMembers(projcomp, "config") --[[@cast c table]]
    local ragdoll_map = {
        [0] = "NONE",
        [1] = "NORMAL",
        [2] = "BLOOD_EXPLOSION",
        [3] = "BLOOD_SPRAY",
        [4] = "FROZEN",
        [5] = "CONVERT_TO_MATERIAL",
        [6] = "CUSTOM_RAGDOLL_ENTITY",
        [7] = "DISINTEGRATED",
        [8] = "NO_RAGDOLL_FILE",
        [9] = "PLAYER_RAGDOLL_CAMERA",
    }

    local length = 400 * math.random(0.70,1.30) * c.speed_multiplier
    local rot = math.random() * (math.pi*2)
    local vel_x = math.cos(rot) * length
    local vel_y = math.sin(rot) * length
    local l_grav = ComponentGetValue2( l_velcomp, "gravity_y" )

    ComponentSetValue2( l_projcomp, "mEntityThatShot", entity_id )
    ComponentSetValue2( l_projcomp, "mWhoShot", shooter )
    ComponentSetValue2( l_projcomp, "mShooterHerdId", herd_id )
    ComponentSetValue2( l_velcomp, "mVelocity", vel_x, vel_y )
    ComponentSetValue2( l_velcomp, "gravity_y", l_grav+c.gravity )
	GameShootProjectile( shooter, x, y, x+vel_x, y+vel_y, entity_id, true, entity_id )

    -- Damages
    local null = c.damage_null_all >= math.random()
    ComponentSetValue2(l_projcomp,        "damage",                           null and 0 or (l_proj.damage                 + c.damage_projectile_add    ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "curse",        null and 0 or (l_damage_by_type.curse        + c.damage_curse_add         ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "drill",        null and 0 or (l_damage_by_type.drill        + c.damage_drill_add         ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "electricity",  null and 0 or (l_damage_by_type.electricity  + c.damage_electricity_add   ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "explosion",    null and 0 or (l_damage_by_type.explosion    + c.damage_explosion_add     ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "fire",         null and 0 or (l_damage_by_type.fire         + c.damage_fire_add          ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "healing",      null and 0 or (l_damage_by_type.healing      + c.damage_healing_add       ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "ice",          null and 0 or (l_damage_by_type.ice          + c.damage_ice_add           ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "melee",        null and 0 or (l_damage_by_type.melee        + c.damage_melee_add         ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "projectile",   null and 0 or (l_damage_by_type.projectile   + c.damage_projectile_add    ))
    ComponentObjectSetValue2(l_projcomp,  "damage_by_type",   "slice",        null and 0 or (l_damage_by_type.slice        + c.damage_slice_add         ))
    ComponentObjectSetValue2(l_projcomp,  "damage_critical",   "chance",               l_damage_critical.chance            + c.damage_critical_chance    )
    ComponentObjectSetValue2(l_projcomp,  "damage_critical",   "damage_multiplier",    l_damage_critical.damage_multiplier + c.damage_critical_multiplier)

    -- Extra Ents
    for seg in string.gmatch(c.extra_entities, "([^,]+)[,$]") do
        EntityLoadToEntity(seg, larpad)
    end

    ComponentSetValue2(projcomp, "lifetime", l_proj.lifetime + c.lifetime_add)
    ComponentSetValue2(projcomp, "lifetime", l_proj.bounces_left + c.bounces)
    ComponentSetValue2(projcomp, "friendly_fire", l_proj.friendly_fire or c.friendly_fire)
    ComponentSetValue2(projcomp, "ragdoll_fx_on_collision", ragdoll_map[c.ragdoll_fx])
    ComponentSetValue2(projcomp, "knockback_force", l_proj.knockback_force + c.knockback_force)
    ComponentSetValue2(projcomp, "knockback_force", l_proj.blood_count_multiplier * c.blood_count_multiplier)

    for key, value in pairs(c) do
        ComponentObjectSetValue2(projcomp, "config", key, value)
    end

    -- c.physics_impulse_coeff does NOTHING

    --[[
        c.lightning_count
        c.sprite
        c.explosion_damage_to_materials
        
        c.trail_material
        c.gore_particles
        c.game_effect_entities
        c.screenshake
        c.material
        c.explosion_radius
        c.light
        c.dampening
        c.trail_material_amount
        c.material_amount
    ]]

    -- TODO: drain mana VIA c.action_mana_drain

end