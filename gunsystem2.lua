-- NOTE: keep this 'enum' in sync with GunActionType in gun_component.h
ACTION_TYPE_PROJECTILE	= 0
ACTION_TYPE_STATIC_PROJECTILE = 1
ACTION_TYPE_MODIFIER	= 2
ACTION_TYPE_DRAW_MANY	= 3
ACTION_TYPE_MATERIAL	= 4
ACTION_TYPE_OTHER		= 5
ACTION_TYPE_UTILITY		= 6
ACTION_TYPE_PASSIVE		= 7

local c = {
    action_id = "",
    action_name = "",
    action_description = "",
    action_sprite_filename = "",
    action_unidentified_sprite_filename = "data/ui_gfx/gun_actions/unidentified.png",
    action_type = ACTION_TYPE_PROJECTILE,
    action_spawn_level = "",
    action_spawn_probability = "",
    action_spawn_requires_flag = "",
    action_spawn_manual_unlock = false,
    action_max_uses = -1,
    custom_xml_file = "",
    action_mana_drain = 10,
    action_is_dangerous_blast = false,
    action_draw_many_count = 0,
    action_ai_never_uses = false,
    action_never_unlimited = false,
    state_shuffled = false,
    state_cards_drawn = 0,
    state_discarded_action = false,
    state_destroyed_action = false,
    fire_rate_wait = 0,
    speed_multiplier = 1.0,
    child_speed_multiplier = 1.0,
    dampening = 1,
    explosion_radius = 0,
    spread_degrees = 0,
    pattern_degrees = 0,
    screenshake = 0,
    recoil = 0,
    damage_melee_add = 0.0,
    damage_projectile_add = 0.0,
    damage_electricity_add = 0.0,
    damage_fire_add = 0.0,
    damage_explosion_add = 0.0,
    damage_ice_add = 0.0,
    damage_slice_add = 0.0,
    damage_healing_add = 0.0,
    damage_curse_add = 0.0,
    damage_drill_add = 0.0,
    damage_critical_chance = 0,
    damage_critical_multiplier = 0.0,
    explosion_damage_to_materials = 0,
    knockback_force = 0,
    reload_time = 0,
    lightning_count = 0,
    material = "",
    material_amount = 0,
    trail_material = "",
    trail_material_amount = 0,
    bounces = 0,
    gravity = 0,
    light = 0,
    blood_count_multiplier = 1.0,
    gore_particles = 0,
    ragdoll_fx = 0,
    friendly_fire = false,
    physics_impulse_coeff = 0,
    lifetime_add = 0,
    sprite = "",
    extra_entities = "",
    game_effect_entities = "",
    sound_loop_tag = "",
    projectile_file = ""
}

-- Load Ent + add velocity

-- Extra Ents
do
    local projectile = nil
    for extra_entity in string.gmatch(c.extra_entities, '([^,]+)') do
        local new_entity = EntityLoad(extra_entity)
        EntityAddChild(projectile, new_entity)
    end
end

-- todo: damage typed additions
local damage = ComponentGetValue2( projcomp, "damage" )
ComponentSetValue2( projcomp, "damage", damage * 1.5 )
for _, type in ipairs(damage_types) do
    local type_damage = ComponentObjectGetValue2(projcomp, "damage_by_type", type)
    ComponentObjectSetValue2(projcomp, "damage_by_type", type, type_damage * 1.5)
end


