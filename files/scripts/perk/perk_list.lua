to_insert =
{
    --  Health multiplication (GROSS)
    --[[
    {
        id = "COPIS_THINGS_MULTIPLY_HP",
        ui_name = "$perk_name_copis_things_multiply_hp",
        ui_description = "$perk_desc_copis_things_multiply_hp",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/multiply_hp.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/multiply_hp.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for i, damagemodel in ipairs(damagemodels) do
                    local hp = ComponentGetValue2(damagemodel, "hp") * 3
                    local max_hp = ComponentGetValue2(damagemodel, "max_hp") * 3
                    ComponentSetValue2(damagemodel, "max_hp", max_hp)
                    ComponentSetValue2(damagemodel, "max_hp_cap", max_hp)
                    ComponentSetValue2(damagemodel, "hp", hp)
                end
            end
        end,
        func_remove = function(entity_who_picked)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for i, damagemodel in ipairs(damagemodels) do
                    local hp = ComponentGetValue2(damagemodel, "hp") / 3
                    local max_hp = ComponentGetValue2(damagemodel, "max_hp") / 3
                    ComponentSetValue2(damagemodel, "max_hp", max_hp)
                    ComponentSetValue2(damagemodel, "max_hp_cap", 0)
                    ComponentSetValue2(damagemodel, "hp", hp)
                end
            end
        end,
    },]]
    --  Acimorphism
    {
        id = "COPIS_THINGS_POLY_TO_ACID",
        author = "Copi",
        ui_name = "$perk_name_copis_things_poly_to_acid",
        ui_description = "$perk_desc_copis_things_poly_to_acid",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/poly_to_acid.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/poly_to_acid.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local x, y = EntityGetTransform(entity_who_picked)
            local child_id = EntityLoad("mods/copis_things/files/entities/misc/perk/poly_to_acid.xml", x, y)
            EntityAddTag(child_id, "perk_entity")
            EntityAddChild(entity_who_picked, child_id)
        end,
    },
    --  Mana efficiency
    {
        id = "COPIS_THINGS_MANA_EFFICIENCY",
        author = "Copi",
        ui_name = "$perk_name_copis_things_mana_efficiency",
        ui_description = "$perk_desc_copis_things_mana_efficiency",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/mana_efficiency.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/mana_efficiency.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        run_on_clients = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
            local vid = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "mana_efficiency_mult" then
                    vid = vscs[i]
                    break
                end
            end
            if vid then
                ComponentSetValue2(vid, "value_float", ComponentGetValue2(vid, "value_float") * 2/3)
            else
                local perk = EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    name = "mana_efficiency_mult",
                    _tags = "perk_component",
                    value_float = 2/3
                })
            end
        end,
    },
    --  Short temper
    {
        id = "COPIS_THINGS_SHORT_TEMPER",
        author = "Copi",
        ui_name = "$perk_name_copis_things_short_temper",
        ui_description = "$perk_desc_copis_things_short_temper",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/short_temper.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/short_temper.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/short_temper.lua"
            })
        end,
    },
    --  Swapper
    {
        id = "COPIS_THINGS_SWAPPER",
        author = "Copi",
        ui_name = "$perk_name_copis_things_swapper",
        ui_description = "$perk_desc_copis_things_swapper",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/swapper.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/swapper.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/swapper.lua"
            })
            local dmcs = EntityGetComponent(entity_who_picked, "DamageModelComponent") or {}
            for i=1,#dmcs do
                local res = ComponentObjectGetValue2(dmcs[i], "damage_multipliers", "projectile")
                ComponentObjectSetValue2(dmcs[i], "damage_multipliers", "projectile", res*.8)
            end
        end,
    },
    --  Fragile Ego
    {
        id = "COPIS_THINGS_FRAGILE_EGO",
        author = "Copi",
        ui_name = "$perk_name_copis_things_fragile_ego",
        ui_description = "$perk_desc_copis_things_fragile_ego",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/fragile_ego.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/fragile_ego.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for _, damagemodel in ipairs(damagemodels) do
                    local multipliers = {
                        ice = 0.25,
                        electricity = 0.25,
                        radioactive = 0.25,
                        slice = 0.25,
                        projectile = 0.25,
                        healing = 0.25,
                        physics_hit = 0.25,
                        explosion = 0.25,
                        poison = 0.25,
                        melee = 0.25,
                        drill = 0.25,
                        fire = 0.25,
                    }
                    for damage_type, multiplier in pairs(multipliers) do
                        local resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", damage_type);
                        resistance = resistance * multiplier;
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", damage_type, resistance);
                    end
                end
            end
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/fragile_ego.lua"
            })
        end,
        func_remove = function(entity_who_picked)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for damagemodel in damagemodels do
                    local multipliers = {
                        "ice",
                        "electricity",
                        "radioactive",
                        "slice",
                        "projectile",
                        "healing",
                        "physics_hit",
                        "explosion",
                        "poison",
                        "melee",
                        "drill",
                        "fire",
                    }
                    for _, damage_type in pairs(multipliers) do
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", damage_type, 1);
                    end
                end
            end
        end,
    },
    --  Golden Blood
    {
        id = "COPIS_THINGS_GOLDEN_BLOOD",
        author = "Copi",
        ui_name = "$perk_name_copis_things_golden_blood",
        ui_description = "$perk_desc_copis_things_golden_blood",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/golden_blood.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/golden_blood.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)

            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for i, damagemodel in ipairs(damagemodels) do

                    ComponentSetValue2(damagemodel, "blood_material", "gold");
                    ComponentSetValue2(damagemodel, "blood_spray_material", "gold");
                    ComponentSetValue2(damagemodel, "blood_multiplier", 0.2);
                    ComponentSetValue2(damagemodel, "blood_sprite_directional", "data/particles/bloodsplatters/bloodsplatter_directional_yellow_$[1-3].xml");
                    ComponentSetValue2(damagemodel, "blood_sprite_large", "data/particles/bloodsplatters/bloodsplatter_yellow_$[1-3].xml");

                    local projectile_resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", "projectile"))
                    projectile_resistance = projectile_resistance * 0.9
                    ComponentObjectSetValue(damagemodel, "damage_multipliers", "projectile", tostring(projectile_resistance))
                end
            end

        end,
        func_remove = function(entity_who_picked)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for i, damagemodel in ipairs(damagemodels) do
                    ComponentSetValue(damagemodel, "blood_material", "blood")
                    ComponentSetValue(damagemodel, "blood_spray_material", "blood")
                    ComponentSetValue(damagemodel, "blood_multiplier", "1.0")
                    ComponentSetValue(damagemodel, "blood_sprite_directional", "")
                    ComponentSetValue(damagemodel, "blood_sprite_large", "")
                    ComponentObjectSetValue(damagemodel, "damage_multipliers", "projectile", "1.0")
                end
            end
        end,
    },
    {
        id = "COPIS_THINGS_REGRESSION_SCALES",
        author = "Copi",
        ui_name = "$perk_name_copis_things_regression_scales",
        ui_description = "$perk_desc_copis_things_regression_scales",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/regression_scales.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/regression_scales.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            -- TODO - this should work - seems to work
            GlobalsSetValue("TEMPLE_PERK_REROLL_COUNT", tostring(0))
            local perk_count = tonumber(GlobalsGetValue("TEMPLE_PERK_COUNT", "3"))
            perk_count = math.max(perk_count - 1, 1)
            GlobalsSetValue("TEMPLE_PERK_COUNT", tostring(perk_count))
        end,
        func_remove = function(entity_who_picked)
            -- TODO - this should work - seems to work
            GlobalsSetValue("TEMPLE_PERK_COUNT", "3")
        end,
    },
    --  Protection Lottery
    {
        id = "COPIS_THINGS_PROTECTION_LOTTERY",
        author = "Copi",
        ui_name = "$perk_name_copis_things_protection_lottery",
        ui_description = "$perk_desc_copis_things_protection_lottery",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/protection_lottery.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/protection_lottery.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for _, damagemodel in ipairs(damagemodels) do
                    local multipliers = {
                        "ice",
                        "electricity",
                        "radioactive",
                        "slice",
                        "projectile",
                        "healing",
                        "physics_hit",
                        "explosion",
                        "poison",
                        "melee",
                        "drill",
                        "fire",
                    }
                    for i=1, #multipliers do
                        local resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", multipliers[i]);
                        resistance = math.max(0, resistance * (math.random(50, 125) / 100));
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", multipliers[i], resistance)
                    end
                end
            end

            local effects = {
                "PROTECTION_FIRE",
                "PROTECTION_RADIOACTIVITY",
                "PROTECTION_EXPLOSION",
                "PROTECTION_MELEE",
                "PROTECTION_ELECTRICITY",
            }

            local children = EntityGetAllChildren(entity_who_picked) or {}
            for i = 1, #children do
                local effect = EntityGetFirstComponent(children[i], "GameEffectComponent")
                if effect ~= nil then
                    if #effects < 1 then
                        break
                    end
                    for j = 1, #effects do
                        if ComponentGetValue2(effect, "effect") == effects[j] then
                            table.remove(effects, j)
                            break
                        end
                    end
                end
            end

            if #effects > 0 then
                local effect_type = effects[math.random(1, #effects)]
                local effect = EntityCreateNew("PROT_LOTTERY_EFFECT")
                EntityAddTag(effect, "perk_entity")
                EntityAddComponent2(effect, "GameEffectComponent", {
                    effect=effect_type,
                    frames=-1
                })
                EntityAddChild(entity_who_picked, effect)
            end

        end,
        func_remove = function(entity_who_picked)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for damagemodel in damagemodels do
                    local multipliers = {
                        "ice",
                        "electricity",
                        "radioactive",
                        "slice",
                        "projectile",
                        "healing",
                        "physics_hit",
                        "explosion",
                        "poison",
                        "melee",
                        "drill",
                        "fire",
                    }
                    for _, damage_type in pairs(multipliers) do
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", damage_type, 1);
                    end
                end
            end
        end,
    },
    -- Resilience
    {
        id = "COPIS_THINGS_RESILIENCE",
        author = "Copi",
        ui_name = "$perk_name_copis_things_resilience",
        ui_description = "$perk_desc_copis_things_resilience",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/resilience.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/resilience.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for _, damagemodel in ipairs(damagemodels) do
                    local multipliers = {
                        fire = 0.5,
                        radioactive = 0.5,
                        poison = 0.5,
                        electricity = 0.5,
                    }
                    for damage_type, multiplier in pairs(multipliers) do
                        local resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", damage_type);
                        resistance = resistance * multiplier;
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", damage_type, resistance);
                    end
                end
            end
        end,
        func_remove = function(entity_who_picked)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for damagemodel in damagemodels do
                    local multipliers = {
                        "electricity",
                        "radioactive",
                        "poison",
                        "fire",
                    }
                    for _, damage_type in pairs(multipliers) do
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", damage_type, 1);
                    end
                end
            end
        end,
    },
    -- Spell efficiency
    {
        id = "COPIS_THINGS_SPELL_EFFICIENCY",
        author = "Copi",
        ui_name = "$perk_name_copis_things_spell_efficiency",
        ui_description = "$perk_desc_copis_things_spell_efficiency",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/spell_efficiency.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/spell_efficiency.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "ShotEffectComponent", {
                _tags = "perk_component",
                extra_modifier = "copis_things_spell_efficiency"
            })
        end,
    },
    --  Protagonist
    {
        id = "COPIS_THINGS_PROTAGONIST",
        author = "Copi",
        ui_name = "$perk_name_copis_things_protagonist",
        ui_description = "$perk_desc_copis_things_protagonist",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/protagonist.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/protagonist.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)

            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
            local vid = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "protagonist_bonus" then
                    vid = vscs[i]
                    break
                end
            end
            if vid then
                ComponentSetValue2(vid, "value_float", ComponentGetValue2(vid, "value_float") + 2.0)
            else
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_shot = "mods/copis_things/files/scripts/perk/script_shot/protagonist.lua"
                })
                EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    _tags = "perk_component",
                    name = "protagonist_bonus",
                    value_float = 2.0
                })
            end
        end,
    },
    --  Spell Jam
    {
        id = "COPIS_THINGS_SPELL_JAM",
        author = "Copi",
        ui_name = "$perk_name_copis_things_spell_jam",
        ui_description = "$perk_desc_copis_things_spell_jam",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/spell_jam.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/spell_jam.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = false,
        one_off_effect = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local spells = {}

            -- Get spells inventory
            local children = EntityGetAllChildren(entity_who_picked) or {}
            for i=1,#children do
                if (EntityGetName(children[i]) == "inventory_full") then

                    -- Gather all spells in inventory
                    local inventory_items = EntityGetAllChildren(children[i]) or {}
                    for j=1,#inventory_items do
                        if EntityHasTag(inventory_items[j], "card_action") then
                            spells[#spells+1] = inventory_items[j]
                        end
                    end
                    break

                end
            end

            -- Kill inventory spells and drop new ones
            if #spells > 0 then
                local x, y = EntityGetTransform(entity_who_picked)
                for index, spell in ipairs(spells) do
                    local card = CreateItemActionEntity(GetRandomAction(x + math.random(-10000, 10000), y + math.random(-10001, 10000), 6, index), x, y)
                    local velcomp = EntityGetFirstComponentIncludingDisabled(card, "VelocityComponent")
                    ComponentSetValue2(velcomp, "mVelocity", math.random(-100, 100), math.random(-50, -100))
                    EntityKill(spell)
                end
            end
        end,
    },
    --  Spell Jam
    {
        id = "COPIS_THINGS_SPINDOWN",
        author = "Copi",
        ui_name = "$perk_name_copis_things_spindown",
        ui_description = "$perk_desc_copis_things_spindown",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/spindown.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/spindown.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = false,
        one_off_effect = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            dofile("data/scripts/gun/gun.lua")
            local lookup = GunUtils.lookup_spells()
            local spells = {}
            -- Get spells inventory
            local children = EntityGetAllChildren(entity_who_picked) or {}
            for i=1,#children do
                if (EntityGetName(children[i]) == "inventory_full") then

                    -- Gather all spells in inventory
                    local inventory_items = EntityGetAllChildren(children[i]) or {}
                    for j=1,#inventory_items do
                        if EntityHasTag(inventory_items[j], "card_action") then

                            spells[#spells+1] = inventory_items[j]

                        end
                    end
                    break

                end
            end


            local x, y = EntityGetTransform(entity_who_picked)
            for i=1, #spells do
                local iac = EntityGetFirstComponentIncludingDisabled( spells[i], "ItemActionComponent" ) --[[@cast iac number]]

                -- I apologize for my sins against math :pray: 
                -- Bear with me as I explain this mess, or just ask me on discord if you want to get a more comprehensive step by step

                --- @see _utils.lua Get current spell index via lookuptable 
                local index = lookup[ComponentGetValue2( iac, "action_id" )]['index']
                -- go down 2, modulo by actions count, add 1 (CASE: "BOMB"=1, go down to -1, wrap to #actions, add 1)
                -- this was a fucking pain to figure out, sometimes I despise lua for being indexed from 1...
                local spun  = ((index-2)%#actions)+1
                -- get action at new id
                local action= actions[spun]['id']
                -- spawn said action
                local card = CreateItemActionEntity(action, x, y)
                local velcomp = EntityGetFirstComponentIncludingDisabled(card, "VelocityComponent") --[[@cast velcomp number]]
                -- launch spells
                ComponentSetValue2(velcomp, "mVelocity", 10*(i-(#spells/2)), -100)
                -- make floaty until pickup
                EntityAddComponent2(card, "LuaComponent", {
                    script_item_picked_up="mods/copis_things/files/scripts/perk/misc/card_levitate_pickup.lua",
                    script_source_file = "mods/copis_things/files/scripts/perk/misc/card_levitate.lua",
                    execute_every_n_frame = 1,
                    _tags="enabled_in_world",
                })
                -- kill old card
                -- TODO: figure out how to forcefully place card in the same slot, but I'm a lazy fucker with no motivation
                EntityKill(spells[i])
            end

        end,
    },
    --  Lead Boots
    {
        id = "COPIS_THINGS_LEAD_BOOTS",
        author = "Copi",
        ui_name = "$perk_name_copis_things_lead_boots",
        ui_description = "$perk_desc_copis_things_lead_boots",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/lead_boots.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/lead_boots.png",
        stackable = STACKABLE_NO,
        run_on_clients = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent2(entity_who_picked, "ShotEffectComponent", {
                _tags = "perk_component",
                extra_modifier = "copis_things_lead_boots"
            })
        end,
    },
    --  Iron Feathers
    {
        id = "COPIS_THINGS_IRON_FEATHERS",
        author = "Copi",
        ui_name = "$perk_name_copis_things_iron_feathers",
        ui_description = "$perk_desc_copis_things_iron_feathers",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/iron_feathers.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/iron_feathers.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            do
                local models = EntityGetComponent(entity_who_picked, "CharacterPlatformingComponent")
                if (models ~= nil) then
                    for i, model in ipairs(models) do
                        local gravity = tonumber(ComponentGetValue(model, "pixel_gravity")) * 0.8
                        ComponentSetValue(model, "pixel_gravity", gravity)
                    end
                end
            end
            EntityAddComponent2(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_about_to_be_received = "mods/copis_things/files/scripts/perk/damage_about_to_be_received/iron_feathers.lua"
            })
        end,
    },
    --  Healthier Hearts
    {
        id = "COPIS_THINGS_HEALTHIER_HEARTS",
        author = "Copi",
        ui_name = "$perk_name_copis_things_healthier_hearts",
        ui_description = "$perk_desc_copis_things_healthier_hearts",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/healthier_hearts.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/healthier_hearts.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        run_on_clients = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
            local vid = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "healthier_hearts_count" then
                    vid = vscs[i]
                    break
                end
            end
            if vid then
                ComponentSetValue2(vid, "value_float", ComponentGetValue2(vid, "value_float") + 0.5)
            else
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_source_file = "mods/copis_things/files/scripts/perk/source/healthier_hearts.lua"
                })
                EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    _tags = "perk_component",
                    name = "healthier_hearts_count",
                    value_float = 0.5
                })
            end
        end,
    },
    --  Invincibility Frames
    {
        id = "COPIS_THINGS_INVINCIBILITY_FRAMES",
        author = "Copi",
        ui_name = "$perk_name_copis_things_invincibility_frames",
        ui_description = "$perk_desc_copis_things_invincibility_frames",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/invincibility_frames.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/invincibility_frames.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        run_on_clients = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
            local vid = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "invincibility_frames" then
                    vid = vscs[i]
                    break
                end
            end
            if vid then
                ComponentSetValue2(vid, "value_int", ComponentGetValue2(vid, "value_int") + 10)
            else
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_source_file = "mods/copis_things/files/scripts/perk/source/Invincibility_flash.lua"
                })
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/Invincibility_frames.lua"
                })
                EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    _tags = "perk_component",
                    name = "invincibility_frames",
                    value_int = 20
                })
            end
        end,
    },
    --  Demolitionist
    {
        id = "COPIS_THINGS_DEMOLITIONIST",
        author = "Copi",
        ui_name = "$perk_name_copis_things_demolitionist",
        ui_description = "$perk_desc_copis_things_demolitionist",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/demolitionist.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/demolitionist.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
            local vid = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "demolitionist_bonus" then
                    vid = vscs[i]
                    break
                end
            end
            if vid then
                ComponentSetValue2(vid, "value_int", ComponentGetValue2(vid, "value_int") + 1.0)
            else
                EntityAddComponent2(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_shot = "mods/copis_things/files/scripts/perk/script_shot/demolitionist.lua"
                })
                EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    _tags = "perk_component",
                    name = "demolitionist_bonus",
                    value_int = 1.0
                })
            end
        end,
    },
    --  Recursion
    {
        id = "COPIS_THINGS_RECURSION",
        author = "Copi",
        ui_name = "$perk_name_copis_things_recursion",
        ui_description = "$perk_desc_copis_things_recursion",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/recursion.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/recursion.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
            local vid = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "copi_recursion_stacks" then
                    vid = vscs[i]
                    break
                end
            end
            if vid then
                ComponentSetValue2(vid, "value_int", ComponentGetValue2(vid, "value_int") + 3)
            else
                EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
                    _tags = "perk_component",
                    name = "copi_recursion_stacks",
                    value_int = 3
                })
            end
            -- Reduce max hp
            local dmcs = EntityGetComponent(entity_who_picked, "DamageModelComponent") or {}
            for i=1, #dmcs do
                local damagemodel = dmcs[i]
                local max_hp    = math.max(0.06, ComponentGetValue2(damagemodel, "max_hp")) * (2/3)
                local hp        = math.max(0.06, ComponentGetValue2(damagemodel, "hp"))     * (2/3)
                ComponentSetValue2(damagemodel, "max_hp",   max_hp)
                ComponentSetValue2(damagemodel, "hp",       hp)
            end
        end,
        func_remove = function(entity_who_picked)
            local dmcs = EntityGetComponent(entity_who_picked, "DamageModelComponent") or {}
            for i=1, #dmcs do
                local damagemodel = dmcs[i]
                local max_hp = ComponentGetValue2(damagemodel, "max_hp")*1.5
                local hp = ComponentGetValue2(damagemodel, "hp")*1.5
                ComponentSetValue2(damagemodel, "max_hp", max_hp)
                ComponentSetValue2(damagemodel, "hp", hp)
            end
        end,
    }
}

local len = #perk_list
for i=1,#to_insert do
    perk_list[len+i] = to_insert[i]
end

local year, month, day, hour = GameGetDateAndTimeLocal()
if month == 4 and day == 1 then
    -- Fix noita:
    if ModSettingGet("CopisThings.do_april_fools") then
        local perks_new = {}
        for i=1, #perk_list do
            if perk_list[i].author ~= nil then
                perks_new[#perks_new+1] = perk_list[i]
            end
        end
        perk_list = perks_new
    end
end




--[[
        --  Duplicate Wand (One-Off)
    {
        id = "COPIS_THINGS_WAND_DUPLICATE",
        ui_name = "Duplicate Wand (One-Off)",
        ui_description = "Create a copy of your wand.",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/wand_duplicate.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/wand_duplicate.png",
		stackable = STACKABLE_YES,
		max_in_perk_pool = 3,
		one_off_effect = true,
        usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x, y = EntityGetTransform( entity_who_picked );
            local wand = find_the_wand_held( entity_who_picked )
            if wand ~= nil then
                local cloned_wand = wand:Clone()
                cloned_wand:PlaceAt(x, y)
            end
        end,
    }
            --  Alchemic aura
    {
        id = "COPIS_THINGS_ALCHEMY_AURA",
        ui_name = "Alchemic Aura",
        ui_description = "Transmutes some materials into other ones",
        ui_icon = "mods/copis_things/files/sprites/perks/ui/alchemic_aura.png",
        perk_icon = "mods/copis_things/files/sprites/perks/alchemic_aura.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/copis_things/files/entities/misc/perk/alchemy_aura.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
    },

    {
        id = "COPIS_THINGS_HALLOWED_STEP",
        ui_name = "Hallowed Step",
        ui_description = "Purifies stone within a short radius",
        ui_icon = "mods/copis_things/files/sprites/perks/ui/hallowed_step.png",
        perk_icon = "mods/copis_things/files/sprites/perks/hallowed_step.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/copis_things/files/entities/misc/perk/hallowed_step.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
    },
    -- Death Lottery
    {
        id = "COPIS_THINGS_DEATH_LOTTERY",
        ui_name = "$perk_name_copis_things_death_lottery",
        ui_description = "$perk_desc_copis_things_death_lottery",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/death_lottery.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/death_lottery.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for _, damagemodel in ipairs(damagemodels) do
                    ComponentSetValue2(damagemodel, "wait_for_kill_flag_on_death", true)
                end
            end
            EntityAddComponent(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/death_lottery.lua"
            })
        end,
        func_remove = function(entity_who_picked)
            local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
            if (damagemodels ~= nil) then
                for damagemodel in damagemodels do
                    ComponentSetValue2(damagemodel, "wait_for_kill_flag_on_death", false)
                end
            end
        end,
    },
    ]] --
