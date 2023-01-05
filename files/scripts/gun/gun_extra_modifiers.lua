--[[ ####################################################################################
    PERK
]]

extra_modifiers["copis_things_lead_boots"] = function()
    local chardatcomp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "CharacterDataComponent");
    if chardatcomp ~= nil then
        if ComponentGetValue2( chardatcomp, "is_on_ground" ) == true then
            shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10000;
        end
    end
end

extra_modifiers["copis_things_spell_efficiency"] = function()
    if current_action.uses_remaining > 0 and math.random() <= 0.33 then
        current_action.uses_remaining = current_action.uses_remaining + 1;
    end
end

extra_modifiers["copis_things_mana_efficiency"] = function()
    mana = math.ceil(mana + c.action_mana_drain * 0.667)
end

--[[ ####################################################################################
    ONHIT
]]

extra_modifiers["COPIS_THINGS_ON_DAMAGE_DAMAGE"] = function(recursion_level, iteration)
    c.damage_projectile_add = c.damage_projectile_add + 0.2
    c.gore_particles = c.gore_particles + 2.5
    c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
end

--[[ ####################################################################################
    BUFFS
]]

extra_modifiers["COPIS_THINGS_BUFF_RECHARGE"] = function(recursion_level, iteration)
    c.fire_rate_wait = c.fire_rate_wait - 20
    current_reload_time = current_reload_time - 40
end
