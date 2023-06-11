function shot(projectile_entity)
    local multiplier        = 1.0
    local ratio_best        = 1.0
    local protagonist_bonus = 1.0
    local shooter = GetUpdatedEntityID()
    local dmcs = EntityGetComponentIncludingDisabled(shooter, "DamageModelComponent") or {}
    local vscs = EntityGetComponent(shooter, "VariableStorageComponent") or {}
    for i=1, #vscs do
        if ComponentGetValue2( vscs[i], "name" ) == "protagonist_bonus" then
            protagonist_bonus = protagonist_bonus + ComponentGetValue2(vscs[i], "value_int")
            break
        end
    end
    for i=1,#dmcs do
        local hp = ComponentGetValue2(dmcs[i], "hp")
        local max_hp = ComponentGetValue2(dmcs[i], "max_hp")
        local hp_ratio = hp / max_hp
        if hp_ratio < ratio_best then
            ratio_best = hp_ratio
        end
    end
    local adjuted_ratio = (1 - ratio_best) ^ 1.5;
    multiplier = protagonist_bonus * adjuted_ratio;

    -- Damage affector for projectile comps
    local projectile = EntityGetFirstComponentIncludingDisabled(projectile_entity, "ProjectileComponent");
    if projectile then
        -- Set damage
        ComponentSetValue2(projectile, "damage", ComponentGetValue2(projectile, "damage") * multiplier)
        -- Set typed damage
        for _, type in ipairs({"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice"}) do
            local damage = ComponentObjectGetValue2(projectile, "damage_by_type", type)
            ComponentObjectSetValue2(projectile, "damage_by_type", type, damage * multiplier)
        end
        -- Set explosion damage
        ComponentObjectSetValue2(projectile, "config_explosion", "damage", ComponentObjectGetValue2(projectile, "config_explosion", "damage") * multiplier)
    end

    -- Damage affector for area damage comps
    local areacomps = EntityGetComponentIncludingDisabled(projectile_entity, "AreaDamageComponent") or {}
    for _, areacomp in ipairs(areacomps) do
        -- Set damage
        ComponentSetValue2(areacomp, "damage_per_frame", ComponentGetValue2(areacomp, "damage_per_frame") * multiplier);
    end

    -- Damage affector for lightning comps
    local lightning = EntityGetFirstComponentIncludingDisabled(projectile_entity, "LightningComponent");
    if lightning then
        -- Set damage
        ComponentObjectSetValue2(lightning, "config_explosion", "damage", ComponentObjectGetValue2(lightning, "config_explosion", "damage") * multiplier)
    end
end