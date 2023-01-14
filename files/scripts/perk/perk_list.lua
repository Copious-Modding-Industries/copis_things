to_insert =
{
    --  Health multiplication
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
    },
    --  Acimorphism
    {
        id = "COPIS_THINGS_POLY_TO_ACID",
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
        ui_name = "$perk_name_copis_things_mana_efficiency",
        ui_description = "$perk_desc_copis_things_mana_efficiency",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/mana_efficiency.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/mana_efficiency.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent(entity_who_picked, "ShotEffectComponent", {
                _tags = "perk_component",
                extra_modifier = "copis_things_mana_efficiency"
            })
        end,
    },
    --  Short temper
    {
        id = "COPIS_THINGS_SHORT_TEMPER",
        ui_name = "$perk_name_copis_things_short_temper",
        ui_description = "$perk_desc_copis_things_short_temper",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/short_temper.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/short_temper.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/short_temper.lua"
            })
        end,
    },
    --  Swapper
    {
        id = "COPIS_THINGS_SWAPPER",
        ui_name = "$perk_name_copis_things_swapper",
        ui_description = "$perk_desc_copis_things_swapper",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/swapper.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/swapper.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/swapper.lua"
            })
        end,
    },
    --  Fragile Ego
    {
        id = "COPIS_THINGS_FRAGILE_EGO",
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
            EntityAddComponent(entity_who_picked, "LuaComponent", {
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
                    ComponentSetValue2(damagemodel, "blood_sprite_directional",
                        "data/particles/bloodsplatters/bloodsplatter_directional_yellow_$[1-3].xml");
                    ComponentSetValue2(damagemodel, "blood_sprite_large",
                        "data/particles/bloodsplatters/bloodsplatter_yellow_$[1-3].xml");

                    local projectile_resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers",
                        "projectile"))
                    projectile_resistance = projectile_resistance * 0.9
                    ComponentObjectSetValue(damagemodel, "damage_multipliers", "projectile",
                        tostring(projectile_resistance))
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
        ui_name = "$perk_name_copis_things_regression_scales",
        ui_description = "$perk_desc_copis_things_regression_scales",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/regression_scales.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/regression_scales.png",
        stackable = STACKABLE_YES,
        stackable_maximum = 2,
        max_in_perk_pool = 2,
        stackable_is_rare = true,
        usable_by_enemies = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            -- TODO - this should work - seems to work
            GlobalsSetValue("TEMPLE_PERK_REROLL_COUNT", tostring(0))
            local perk_count = tonumber(GlobalsGetValue("TEMPLE_PERK_COUNT", "3"))
            perk_count = perk_count - 1
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
                    local num = GameGetFrameNum() * 2
                    for _, damage_type in pairs(multipliers) do
                        local resistance = ComponentObjectGetValue2(damagemodel, "damage_multipliers", damage_type);
                        SetRandomSeed(num, 9 + num)
                        resistance = math.max(0, resistance * (Random(50, 125) / 100));
                        ComponentObjectSetValue2(damagemodel, "damage_multipliers", damage_type, resistance);
                        num = num + 1
                    end
                end
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
        ui_name = "$perk_name_copis_things_spell_efficiency",
        ui_description = "$perk_desc_copis_things_spell_efficiency",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/spell_efficiency.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/spell_efficiency.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent(entity_who_picked, "ShotEffectComponent", {
                _tags = "perk_component",
                extra_modifier = "copis_things_spell_efficiency"
            })
        end,
    },
    --  Protagonist
    {
        id = "COPIS_THINGS_PROTAGONIST",
        ui_name = "$perk_name_copis_things_protagonist",
        ui_description = "$perk_desc_copis_things_protagonist",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/protagonist.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/protagonist.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vsc = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "protagonist_bonus")
            if vsc then
                ComponentSetValue2(vsc, "value_float", ComponentGetValue2(vsc, "value_float") + 2.0)
            else
                EntityAddComponent(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_shot = "mods/copis_things/files/scripts/perk/script_shot/protagonist.lua"
                })
                EntityAddComponent(entity_who_picked, "VariableStorageComponent", {
                    _tags = "protagonist_bonus,perk_component",
                    value_float = 2.0
                })
            end
        end,
    },
    --  Spell Jam
    {
        id = "COPIS_THINGS_SPELL_JAM",
        ui_name = "$perk_name_copis_things_spell_jam",
        ui_description = "$perk_desc_copis_things_spell_jam",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/spell_jam.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/spell_jam.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local spells = {}

            -- Get spells inventory
            local inventory_full
            for _, child in ipairs(EntityGetAllChildren(entity_who_picked) or {}) do
                if (EntityGetName(child) == "inventory_full") then
                    inventory_full = child
                    break
                end
            end

            -- Gather all spells in inventory
            local inventory_items = EntityGetAllChildren(inventory_full) or {}
            for _, item in ipairs(inventory_items) do
                if EntityHasTag(item, "card_action") then
                    table.insert(spells, item)
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
    --  Lead Boots
    {
        id = "COPIS_THINGS_LEAD_BOOTS",
        ui_name = "$perk_name_copis_things_lead_boots",
        ui_description = "$perk_desc_copis_things_lead_boots",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/lead_boots.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/lead_boots.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            EntityAddComponent(entity_who_picked, "ShotEffectComponent", {
                _tags = "perk_component",
                extra_modifier = "copis_things_lead_boots"
            })
        end,
    },
    --  Iron Feathers
    {
        id = "COPIS_THINGS_IRON_FEATHERS",
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
            EntityAddComponent(entity_who_picked, "LuaComponent", {
                _tags = "perk_component",
                script_damage_about_to_be_received = "mods/copis_things/files/scripts/perk/damage_about_to_be_received/iron_feathers.lua"
            })
        end,
    },
    --  Healthier Hearts
    {
        id = "COPIS_THINGS_HEALTHIER_HEARTS",
        ui_name = "$perk_name_copis_things_healthier_hearts",
        ui_description = "$perk_desc_copis_things_healthier_hearts",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/healthier_hearts.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/healthier_hearts.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vsc = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "healthier_hearts_count")
            if vsc then
                ComponentSetValue2(vsc, "value_float", ComponentGetValue2(vsc, "value_float") + 0.5)
            else
                EntityAddComponent(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_source_file = "mods/copis_things/files/scripts/perk/source/healthier_hearts.lua"
                })
                EntityAddComponent(entity_who_picked, "VariableStorageComponent", {
                    _tags = "healthier_hearts_count,perk_component",
                    value_float = 0.5
                })
            end
        end,
    },
    --  Invincibility Frames
    {
        id = "COPIS_THINGS_INVINCIBILITY_FRAMES",
        ui_name = "$perk_name_copis_things_invincibility_frames",
        ui_description = "$perk_desc_copis_things_invincibility_frames",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/invincibility_frames.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/invincibility_frames.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = false,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vsc = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "invincibility_frames")
            if vsc then
                ComponentSetValue2(vsc, "value_int", ComponentGetValue2(vsc, "value_int") + 10)
            else
                EntityAddComponent(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_source_file = "mods/copis_things/files/scripts/perk/source/Invincibility_flash.lua"
                })
                EntityAddComponent(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_damage_received = "mods/copis_things/files/scripts/perk/damage_received/Invincibility_frames.lua"
                })
                EntityAddComponent(entity_who_picked, "VariableStorageComponent", {
                    _tags = "invincibility_frames,perk_component",
                    value_int = 20
                })
            end
        end,
    },
    --  Demolitionist
    {
        id = "COPIS_THINGS_DEMOLITIONIST",
        ui_name = "$perk_name_copis_things_demolitionist",
        ui_description = "$perk_desc_copis_things_demolitionist",
        ui_icon = "mods/copis_things/files/ui_gfx/perk_icons/demolitionist.png",
        perk_icon = "mods/copis_things/files/items_gfx/perks/demolitionist.png",
        stackable = STACKABLE_YES,
        stackable_is_rare = true,
        usable_by_enemies = true,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local vsc = EntityGetFirstComponent(entity_who_picked, "VariableStorageComponent", "demolitionist_bonus")
            if vsc then
                ComponentSetValue2(vsc, "value_int", ComponentGetValue2(vsc, "value_int") + 1.0)
            else
                EntityAddComponent(entity_who_picked, "LuaComponent", {
                    _tags = "perk_component",
                    script_shot = "mods/copis_things/files/scripts/perk/script_shot/demolitionist.lua"
                })
                EntityAddComponent(entity_who_picked, "VariableStorageComponent", {
                    _tags = "demolitionist_bonus,perk_component",
                    value_int = 1.0
                })
            end
        end,
    },
}

for k, v in ipairs(to_insert) do
    table.insert(perk_list, v)
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
