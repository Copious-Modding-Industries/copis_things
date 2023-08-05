---@diagnostic disable-next-line: lowercase-global
function shot(projectile_entity)
    local shooter = GetUpdatedEntityID()
    local demolitionist_bonus = 1
    local vscs = EntityGetComponent(shooter, "VariableStorageComponent") or {}
    for i=1, #vscs do
        if ComponentGetValue2( vscs[i], "name" ) == "demolitionist_bonus" then
            demolitionist_bonus = demolitionist_bonus + ComponentGetValue2(vscs[i], "value_int")
            break
        end
    end
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
        for i=1,#values do
            local old_proj = ComponentObjectGetValue2(proj, "config_explosion", values[i])
            ComponentObjectSetValue2(proj, "config_explosion", values[i], old_proj * demolitionist_bonus)
        end
    end
    if lgtn ~= nil then
        for i=1,#values do
            local old_lgtn = ComponentObjectGetValue2(lgtn, "config_explosion", values[i])
            ComponentObjectSetValue2(lgtn, "config_explosion", values[i], old_lgtn * demolitionist_bonus)
        end
    end
end
