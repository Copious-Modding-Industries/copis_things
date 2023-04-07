local entity_id = GetUpdatedEntityID()
local comps = EntityGetAllComponents(entity_id) or {}

local values_by_type = {
    VelocityComponent = {
        gravity_x = 0,
        gravity_y = 0,
        air_friction = 0,
        mass = 0,
        terminal_velocity = 1,
        apply_terminal_velocity = true,
        updates_velocity = true,
    },
    ProjectileComponent = {
        _enabled = true,
        lob_min = 0.8,
        lob_max = 1,
        speed_min = 20,
        speed_max = 20,
        direction_random_rad = 0,
        on_death_explode = false,
        on_death_gfx_leave_sprite = false,
        on_lifetime_out_explode = false,
        explosion_dont_damage_shooter = true,
        on_collision_die = false,
        die_on_liquid_collision = false,
        damage = 0,
        ragdoll_force_multiplier = 0,
        hit_particle_force_multiplier = 0,
        camera_shake_when_shot = 0,
        bounce_energy = 0,
        bounces_left = 0,
        muzzle_flash_file = "",
        shoot_light_flash_radius = 0,
        knockback_force = 0,
        physics_impulse_coeff = 0,
        penetrate_entities = true,
        penetrate_world = true,
        damage_every_x_frames = 25,
        collide_with_world = false,
    }
}
local objects_by_type = {
    ProjectileComponent = {
        config_explosion = {
            damage = 0.0,
            explosion_radius = 0
        },
    },
    VelocityComponent = {
    },
}

for i = 1, #comps do
    local comp = comps[i]
    local comp_type = ComponentGetTypeName(comp)
    if values_by_type[comp_type] ~= nil then
        for key, value in pairs(values_by_type[comp_type]) do
            ComponentSetValue2(comp, key, value)
        end
        for object, values in pairs(objects_by_type[comp_type]) do
            for key, value in pairs(objects_by_type[comp_type][object]) do
                ComponentObjectSetValue2(comp, object, key, value)
            end
        end
    else
        EntityRemoveComponent(entity_id, comp)
    end
end
