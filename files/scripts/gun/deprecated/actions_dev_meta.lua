local to_insert = {
    {
        id                = "DEV",
        name              = "Dev",
        description       = "Simulation backdoor -- remove before awakening subject",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = -255,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)


            if reflecting then return; end

            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            local x, y = EntityGetTransform(player)
            if entity_id ~= nil and entity_id ~= 0 then
                if (entity_id == player) then

                    if GameHasFlagRun("Detected") then
                        GamePrintImportant("Simulation administrators have detected you.", "ERASING ACTOR",
                            "mods/copis_things/files/ui_gfx/decorations/3piece_meta.png")
                        EntityLoadToEntity("data/entities/misc/effect_weaken.xml", player)
                        local damage_model_component = EntityGetFirstComponent(player, "DamageModelComponent")
                        local damage = 10000000
                        GameScreenshake(100, x, y) --shake
                        GameDropAllItems(player) --drop junk
                        GamePrintImportant("Simulation actor terminated", "",
                            "mods/copis_things/files/ui_gfx/decorations/3piece_meta.png") --flavour text
                        EntityLoad("data/entities/particles/image_emitters/player_disappear_effect_right.xml", x, y) -- gfx
                        EntityKill(player) --no way you're escaping this one buckaroo

                        --EntityInflictDamage(player, damage, "DAMAGE_PHYSICS_BODY_DAMAGED", "Simulation actor terminated", "DISINTEGRATED", 0, 0)		--crashes

                    else
                        GamePrintImportant("Backdoor accessed!", "self targetted",
                            "mods/copis_things/files/ui_gfx/decorations/3piece_meta.png")
                        GamePrintImportant("Permissions level increased", "2/10",
                            "mods/copis_things/files/ui_gfx/decorations/3piece_meta.png")
                        EntityAddComponent2(player, "UIIconComponent", {
                            name = "Developer " .. tostring(player),
                            description = "You feel empowered ",
                            icon_sprite_file = "mods/copis_things/files/ui_gfx/status_indicators/dev_meta.png",
                            display_above_head = false,
                            display_in_hud = true,
                            is_perk = true,
                        })

                        local text_id = EntityCreateNew("text_above_head")
                        EntityAddComponent2(text_id, "SpriteComponent", {
                            image_file = "mods/copis_things/files/fonts/font_small_numbers_grey.xml",
                            is_text_sprite = true,
                            offset_x = -15,
                            offset_y = 0,
                            text = tostring(player),
                            update_transform = true,
                            update_transform_rotation = false,
                            has_special_scale = true,
                            special_scale_x = 0.65,
                            special_scale_y = 0.65,
                            alpha = 1,
                            emissive = true,
                            z_index = 10
                        })
                        EntityAddComponent2(text_id, "InheritTransformComponent", {})
                        EntityAddChild(player, text_id)

                        local text_id2 = EntityCreateNew("text_above_head")
                        EntityAddComponent2(text_id2, "SpriteComponent", {
                            image_file = "mods/copis_things/files/fonts/font_small_numbers_damage.xml",
                            is_text_sprite = true,
                            offset_x = -15,
                            offset_y = 9,
                            text = tostring(player),
                            update_transform = true,
                            update_transform_rotation = false,
                            has_special_scale = true,
                            special_scale_x = 0.65,
                            special_scale_y = 0.65,
                            alpha = 1,
                            emissive = true,
                            z_index = 10
                        })
                        EntityAddComponent2(text_id2, "LuaComponent", {
                            script_source_file = "mods/copis_things/files/scripts/magic/health_amount.lua",
                            execute_every_n_frame = 1,
                        })
                        EntityAddComponent2(text_id2, "InheritTransformComponent", {})
                        EntityAddChild(player, text_id2)

                        local text_id3 = EntityCreateNew("text_above_head")
                        EntityAddComponent2(text_id3, "SpriteComponent", {
                            image_file = "mods/copis_things/files/fonts/font_small_numbers_gold.xml",
                            is_text_sprite = true,
                            offset_x = -15,
                            offset_y = 18,
                            text = tostring(player),
                            update_transform = true,
                            update_transform_rotation = false,
                            has_special_scale = true,
                            special_scale_x = 0.65,
                            special_scale_y = 0.65,
                            alpha = 1,
                            emissive = true,
                            z_index = 10
                        })
                        EntityAddComponent2(text_id3, "LuaComponent", {
                            script_source_file = "mods/copis_things/files/scripts/magic/gold_amount.lua",
                            execute_every_n_frame = 1,
                        })
                        EntityAddComponent2(text_id3, "InheritTransformComponent", {})
                        EntityAddChild(player, text_id3)

                        local text_id4 = EntityCreateNew("text_above_head")
                        EntityAddComponent2(text_id4, "SpriteComponent", {
                            image_file = "mods/copis_things/files/fonts/font_small_numbers_true_damage.xml",
                            is_text_sprite = true,
                            offset_x = -15,
                            offset_y = 27,
                            text = tostring(player),
                            update_transform = true,
                            update_transform_rotation = false,
                            has_special_scale = true,
                            special_scale_x = 0.65,
                            special_scale_y = 0.65,
                            alpha = 1,
                            emissive = true,
                            z_index = 10
                        })
                        EntityAddComponent2(text_id4, "LuaComponent", {
                            script_source_file = "mods/copis_things/files/scripts/magic/enemy_amount.lua",
                            execute_every_n_frame = 1,
                        })
                        EntityAddComponent2(text_id4, "InheritTransformComponent", {})
                        EntityAddChild(player, text_id4)

                        local character_data_component = EntityGetFirstComponent(player, "CharacterDataComponent")
                        ComponentSetValue2(character_data_component, "flying_needs_recharge", false) --fly

                        GamePrintImportant("You feel an uncomfortable presence watching you", "",
                            "mods/copis_things/files/ui_gfx/decorations/3piece_meta.png")
                        GameScreenshake(50, x, y)
                        GameAddFlagRun("Detected")
                    end
                end
            end
            c.fire_rate_wait = math.max(1000, c.fire_rate_wait * 2)
            current_reload_time = math.max(1000, current_reload_time * 2)

        end,
    },

}

for _, value in ipairs(to_insert) do
    if (value.author == nil) then
        value.author = "Copi"
    end
    value.id = "COPIS_THINGS_" .. value.id
    table.insert(actions, value)
end