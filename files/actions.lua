dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local to_insert = {

    -- BLOOD TENTACLE
    {
        id                  = "BLOODTENTACLE",
        name                = "$action_bloodtentacle",
        description         = "$actiondesc_bloodtentacle",
        spawn_requires_flag = "card_unlocked_pyramid",
        sprite              = "data/ui_gfx/gun_actions/bloodtentacle.png",
        related_projectiles = { "data/entities/projectiles/deck/bloodtentacle.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "3,4,5,6", -- TENTACLE
        spawn_probability   = "0.2,0.5,1,1", -- TENTACLE
        price               = 170,
        mana                = 30,
        --max_uses = 40,
        author              = "Nolla Games",
        action              = function()
            add_projectile("data/entities/projectiles/deck/bloodtentacle.xml")
            c.fire_rate_wait = c.fire_rate_wait + 20
        end,
    },

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

    -- PSYCHIC SHOT
    {
        id                = "PSYCHIC_SHOT",
        name              = "Psychic shot",
        description       = "Causes the projectile to be controlled telekinetically",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/psychic_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price             = 150,
        mana              = 15,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_shot.xml,"
            draw_actions(1, true)
        end
    },


    -- LUNGE
    {
        id                = "LUNGE",
        name              = "Lunge",
        description       = "Launch yourself forwards with a burst of speed",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/lunge.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,4",
        spawn_probability = "0.6,0.6",
        price             = 100,
        mana              = 5,
        ai_never_uses     = true,
        action            = function()
            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            if (entity_id == player) then
                local pos_x, pos_y = EntityGetTransform(player)
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player,
                    "ControlsComponent"), "mMousePosition")
                if (mouse_x == nil or mouse_y == nil) then return end
                local aim_x = mouse_x - pos_x
                local aim_y = mouse_y - pos_y
                local len = math.sqrt((aim_x ^ 2) + (aim_y ^ 2))
                local force_x = 1000
                local force_y = 1000
                ComponentSetValue2(EntityGetFirstComponent(player, "CharacterDataComponent"), "mVelocity",
                    (aim_x / len * force_x), (aim_y / len * force_y))
            end
        end,
    },

    {
        id                  = "SUMMON_TABLET",
        name                = "Summon Emerald Tablet",
        description         = "Summon an emerald tablet",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/summon_tablet.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/tablet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5,6", -- SUMMON_ROCK
        spawn_probability   = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- SUMMON_ROCK
        price               = 160,
        mana                = 100,
        max_uses            = 3,
        --custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/summon_rock.xml",
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/tablet.xml")
        end,
    },

    {
        id                = "PROJECTION_CAST",
        name              = "Projection cast",
        description       = "Projects your cast to where your mind focuses",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/projection_cast.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "6,10",
        spawn_probability = "0.2,1",
        price             = 250,
        mana              = 50,
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait + 10
            c.spread_degrees = c.spread_degrees - 6
            if reflecting then return; end
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/projection_cast.xml", 1)
        end,
    },

    {
        id                = "SLOW",
        name              = "Speed Down",
        description       = "Decreases the speed at which a projectile flies through the air",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/slow.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,		2,		3,		4",
        spawn_probability = "0.8,		0.8,	0.8,	0.8",
        price             = 50,
        mana              = -3,
        --max_uses = 100,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/slow.xml",
        action            = function()
            c.speed_multiplier = c.speed_multiplier * 0.6
            c.spread_degrees = c.spread_degrees - 8
            draw_actions(1, true)
        end,
    },

    {
        id                = "CLAIRVOYANCE",
        name              = "Clairvoyance",
        description       = "Allows you to project your vision",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/clairvoyance.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.5,1,1,1,1", -- TINY_GHOST
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/clairvoyance.xml",
        action            = function()
            draw_actions(1, true)
        end,
    },

    {
        id                = "PEACEFUL_SHOT",
        name              = "Peaceful Shot",
        description       = "Sharply reduces the damage of a projectile",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/peaceful_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price             = 100,
        mana              = -15,
        action            = function()
            c.speed_multiplier      = c.speed_multiplier * 0.8
            c.gore_particles        = c.gore_particles - 5
            c.fire_rate_wait        = c.fire_rate_wait - 5
            c.damage_projectile_add = c.damage_projectile_add - 1
            c.spread_degrees        = c.spread_degrees - 5
            draw_actions(1, true)
        end,
    },

    {
        id                = "ANCHORED_SHOT",
        name              = "Anchored Shot",
        description       = "Anchors a projectile where it was fired",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/anchored_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price             = 100,
        mana              = 10,
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait + 26
            if reflecting then return; end
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/anchored_shot.xml,"
            c.spread_degrees = c.spread_degrees - 10
            c.lifetime_add   = c.lifetime_add + 250
            draw_actions(1, true)
        end,
    },

    {
        id                = "LEVITY_SHOT",
        name              = "Levity Shot",
        description       = "Nullifies a projectile's gravity",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/levity_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price             = 100,
        mana              = 5,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/levity_shot.xml,"
            c.speed_multiplier = c.speed_multiplier * 0.9
            c.spread_degrees = c.spread_degrees - 10
            draw_actions(1, true)
        end,
    },

    {
        id                = "BOUNCE_100",
        name              = "Hundredfold Bounce",
        description       = "Causes a projectile to bounce many times",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/bounce_100.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3,4,5,6", -- BOUNCE
        spawn_probability = "1,1,0.4,0.2,0.2", -- BOUNCE
        price             = 100,
        mana              = 10,
        action            = function()
            c.bounces = c.bounces + 100
            c.speed_multiplier = c.speed_multiplier * 1.2
            c.spread_degrees = c.spread_degrees - 10
            draw_actions(1, true)
        end,
    },

    {
        id                = "SEPARATOR_CAST",
        name              = "Separator cast",
        description       = "Casts a projectile independent of any modifiers before it, like in a multicast",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/separator_cast.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5", -- BOUNCE
        spawn_probability = "0.3,		0.3,	0.3,	0.3",
        price             = 210,
        mana              = 0,
        action            = function()
            if reflecting then return; end
            local old_c = c;
            c = {};
            reset_modifiers(c);
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/separator_cast.xml", 1);
            c = old_c;
            --[[
            local old_c = c;
			c = {};
			reset_modifiers( c );
            BeginProjectile( "mods/copis_things/files/entities/projectiles/separator_cast.xml" );
                BeginTriggerDeath();
                    for k,v in pairs(old_c) do
                        c[k] = v;
                    end
                    draw_actions( 1, true );
                    register_action( c );
                    SetProjectileConfigs();
                EndTrigger();
            EndProjectile();
            c = old_c;
			]]
        end,
    },

    {
        id                = "SPREAD",
        name              = "Spread",
        description       = "Adds spread to a projectile",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/spread.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- SPREAD_REDUCE
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8", -- SPREAD_REDUCE
        price             = 100,
        mana              = -5,
        action            = function()
            c.spread_degrees = c.spread_degrees + 30.0
            c.fire_rate_wait = c.fire_rate_wait - 5
            draw_actions(1, true)
        end,
    },

    {
        id                  = "DART",
        name                = "Dart",
        description         = "An accelerating magical dart that pierces soft materials",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/dart.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/dart.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2",
        spawn_probability   = "2,1,0.5",
        price               = 120,
        mana                = 7,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
            c.fire_rate_wait = c.fire_rate_wait + 2;
        end,
    },

    {
        id                = "DIE",
        name              = "Die",
        description       = "Reverses the flow of mana in your body, giving you a quick and painless death.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/die.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "6,10",
        spawn_probability = "0.2,1",
        price             = 250,
        mana              = 0,
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local damage_model_component = EntityGetFirstComponent(entity_id, "DamageModelComponent")
                ComponentSetValue2(damage_model_component, "hp", 0)
                ComponentSetValue2(damage_model_component, "air_needed", true)
                ComponentSetValue2(damage_model_component, "air_in_lungs", 0)
            end
        end,
    },
    {
        id                  = "TEMPORARY_CIRCLE",
        name                = "Summon Circle",
        description         = "Summons a shortlived hollow circle",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/temporary_circle.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/deck/temporary_wall.xml" },
        type                = ACTION_TYPE_UTILITY,
        spawn_level         = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability   = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price               = 100,
        mana                = 40,
        max_uses            = 20,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/temporary_circle.xml")
            c.fire_rate_wait = c.fire_rate_wait + 40
        end,
    },
    {
        id                     = "LARPA_FORWARDS",
        name                   = "Forwards Larpa",
        description            = "Makes a projectile cast copies of itself forwards",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/forwards_larpa.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/forwards_larpa.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability      = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price                  = 260,
        mana                   = 100,
        --max_uses = 20,
        action                 = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/forwards_larpa.xml,"
            draw_actions(1, true)
        end,
    },
    {
        id                     = "HOMING_LIGHT",
        name                   = "Soft Homing",
        description            = "Guides a projectile weakly towards your foes",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/homing_light.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/homing_light.xml,data/entities/particles/tinyspark_white_weak.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5,6", -- HOMING
        spawn_probability      = "0.4,0.8,1,0.4,0.1,0.1", -- HOMING
        price                  = 100,
        mana                   = 25,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/homing_light.xml,data/entities/particles/tinyspark_white_weak.xml,"
            draw_actions(1, true)
        end,
    },
    -- PSYCHIC GRIP
    {
        id                = "PSYCHIC_GRIP",
        name              = "Psychic Grip",
        description       = "Locks a projectile in front of your wand",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/psychic_grip.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price             = 150,
        mana              = 15,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_grip.xml,"
            draw_actions(1, true)
        end
    },

    -- WISPY SHOT
    {
        id                = "WISPY_SHOT",
        name              = "Wispy Shot",
        description       = "Imbues a projectile with a wispy spirit",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/wispy_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price             = 150,
        mana              = 15,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/wispy_shot.xml,"
            draw_actions(1, true)
            c.lifetime_add   = c.lifetime_add + 1500
            c.fire_rate_wait = c.fire_rate_wait + 20
        end
    },

    {
        id                     = "GUNNER_SHOT",
        name                   = "Gunner Shot",
        description            = "Makes a projectile rapidly fire weak shots at nearby foes",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability      = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price                  = 260,
        mana                   = 100,
        --max_uses = 20,
        action                 = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                     = "GUNNER_SHOT_STRONG",
        name                   = "Strong Gunner Shot",
        description            = "Makes a projectile occasionally shoot powerful shots at nearby foes",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_strong.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_strong.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability      = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price                  = 260,
        mana                   = 100,
        --max_uses = 20,
        action                 = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_strong.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                     = "GUNNER_SHOT_CURSOR",
        name                   = "Controlled Gunner Shot",
        description            = "Makes a projectile rapidly fire weak shots at the cursor while holding RMB",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_cursor.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_cursor.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability      = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price                  = 260,
        mana                   = 100,
        --max_uses = 20,
        action                 = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_cursor.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "SOIL_TRAIL",
        name              = "Soil Trail",
        description       = "Gives a projectile a trail of soil",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/soil_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3,4", -- POISON_TRAIL
        spawn_probability = "0.3,0.3,0.3", -- POISON_TRAIL
        price             = 160,
        mana              = 10,
        action            = function()
            c.trail_material = c.trail_material .. "soil,"
            c.trail_material_amount = c.trail_material_amount + 9
            draw_actions(1, true)
        end,
    },

    {
        id                  = "CONCRETEBALL",
        name                = "Chunk of concrete",
        description         = "The power of industry!",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_concrete.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,5", -- SOILBALL
        spawn_probability   = "1,1,1,1", -- SOILBALL
        price               = 10,
        mana                = 5,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml")
        end,
    },
    --[[
	{
		id					= "BUBBLEBOMB",
		name				= "Bubblebomb",
		description			= "Testing",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/bubblebomb.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		add_projectile("mods/copis_things/files/entities/projectiles/bubblebomb.xml")
		end,
	},
	{
		id					= "BUBBLEBOMB_DEATH_TRIGGER",
		name				= "Bubblebomb with death trigger",
		description			= "Testing",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/bubblebomb_death_trigger.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/bubblebomb.xml", 1)
		end,
	},
]]

    {
        id                = "ZENITH_DISC",
        name              = "Zenith disc",
        description       = "Summons a no nonsense sawblade.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/zenith_disc.png",
        type              = ACTION_TYPE_PROJECTILE,
        spawn_level       = "6,10",
        spawn_probability = "0.2,0.2",
        price             = 100,
        mana              = 140,
        action            = function()
            c.spread_degrees = c.spread_degrees + 5.0
            add_projectile("mods/copis_things/files/entities/projectiles/zenith_disc.xml")
        end,
    },

    {
        id                = "EVISCERATOR_DISC",
        name              = "Eviscerator",
        description       = "Please, don't cast this.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/eviscerator.png",
        type              = ACTION_TYPE_PROJECTILE,
        spawn_level       = "6,10",
        spawn_probability = "0.1,0.1",
        price             = 1000,
        mana              = 280,
        action            = function()
            c.spread_degrees = c.spread_degrees + 5.0
            add_projectile("mods/copis_things/files/entities/projectiles/eviscerator.xml")
        end,
    },


    {
        id                = "SUMMON_HAMIS",
        name              = "Summon Hämis",
        description       = "Praise Hämis.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_hamis.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability = "0.3,		0.2,	0.2,	0.2,	0.2,	0.2,	0.2",
        price             = 0,
        mana              = 10,
        action            = function()
            add_projectile("mods/copis_things/files/entities/projectiles/longleg_projectile.xml")
            c.fire_rate_wait = c.fire_rate_wait + 10
        end,
    },

    {
        id                  = "SILVER_BULLET",
        name                = "Silver bullet",
        description         = "A small bullet created from arcane silver",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "2,3,4",
        spawn_probability   = "1,1,0.5",
        price               = 220,
        mana                = 20,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
            c.fire_rate_wait = c.fire_rate_wait - 12;
        end,
    },

    {
        id                  = "SILVER_MAGNUM",
        name                = "Silver magnum",
        description         = "A large bullet created from arcane silver",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_magnum.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "4,			5,			6",
        spawn_probability   = "1.00,		0.66,		0.33",
        price               = 330,
        mana                = 35,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/silver_magnum.xml")
            c.fire_rate_wait = c.fire_rate_wait - 6;
        end,
    },

    {
        id                  = "SILVER_BULLET_DEATH_TRIGGER",
        name                = "Silver bullet with expiration trigger",
        description         = "A small bullet created from arcane silver that casts another spell upon expiring",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_death_trigger.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "4,			5,			6",
        spawn_probability   = "1.00,		0.50,		0.20",
        price               = 220,
        mana                = 25,
        action              = function()
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_bullet.xml", 1)
            c.fire_rate_wait = c.fire_rate_wait - 12;
        end,
    },

    {
        id                  = "SILVER_MAGNUM_DEATH_TRIGGER",
        name                = "Silver magnum with expiration trigger",
        description         = "A large bullet created from arcane silver that casts another spell upon expiring",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum_death_trigger.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_magnum.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "2,			3,			4",
        spawn_probability   = "1.00,		0.66,		0.33",
        price               = 330,
        mana                = 40,
        action              = function()
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_magnum.xml", 1)
            c.fire_rate_wait = c.fire_rate_wait - 6;
        end,
    },

    {
        id                = "PLANK_HORIZONTAL",
        name              = "Build Wooden Platform",
        description       = "Construct a horizontal wooden platform",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/plank_horizontal.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price             = 100,
        mana              = 40,
        max_uses          = 3,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/plank_horizontal.xml",
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,
                    "ControlsComponent"), "mMousePosition")
                EntityLoad("mods/copis_things/files/entities/buildings/plank_horizontal_building.xml", mouse_x, mouse_y)
                c.fire_rate_wait = c.fire_rate_wait + 5
                current_reload_time = current_reload_time + 15
            end

        end,
    },

    {
        id                = "PLANK_CUBE",
        name              = "Build Wooden Cube",
        description       = "Construct a wooden cube",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/plank_cube.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price             = 100,
        mana              = 40,
        max_uses          = 12,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/plank_cube.xml",
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,
                    "ControlsComponent"), "mMousePosition")
                function round(n, to)
                    return math.floor(n / to + 0.5) * to
                end

                EntityLoad("mods/copis_things/files/entities/buildings/plank_cube_building.xml", round(mouse_x, 16),
                    round(mouse_y, 16))
                c.fire_rate_wait = c.fire_rate_wait + 5
                current_reload_time = current_reload_time + 15
            end

        end,
    },

    {
        id                = "PLANK_VERTICAL",
        name              = "Build Wooden Wall",
        description       = "Construct a vertical wooden wall",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/plank_vertical.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price             = 100,
        mana              = 40,
        max_uses          = 3,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/plank_vertical.xml",
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,
                    "ControlsComponent"), "mMousePosition")
                EntityLoad("mods/copis_things/files/entities/buildings/plank_vertical_building.xml", mouse_x, mouse_y)
                c.fire_rate_wait = c.fire_rate_wait + 5
                current_reload_time = current_reload_time + 15
            end

        end,
    },

    {
        id                     = "SLOTS_TO_POWER",
        name                   = "Slots To Power",
        description            = "Increases a projectile's damage based on the number of empty slots in the wand",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/slots_to_power.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/homing_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/slots_to_power.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability      = "0.2,0.5,0.5,0.1", -- AREA_DAMAGE
        price                  = 120,
        mana                   = 110,
        -- max_uses = 20,
        action                 = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/slots_to_power.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 20
            draw_actions(1, true)
        end,
    },

    {
        id                = "UPGRADE_GUN_SHUFFLE",
        name              = "Unshuffle (One-Off)",
        description       = "Cast inside a wand to unshuffle it at the cost of reduced stats. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                if (wand.shuffle == true) then
                    wand.shuffle = false
                    wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_SHUFFLE")
                    wand.manaMax = wand.manaMax * 0.9
                    wand.manaChargeSpeed = wand.manaChargeSpeed * 0.9
                    wand.castDelay = wand.castDelay * 1.1
                    wand.rechargeTime = wand.rechargeTime * 1.1


                    local function has_custom_sprite(ez_wand)
                        local sprite_file = ez_wand:GetSprite()
                        return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                    end

                    if not has_custom_sprite(wand) then
                        wand:UpdateSprite()
                    end
                    GameScreenshake(50, pos_x, pos_y)
                    GamePrintImportant("Wand unshuffled!", "Stats slightly reduced.")
                end
            end
        end,
    },

    {
        id                = "UPGRADE_GUN_SHUFFLE_BAD",
        name              = "Shuffle (One-Off)",
        description       = "Cast inside a wand to shuffle it, but greatly improve it's stats. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle_bad.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                if (wand.shuffle == false) then
                    wand.shuffle = true
                    wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD")
                    wand.manaMax = wand.manaMax * 1.5
                    wand.manaChargeSpeed = wand.manaChargeSpeed * 1.5
                    wand.castDelay = wand.castDelay * 0.55
                    wand.rechargeTime = wand.rechargeTime * 0.55


                    local function has_custom_sprite(ez_wand)
                        local sprite_file = ez_wand:GetSprite()
                        return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                    end

                    if not has_custom_sprite(wand) then
                        wand:UpdateSprite()
                    end
                    GameScreenshake(50, pos_x, pos_y)
                    GamePrintImportant("Wand shuffled!", "Stats improved.")
                end
            end
        end,
    },

    {
        id                = "UPGRADE_ACTIONS_PER_ROUND",
        name              = "Upgrade Spells per Cast (One-Off)",
        description       = "Cast inside a wand to increase the amount of spells fired per cast. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_actions_per_round.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.1", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND")
                wand.spellsPerCast = wand.spellsPerCast + 1


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!", tostring(wand.spellsPerCast) .. " spells per cast.")
            end
        end,
    },

    {
        id                = "UPGRADE_SPEED_MULTIPLIER",
        name              = "Upgrade spell speed multiplier (One-Off)",
        description       = "Cast inside a wand to increase the velocity of projectiles from it. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_speed_multiplier.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.1", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER")
                SetRandomSeed(pos_x, pos_y + GameGetFrameNum() + 137)
                wand.speedMultiplier = wand.speedMultiplier * Random(2, 3)


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!", tostring(wand.speedMultiplier) .. " speed multiplier.")
            end
        end,
    },

    {
        id                = "UPGRADE_GUN_CAPACITY",
        name              = "Upgrade wand capacity (One-Off)",
        description       = "Cast inside a wand to increase the wand's total spell capacity. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_capacity.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.1", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                if (wand.capacity < 26) then
                    wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_CAPACITY")
                    SetRandomSeed(pos_x, pos_y + GameGetFrameNum() + 137)
                    wand.capacity = wand.capacity + Random(1, 3)
                    local function has_custom_sprite(ez_wand)
                        local sprite_file = ez_wand:GetSprite()
                        return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                    end

                    if not has_custom_sprite(wand) then
                        wand:UpdateSprite()
                    end
                    GameScreenshake(50, pos_x, pos_y)
                    GamePrintImportant("Wand upgraded!", tostring(wand.capacity) .. " capacity.")
                end
            end
        end,
    },

    {
        id                = "UPGRADE_FIRE_RATE_WAIT",
        name              = "Upgrade Cast Delay (One-Off)",
        description       = "Cast inside a wand to decrease the cast delay. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_fire_rate_wait.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT")
                local castDelay_old = wand.castDelay
                wand.castDelay = ((wand.castDelay - 0.2) * 0.8) + 0.2


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!",
                    ("%.2fs"):format(castDelay_old / 60) ..
                    " -> " .. ("%.2fs"):format(wand.castDelay / 60) .. " cast delay.")
            end
        end,
    },

    {
        id                = "UPGRADE_RELOAD_TIME",
        name              = "Upgrade Reload Time (One-Off)",
        description       = "Cast inside a wand to decrease the reload time. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_reload_time.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_RELOAD_TIME")
                local rechargeTime_old = wand.rechargeTime
                wand.rechargeTime = ((wand.rechargeTime - 0.2) * 0.8) + 0.2


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!",
                    ("%.2fs"):format(rechargeTime_old / 60) ..
                    " -> " .. ("%.2fs"):format(wand.rechargeTime / 60) .. " recharge time.")
            end
        end,
    },

    {
        id                = "UPGRADE_SPREAD_DEGREES",
        name              = "Upgrade accuracy (One-Off)",
        description       = "Cast inside a wand to increase the accuracy. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_spread_degrees.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_SPREAD_DEGREES")
                local rechargeTime_old = wand.rechargeTime
                wand.spread = wand.spread - ((math.abs(wand.spread) * 0.25) + 0.5)


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!",
                    tostring(rechargeTime_old) .. " -> " .. tostring(wand.spread) .. " degrees spread.")
            end
        end,
    },

    {
        id                = "UPGRADE_MANA_MAX",
        name              = "Upgrade maximum mana (One-Off)",
        description       = "Cast inside a wand to increase it's mana capacity. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_max.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_MANA_MAX")
                wand.manaMax = wand.manaMax * 1.2 + 50


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!", tostring(wand.manaMax) .. " mana capacity.")
            end
        end,
    },

    {
        id                = "UPGRADE_MANA_CHARGE_SPEED",
        name              = "Upgrade mana charge speed (One-Off)",
        description       = "Cast inside a wand to increase it's mana charge speed. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_charge_speed.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                wand:RemoveSpells("COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED")
                wand.manaChargeSpeed = wand.manaChargeSpeed * 1.2 + 50


                local function has_custom_sprite(ez_wand)
                    local sprite_file = ez_wand:GetSprite()
                    return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                end

                if not has_custom_sprite(wand) then
                    wand:UpdateSprite()
                end
                GameScreenshake(50, pos_x, pos_y)
                GamePrintImportant("Wand upgraded!", tostring(wand.manaChargeSpeed) .. " mana charge speed.")
            end
        end,
    },

    {
        id                = "UPGRADE_GUN_ACTIONS_PERMANENT",
        name              = "Upgrade Always Cast (One-Off)",
        description       = "Cast inside a wand to turn it's first spell into an always cast. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            draw_actions(1, true)
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                local spells, attached_spells = wand:GetSpells()
                if (
                    #spells > 0 and spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT" and
                        spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE") then
                    local action_to_attach = spells[1]
                    wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT")
                    wand:RemoveSpells(spells[1].action_id)
                    wand:AttachSpells(spells[1].action_id)
                    local function has_custom_sprite(ez_wand)
                        local sprite_file = ez_wand:GetSprite()
                        return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                    end

                    if not has_custom_sprite(wand) then
                        wand:UpdateSprite()
                    end
                    GameScreenshake(50, pos_x, pos_y)
                    GamePrintImportant("Spell attached!")
                end
            end
        end,
    },

    {
        id                = "UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE",
        name              = "Upgrade Remove Always Cast (One-Off)",
        description       = "Cast inside a wand to turn it's first always cast into a spell. Spell is voided upon use!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions_remove.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "1,2,3,10", -- AREA_DAMAGE
        spawn_probability = "1,1,0.5,0.2", -- AREA_DAMAGE
        price             = 840,
        mana              = 0,
        recursive         = true,
        action            = function(recursion_level, iteration)
            if (recursion_level or iteration) ~= nil then
                GamePrintImportant("You cannot cheat the gods!", "")
                return
            end
            local entity_id = GetUpdatedEntityID()
            draw_actions(1, true)
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local pos_x, pos_y = EntityGetTransform(entity_id)
                local wand = EZWand.GetHeldWand()
                local spells, attached_spells = wand:GetSpells()
                if (
                    #attached_spells > 0 and attached_spells[1].action_id ~= "UPGRADE_GUN_ACTIONS_PERMANENT" and
                        wand:GetFreeSlotsCount() > 0) then
                    local action_to_attach = attached_spells[1]
                    wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE")
                    wand:DetachSpells(attached_spells[1].action_id)
                    wand:AddSpells(attached_spells[1].action_id)
                    local function has_custom_sprite(ez_wand)
                        local sprite_file = ez_wand:GetSprite()
                        return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
                    end

                    if not has_custom_sprite(wand) then
                        wand:UpdateSprite()
                    end
                    GameScreenshake(50, pos_x, pos_y)
                    GamePrintImportant("Spell extracted!")
                end
            end
        end,
    },

    {
        id                     = "DAMAGE_MELEE",
        name                   = "Melee damage plus",
        description            = "Increases melee the damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_melee.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_melee_add            = c.damage_melee_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_DRILL",
        name                   = "Drill damage plus",
        description            = "Increases the drill damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_drill.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_drill_add            = c.damage_drill_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,

    },
    --[[
	{
		id          = "DAMAGE_EXPLOSION",
		name 		= "Explosive damage plus",
		description = "Increases the explosion damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_explosion.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_explosion_add = c.damage_explosion_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},
]]
    {
        id                     = "DAMAGE_SLICE",
        name                   = "Slice damage plus",
        description            = "Increases the slice damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_slice.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_slice_add            = c.damage_slice_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_ELECTRICITY",
        name                   = "Electric damage plus",
        description            = "Increases the electric damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_electricity.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_electricity_add      = c.damage_electricity_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_FREEZE",
        name                   = "Freeze damage plus",
        description            = "Increases the freeze damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_freeze.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_ice_add              = c.damage_ice_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_CURSE",
        name                   = "Curse damage plus",
        description            = "Increases the curse damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_curse.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_curse_add            = c.damage_curse_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_FIRE",
        name                   = "Fire damage plus",
        description            = "Increases the fire damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_fire.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_fire_add             = c.damage_fire_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                  = "DAMAGE_MINUS",
        name                = "Damage Minus",
        description         = "Decreases the damage done by a projectile",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_minus.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "2,3,4,5", -- DAMAGE
        spawn_probability   = "0.3,0.3,0.3,0.3", -- DAMAGE
        price               = 50,
        mana                = -20,
        --max_uses = 50,
        action              = function()
            c.damage_projectile_add       = c.damage_projectile_add - 0.2
            c.gore_particles              = c.gore_particles - 5
            c.fire_rate_wait              = c.fire_rate_wait - 2.5
            shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                  = "DAMAGE_TO_CURSE",
        name                = "Damage to Curse",
        description         = "Converts 80% of projectile damage to curse damage",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_to_curse.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "1,2,4,5,10", -- MATTER_EATER
        spawn_probability   = "0.1,1,0.1,0.1,0.2", -- MATTER_EATER
        price               = 280,
        mana                = 30,
        action              = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_to_curse.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                  = "DAMAGE_LIFETIME",
        name                = "Damage growth",
        description         = "Causes your projectile to gain damage the longer it's alive",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_lifetime.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "1,2,4,5,10", -- MATTER_EATER
        spawn_probability   = "0.1,1,0.1,0.1,0.2", -- MATTER_EATER
        price               = 280,
        mana                = 30,
        action              = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_lifetime.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                  = "INFINITE_LIFETIME",
        name                = "Infinite Lifetime",
        description         = "Causes your projectile to last forever, but drain your wand's mana. Projectile expires when you run out of mana.",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/lifetime_infinite.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "1,2,4,5,10", -- MATTER_EATER
        spawn_probability   = "0.1,1,0.1,0.1,0.2", -- MATTER_EATER
        price               = 280,
        mana                = 60,
        action              = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/infinite_lifetime.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "OSCILLATING_SPEED",
        name              = "Oscillating Speed",
        description       = "Causes a projectile's speed to fluctuate",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/oscillating_speed.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price             = 80,
        mana              = 2,
        --max_uses = 100,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/oscillating_speed.xml,"
            c.spread_degrees = c.spread_degrees - 8
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_DRUNK",
        name              = "Critical on drunk enemies",
        description       = "Makes a projectile always do a critical hit on drunk enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_alcoholic.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_alcoholic.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_CHARM",
        name              = "Critical on charmed enemies",
        description       = "Makes a projectile always do a critical hit on charmed enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_charm.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_charm.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_CONFUSION",
        name              = "Critical on confused enemies",
        description       = "Makes a projectile always do a critical hit on confused enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_confusion.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_confusion.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_ELECTROCUTED",
        name              = "Critical on electrocuted enemies",
        description       = "Makes a projectile always do a critical hit on electrocuted enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_electrocuted.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_electrocuted.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_FROZEN",
        name              = "Critical on frozen enemies",
        description       = "Makes a projectile always do a critical hit on frozen enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_frozen.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_frozen.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_2",
        name              = "Reduce recharge time II",
        description       = "Reduces the time between spellcasts heavily",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_2.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
        price             = 400,
        mana              = 24,
        --max_uses = 75,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 20
            current_reload_time = current_reload_time - 40
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_3",
        name              = "Reduce recharge time III",
        description       = "Reduces the time between spellcasts immensely",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_3.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.33,0.33,0.33,0.33,0.33,0.33", -- RECHARGE
        price             = 600,
        mana              = 48,
        --max_uses = 50,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 30
            current_reload_time = current_reload_time - 60
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_DELAY_UP",
        name              = "Delayed recharge",
        description       = "Sharply reduces wand recharge speed at the cost of cast delay",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_delay_up.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
        price             = 400,
        mana              = 24,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 60
            current_reload_time = current_reload_time - 80
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_DELAY_DOWN",
        name              = "Rushing recharge",
        description       = "Sharply reduces cast delay between spells at the cost of wand recharge speed",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_delay_down.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
        price             = 400,
        mana              = 24,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 80
            current_reload_time = current_reload_time + 60
            draw_actions(1, true)
        end,
    },

    {
        id                = "ARCANE_RECHARGE",
        name              = "Arcane Recharge",
        description       = "Slightly reduce the time between spellcasts, but gain mana when casting",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/arcane_recharge.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
        price             = 400,
        mana              = -12,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 5
            current_reload_time = current_reload_time - 10
            draw_actions(1, true)
        end,
    },
    --[[
	{
		id					= "PASSIVE_RECHARGE",
		name				= "Passive Recharge",
		description			= "Your wand recharges faster!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/passive_recharge.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
		price				= 200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/passive_recharge.xml",
		action = function()
			draw_actions( 1, true )
		end
	},
]]
    {
        id                = "MANA_REDUCE_2",
        name              = "Add mana II",
        description       = "Adds 60 mana to the wand",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/mana_2.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- MANA_REDUCE
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- MANA_REDUCE
        price             = 500,
        mana              = -60,
        --max_uses = 75,
        custom_xml_file   = "data/entities/misc/custom_cards/mana_reduce.xml",
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait + 20
            draw_actions(1, true)
        end,
    },

    {
        id                = "MANA_REDUCE_3",
        name              = "Add mana III",
        description       = "Adds 90 mana to the wand",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/mana_3.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- MANA_REDUCE
        spawn_probability = "0.33,0.33,0.33,0.33,0.33,0.33", -- MANA_REDUCE
        price             = 750,
        mana              = -90,
        --max_uses = 50,
        custom_xml_file   = "data/entities/misc/custom_cards/mana_reduce.xml",
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait + 30
            draw_actions(1, true)
        end,
    },

    {
        id                = "PASSIVE_MANA",
        name              = "Passive Mana",
        description       = "Your wand regenerates mana faster!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/passive_mana.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
        price             = 200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/passive_mana.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "SUMMON_BOSS_CENTIPEDE",
        name              = "Summon Kolmisilmä",
        description       = "Summons Kolmisilmä.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_centipede.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_centipede/boss_centipede.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_WIZARD",
        name              = "Summon Mestarien mestari",
        description       = "Summons Mestarien mestari.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_wizard.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_wizard/boss_wizard.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_ALCHEMIST",
        name              = "Summon Ylialkemisti",
        description       = "Summons Ylialkemisti.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_alchemist.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_alchemist/boss_alchemist.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_DRAGON",
        name              = "Summon Suomuhauki",
        description       = "Summons Suomuhauki.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_dragon.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_dragon.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_GHOST",
        name              = "Summon Ylialkemisti",
        description       = "Summons Ylialkemisti.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_ghost.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_ghost/boss_ghost.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_PIT",
        name              = "Summon Sauvojen Tuntija",
        description       = "Summons Sauvojen Tuntija.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_pit.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_pit/boss_pit.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_LIMBS",
        name              = "Summon Kolmisilmän Koipi",
        description       = "Summons Kolmisilmän Koipi.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_limbs.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_limbs/boss_limbs.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_ROBOT",
        name              = "Summon Kolmisilmän silmä",
        description       = "Summons Kolmisilmän Koipi.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_robot.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_robot/boss_robot.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_MAGGOT_TINY",
        name              = "Summon Limatoukka",
        description       = "Summons Limatoukka.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_maggot_tiny.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/maggot_tiny/maggot_tiny.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_FLASK",
        name              = "Summon flask",
        description       = "Summons an empty flask",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_flask.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 90,
        max_uses          = 1,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/potion_empty.xml")
        end,
    },

    {
        id                = "SUMMON_FLASK_FULL",
        name              = "Summon filled flask",
        description       = "Summons a flask filled with a random material",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_flask_full.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 300,
        mana              = 120,
        max_uses          = 1,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/potion_random_material.xml")
        end,
    },

    {
        id                = "SUMMON_JAR",
        name              = "Summon jar",
        description       = "Summons an empty jar",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_jar.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.050,	0.067,	0.100,	0.067,	0.050",
        price             = 200,
        mana              = 90,
        max_uses          = 1,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/jar.xml")
        end,
    },

    {
        id                = "SUMMON_JAR_URINE",
        name              = "Jarate",
        description       = "Jar-based Karate",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_jar_urine.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.025,	0.033,	0.050,	0.033,	0.025",
        price             = 200,
        mana              = 45,
        max_uses          = 30,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 10
            current_reload_time = current_reload_time + 20
            add_projectile("data/entities/items/pickup/jar_of_urine.xml")
        end,
    },

    {
        id                = "SUMMON_SUN",
        name              = "Summon Sun",
        description       = "Summons the sun.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_sun.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 3000,
        action            = function()
            add_projectile("data/entities/items/pickup/sun/newsun.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_DARK_SUN",
        name              = "Summon Dark Sun",
        description       = "Summons the dark sun.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_dark_sun.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 3000,
        action            = function()
            add_projectile("data/entities/items/pickup/sun/newsun_dark.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "BUFF_BERSERK",
        name              = "Status: Berserk",
        description       = "Applies the berserk status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_berserk.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_berserk.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_BOUNCE",
        name              = "Status: Bouncing Shots",
        description       = "Applies the bouncing shots status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_bounce.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_bounce.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_DAMAGE_PLUS",
        name              = "Status: Damage plus",
        description       = "Applies the damage plus status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_damage_plus.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_damage_plus.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_EDIT_WANDS_EVERYWHERE",
        name              = "Status: Tinker with wands",
        description       = "Applies the tinker with wands status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_edit_wands_everywhere.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.083,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_edit_wands_everywhere.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_FASTER_LEVITATION",
        name              = "Status: Faster levitiation",
        description       = "Applies the faster levitation status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_faster_levitation.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_faster_levitation.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_HOMING",
        name              = "Status: Homing shots",
        description       = "Applies the homing shots status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_homing.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_homing.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_HP_REGENERATION",
        name              = "Status: Health regeneration",
        description       = "Applies the health regeneration status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_hp_regeneration.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_hp_regeneration.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_INVISIBILITY",
        name              = "Status: Invisibility",
        description       = "Applies the invisibility status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_invisibility.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_invisibility.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_MANA_REGENERATION",
        name              = "Status: Mana regeneration",
        description       = "Applies the mana regeneration status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_mana_regeneration.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_mana_regeneration.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_MOVEMENT_FASTER",
        name              = "Status: Greased lightning",
        description       = "Applies the greased lightning status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_movement_faster.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_movement_faster.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_NIGHTVISION",
        name              = "Status: Wormy vision",
        description       = "Applies the wormy vision status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_nightvision.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_nightvision.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_PROTECTION_ALL",
        name              = "Status: Immunity",
        description       = "Applies the immunity status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_protection_all.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_protection_all.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_RECHARGE",
        name              = "Status: Reduced recharge",
        description       = "Applies the reduced recharge status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_recharge.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
                    px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_SHIELD",
        name              = "Status: Shielded",
        description       = "Applies the shielded status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_shield.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_shield.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },
    --[[
	{
		id					= "SPELL_REFRESH",
		name				= "Spell refresh",
		description			= "Refreshes the spells within your wands and inventory",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/spell_refresh.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
		spawn_probability	= "0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005",
		price				= 600,
		mana				= 240,
        ai_never_uses       = true,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
            if reflecting then return; end
			local entity_id = GetUpdatedEntityID()


            local valid1 = false
            local valid2 = false
            local spell_comp
            local uses_left
            local stomach
			local player = EntityGetWithTag( "player_unit" )[1]
			if entity_id ~= nil and entity_id == player then
                IngestionComps = EntityGetComponent(player, "IngestionComponent")

                for _, value in pairs(IngestionComps)do
                    stomach = value
                    local fullness = ComponentGetValue2(value, "ingestion_size")
                    if fullness >= 500 then
                        valid1 = true
                    else
                        valid1 = false
                        GamePrint("Not enough satiety!")
                        return
                    end

                    local inventory_2_comp = EntityGetFirstComponentIncludingDisabled( player, "Inventory2Component")
                    if inventory_2_comp == nil then return end
                    local wand_id = ComponentGetValue2( inventory_2_comp, "mActiveItem" )
                    for i, spell in ipairs(EntityGetAllChildren( wand_id )) do
                        spell_comp = EntityGetFirstComponentIncludingDisabled( spell, "ItemComponent" )
                        if spell_comp ~= nil then
                            ComponentSetValue2( spell_comp, "uses_remaining", uses_left - 1 )
                        end
                    end

                    if valid1 == true and valid2 == true then
                        ComponentSetValue2(stomach, "ingestion_size", fullness - 500) ---@diagnostic disable-next-line: param-type-mismatch
                        ComponentSetValue2( spell_comp, "uses_remaining", uses_left - 1 )
                        add_projectile( "mods/copis_things/files/entities/projectiles/vomere.xml" );
                        c.fire_rate_wait = c.fire_rate_wait + 15;
                        current_reload_time = current_reload_time + 33;
                    end

                end

            end

        end
	},
]]
    {
        id                = "GOLD",
        name              = "Gold",
        description       = "Summons a nugget of gold",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/gold.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
        spawn_probability = "0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001",
        price             = 200000,
        mana              = 150,
        max_uses          = 3,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/goldnugget_200.xml")
        end,
    },
    {
        id                = "FREEZING_VAPOUR_TRAIL",
        name              = "Freezing Vapour Trail",
        description       = "Gives a projectile a trail of stinging frost",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/freezing_vapour_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
        price             = 300,
        mana              = 13,
        action            = function()
            c.trail_material = c.trail_material .. "blood_cold";
            c.trail_material_amount = c.trail_material_amount + 5;
            draw_actions(1, true);
        end,
    },
    {
        id                = "VOID_TRAIL",
        name              = "Void Liquid Trail",
        description       = "Gives a projectile a trail of pure darkness",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/void_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
        price             = 200,
        mana              = 6,
        action            = function()
            c.trail_material = c.trail_material .. "void_liquid,";
            c.trail_material_amount = c.trail_material_amount + 1;
            draw_actions(1, true);
        end,
    },
    {
        id                = "DAMAGE_CRITICAL",
        name              = "Critical strike",
        description       = "Increases spell critical damage",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/damage_critical.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7", -- FIREBALL_RAY
        price             = 300,
        mana              = 10,
        action            = function()
            c.damage_critical_multiplier = math.max(1, c.damage_critical_multiplier) + 1;
            draw_actions(1, true);
        end,
    },
    {
        id                = "DIMIGE",
        name              = "Dimige",
        description       = "Increases spell damage slightly for each projectile spell on the wand",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dimige.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3", -- FIREBALL_RAY
        spawn_probability = "1.0,1.0,1.0,1.0", -- FIREBALL_RAY
        price             = 70,
        mana              = 5,
        action            = function()
            local projectile_type_sum = 0;
            for k, v in ipairs(deck or {}) do if v.type == ACTION_TYPE_PROJECTILE or
                v.type == ACTION_TYPE_STATIC_PROJECTILE or v.type == ACTION_TYPE_MATERIAL then projectile_type_sum = projectile_type_sum
                + 1; end end
            for k, v in ipairs(hand or {}) do if v.type == ACTION_TYPE_PROJECTILE or
                v.type == ACTION_TYPE_STATIC_PROJECTILE or v.type == ACTION_TYPE_MATERIAL then projectile_type_sum = projectile_type_sum
                + 1; end end
            for k, v in ipairs(discarded or {}) do if v.type == ACTION_TYPE_PROJECTILE or
                v.type == ACTION_TYPE_STATIC_PROJECTILE or v.type == ACTION_TYPE_MATERIAL then projectile_type_sum = projectile_type_sum
                + 1; end end
            c.damage_projectile_add = c.damage_projectile_add + 0.04 + 0.04 * projectile_type_sum;
            draw_actions(1, true);
        end,
    },
    {
        id                = "POWER_SHOT",
        name              = "Power Shot",
        description       = "Cast a spell with increased damage and material penetration",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/power_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7", -- FIREBALL_RAY
        price             = 300,
        mana              = 20,
        action            = function()
            c.damage_projectile_add = c.damage_projectile_add + 0.24;
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/power_shot.xml,";
            draw_actions(1, true);
        end,
    },
    {
        id                = "STICKY_SHOT",
        name              = "Sticky Shot",
        description       = "Cast a spell which sticks to surfaces it hits",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/sticky_shot.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.6,0.6,0.6,0.6,0.6,0.6,0.6", -- FIREBALL_RAY
        price             = 200,
        mana              = 9,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/sticky_shot.xml,";
            c.gravity = c.gravity + 300.0
            draw_actions(1, true);
        end,
    },
    {
        id                = "LIGHT_REMOVER",
        name              = "Light Remover",
        description       = "Removes the light from a projectile",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/light_remover.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2", -- FIREBALL_RAY
        price             = 50,
        mana              = 0,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/light_remover.xml,";
            draw_actions(1, true);
        end,
    },
    {
        id                = "LOVELY_TRAIL",
        name              = "Lovely Trail",
        description       = "Show your enemies some love",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/lovely_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price             = 10,
        mana              = 0,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/lovely_trail.xml,";
            draw_actions(1, true);
        end,
    },
    {
        id                = "STARRY_TRAIL",
        name              = "Starry Trail",
        description       = "Only shooting stars",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/starry_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price             = 10,
        mana              = 0,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/starry_trail.xml,";
            draw_actions(1, true);
        end,
    },
    {
        id                = "SPARKLING_TRAIL",
        name              = "Sparkling Trail",
        description       = "Spread glitter across the world",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/sparkling_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price             = 10,
        mana              = 0,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/sparkling_trail.xml,";
            draw_actions(1, true);
        end,
    },
    {
        id                = "NULL_TRAIL",
        name              = "Null Trail",
        description       = "Remove all particle emitters from the projectile",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/null_trail.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price             = 10,
        mana              = 0,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/null_trail.xml,";
            draw_actions(1, true);
        end,
    },

    {
        id                = "RANDOM_CAST",
        name              = "Random cast",
        description       = "Casts a spell from a random position",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/random_cast.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,3,4,5", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price             = 90,
        mana              = 0,
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait - 10
            if reflecting then return; end
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/random_cast.xml", 1)
        end,
    },

    {
        id                = "ROOT_GROWER",
        name              = "Creeping Vines",
        description       = "Spawns a mass of rapidly growing nature",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/root_grower.png",
        type              = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level       = "0,1,2,3,4,5", -- FIREBALL_RAY
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
        price             = 90,
        mana              = 40,
        max_uses          = 10,
        action            = function()
            add_projectile("mods/copis_things/files/entities/props/root_grower.xml")
            c.fire_rate_wait = c.fire_rate_wait + 12
        end,
    },

    {
        id                = "HOMING_CURSOR",
        name              = "Cursor Homing",
        description       = "Homing projectiles will be able to target your cursor",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/homing_cursor.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 100,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/homing_cursor.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                     = "HOMING_ANTI",
        name                   = "Anti Homing",
        description            = "Projectiles will be repelled by enemies",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/homing_anti.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/homing_anti.xml,data/entities/particles/tinyspark_white_weak.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- HOMING
        spawn_probability      = "0.1,0.1,0.1,0.1,0.1", -- HOMING
        price                  = 100,
        mana                   = 0,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/homing_anti.xml,data/entities/particles/tinyspark_white_weak.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "PROTECTION_FIRE",
        name              = "Fire immunity",
        description       = "Your wand grants you a magical aura of fire immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_fire.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_fire.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_EXPLOSION",
        name              = "Explosion immunity",
        description       = "Your wand grants you a magical aura of explosion immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_explosion.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_explosion.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_ELECTRICITY",
        name              = "Electricity immunity",
        description       = "Your wand grants you a magical aura of electricity immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_electricity.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_electricity.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_ICE",
        name              = "Freeze immunity",
        description       = "Your wand grants you a magical aura of freeze immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_ice.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_ice.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_RADIOACTIVITY",
        name              = "Toxic immunity",
        description       = "Your wand grants you a magical aura of toxic immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_radioactivity.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_radioactivity.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_MELEE",
        name              = "Melee immunity",
        description       = "Your wand grants you a magical aura of melee immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_melee.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_melee.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_POLYMORPH",
        name              = "Polymorph immunity",
        description       = "Your wand grants you a magical aura of polymorph immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_polymorph.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.05,0.05,0.05,0.05,0.05,0.05,0.1", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_polymorph.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROJECTILE_HOMING",
        name              = "Passive Homing",
        description       = "All projectiles fired while holding the wand slighty home in on enemies!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/projectile_homing.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
        price             = 800,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/projectile_homing.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "INVISIBILITY",
        name              = "Invisibility",
        description       = "Your wand grants you a magical aura of invisibility!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/invisibility.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
        price             = 800,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/invisibility.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "BREATH_UNDERWATER",
        name              = "Breath Underwater",
        description       = "Your wand grants you a magical aura of respiration!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/breath_underwater.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
        price             = 800,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/breath_underwater.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "ATTACK_LEG",
        name              = "Lukki Limb",
        description       = "Control a Lukki leg to kick nearby enemies automatically",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/attack_leg.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.1,0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/attack_leg.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                = "BAYONET",
        name              = "Bayonet",
        description       = "Attach a small knife to the tip of your wand --INDEV WRONG AREA DAMAGE--",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/bayonet.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.1,0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/bayonet.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                = "KICK_EXPLOSION",
        name              = "Explosive Kick",
        description       = "Create a devastating explosion when you kick. Use wisely! Consumes 60 mana when you kick.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/kick_explosion.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 280,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/kick_explosion.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                = "ALT_FIRE_FLAMETHROWER",
        name              = "Sidearm Flamethrower",
        description       = "Fires a deadly stream of flames while you hold alt fire. Consumes 20 mana per shot.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_flamethrower.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 280,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_flamethrower.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                  = "DECOY",
        name                = "$action_decoy",
        description         = "$actiondesc_decoy",
        sprite              = "data/ui_gfx/gun_actions/decoy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/decoy_unidentified.png",
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability   = "0.1,0.3,0.2,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price               = 130,
        mana                = 60,
        max_uses            = 10,
        custom_xml_file     = "data/entities/misc/custom_cards/decoy.xml",
        action              = function()
            add_projectile("data/entities/projectiles/deck/decoy.xml")
            c.fire_rate_wait = c.fire_rate_wait + 40
        end,
    },

    {
        id                  = "DECOY_TRIGGER",
        name                = "$action_decoy_trigger",
        description         = "$actiondesc_decoy_trigger",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/decoy_death_trigger.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/decoy_trigger_unidentified.png",
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability   = "0.1,0.3,0.2,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price               = 150,
        mana                = 80,
        max_uses            = 10,
        custom_xml_file     = "data/entities/misc/custom_cards/decoy_trigger.xml",
        action              = function()
            add_projectile_trigger_death("data/entities/projectiles/deck/decoy_trigger.xml", 1)
            c.fire_rate_wait = c.fire_rate_wait + 40
        end,
    },

    {
        id                     = "HITFX_EXPLOSION_FROZEN",
        name                   = "Explosion on frozen enemies",
        description            = "Makes a projectile explode upon collision with frozen creatures",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,3,4,5", -- HITFX_EXPLOSION_ALCOHOL
        spawn_probability      = "0.2,0.2,0.2,0.2", -- HITFX_EXPLOSION_ALCOHOL
        price                  = 140,
        mana                   = 20,
        --max_uses = 50,
        action                 = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                     = "HITFX_EXPLOSION_FROZEN_GIGA",
        name                   = "Giant explosion on frozen enemies",
        description            = "Makes a projectile explode powerfully upon collision with frozen creatures",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen_giga.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_explode_frozen_giga.xml",
            "data/entities/particles/tinyspark_orange.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,3,4,5", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        spawn_probability      = "0.1,0.1,0.1,0.1", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        price                  = 300,
        mana                   = 200,
        max_uses               = 20,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,data/entities/particles/tinyspark_orange.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                     = "CIRCLE_EDIT_WANDS_EVERYWHERE",
        name                   = "Circle of Divine Blessing",
        description            = "A field of modification magic",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/circle_edit_wands_everywhere.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml" },
        type                   = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level            = "0,		1,		2,		3",
        spawn_probability      = "1,		1,		1,		1",
        price                  = 200,
        mana                   = 50,
        max_uses               = 3,
        action                 = function()
            add_projectile("mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml")
            draw_actions(1, true)
        end,
    },

    {
        id                     = "MINI_SHIELD",
        name                   = "Projectile Bubble Shield",
        description            = "Encases a projectile in a deflective shield",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/mini_shield.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/mini_shield.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "0,1,2,3,4,5,6", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        spawn_probability      = "1,1,1,1,1,1,1", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        price                  = 540,
        mana                   = 20,
        action                 = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/mini_shield.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                  = "NGON_SHAPE",
        name                = "Formation - N-gon",
        description         = "Cast all remaining spells in a circular pattern",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ngon_shape.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type                = ACTION_TYPE_DRAW_MANY,
        spawn_level         = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability   = "0.33,	0.33,	0.33,	0.33,	0.33,	0.33,	0.33",
        price               = 120,
        mana                = 24,
        action              = function()
            c.pattern_degrees = 180;
            draw_actions(#deck, true);
        end,
    },

    {
        id                  = "SHUFFLE_DECK",
        name                = "Shuffle Deck",
        description         = "Randomize the order of all spells in the cast",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/shuffle_deck.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability   = "0.4,	0.4,	0.4,	0.4,	0.4,	0.4,	0.4",
        price               = 100,
        mana                = -20,
        action              = function()
            SetRandomSeed(GameGetFrameNum(), 1284);
            local shuffle_deck = {};
            for i = 1, #deck do
                local index = Random(1, #deck);
                local action = deck[index];
                table.remove(deck, index);
                table.insert(shuffle_deck, action);
            end
            for index, action in pairs(shuffle_deck) do
                table.insert(deck, action);
            end
            draw_actions(1, true);
        end,
    },


    {
        id                  = "STORED_SHOT",
        name                = "Stored cast",
        description         = "Summon a magical phenomenon that casts a spell when you stop casting",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/stored_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type                = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level         = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability   = "0.4,	0.4,	0.4,	0.4,	0.4,	0.4,	0.4",
        price               = 160,
        mana                = 4,
        action              = function()
            current_reload_time = current_reload_time + 3;
            if reflecting then return; end
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/stored_shot.xml", 1);
        end,
    },

    {
        id                     = "BARRIER_TRAIL",
        name                   = "Barrier Trail",
        description            = "Projectiles gain a trail of barriers",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/barrier_trail.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/barrier_trail.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,		3,		4,		5",
        spawn_probability      = "0.7,	0.7,	0.7,	0.7",
        price                  = 200,
        mana                   = 20,
        action                 = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/barrier_trail.xml,"
            draw_actions(1, true);
        end,
    },

    {
        id                     = "EXPIRE_NEARBY_ENEMIES",
        name                   = "Projectile Area Expiration",
        description            = "Projectiles will expire when enemies are nearby",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/expire_nearby_enemies.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/expire_nearby_enemies.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,		4,		5,		6",
        spawn_probability      = "0.2,	0.2,	0.5,	0.1",
        price                  = 50,
        mana                   = 5,
        action                 = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/expire_nearby_enemies.xml,"
            draw_actions(1, true);
        end,
    },

    {
        id                  = "DEATH_RAY",
        name                = "Deathray",
        description         = "A blast of crackling red energy",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/death_ray.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/death_ray.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "3,			4",
        spawn_probability   = "1.00,		0.50",
        price               = 220,
        mana                = 25,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/death_ray.xml")
        end,
    },

    {
        id                  = "LIGHT_BULLET_DEATH_TRIGGER",
        name                = "Spark bolt with expiration trigger",
        description         = "A spark bolt that casts another spell upon expiring",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_death_trigger.png",
        related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3", -- LIGHT_BULLET_TRIGGER
        spawn_probability   = "1,0.5,0.5,0.5", -- LIGHT_BULLET_TRIGGER
        price               = 140,
        mana                = 10,
        --max_uses = 100,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 3
            c.screenshake = c.screenshake + 0.5
            c.damage_critical_chance = c.damage_critical_chance + 5
            add_projectile_trigger_death("data/entities/projectiles/deck/light_bullet.xml", 1)
        end,
    },

    {
        id                  = "LIGHT_BULLET_INHERIT_TRIGGER",
        name                = "Spark bolt with inheritance trigger",
        description         = "A spark bolt that casts another spell upon expiring, which inherits modifiers",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_inherit_trigger.png",
        related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "2,3,4", -- LIGHT_BULLET_TRIGGER
        spawn_probability   = "0.2,0.2,0.2", -- LIGHT_BULLET_TRIGGER
        price               = 280,
        mana                = 60,
        --max_uses = 100,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 3
            c.screenshake = c.screenshake + 0.5
            c.damage_critical_chance = c.damage_critical_chance + 5

            if reflecting then
                Reflection_RegisterProjectile("data/entities/projectiles/deck/light_bullet.xml")
                return
            end

            local c_old = c
            BeginProjectile("data/entities/projectiles/deck/light_bullet.xml");
            BeginTriggerDeath();
            draw_actions(1, true);
            register_action(c);
            SetProjectileConfigs();
            EndTrigger();
            EndProjectile();
            c = c_old
        end,
    },
    --[[
	{
		id          = "LIGHT_DELAY_2",
		name 		= "Double Burst",
		description = "Casts 2 spells in a row",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/delay_2.png",
		related_projectiles	= {"data/entities/projectiles/deck/light_bullet.xml"},
		type 		= ACTION_TYPE_DRAW_MANY,
		spawn_level                         = "2,3,4", -- LIGHT_BULLET_TRIGGER
		spawn_probability                   = "0.2,0.2,0.2", -- LIGHT_BULLET_TRIGGER
		price = 280,
		mana = 5,
		--max_uses = 100,
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.damage_critical_chance = c.damage_critical_chance + 5

			if reflecting then
				Reflection_RegisterProjectile("data/entities/projectiles/deck/light_bullet.xml")
				return
			end

			local c_old = c
            BeginProjectile( "data/entities/projectiles/deck/light_bullet.xml" );
                BeginTriggerDeath();
                    draw_actions( 1, true );
                    register_action( c );
                    SetProjectileConfigs();
                EndTrigger();
            EndProjectile();
			c = c_old
		end,
	},
]]
    {
        id                  = "IF_PLAYER",
        name                = "Requirement - Player",
        description         = "The next spell is skipped if the spell isn't cast by the player",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/if_player.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_maths",
        type                = ACTION_TYPE_OTHER,
        spawn_level         = "10", -- MANA_REDUCE
        spawn_probability   = "1", -- MANA_REDUCE
        price               = 100,
        mana                = 0,
        action              = function(recursion_level, iteration)
            local endpoint = -1
            local elsepoint = -1
            local entity_id = GetUpdatedEntityID()
            local player_id = EntityGetWithTag("player_unit")[1]

            local doskip = false
            if (entity_id ~= player_id) then
                doskip = true
            end

            if (#deck > 0) then
                for i, v in ipairs(deck) do
                    if (v ~= nil) then
                        if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
                            endpoint = -1
                            break
                        end

                        if (v.id == "IF_ELSE") then
                            endpoint = i
                            elsepoint = i
                        end

                        if (v.id == "IF_END") then
                            endpoint = i
                            break
                        end
                    end
                end

                local envelope_min = 1
                local envelope_max = 1

                if doskip then
                    if (elsepoint > 0) then
                        envelope_max = elsepoint
                    elseif (endpoint > 0) then
                        envelope_max = endpoint
                    end

                    for i = envelope_min, envelope_max do
                        local v = deck[envelope_min]

                        if (v ~= nil) then
                            table.insert(discarded, v)
                            table.remove(deck, envelope_min)
                        end
                    end
                else
                    if (elsepoint > 0) then
                        envelope_min = elsepoint

                        if (endpoint > 0) then
                            envelope_max = endpoint
                        else
                            envelope_max = #deck
                        end

                        for i = envelope_min, envelope_max do
                            local v = deck[envelope_min]

                            if (v ~= nil) then
                                table.insert(discarded, v)
                                table.remove(deck, envelope_min)
                            end
                        end
                    end
                end
            end

            draw_actions(1, true)
        end,
    },

    {
        id                  = "IF_ALT_FIRE",
        name                = "Requirement - Alt Fire",
        description         = "The next spell is skipped if the alt fire key isn't held down",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/if_alt_fire.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_maths",
        type                = ACTION_TYPE_OTHER,
        spawn_level         = "10", -- MANA_REDUCE
        spawn_probability   = "1", -- MANA_REDUCE
        price               = 100,
        mana                = 0,
        action              = function(recursion_level, iteration)
            local endpoint = -1
            local elsepoint = -1
            local entity_id = GetUpdatedEntityID()
            local player_id = EntityGetWithTag("player_unit")[1]
            local controlscomp = EntityGetFirstComponent(player_id, "ControlsComponent")

            local doskip = false    ---@diagnostic disable-next-line: param-type-mismatch
            if (ComponentGetValue2(controlscomp, "mButtonDownRightClick") ~= true) then
                doskip = true
            end

            if (#deck > 0) then
                for i, v in ipairs(deck) do
                    if (v ~= nil) then
                        if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
                            endpoint = -1
                            break
                        end

                        if (v.id == "IF_ELSE") then
                            endpoint = i
                            elsepoint = i
                        end

                        if (v.id == "IF_END") then
                            endpoint = i
                            break
                        end
                    end
                end

                local envelope_min = 1
                local envelope_max = 1

                if doskip then
                    if (elsepoint > 0) then
                        envelope_max = elsepoint
                    elseif (endpoint > 0) then
                        envelope_max = endpoint
                    end

                    for i = envelope_min, envelope_max do
                        local v = deck[envelope_min]

                        if (v ~= nil) then
                            table.insert(discarded, v)
                            table.remove(deck, envelope_min)
                        end
                    end
                else
                    if (elsepoint > 0) then
                        envelope_min = elsepoint

                        if (endpoint > 0) then
                            envelope_max = endpoint
                        else
                            envelope_max = #deck
                        end

                        for i = envelope_min, envelope_max do
                            local v = deck[envelope_min]

                            if (v ~= nil) then
                                table.insert(discarded, v)
                                table.remove(deck, envelope_min)
                            end
                        end
                    end
                end
            end

            draw_actions(1, true)
        end,
    },

    {
        id                     = "ZIPPING_ARC",
        name                   = "Zipping Arc",
        description            = "Causes a projectile to zip away from walls",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/zipping_arc.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/sinewave_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/zipping_arc.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,4,6",
        spawn_probability      = "0.3,0.5,0.4",
        price                  = 50,
        mana                   = 10,
        --max_uses = 150,
        action                 = function()
            c.fire_rate_wait = c.fire_rate_wait + 10
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/zipping_arc.xml,"
            draw_actions(1, true);
        end,
    },

    {
        id                  = "SLOW_BULLET_TIMER_2",
        name                = "Energy orb with two timers",
        description         = "A slow but powerful orb of energy that casts a spell after a timer runs out, then a second spell after a secondary timer runs out",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/slow_bullet_timer_2.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/bullet_slow.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "1,2,3,4,5,6", -- SLOW_BULLET_TIMER
        spawn_probability   = "0.5,0.5,0.5,0.5,1,1", -- SLOW_BULLET_TIMER
        price               = 200,
        mana                = 50,
        --max_uses = 50,
        custom_xml_file     = "data/entities/misc/custom_cards/bullet_slow.xml",
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 6
            c.screenshake = c.screenshake + 2
            c.spread_degrees = c.spread_degrees + 3.6

            if reflecting then
                Reflection_RegisterProjectile("data/entities/projectiles/deck/bullet_slow.xml")
                return
            end

            BeginProjectile("data/entities/projectiles/deck/bullet_slow.xml")
            BeginTriggerTimer(25)
            draw_shot(create_shot(1), true)
            EndTrigger()
            BeginTriggerTimer(50)
            draw_shot(create_shot(1), true)
            EndTrigger()
            EndProjectile()

            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
        end,
    },

    {
        id                  = "SLOW_BULLET_TIMER_N",
        name                = "Energy orb with n timers",
        description         = "A slow but powerful orb of energy that casts all remaining spells with a delay dependent on your cast delay",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/slow_bullet_timer_n.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/bullet_slow.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "1,2,3,4,5,6", -- SLOW_BULLET_TIMER
        spawn_probability   = "0.3,0.3,0.3,0.3,0.5,0.5", -- SLOW_BULLET_TIMER
        price               = 200,
        mana                = 50,
        --max_uses = 50,
        custom_xml_file     = "data/entities/misc/custom_cards/bullet_slow.xml",
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 6
            c.screenshake = c.screenshake + 2
            c.spread_degrees = c.spread_degrees + 3.6

            if reflecting then
                Reflection_RegisterProjectile("data/entities/projectiles/deck/bullet_slow.xml")
                return
            end

            local firerate = c.fire_rate_wait
            local n = 1

            BeginProjectile("data/entities/projectiles/deck/bullet_slow.xml")
            while (#deck > 0) do
                n = n + 1
                BeginTriggerTimer(firerate * n)
                c.speed_multiplier = math.max(c.speed_multiplier, 1)
                draw_shot(create_shot(1), true)
                EndTrigger()
            end
            EndProjectile()

            c.lifetime_add = c.lifetime_add + (n * firerate)

            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
        end,
    },
    --[[	WIP - FIX BOUNCE FORCE
		{
			id					= "SILVER_BULLET_RECURSIVE_TRIGGER",
			name				= "Silver bullet with Recursive Trigger",
			description			= "A small bullet created from arcane silver which fires a copy which fires a spell upon collision",
			sprite				= "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_recursive_trigger.png",
			related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_bullet.xml"},
			type				= ACTION_TYPE_PROJECTILE,
			spawn_level			= "2,3,4",
			spawn_probability	= "0.2,0.2,0.1",
			price				= 420,
			mana				= 50,
			action				= function()
				c.fire_rate_wait = c.fire_rate_wait - 24;
	
				if reflecting then
					Reflection_RegisterProjectile( "mods/copis_things/files/entities/projectiles/silver_bullet.xml" )
					return
				end
	
				BeginProjectile( "mods/copis_things/files/entities/projectiles/silver_bullet.xml" )
					BeginTriggerHitWorld()
						BeginProjectile( "mods/copis_things/files/entities/projectiles/silver_bullet.xml" )
							BeginTriggerHitWorld()
								draw_shot( create_shot( 1 ), true )
							EndTrigger()
						EndProjectile()
					EndTrigger()
				EndProjectile()
			end,
		},
	]]

    {
        id                  = "LIGHT_BULLET_RECURSIVE_TRIGGER",
        name                = "Spark bolt with Recursive Trigger",
        description         = "A spark bolt which fires a copy which fires a spell upon collision",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_recursive_trigger.png",
        related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3", -- LIGHT_BULLET_TRIGGER
        spawn_probability   = "1,0.5,0.5,0.5", -- LIGHT_BULLET_TRIGGER
        price               = 160,
        mana                = 20,
        --max_uses = 100,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 6
            c.screenshake = c.screenshake + 1
            c.damage_critical_chance = c.damage_critical_chance + 10

            if reflecting then
                Reflection_RegisterProjectile("data/entities/projectiles/deck/light_bullet.xml")
                return
            end

            BeginProjectile("data/entities/projectiles/deck/light_bullet.xml")
            BeginTriggerHitWorld()
            BeginProjectile("data/entities/projectiles/deck/light_bullet.xml")
            BeginTriggerHitWorld()
            draw_shot(create_shot(1), true)
            EndTrigger()
            EndProjectile()
            EndTrigger()
            EndProjectile()
        end,
    },

    {
        id                  = "FALSE_SPELL",
        name                = "False Spell",
        description         = "A spell that quickly dissipates",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/false_spell.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/false_spell.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1",
        spawn_probability   = "0.1,0.1",
        price               = 90,
        mana                = 1,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait - 6;
            current_reload_time = current_reload_time - 3
            add_projectile("mods/copis_things/files/entities/projectiles/false_spell.xml")
        end,
    },
    --[[	WIP - SET UP CHARGING MECHANISM PROPERLY
	{
		id          		= "CHARGE_BULLET",
		name 				= "Loaded Shot",
		description 		= "Loads a bullet every time the spell is cast, all fired when you stop shooting.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/charge_bullet.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_bullet.xml"},
		type 				= ACTION_TYPE_MODIFIER,
		spawn_level			= "2,3,4",
		spawn_probability	= "0.5,0.6,0.4",
		price 				= 220,
		mana 				= 20,
        ai_never_uses       = true,
		action 		= function()
			local entity_id = GetUpdatedEntityID()
			local player = EntityGetWithTag( "player_unit" )[1]
			if entity_id ~= nil and entity_id ~= 0 then
				if (entity_id == player) then
					local controls_component = EntityGetFirstComponent( player, "ControlsComponent" );
					if controls_component ~= nil then
						if ( GameGetFrameNum() == ComponentGetValue2( controls_component, "mButtonFrameFire" ) ) then
							GlobalsSetValue("Charge_bullet_revs", "0")
						else
							GlobalsSetValue("Charge_bullet_revs", tostring(GlobalsGetValue("Charge_bullet_revs")+1))
						end
						--if ComponentGetValue2( controls_component, "mButtonDownFire") ~= true then
						if tonumber(GlobalsGetValue("Charge_bullet_revs")) == 10 then
							local i = tonumber(GlobalsGetValue("Charge_bullet_revs"))
							while i >= 0 do
								add_projectile("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
								i = i - 1
							end
							GlobalsSetValue("Charge_bullet_revs", "0")
						end
					end
				end
			end
		end
	},
]]
    {
        id                  = "PSI",
        name                = "Psi",
        description         = "Casts a copy of every spell in the last wand",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/psi.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_duplicate",
        type                = ACTION_TYPE_OTHER,
        spawn_manual_unlock = true,
        recursive           = true,
        spawn_level         = "5,6,10", -- MANA_REDUCE
        spawn_probability   = "0.1,0.1,1", -- MANA_REDUCE
        price               = 600,
        mana                = 350,
        action              = function(recursion_level, iteration)
            c.fire_rate_wait = c.fire_rate_wait + 60
            local entity_id = GetUpdatedEntityID()
            local options = {}
            local children = EntityGetAllChildren(entity_id)
            local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")

            if (children ~= nil) and (inventory ~= nil) then

                for i, child_id in ipairs(children) do
                    if (EntityGetName(child_id) == "inventory_quick") then
                        local wand_id = 0
                        local wands = EntityGetAllChildren(child_id)
                        if wands ~= nil and wands[4] ~= nil then
                            wand_id = wands[4]
                        end
                        if (wand_id ~= ComponentGetValue2(inventory, "mActiveItem")) and EntityHasTag(wand_id, "wand") then
                            local spells = EntityGetAllChildren(wand_id)
                            if (spells ~= nil) then
                                for _, spell_id in ipairs(spells) do
                                    local comp = EntityGetFirstComponentIncludingDisabled(spell_id, "ItemActionComponent")
                                    if (comp ~= nil) then
                                        local action_id = ComponentGetValue2(comp, "action_id")
                                        table.insert(options, action_id)
                                    end
                                end
                            end
                        end
                        if (#options > 0) then
                            for _, spell in ipairs(options) do
                                print(tostring(spell))
                                for _, data in ipairs(actions) do
                                    if (data.id == spell) then
                                        local rec = check_recursion(data, recursion_level)
                                        if (rec > -1) then
                                            dont_draw_actions = true
                                            data.action(rec)
                                            dont_draw_actions = false
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end


            end

        end,
    },

    {
        id                = "WAND_SET",
        name              = "Ascension (One-Off)",
        description       = "Cast inside a wand to store it in the heavens.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/wand_set.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
        spawn_probability = "0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05",
        price             = 2000,
        mana              = 0,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 500
            local entity_id     = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local x, y = EntityGetTransform(entity_id)
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                if not ModSettingGet("copis_things.wand0") then
                    local wand = EZWand.GetHeldWand()
                    wand:RemoveSpells("COPIS_THINGS_WAND_SET")
                    ModSettingSet("copis_things.wand0", wand:Serialize())
                    GameScreenshake(50, x, y)
                    EntityLoad("mods/copis_things/files/entities/particles/blast.xml", x, y)
                    GamePrintImportant("Your wand disintegrates into divine light!", "Wand stored!")
                    EntityKill(wand.entity_id)
                else
                    GameScreenshake(10, x, y)
                    GamePrintImportant("You feel the heavens are full", "Wand already stored!")
                    GamePrint("Retrieve your stored wand before inserting a new one")
                end
            end
        end
    },

    {
        id                = "WAND_GET",
        name              = "Deliverance (One-Off)",
        description       = "Cast inside a wand to retrieve what was once yours.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/wand_get.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
        spawn_probability = "0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05",
        price             = 2000,
        mana              = 0,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 500
            local entity_id     = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local x, y = EntityGetTransform(entity_id)
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                if not ModSettingGet("copis_things.wand0") then
                    GamePrintImportant("You feel an emptiness in the heavens", "No wand stored!")
                    GamePrint("Store a wand to retrieve")
                else
                    local wand = EZWand(ModSettingGet("copis_things.wand0"), x, y)
                    GamePrintImportant("The heavens deliver a gift!", "Wand retrieved!")
                    GameScreenshake(10, x, y)
                    EntityLoad("mods/copis_things/files/entities/particles/blast.xml", x, y)
                    ModSettingRemove("copis_things.wand0")
                    local wand2 = EZWand.GetHeldWand()
                    wand2:RemoveSpells("COPIS_THINGS_WAND_GET")
                end
            end
        end
    },

    {
        id                = "AUTO_FRAME",
        name              = "Automation - Constant",
        description       = "Your held wand fires constantly",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/passive_auto_frame.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/auto_frame.xml",
        action            = function()
            draw_actions(1, true)
        end,
    },

    {
        id                = "AUTO_HURT",
        name              = "Automation - Hurt",
        description       = "Your held wand fires when you're hurt",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/passive_auto_hurt.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/auto_hurt.xml",
        action            = function()
            draw_actions(1, true)
        end,
    },

    {
        id                = "AUTO_ALT_FIRE",
        name              = "Automation - Alt fire",
        description       = "Your held wand fires when you hold alt fire",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/passive_auto_alt_fire.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/auto_alt_fire.xml",
        action            = function()
            draw_actions(1, true)
        end,
    },

    {
        id                  = "ICICLE_LANCE",
        name                = "Icicle Lance",
        description         = "A rapidly accelerating icicle which impales itself into terrain",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/icicle_lance.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/icicle_lance.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "1,2,3,4,5,6",
        spawn_probability   = "1,1,1,1,1,1",
        price               = 175,
        mana                = 25,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            add_projectile("mods/copis_things/files/entities/projectiles/icicle_lance.xml")
        end,
    },

    {
        id                     = "STATIC_TO_EXPLOSION",
        name                   = "Terrain Detonator",
        description            = "Makes any hard, solid materials within a projectile's range explode violently",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/static_to_explosion.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/static_to_explosion.xml",
            "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4", -- STATIC_TO_SAND
        spawn_probability      = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price                  = 140,
        mana                   = 70,
        max_uses               = 8,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/static_to_explosion.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end,
    },

    {
        id                     = "LIQUID_TO_SOIL",
        name                   = "Liquids to Soil",
        description            = "Makes any fluids within a projectile's range turn earthly",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/liquid_to_soil.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/liquid_to_soil.xml",
            "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4", -- STATIC_TO_SAND
        spawn_probability      = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price                  = 140,
        mana                   = 70,
        max_uses               = 8,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/liquid_to_soil.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end,
    },

    {
        id                     = "POWDER_TO_WATER",
        name                   = "Powders to water",
        description            = "Makes any soft, powdery materials within a projectile's range dissolve into water",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/powder_to_water.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/powder_to_water.xml",
            "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4", -- STATIC_TO_SAND
        spawn_probability      = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price                  = 140,
        mana                   = 70,
        max_uses               = 8,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/powder_to_water.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end,
    },

    {
        id                     = "POWDER_TO_STEEL",
        name                   = "Powders to steel",
        description            = "Makes any soft, powdery materials within a projectile's range become hard like metal",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/powder_to_steel.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/powder_to_steel.xml",
            "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4", -- STATIC_TO_SAND
        spawn_probability      = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price                  = 140,
        mana                   = 70,
        max_uses               = 8,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/powder_to_steel.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end,
    },

    {
        id                  = "ZAP",
        name                = "Zap",
        description         = "A short lived spark of electricity",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/zap.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/zap.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "1,3,4",
        spawn_probability   = "1,1,1",
        price               = 170,
        mana                = 8,
        custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/zap.xml",
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait - 5;
            current_reload_time = current_reload_time - 5;

            if reflecting then
                Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                return;
            end

            local function zap(count)
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                BeginTriggerDeath();
                for i = 1, count, 1 do
                    BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                    EndProjectile();
                end
                register_action(c);
                SetProjectileConfigs();
                EndTrigger();
                EndProjectile();
            end

            if GameGetFrameNum() % 3 == 0 then
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                BeginTriggerDeath();
                zap(2)
                zap(2)
                register_action(c);
                SetProjectileConfigs();
                EndTrigger();
                EndProjectile();

            elseif GameGetFrameNum() % 3 == 1 then
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                BeginTriggerDeath();
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                EndProjectile();
                zap(1)
                register_action(c);
                SetProjectileConfigs();
                EndTrigger();
                EndProjectile();

            else
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                BeginTriggerDeath();
                zap(1);
                EndTrigger();
                EndProjectile();

                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml");
                BeginTriggerDeath();
                zap(1)
                EndTrigger();
                EndProjectile();
            end
        end,
    },

    {
        id                  = "MATRA_MAGIC",
        name                = "Matra Magic",
        description         = "Summon a seeking arcane missile",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/matra_magic.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/matra_magic.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "3,4,5,6",
        spawn_probability   = "1,1,1,1",
        price               = 180,
        mana                = 52,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/matra_magic.xml");
            c.fire_rate_wait = c.fire_rate_wait + 33;
            current_reload_time = current_reload_time + 33;
        end,
    },

    {
        id                  = "VOMERE",
        name                = "Vomeremancy",
        description         = "Purge thy satiety, Allow oneself to feast again",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/vomeremancy.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/vomere.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "3,4,5,6",
        spawn_probability   = "1,1,1,1",
        price               = 180,
        mana                = 52,
        max_uses            = 30,
        custom_uses_logic   = true,
        ai_never_uses       = true,
        action              = function()

            if reflecting then return; end
            local valid1 = false
            local valid2 = false
            local spell_comp
            local uses_left
            local stomach
            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            if entity_id ~= nil and entity_id == player then
                IngestionComps = EntityGetComponent(player, "IngestionComponent")

                for _, value in pairs(IngestionComps) do
                    stomach = value
                    local fullness = ComponentGetValue2(value, "ingestion_size")
                    if fullness >= 500 then
                        valid1 = true
                    else
                        valid1 = false
                        GamePrint("Not enough satiety!")
                        return
                    end

                    local inventory_2_comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
                    if inventory_2_comp == nil then return end
                    local wand_id = ComponentGetValue2(inventory_2_comp, "mActiveItem")
                    for i, spell in ipairs(EntityGetAllChildren(wand_id)) do
                        spell_comp = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent")
                        if spell_comp ~= nil and
                            ComponentGetValue2(spell_comp, "mItemUid") == current_action.inventoryitem_id then
                            uses_left = ComponentGetValue2(spell_comp, "uses_remaining")
                            if uses_left ~= 0 then
                                valid2 = true
                            else
                                valid2 = false
                                GamePrint("Not enough charges!")
                                return
                            end
                            break
                        end
                    end

                    if valid1 == true and valid2 == true then
                        ComponentSetValue2(stomach, "ingestion_size", fullness - 500) ---@diagnostic disable-next-line: param-type-mismatch
                        ComponentSetValue2(spell_comp, "uses_remaining", uses_left - 1)
                        add_projectile("mods/copis_things/files/entities/projectiles/vomere.xml");
                        c.fire_rate_wait = c.fire_rate_wait + 15;
                        current_reload_time = current_reload_time + 33;
                    end

                end

            end

        end,
    },

    {
        id                  = "CIRCLE_RANDOM",
        name                = "Circle of Chaos",
        description         = "An expanding circle of a random material",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/circle_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/circle_random.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,4", -- CIRCLE_FIRE
        spawn_probability   = "0.4,0.4,0.4,0.4", -- CIRCLE_FIRE
        price               = 170,
        mana                = 20,
        max_uses            = 15,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/circle_random.xml")
            c.fire_rate_wait = c.fire_rate_wait + 20
        end,
    },

    {
        id                  = "CLOUD_RANDOM",
        name                = "Chaos Cloud",
        description         = "Creates a rain of a random material",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cloud_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/cloud_random.xml" },
        type                = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5", -- CLOUD_WATER
        spawn_probability   = "0.3,0.3,0.3,0.3,0.3,0.3", -- CLOUD_WATER
        price               = 140,
        mana                = 30,
        max_uses            = 10,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/cloud_random.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
    },

    {
        id                  = "TOUCH_RANDOM",
        name                = "Touch of Chaos",
        description         = "Transmutes everything in a short radius into a random material, including walls, creatures... and you",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/touch_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/touch_random.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,4,5,6,7,10", -- TOUCH_WATER
        spawn_probability   = "0,0,0,0,0.1,0.1,0.1,0.1", -- TOUCH_WATER
        price               = 420,
        mana                = 280,
        max_uses            = 5,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/touch_random.xml")
        end,
    },

    {
        id                  = "CHUNK_OF_RANDOM",
        name                = "Chunk of Chaos",
        description         = "A blast of random material",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/chunk_of_random.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,5", -- SOILBALL
        spawn_probability   = "0.4,0.4,0.4,0.4", -- SOILBALL
        price               = 50,
        mana                = 50,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_random.xml")
        end,
    },

    {
        id                  = "MATERIAL_RANDOM",
        name                = "Droplet of Chaos",
        description         = "Transmute drops of a random material from nothing",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/material_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/material_random.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "1,2,3,4,5", -- MATERIAL_WATER
        spawn_probability   = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_WATER
        price               = 110,
        mana                = 0,
        sound_loop_tag      = "sound_spray",
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/material_random.xml")
            c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
        end,
    },

    {
        id                  = "SEA_RANDOM",
        name                = "Sea of Chaos",
        description         = "Summons a large body of a random material below the caster",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/sea_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/sea_random.xml" },
        type                = ACTION_TYPE_MATERIAL,
        spawn_level         = "0,4,5,6", -- SEA_LAVA
        spawn_probability   = "0.2,0.2,0.2,0.2", -- SEA_LAVA
        price               = 350,
        mana                = 140,
        max_uses            = 3,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/sea_random.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
    },
--[[
    {
        id                = "SPELLS_TO_HEART_EXTRAHP",
        name              = "Spells to Vitality",
        description       = "Turn all nearby spells on the ground into hearts",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/spells_to_heart_extrahp.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,4",
        spawn_probability = "0.6,0.6",
        price             = 100,
        mana              = 5,
        max_uses          = 3,
        never_unlimited   = true,
        action            = function()
            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            if (entity_id == player) then
                local pos_x, pos_y = EntityGetTransform(player) ---@diagnostic disable-next-line: param-type-mismatch
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")
                if (mouse_x == nil or mouse_y == nil) then return end
                local aim_x = mouse_x - pos_x
                local aim_y = mouse_y - pos_y
                local len = math.sqrt((aim_x ^ 2) + (aim_y ^ 2))
                local force_x = 1000
                local force_y = 1000
                ---@diagnostic disable-next-line: param-type-mismatch
                ComponentSetValue2(EntityGetFirstComponent(player, "CharacterDataComponent"), "mVelocity",
                    (aim_x / len * force_x), (aim_y / len * force_y))
            end
        end,
    },

    {
        id                  = "TELEPORT_CAST_BETTER",
        name                = "Conveying cast",
        description         = "Casts a spell at the nearest enemy in a large area",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/teleport_cast_better.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/teleport_cast.xml" },
        type                = ACTION_TYPE_UTILITY,
        spawn_level         = "0,1,2,4,5,6", -- TELEPORT_CAST
        spawn_probability   = "0.1,0.2,0.4,0.7,0.6,0.2", -- TELEPORT_CAST
        price               = 190,
        mana                = 100,
        max_uses            = 100,
        custom_uses_logic   = true,
        ai_never_uses       = true,
        action              = function()

            if reflecting then return; end
            local valid2 = false
            local spell_comp
            local uses_left
            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            if entity_id ~= nil and entity_id == player then

                local inventory_2_comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
                if inventory_2_comp == nil then return end
                local wand_id = ComponentGetValue2(inventory_2_comp, "mActiveItem")
                for i, spell in ipairs(EntityGetAllChildren(wand_id)) do
                    spell_comp = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent")
                    if spell_comp ~= nil and
                        ComponentGetValue2(spell_comp, "mItemUid") == current_action.inventoryitem_id then
                        uses_left = ComponentGetValue2(spell_comp, "uses_remaining")
                        if uses_left ~= 0 then
                            ComponentSetValue2(spell_comp, "uses_remaining", uses_left - 1)
                            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/teleport_cast_better.xml");
                            c.fire_rate_wait = c.fire_rate_wait + 30;
                            current_reload_time = current_reload_time + 66;
                        else
                            GamePrint("Not enough charges!")
                            return
                        end
                        break
                    end
                end
            end
        end,
    },
]]
    {
        id                  = "SUMMON_ANVIL",
        name                = "Summon Anvil",
        description         = "Summon a heavy anvil which can be kicked around and even moved by explosions",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/summon_anvil.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/anvil.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5,6", -- SUMMON_ROCK
        spawn_probability   = "0.1,0.1,0.2,0.3,0.1,0.1,0.1", -- SUMMON_ROCK
        price               = 227,
        mana                = 143,
        max_uses            = 3,
        --custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/summon_rock.xml",
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/anvil.xml")
        end,
    },

    {
        id = "ARCANE_TURRET",
        name = "Spell turret",
        description = "Conjures a magical turret that casts spells from your wand",
        author = "Disco Witch",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/spell_turret.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/spell_turret.xml" },
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6,10",
        spawn_probability = "0,0,0,0.1,0.1,0.1,0.2,0.3",
        price = 500,
        mana = 300,
        ai_never_uses = true,
        max_uses = -1,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/spell_turret.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            if reflecting then return end

            local shooter = Entity.Current()                                        -- Returns the entity shooting the wand
            local wand = Entity(shooter.Inventory2Component.mActiveItem)
            if not wand then return end

            local storage = Entity(EntityCreateNew("turret_storage"))               -- Create a storage entity to pass our spell info to the turret
            local cards = GetSpells(wand)
            local store_deck = ""
            local store_inventory_item_id = ""                                      -- The inventory_item_id is used to synchronize spell uses
            for k, v in ipairs(deck) do                                                     -- Generate ordered lists of cards to populate the turret wand
                store_deck = store_deck .. tostring(cards[v.deck_index + 1]:id()) .. ","
                store_inventory_item_id = store_inventory_item_id .. tostring(v.inventoryitem_id) .. ","
            end
            storage.variables.wand = tostring(wand:id())                            -- Store relevant data in the storage entity for the turret to retrieve on spawn
            storage.variables.deck = store_deck
            storage.variables.inventoryitem_id = store_inventory_item_id
            for i, action in ipairs(deck) do table.insert(discarded, action) end    -- Dump the rest of the deck into discard because they're consumed by the turret
            deck = {}
        end
    },

    {
        id = "ARCANE_TURRET_PATIENT",
        name = "Calculating Spell Turret",
        description = "Conjures a magical turret that casts spells from your wand, but only when enemies are in range",
        author = "Disco Witch",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/spell_turret_patient.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {"mods/copis_things/files/entities/projectiles/spell_turret_patient.xml"},
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6,10",
        spawn_probability = "0,0,0,0.1,0.1,0.1,0.2,0.3",
        price = 500,
        mana = 300,
        ai_never_uses = true,
        max_uses = -1,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/spell_turret_patient.xml")
            c.fire_rate_wait = c.fire_rate_wait + 60
            if reflecting then return end

            local shooter = Entity.Current()                                        -- Returns the entity shooting the wand
            local wand = Entity(shooter.Inventory2Component.mActiveItem)
            if not wand then return end

            local storage = Entity(EntityCreateNew("turret_storage"))               -- Create a storage entity to pass our spell info to the turret
            local cards = GetSpells(wand)
            local store_deck = ""
            local store_inventory_item_id = ""                                      -- The inventory_item_id is used to synchronize spell uses
            for k, v in ipairs(deck) do                                                     -- Generate ordered lists of cards to populate the turret wand
                store_deck = store_deck .. tostring(cards[v.deck_index + 1]:id()) .. ","
                store_inventory_item_id = store_inventory_item_id .. tostring(v.inventoryitem_id) .. ","
            end
            storage.variables.wand = tostring(wand:id())                            -- Store relevant data in the storage entity for the turret to retrieve on spawn
            storage.variables.deck = store_deck
            storage.variables.inventoryitem_id = store_inventory_item_id
            for i, action in ipairs(deck) do table.insert(discarded, action) end    -- Dump the rest of the deck into discard because they're consumed by the turret
            deck = {}
        end
    },

    {
        id = "RECURSIVE_LARPA",
        name = "Recursive Larpa",
        description = "Causes a spell to cast a perfect copy of itself on death",
        author = "Disco Witch",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/recursive_larpa.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {},
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "10",
        spawn_probability = "0.1",
        price = 300,
        mana = 150,
        ai_never_uses = true,
        max_uses = -1,
        action = function()
            if reflecting then return end
            c.fire_rate_wait = c.fire_rate_wait + 60
            BeginProjectile("mods/copis_things/files/entities/projectiles/recursive_larpa_host.xml")
                BeginTriggerHitWorld()
                    local shot = create_shot(1)
                    shot.state.extra_entities = shot.state.extra_entities .. "mods/copis_things/files/entities/misc/recursive_larpa.xml,"
                    draw_shot(shot, true)
                EndTrigger()
            EndProjectile()
        end
    },

    {
        id = "LARPA_FIELD",
        name = "Larpa Lens",
        description = "Creates a field that duplicates projectiles passing through it",
        author = "Disco Witch",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/larpa_lens.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {"mods/copis_things/files/entities/projectiles/larpa_lens.xml"},
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6,10",
        spawn_probability = "0,0,0,0.1,0.1,0.1,0.2,0.3",
        price = 300,
        mana = 50,
        max_uses = 12,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/larpa_lens.xml");
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },

    {
        id = "SHIELD_SAPPER",
        name = "Shield Sapper",
        description = "Slowly sap nearby energy shields (including your own)",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/shield_sapper.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {},
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.05,0.6,0.6,0.6,0.6,0.6",
        price = 220,
        mana = 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/shield_sapper.xml",
        action = function()
            draw_actions(1, true)
        end
    },

    {
        id = "PAPER_SHOT",
        name = "Paper Shot",
        description = "Projectiles are affected by a very low terminal velocity",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/paper_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {"mods/copis_things/files/entities/misc/paper_shot.xml"},
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4",
        spawn_probability = "0.5,0.4,0.3,0.2,0.1",
        price = 20,
        mana = -5,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/paper_shot.xml,";
            c.damage_slice_add = c.damage_slice_add + 0.2
            draw_actions(1, true)
        end
    },

    {
        id = "FEATHER_SHOT",
        name = "Feather Shot",
        description = "The projectile has reduced terminal velocity and added lifetime",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/feather_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {"mods/copis_things/files/entities/misc/feather_shot.xml"},
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,5",
        spawn_probability = "0.3,0.3,0.3",
        price = 100,
        mana = 3,
        action = function()
            c.lifetime_add = c.lifetime_add + 21;
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/feather_shot.xml,";
            current_reload_time = current_reload_time - 6;
            draw_actions( 1, true );
        end
    },

	{

		id          = "SCATTER_6",
		name 		= "Sextuple scatter spell",
		description = "Simultaneously casts 6 spells with low accuracy",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/scatter_6.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/scatter_2_unidentified.png",
		type 		= ACTION_TYPE_DRAW_MANY,
		spawn_level                       = "1,2,3,4,5,6", -- SCATTER_4
		spawn_probability                 = "0.4,0.4,0.5,0.6,0.6,0.6", -- SCATTER_4
		price = 140,
		mana = 2,
		--max_uses = 100,
		action 		= function()
			draw_actions( 6, true )
			c.spread_degrees = c.spread_degrees + 60.0
		end,
	},

	{
		id          = "SCATTER_8",
		name 		= "Octuple scatter spell",
		description = "Simultaneously casts 8 spells with low accuracy",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/scatter_8.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/scatter_2_unidentified.png",
		type 		= ACTION_TYPE_DRAW_MANY,
		spawn_level                       = "1,2,3,4,5,6", -- SCATTER_4
		spawn_probability                 = "0.2,0.2,0.3,0.4,0.4,0.4", -- SCATTER_4
		price = 160,
		mana = 4,
		--max_uses = 100,
		action 		= function()
			draw_actions( 8, true )
			c.spread_degrees = c.spread_degrees + 80.0
		end,
	},

    {
        id                  = "CLOUD_MAGIC_LIQUID_HP_REGENERATION",
        name                = "Healthy Cloud",
        description         = "Creates a soothing rain that cures your wounds",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cloud_magic_liquid_hp_regeneration.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml" },
        type                = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5", -- CLOUD_WATER
        spawn_probability   = "0.3,0.3,0.3,0.3,0.3,0.3", -- CLOUD_WATER
        price               = 300,
        mana                = 120,
        max_uses            = 3,
		never_unlimited = true,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end,
    },

    {
        id                  = "CHAOS_SPRITES",
        name                = "Chaos Sprites",
        description         = "Cast an uncontrolled burst of projectiles",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/chaos_sprites.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/chaos_sprites.xml", 5 },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "3,4,5,6",
        spawn_probability   = "1,1,1,1",
        price               = 260,
        mana                = 42,
        max_uses            = -1,
		never_unlimited = true,
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
        end,
    },

	{
		id          = "SHIELD_GHOST",
		name 		= "Summon Shielding Ghost",
		description = "Summons a tiny ethereal being to your help. It will fire protective shots that grant you an energy shield.",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shield_ghost.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/torch_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level                       = "1,2,3,4,5,6", -- TINY_GHOST
		spawn_probability                 = "0.1,0.5,1,1,1,1", -- TINY_GHOST
		price = 160,
		mana = 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/shield_ghost.xml",
		action 		= function()
			draw_actions( 1, true )
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



--[[
	{
		id					= "SUMMON_POUCH",
		name				= "Summon pouch",
		description			= "Summons an empty pouch",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 90,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},

	{
		id					= "SUMMON_POUCH_FULL",
		name				= "Summon filled pouch",
		description			= "Summons a pouch filled with a random material",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask_full.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 300,
		mana				= 120,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},

	{
		id          = "SORT_DECK",
		name 		= "Unshuffle",
		description = "Stablizes shuffled wands",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sort_deck.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,3,4,5", -- FREEZE
		spawn_probability	               = "1,1,1,1", -- FREEZE
		price = 100,
		mana = 5,
		action				= function()
		end,
	},

	{
		id          = "SHUFFLE_DECK",
		name 		= "Shuffle",
		description = "Imbues a wand with unpredictable energy",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shuffle_deck.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,3,4,5", -- FREEZE
		spawn_probability	               = "1,1,1,1", -- FREEZE
		price = 100,
		mana = -20,
		action				= function()
		end,
	},

]] --




--[[


	{
		id          = "SUNSABER_DARK",
		name 		= "Dark Sunsaber",
		description = "A blade forged from the dark sun",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sunsaber_dark.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/sunsaber_dark.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			               = "0,0",
		spawn_probability	               = "0,0",
		price = 150,
		mana = 0,
		sound_loop_tag = "sound_digger",
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/sunsaber_dark.xml")
			c.fire_rate_wait = c.fire_rate_wait - 35
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},



	{
		id					= "SWORD_BLADE",
		name				= "Sword Blade",
		description			= "Your sword's sharp edge deals damage as it hits foes!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/sword_blade.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level       = "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/projectiles/sword_blade.xml",
		action = function()
		end
	},


	{
		id					= "SPECIAL_DATARANDAL",
		name				= "Datarandal",
		description			= "The personal weapon of choice of the great warrior mage Copisinpäällikkö.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/datarandal.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		custom_xml_file 	= "mods/copis_things/files/entities/misc/custom_cards/datarandal.xml",
		action 				= function()
		end
	},

	

	{
		id					= "JSR_BLAST",
		name				= "JSR Blast",
		description			= "Fire a pulse of energy",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/jsr_blast.png",
		related_projectiles	= {"data/entities/projectiles/laser_bouncy.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
		action				= function()
				add_projectile("data/entities/projectiles/laser_bouncy.xml")
				c.spread_degrees = c.spread_degrees - 2.0
				c.damage_projectile_add = c.damage_projectile_add - 0.25
		end,
	},




	-- SWORD THROW
	{
		id					= "TWISTED_SWORD_THROW",
		name				= "Sword throw",
		description			= "Throw a rapidly spinning sword clone",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/twisted_throw.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/twisted_throw.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
	action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/twisted_throw.xml")
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
			c.fire_rate_wait = c.fire_rate_wait + 40
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
			c.damage_projectile_add = c.damage_projectile_add + 0.2
		end,
	},


	{
		id          = "SHADOWTENTACLE",
		name 		= "Shadow Apparition",
		description = "Release a lash of pure darkness which spreads from it's victims",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shadowtentacle.png",
		related_projectiles	= {"mods/copis_things/files/projectiles/shadowtentacle.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price = 170,
		mana = 30,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/shadow_lash.xml")
			c.fire_rate_wait = c.fire_rate_wait - 5
		end
	},



	]]
