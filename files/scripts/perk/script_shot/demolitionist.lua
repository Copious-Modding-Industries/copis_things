function shot(projectile_entity)
    local shooter = GetUpdatedEntityID()
    local vsc = EntityGetFirstComponentIncludingDisabled(shooter, "VariableStorageComponent", "demolitionist_bonus");
    local demolitionist_bonus = ComponentGetValue2(vsc, "value_int") + 1
    local proj = EntityGetFirstComponentIncludingDisabled(projectile_entity, "ProjectileComponent");
    local lgtn = EntityGetFirstComponentIncludingDisabled(projectile_entity, "LightningComponent");
    local values = {
        "knockback_force",
        "explosion_radius",
        "max_durability_to_destroy",
        "ray_energy",
        "cell_explosion_power",
        "cell_explosion_radius_min",
        "cell_explosion_radius_max",
        "cell_explosion_velocity_min",
        "cell_explosion_damage_required",
        "cell_explosion_probability",
        "cell_explosion_power_ragdoll_coeff",
    }
    if proj ~= nil then
        for _, value in ipairs(values) do
            local old_proj = ComponentObjectGetValue2(proj, "config_explosion", value)
            ComponentObjectSetValue2(proj, "config_explosion", value, old_proj * demolitionist_bonus)
        end
    end
    if lgtn ~= nil then
        for _, value in ipairs(values) do
            local old_lgtn = ComponentObjectGetValue2(lgtn, "config_explosion", value)
            ComponentObjectSetValue2(lgtn, "config_explosion", value, old_lgtn * demolitionist_bonus)
        end
    end
end
