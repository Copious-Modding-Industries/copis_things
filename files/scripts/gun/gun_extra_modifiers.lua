extra_modifiers["copis_things_no_recoil"] = function()
	shot_effects.recoil_knockback = -999999;
end
--[[
extra_modifiers["copis_things_spell_efficiency"] = function()
    if current_action.uses_remaining > 0 and Random() <= MISC.PerkOptions.SpellEfficiency.RetainChance then
        current_action.uses_remaining = current_action.uses_remaining + 1;
    end
end
]]
extra_modifiers["copis_things_mana_efficiency"] = function()
    mana = mana + c.action_mana_drain * 0.667
end

extra_modifiers["copis_things_no_recoil"] = function()
	shot_effects.recoil_knockback = -999999;
end


-- On crit effects

extra_modifiers["COPIS_THINGS_ON_CRIT_DAMAGE"] = function (recursion_level, iteration)
    c.damage_projectile_add = c.damage_projectile_add + 0.4
    c.gore_particles        = c.gore_particles + 5
    c.fire_rate_wait        = c.fire_rate_wait + 5
    c.extra_entities        = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
    shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
end

extra_modifiers["COPIS_THINGS_ON_CRIT_RECHARGE"] = function (recursion_level, iteration)
    c.fire_rate_wait        = c.fire_rate_wait - 10
    current_reload_time     = current_reload_time - 20
end

extra_modifiers["COPIS_THINGS_ON_CRIT_SPEED"] = function (recursion_level, iteration)
    c.speed_multiplier = c.speed_multiplier * 2.5

    if ( c.speed_multiplier >= 20 ) then
    c.speed_multiplier = math.min( c.speed_multiplier, 20 )
    elseif ( c.speed_multiplier < 0 ) then
    c.speed_multiplier = 0
    end
end

extra_modifiers["COPIS_THINGS_ON_CRIT_PIERCING"] = function (recursion_level, iteration)
    c.damage_projectile_add = c.damage_projectile_add - 0.6
    c.extra_entities        = c.extra_entities .. "data/entities/misc/piercing_shot.xml,"
    c.friendly_fire         = true
end

-- On damage effects

extra_modifiers["COPIS_THINGS_ON_DAMAGE_DAMAGE"] = function (recursion_level, iteration)
    c.damage_projectile_add = c.damage_projectile_add + 0.2
    c.gore_particles        = c.gore_particles + 2.5
    c.extra_entities        = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
end

-- buff spells

extra_modifiers["COPIS_THINGS_BUFF_RECHARGE"] = function (recursion_level, iteration)
    c.fire_rate_wait        = c.fire_rate_wait - 20
    current_reload_time     = current_reload_time - 40
end