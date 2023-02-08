dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local actions_to_insert = {
    -- BLOOD TENTACLE
    {
        id = "COPIS_THINGS_BLOODTENTACLE",
        author = "Nolla Games",
        name = "$action_bloodtentacle",
        description = "$actiondesc_bloodtentacle",
        spawn_requires_flag = "card_unlocked_pyramid",
        sprite = "data/ui_gfx/gun_actions/bloodtentacle.png",
        related_projectiles = { "data/entities/projectiles/deck/bloodtentacle.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "3,4,5,6", -- TENTACLE
        spawn_probability = "0.2,0.5,1,1", -- TENTACLE
        price = 170,
        mana = 30,
        --max_uses = 40,
        action = function()
            add_projectile("data/entities/projectiles/deck/bloodtentacle.xml")
            c.fire_rate_wait = c.fire_rate_wait + 20
        end
    },
    {
        id = "COPIS_THINGS_PSYCHIC_SHOT",
        author = "Copi",
        name = "Psychic shot",
        description = "Causes the projectile to be controlled telekinetically",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/psychic_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_shot.xml,"
            draw_actions(1, true)
        end
    },
    -- LUNGE
    {
        id = "COPIS_THINGS_LUNGE",
        author = "Copi",
        name = "Lunge",
        description = "Launch yourself forwards with a burst of speed",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/lunge.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "2,4",
        spawn_probability = "0.6,0.6",
        price = 100,
        mana = 5,
        ai_never_uses = true,
        action = function()
            local entity_id = GetUpdatedEntityID()
            local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
            if controls_comp ~= nil then
                local character_data_comp = EntityGetFirstComponent(entity_id, "CharacterDataComponent")
                if character_data_comp ~= nil then
                    local caster = {
                        velocity = { x = 0, y = 0 },
                        position = { x = 0, y = 0 }
                    }
                    local mouse = {
                        position = { x = 0, y = 0 }
                    }

                    caster.position.x, caster.position.y = EntityGetTransform(entity_id)
                    caster.velocity.x, caster.velocity.y = ComponentGetValueVector2(character_data_comp, "mVelocity")
                    mouse.position.x, mouse.position.y = ComponentGetValueVector2(controls_comp, "mMousePosition")

                    local offset = {
                        x = mouse.position.x - caster.position.x,
                        y = mouse.position.y - caster.position.y
                    }
                    local force = {
                        x = 650,
                        y = 1000
                    }

                    local len = math.sqrt((offset.x ^ 2) + (offset.y ^ 2))
                    caster.velocity.x = caster.velocity.x + (offset.x / len * force.x)
                    caster.velocity.y = caster.velocity.y + (offset.y / len * force.y)

                    ComponentSetValue2(character_data_comp, "mVelocity", caster.velocity.x, caster.velocity.y)
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_PROJECTION_CAST",
        author = "Copi",
        name = "Projection cast",
        description = "Projects your cast to where your mind focuses",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/projection_cast.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "6,10",
        spawn_probability = "0.2,1",
        price = 250,
        mana = 50,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 10
            c.spread_degrees = c.spread_degrees - 6
            if reflecting then
                return
            end
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/projection_cast.xml", 1)
        end
    },
    {
        id = "COPIS_THINGS_SLOW",
        author = "Copi",
        name = "Speed Down",
        description = "Decreases the speed at which a projectile flies through the air",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/slow.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,		2,		3,		4",
        spawn_probability = "0.8,		0.8,	0.8,	0.8",
        price = 50,
        mana = -3,
        --max_uses = 100,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/slow.xml",
        action = function()
            c.speed_multiplier = c.speed_multiplier * 0.6
            c.spread_degrees = c.spread_degrees - 8
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_CLAIRVOYANCE",
        author = "Copi",
        name = "Clairvoyance",
        description = "Allows you to project your vision",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/clairvoyance.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.5,1,1,1,1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/clairvoyance.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_PEACEFUL_SHOT",
        author = "Copi",
        name = "Peaceful Shot",
        description = "Sharply reduces the damage of a projectile",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/peaceful_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price = 100,
        mana = -15,
        action = function()
            c.gore_particles = c.gore_particles - 10
            c.damage_projectile_add = c.damage_projectile_add - 1.4

            c.spread_degrees = c.spread_degrees - 5
            c.speed_multiplier = c.speed_multiplier * 0.8
            shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10.0

            c.fire_rate_wait = c.fire_rate_wait - 12
            current_reload_time = current_reload_time - 24

            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ANCHORED_SHOT",
        author = "Copi",
        name = "Anchored Shot",
        description = "Anchors a projectile where it was fired",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/anchored_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price = 100,
        mana = 10,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 26
            if reflecting then
                return
            end
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/anchored_shot.xml,"
            c.spread_degrees = c.spread_degrees - 10
            c.lifetime_add = c.lifetime_add + 250
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_LEVITY_SHOT",
        author = "Copi",
        name = "Levity Shot",
        description = "Nullifies a projectile's gravity",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/levity_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price = 100,
        mana = 5,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/levity_shot.xml,"
            c.speed_multiplier = c.speed_multiplier * 0.9
            c.spread_degrees = c.spread_degrees - 10
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SEPARATOR_CAST",
        author = "Copi",
        name = "Separator cast",
        description = "Casts a projectile independent of any modifiers before it, like in a multicast",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/separator_cast.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "2,		3,		4,		5", -- BOUNCE
        spawn_probability = "0.3,		0.3,	0.3,	0.3",
        price = 210,
        mana = 0,
        action = function()
            if reflecting then
                return
            end
            local old_c = c
            c = {}
            shot_effects = {}
            --reset_modifiers(c);

            BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
            BeginTriggerDeath()
            local shot = create_shot(1)
            shot.state = {}
            draw_shot(shot, true)
            EndTrigger()
            EndProjectile()
            c = old_c
        end
    },
    {
        id = "COPIS_THINGS_SPREAD",
        author = "Copi",
        name = "Spread",
        description = "Adds spread to a projectile",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/spread.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6", -- SPREAD_REDUCE
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8", -- SPREAD_REDUCE
        price = 100,
        mana = -5,
        action = function()
            c.spread_degrees = c.spread_degrees + 30.0
            c.fire_rate_wait = c.fire_rate_wait - 5
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DART",
        author = "Copi",
        name = "Dart",
        description = "An accelerating magical dart that pierces soft materials",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/dart.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/dart.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2",
        spawn_probability = "2,1,0.5",
        price = 120,
        mana = 7,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
            c.fire_rate_wait = c.fire_rate_wait + 2
        end
    },
    {
        id = "COPIS_THINGS_TEMPORARY_CIRCLE",
        author = "Copi",
        name = "Summon Circle",
        description = "Summons a shortlived hollow circle",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/temporary_circle.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/deck/temporary_wall.xml" },
        type = ACTION_TYPE_UTILITY,
        spawn_level = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price = 100,
        mana = 40,
        max_uses = 20,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/temporary_circle.xml")
            c.fire_rate_wait = c.fire_rate_wait + 40
        end
    },
    {
        id = "COPIS_THINGS_LARPA_FORWARDS",
        author = "Copi",
        name = "Forwards Larpa",
        description = "Makes a projectile cast copies of itself forwards",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/forwards_larpa.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/forwards_larpa.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price = 260,
        mana = 100,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/forwards_larpa.xml,"
            draw_actions(1, true)
        end
    },
    -- PSYCHIC GRIP
    {
        id = "COPIS_THINGS_PSYCHIC_GRIP",
        author = "Copi",
        name = "Psychic Grip",
        description = "Locks a projectile in front of your wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/psychic_grip.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_grip.xml,"
            draw_actions(1, true)
        end
    },
    -- WISPY SHOT
    {
        id = "COPIS_THINGS_WISPY_SHOT",
        author = "Copi",
        name = "Wispy Shot",
        description = "Imbues a projectile with a wispy spirit",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/wispy_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/wispy_shot.xml,"
            draw_actions(1, true)
            c.lifetime_add = c.lifetime_add + 500
            c.fire_rate_wait = c.fire_rate_wait + 20
        end
    },
    {
        id = "COPIS_THINGS_GUNNER_SHOT",
        author = "Copi",
        name = "Gunner Shot",
        description = "Makes a projectile rapidly fire weak shots at nearby foes",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price = 260,
        mana = 100,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_GUNNER_SHOT_STRONG",
        author = "Copi",
        name = "Strong Gunner Shot",
        description = "Makes a projectile occasionally shoot powerful shots at nearby foes",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_strong.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_strong.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price = 260,
        mana = 100,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_strong.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SOIL_TRAIL",
        author = "Copi",
        name = "Soil Trail",
        description = "Gives a projectile a trail of soil",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/soil_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4", -- POISON_TRAIL
        spawn_probability = "0.3,0.3,0.3", -- POISON_TRAIL
        price = 160,
        mana = 10,
        action = function()
            c.trail_material = c.trail_material .. "soil,"
            c.trail_material_amount = c.trail_material_amount + 9
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_CONCRETEBALL",
        author = "Copi",
        name = "Chunk of Concrete",
        description = "A spell with concrete results",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_concrete.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml" },
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,5", -- SOILBALL
        spawn_probability = "1,1,1,1", -- SOILBALL
        price = 10,
        mana = 5,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml")
        end
    },
    {
        id = "COPIS_THINGS_ZENITH_DISC",
        author = "Copi",
        name = "Zenith disc",
        description = "Summons a no nonsense sawblade.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/zenith_disc.png",
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "6,10",
        spawn_probability = "0.2,0.2",
        price = 100,
        mana = 140,
        action = function()
            c.spread_degrees = c.spread_degrees + 5.0
            add_projectile("mods/copis_things/files/entities/projectiles/zenith_disc.xml")
        end
    },
    {
        id = "COPIS_THINGS_EVISCERATOR_DISC",
        author = "Copi",
        name = "Eviscerator",
        description = "Please, don't cast this.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/eviscerator.png",
        type = ACTION_TYPE_OTHER,
        spawn_level = "6,10",
        spawn_probability = "0.1,0.1",
        price = 1000,
        mana = 280,
        recursive = true,
        action = function()
            if reflecting then
                return
            end
            c.spread_degrees = c.spread_degrees + 5.0
            add_projectile("mods/copis_things/files/entities/projectiles/eviscerator.xml")
        end
    },
    {
        id = "COPIS_THINGS_SUMMON_HAMIS",
        author = "Copi",
        name = "Summon Hämis",
        description = "Praise Hämis.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/summon_hamis.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability = "0.3,		0.2,	0.2,	0.2,	0.2,	0.2,	0.2",
        price = 0,
        mana = 10,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/longleg_projectile.xml")
            c.fire_rate_wait = c.fire_rate_wait + 10
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET",
        author = "Copi",
        name = "Silver bullet",
        description = "A small bullet created from arcane silver",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_bullet.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2,3,4",
        spawn_probability = "1,1,0.5",
        price = 220,
        mana = 20,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
            c.fire_rate_wait = c.fire_rate_wait - 12
        end
    },
    {
        id = "COPIS_THINGS_SILVER_MAGNUM",
        author = "Copi",
        name = "Silver magnum",
        description = "A large bullet created from arcane silver",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_magnum.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "4,			5,			6",
        spawn_probability = "1.00,		0.66,		0.33",
        price = 330,
        mana = 35,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/silver_magnum.xml")
            c.fire_rate_wait = c.fire_rate_wait - 6
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET_DEATH_TRIGGER",
        author = "Copi",
        name = "Silver bullet with expiration trigger",
        description = "A small bullet created from arcane silver that casts another spell upon expiring",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_death_trigger.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_bullet.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "4,			5,			6",
        spawn_probability = "1.00,		0.50,		0.20",
        price = 220,
        mana = 25,
        action = function()
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_bullet.xml", 1)
            c.fire_rate_wait = c.fire_rate_wait - 12
        end
    },
    {
        id = "COPIS_THINGS_SILVER_MAGNUM_DEATH_TRIGGER",
        author = "Copi",
        name = "Silver magnum with expiration trigger",
        description = "A large bullet created from arcane silver that casts another spell upon expiring",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum_death_trigger.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_magnum.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2, 3, 4",
        spawn_probability = "1.00, 0.66, 0.33",
        price = 330,
        mana = 40,
        action = function()
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_magnum.xml", 1)
            c.fire_rate_wait = c.fire_rate_wait - 6
        end
    },
    {
        id = "COPIS_THINGS_SLOTS_TO_POWER",
        author = "Copi",
        name = "Slots To Power",
        description = "Increases a projectile's damage based on the number of empty slots in the wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/slots_to_power.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/slots_to_power.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,10",
        spawn_probability = "0.2,0.5,0.5,0.1",
        price = 120,
        mana = 110,
        -- max_uses = 20,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/slots_to_power.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 20
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_GUN_SHUFFLE",
        author = "Copi",
        name = "Unshuffle (One-Off)",
        description = "Cast inside a wand to unshuffle it at the cost of reduced stats. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1.2,1.2,0.3,0.4",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_GUN_SHUFFLE" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        if (wand.shuffle == true) then
                            wand.shuffle = false
                            wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_SHUFFLE")
                            wand.manaMax = wand.manaMax * 0.9
                            wand.manaChargeSpeed = wand.manaChargeSpeed * 0.9
                            wand.castDelay = wand.castDelay * 1.1
                            wand.rechargeTime = wand.rechargeTime * 1.1
                            local sprite_file = wand:GetSprite()
                            if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                                wand:UpdateSprite()
                            end
                            GameScreenshake(50, pos_x, pos_y)
                            GamePrintImportant("Wand unshuffled!", "Stats slightly reduced.")
                        else
                            GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y)
                            GamePrintImportant("Your wand is already unshuffled!", "")
                        end
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD",
        author = "Copi",
        name = "Shuffle (One-Off)",
        description = "Cast inside a wand to shuffle it, but greatly improve it's stats. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle_bad.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "0.6,0.7,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        if (wand.shuffle == false) then
                            wand.shuffle = true
                            wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD")
                            wand.manaMax = wand.manaMax * 1.5
                            wand.manaChargeSpeed = wand.manaChargeSpeed * 1.5
                            wand.castDelay = wand.castDelay * 0.55
                            wand.rechargeTime = wand.rechargeTime * 0.55
                            local sprite_file = wand:GetSprite()
                            if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                                wand:UpdateSprite()
                            end
                            GameScreenshake(50, pos_x, pos_y)
                            GamePrintImportant("Wand shuffled!", "Stats vastly improved.")
                        else
                            GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y)
                            GamePrintImportant("Your wand is already shuffled!", "")
                        end
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND",
        author = "Copi",
        name = "Upgrade Spells per Cast (One-Off)",
        description = "Cast inside a wand to increase the amount of spells fired per cast. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_actions_per_round.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.1",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND")
                        wand.spellsPerCast = wand.spellsPerCast + 1
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        GamePrintImportant("Wand upgraded!", tostring(wand.spellsPerCast) .. " spells per cast.")
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER",
        author = "Copi",
        name = "Upgrade spell speed multiplier (One-Off)",
        description = "Cast inside a wand to increase the velocity of projectiles from it. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_speed_multiplier.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.1",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER")
                        SetRandomSeed(pos_x, pos_y + GameGetFrameNum() + 137)
                        wand.speedMultiplier = wand.speedMultiplier * Random(2, 3)
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        GamePrintImportant("Wand upgraded!", tostring(wand.speedMultiplier) .. " speed multiplier.")
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_GUN_CAPACITY",
        author = "Copi",
        name = "Upgrade wand capacity (One-Off)",
        description = "Cast inside a wand to increase the wand's total spell capacity. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_capacity.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.1",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_GUN_CAPACITY" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        if (wand.capacity < 26) then
                            wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_CAPACITY")
                            SetRandomSeed(pos_x, pos_y + GameGetFrameNum() + 137)
                            wand.capacity = wand.capacity + Random(1, 3)
                            local sprite_file = wand:GetSprite()
                            if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                                wand:UpdateSprite()
                            end
                            GameScreenshake(50, pos_x, pos_y)
                            GamePrintImportant("Wand upgraded!", tostring(wand.capacity) .. " capacity.")
                        end
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT",
        author = "Copi",
        name = "Upgrade Cast Delay (One-Off)",
        description = "Cast inside a wand to decrease the cast delay. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_fire_rate_wait.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT")
                        local castDelay_old = wand.castDelay
                        wand.castDelay = ((wand.castDelay - 0.2) * 0.8) + 0.2
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        local desc = table.concat({
                                ("%.2fs"):format(castDelay_old / 60),
                                "->",
                                ("%.2fs"):format(wand.castDelay / 60),
                                "cast delay."
                            }, " ")
                        GamePrintImportant("Wand upgraded!", desc)
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_RELOAD_TIME",
        author = "Copi",
        name = "Upgrade Reload Time (One-Off)",
        description = "Cast inside a wand to decrease the reload time. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_reload_time.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_RELOAD_TIME" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_RELOAD_TIME")
                        local rechargeTime_old = wand.rechargeTime
                        wand.rechargeTime = ((wand.rechargeTime - 0.2) * 0.8) + 0.2
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        local desc = table.concat({
                                ("%.2fs"):format(rechargeTime_old / 60),
                                "->",
                                ("%.2fs"):format(wand.rechargeTime / 60),
                                "recharge time."
                            }, " ")
                        GamePrintImportant("Wand upgraded!", desc)
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_SPREAD_DEGREES",
        author = "Copi",
        name = "Upgrade accuracy (One-Off)",
        description = "Cast inside a wand to increase the accuracy. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_spread_degrees.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_SPREAD_DEGREES" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_SPREAD_DEGREES")
                        local rechargeTime_old = wand.rechargeTime
                        wand.spread = wand.spread - ((math.abs(wand.spread) * 0.25) + 0.5)
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        local desc = table.concat({
                                tostring(rechargeTime_old),
                                "->",
                                tostring(wand.spread),
                                "degrees spread."
                            }, " ")
                        GamePrintImportant("Wand upgraded!", desc)
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_MANA_MAX",
        author = "Copi",
        name = "Upgrade maximum mana (One-Off)",
        description = "Cast inside a wand to increase it's mana capacity. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_max.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_MANA_MAX" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_MANA_MAX")
                        wand.manaMax = wand.manaMax * 1.2 + 50
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        GamePrintImportant("Wand upgraded!", tostring(wand.manaMax) .. " mana capacity.")
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED",
        author = "Copi",
        name = "Upgrade mana charge speed (One-Off)",
        description = "Cast inside a wand to increase it's mana charge speed. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_charge_speed.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells("COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED")
                        wand.manaChargeSpeed = wand.manaChargeSpeed * 1.2 + 50
                        local sprite_file = wand:GetSprite()
                        if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
                            wand:UpdateSprite()
                        end
                        GameScreenshake(50, pos_x, pos_y)
                        GamePrintImportant("Wand upgraded!", tostring(wand.manaChargeSpeed) .. " mana charge speed.")
                    end
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT",
        author = "Copi",
        name = "Upgrade Always Cast (One-Off)",
        description = "Cast inside a wand to turn it's first spell into an always cast. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            draw_actions(1, true) -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        local spells, attached_spells = wand:GetSpells()
                        if (#spells > 0 and spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT" and
                            spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE")
                        then
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
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE",
        author = "Copi",
        name = "Upgrade Remove Always Cast (One-Off)",
        description = "Cast inside a wand to turn it's first always cast into a spell. Spell is voided upon use!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions_remove.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1,2,3,10",
        spawn_probability = "1,1,0.5,0.2",
        price = 840,
        mana = 0,
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            draw_actions(1, true) -- Check for initial reflection
            if not reflecting then
                -- Check for greek letters/non-self casts
                if current_action.id == "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE" then
                    local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                    local entity_id = GetUpdatedEntityID()
                    local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
                    local active_wand = ComponentGetValue2(inventory, "mActiveItem")
                    local pos_x, pos_y = EntityGetTransform(entity_id)
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        local spells, attached_spells = wand:GetSpells()
                        if (#attached_spells > 0 and attached_spells[1].action_id ~= "UPGRADE_GUN_ACTIONS_PERMANENT" and
                            wand:GetFreeSlotsCount() > 0)
                        then
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
                else
                    -- non-self cast alert
                    GamePrintImportant("You cannot cheat the gods!", "")
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_DAMAGE_LIFETIME",
        author = "Copi",
        name = "Damage growth",
        description = "Causes your projectile to gain damage the longer it's alive",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/damage_lifetime.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,4,5,10",
        spawn_probability = "0.1,1,0.1,0.1,0.2",
        price = 280,
        mana = 30,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_lifetime.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_CRITICAL_CHARM",
        author = "Copi",
        name = "Critical on charmed enemies",
        description = "Makes a projectile always do a critical hit on charmed enemies",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_charm.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price = 70,
        mana = 10,
        --max_uses = 50,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_charm.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_CRITICAL_ELECTROCUTED",
        author = "Copi",
        name = "Critical on electrocuted enemies",
        description = "Makes a projectile always do a critical hit on electrocuted enemies",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_electrocuted.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price = 70,
        mana = 10,
        --max_uses = 50,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_electrocuted.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_CRITICAL_FROZEN",
        author = "Copi",
        name = "Critical on frozen enemies",
        description = "Makes a projectile always do a critical hit on frozen enemies",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_frozen.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price = 70,
        mana = 10,
        --max_uses = 50,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_frozen.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_PASSIVE_MANA",
        author = "Copi",
        name = "Passive Mana",
        description = "Your wand regenerates mana faster!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/passive_mana.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
        price = 200,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/passive_mana.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_FREEZING_VAPOUR_TRAIL",
        author = "Copi",
        name = "Freezing Vapour Trail",
        description = "Gives a projectile a trail of stinging frost",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/freezing_vapour_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
        price = 300,
        mana = 13,
        action = function()
            c.trail_material = c.trail_material .. "blood_cold"
            c.trail_material_amount = c.trail_material_amount + 5
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_VOID_TRAIL",
        author = "Copi",
        name = "Void Liquid Trail",
        description = "Gives a projectile a trail of pure darkness",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/void_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
        price = 200,
        mana = 6,
        action = function()
            c.trail_material = c.trail_material .. "void_liquid,"
            c.trail_material_amount = c.trail_material_amount + 1
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DAMAGE_CRITICAL",
        author = "Copi",
        name = "Critical strike",
        description = "Increases spell critical damage",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/damage_critical.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7", -- FIREBALL_RAY
        price = 300,
        mana = 5,
        action = function()
            c.damage_critical_multiplier = math.max(1, c.damage_critical_multiplier) + 1
            if not reflecting then
                c.damage_critical_chance = math.max(c.damage_critical_chance, 5)
            end
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DIMIGE",
        author = "Copi",
        name = "Dimige",
        description = "Increases spell damage slightly for each projectile spell on the wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/dimige.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3", -- FIREBALL_RAY
        spawn_probability = "1.0,1.0,1.0,1.0", -- FIREBALL_RAY
        price = 70,
        mana = 5,
        action = function()
            local projectile_type_sum = 0
            for k, v in ipairs(deck or {}) do
                if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or
                    v.type == ACTION_TYPE_MATERIAL
                then
                    projectile_type_sum = projectile_type_sum + 1
                end
            end
            for k, v in ipairs(hand or {}) do
                if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or
                    v.type == ACTION_TYPE_MATERIAL
                then
                    projectile_type_sum = projectile_type_sum + 1
                end
            end
            for k, v in ipairs(discarded or {}) do
                if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or
                    v.type == ACTION_TYPE_MATERIAL
                then
                    projectile_type_sum = projectile_type_sum + 1
                end
            end
            c.damage_projectile_add = c.damage_projectile_add + 0.04 + 0.04 * projectile_type_sum
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_POWER_SHOT",
        author = "Copi",
        name = "Power Shot",
        description = "Cast a spell with increased damage and material penetration",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/power_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7", -- FIREBALL_RAY
        price = 300,
        mana = 20,
        action = function()
            c.damage_projectile_add = c.damage_projectile_add + 0.24
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/power_shot.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_STICKY_SHOT",
        author = "Copi",
        name = "Sticky Shot",
        description = "Cast a spell which sticks to surfaces it hits",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/sticky_shot.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.6,0.6,0.6,0.6,0.6,0.6,0.6", -- FIREBALL_RAY
        price = 200,
        mana = 9,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/sticky_shot.xml,"
            c.fire_rate_wait = c.fire_rate_wait - 12
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_LOVELY_TRAIL",
        author = "Copi",
        name = "Lovely Trail",
        description = "Show your enemies some love",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/lovely_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price = 10,
        mana = 0,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/lovely_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_STARRY_TRAIL",
        author = "Copi",
        name = "Starry Trail",
        description = "Only shooting stars",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/starry_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price = 10,
        mana = 0,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/starry_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SPARKLING_TRAIL",
        author = "Copi",
        name = "Sparkling Trail",
        description = "Spread glitter across the world",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/sparkling_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price = 10,
        mana = 0,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/sparkling_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_NULL_TRAIL",
        author = "Copi",
        name = "Null Trail",
        description = "Remove all particle emitters from the projectile",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/null_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price = 10,
        mana = 0,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/null_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ROOT_GROWER",
        author = "Copi",
        name = "Creeping Vines",
        description = "Spawns a mass of rapidly growing nature",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/root_grower.png",
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5", -- FIREBALL_RAY
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
        price = 90,
        mana = 40,
        max_uses = 10,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            add_projectile("mods/copis_things/files/entities/props/root_grower.xml")
        end
    },
    {
        id = "COPIS_THINGS_HOMING_ANTI",
        author = "Copi",
        name = "Anti Homing",
        description = "Projectiles will be repelled by enemies",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/homing_anti.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/homing_anti.xml,data/entities/particles/tinyspark_white_weak.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5", -- HOMING
        spawn_probability = "0.1,0.1,0.1,0.1,0.1", -- HOMING
        price = 100,
        mana = 0,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/homing_anti.xml,data/entities/particles/tinyspark_white_weak.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_PROJECTILE_HOMING",
        author = "Copi",
        name = "Passive Homing",
        description = "All projectiles fired while holding the wand slighty home in on enemies!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/projectile_homing.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
        price = 800,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/projectile_homing.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ALT_FIRE_FLAMETHROWER",
        author = "Copi",
        name = "Sidearm Flamethrower",
        description = "Fires a deadly stream of flames while you hold alt fire. Consumes 20 mana per shot",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_flamethrower.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price = 280,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_flamethrower.xml",
        action = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DECOY",
        author = "Copi",
        name = "$action_decoy",
        description = "$actiondesc_decoy",
        sprite = "data/ui_gfx/gun_actions/decoy.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/decoy_unidentified.png",
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.1,0.3,0.2,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price = 130,
        mana = 60,
        max_uses = 10,
        custom_xml_file = "data/entities/misc/custom_cards/decoy.xml",
        action = function()
            add_projectile("data/entities/projectiles/deck/decoy.xml")
            c.fire_rate_wait = c.fire_rate_wait + 40
        end
    },
    {
        id = "COPIS_THINGS_DECOY_TRIGGER",
        author = "Copi",
        name = "$action_decoy_trigger",
        description = "$actiondesc_decoy_trigger",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/decoy_death_trigger.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/decoy_trigger_unidentified.png",
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.1,0.3,0.2,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price = 150,
        mana = 80,
        max_uses = 10,
        custom_xml_file = "data/entities/misc/custom_cards/decoy_trigger.xml",
        action = function()
            add_projectile_trigger_death("data/entities/projectiles/deck/decoy_trigger.xml", 1)
            c.fire_rate_wait = c.fire_rate_wait + 40
        end
    },
    {
        id = "COPIS_THINGS_HITFX_EXPLOSION_FROZEN",
        author = "Copi",
        name = "Explosion on frozen enemies",
        description = "Makes a projectile explode upon collision with frozen creatures",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,4,5", -- HITFX_EXPLOSION_ALCOHOL
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_EXPLOSION_ALCOHOL
        price = 140,
        mana = 20,
        --max_uses = 50,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_EXPLOSION_FROZEN_GIGA",
        author = "Copi",
        name = "Giant explosion on frozen enemies",
        description = "Makes a projectile explode powerfully upon collision with frozen creatures",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen_giga.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/hitfx_explode_frozen_giga.xml",
            "data/entities/particles/tinyspark_orange.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,4,5", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        spawn_probability = "0.1,0.1,0.1,0.1", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        price = 300,
        mana = 200,
        max_uses = 20,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,data/entities/particles/tinyspark_orange.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_CIRCLE_EDIT_WANDS_EVERYWHERE",
        author = "Copi",
        name = "Circle of Divine Blessing",
        description = "A field of modification magic",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/circle_edit_wands_everywhere.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml" },
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,		1,		2,		3",
        spawn_probability = "1,		1,		1,		1",
        price = 200,
        mana = 50,
        max_uses = 3,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml")
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_MINI_SHIELD",
        author = "Copi",
        name = "Projectile Bubble Shield",
        description = "Encases a projectile in a deflective shield",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/mini_shield.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/mini_shield.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        spawn_probability = "1,1,1,1,1,1,1", -- HITFX_EXPLOSION_ALCOHOL_GIGA
        price = 540,
        mana = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 6
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/mini_shield.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_NGON_SHAPE",
        author = "Copi",
        name = "Formation - N-gon",
        description = "Cast all remaining spells in a circular pattern",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ngon_shape.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability = "0.33,	0.33,	0.33,	0.33,	0.33,	0.33,	0.33",
        price = 120,
        mana = 24,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 16
            c.pattern_degrees = 180
            draw_actions(#deck, true)
        end
    },
    {
        id = "COPIS_THINGS_STORED_SHOT",
        author = "Copi",
        name = "Stored cast",
        description = "Summon a magical phenomenon that casts a spell when you stop casting",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/stored_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability = "0.4,     0.4,	0.4,	0.4,	0.4,	0.4,	0.4",
        price = 160,
        mana = 4,
        action = function()
            current_reload_time = current_reload_time + 3
            if reflecting then
                return
            end
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/stored_shot.xml", 1)
        end
    },
    {
        id = "COPIS_THINGS_BARRIER_TRAIL",
        author = "Copi",
        name = "Barrier Trail",
        description = "Projectiles gain a trail of barriers",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/barrier_trail.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/barrier_trail.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,		3,		4,		5",
        spawn_probability = "0.7,      0.7,	0.7,	0.7",
        price = 200,
        mana = 20,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/barrier_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DEATH_RAY",
        author = "Copi",
        name = "Deathray",
        description = "A blast of crackling red energy",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/death_ray.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/death_ray.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "3,			4",
        spawn_probability = "1.00,		0.50",
        price = 220,
        mana = 25,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/death_ray.xml")
        end
    },
    {
        id = "COPIS_THINGS_LIGHT_BULLET_DEATH_TRIGGER",
        author = "Copi",
        name = "Spark bolt with expiration trigger",
        description = "A spark bolt that casts another spell upon expiring",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_death_trigger.png",
        related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3", -- LIGHT_BULLET_TRIGGER
        spawn_probability = "1,0.5,0.5,0.5", -- LIGHT_BULLET_TRIGGER
        price = 140,
        mana = 10,
        --max_uses = 100,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 3
            c.screenshake = c.screenshake + 0.5
            c.damage_critical_chance = c.damage_critical_chance + 5
            add_projectile_trigger_death("data/entities/projectiles/deck/light_bullet.xml", 1)
        end
    },
    {
        id = "COPIS_THINGS_IF_PLAYER",
        author = "Copi",
        name = "Requirement - Player",
        description = "The next spell is skipped if the spell isn't cast by the player",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/if_player.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_maths",
        type = ACTION_TYPE_OTHER,
        spawn_level = "10", -- MANA_REDUCE
        spawn_probability = "1", -- MANA_REDUCE
        price = 100,
        mana = 0,
        never_ac = true,
        action = function(recursion_level, iteration)
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
        end
    },
    {
        id = "COPIS_THINGS_IF_ALT_FIRE",
        author = "Copi",
        name = "Requirement - Alt Fire",
        description = "The next spell is skipped if the alt fire key isn't held down",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/if_alt_fire.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_maths",
        type = ACTION_TYPE_OTHER,
        spawn_level = "10", -- MANA_REDUCE
        spawn_probability = "1", -- MANA_REDUCE
        price = 100,
        mana = 0,
        never_ac = true,
        action = function(recursion_level, iteration)
            local endpoint = -1
            local elsepoint = -1
            local entity_id = GetUpdatedEntityID()
            local player_id = EntityGetWithTag("player_unit")[1]
            local controlscomp = EntityGetFirstComponent(player_id, "ControlsComponent")

            local doskip = false ---@diagnostic disable-next-line: param-type-mismatch
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
        end
    },
    {
        id = "COPIS_THINGS_ZIPPING_ARC",
        author = "Copi",
        name = "Zipping Arc",
        description = "Causes a projectile to zip away from walls",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/zipping_arc.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/sinewave_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/zipping_arc.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,4,6",
        spawn_probability = "0.3,0.5,0.4",
        price = 50,
        mana = 10,
        --max_uses = 150,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 10
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/zipping_arc.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SLOW_BULLET_TIMER_2",
        author = "Copi",
        name = "Energy orb with two timers",
        description = "A slow but powerful orb of energy that casts a spell after a timer runs out, then a second spell after a secondary timer runs out",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/slow_bullet_timer_2.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/bullet_slow.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "1,2,3,4,5,6", -- SLOW_BULLET_TIMER
        spawn_probability = "0.5,0.5,0.5,0.5,1,1", -- SLOW_BULLET_TIMER
        price = 200,
        mana = 50,
        --max_uses = 50,
        custom_xml_file = "data/entities/misc/custom_cards/bullet_slow.xml",
        action = function()
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
        end
    },
    {
        id = "COPIS_THINGS_SLOW_BULLET_TIMER_N",
        author = "Copi",
        name = "Energy orb with n timers",
        description = "A slow but powerful orb of energy that casts all remaining spells with a delay dependent on your cast delay",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/slow_bullet_timer_n.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/bullet_slow.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "1,2,3,4,5,6", -- SLOW_BULLET_TIMER
        spawn_probability = "0.3,0.3,0.3,0.3,0.5,0.5", -- SLOW_BULLET_TIMER
        price = 200,
        mana = 50,
        --max_uses = 50,
        custom_xml_file = "data/entities/misc/custom_cards/bullet_slow.xml",
        action = function()
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
        end
    },
    {
        id = "COPIS_THINGS_FALSE_SPELL",
        author = "Copi",
        name = "False Spell",
        description = "A spell that quickly dissipates",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/false_spell.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/false_spell.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1",
        spawn_probability = "0.1,0.1",
        price = 90,
        mana = 1,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait - 6
            current_reload_time = current_reload_time - 3
            add_projectile("mods/copis_things/files/entities/projectiles/false_spell.xml")
        end
    },
    {
        id = "COPIS_THINGS_PSI",
        author = "Copi",
        name = "Psi",
        description = "Casts a copy of every spell in the last wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/psi.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_duplicate",
        type = ACTION_TYPE_OTHER,
        spawn_manual_unlock = true,
        recursive = true,
        spawn_level = "5,6,10", -- MANA_REDUCE
        spawn_probability = "0.1,0.1,1", -- MANA_REDUCE
        price = 600,
        mana = 350,
        action = function(recursion_level, iteration)
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
                                    local comp =
                                        EntityGetFirstComponentIncludingDisabled(spell_id, "ItemActionComponent")
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
        end
    },
    {
        id = "COPIS_THINGS_DELTA",
        author = "Copi",
        name = "Delta",
        description = "Cycles through the wand, casting copies of spells.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/delta/delta_base.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_duplicate",
        type = ACTION_TYPE_OTHER,
        spawn_manual_unlock = true,
        recursive = true,
        spawn_level = "5,6,10", -- MANA_REDUCE
        spawn_probability = "0.1,0.1,1", -- MANA_REDUCE
        price = 350,
        mana = 50,
        action = function(recursion_level, iteration)
            if not reflecting then
                local shooter = GetUpdatedEntityID()
                DeltaIndex = DeltaIndex or 1
                local inventory2comp = EntityGetFirstComponent(shooter, "Inventory2Component")
                if inventory2comp then
                    -- Go over all wand spells
                    local active_wand = ComponentGetValue2(inventory2comp, "mActiveItem")
                    for i, wand_action in ipairs(EntityGetAllChildren(active_wand) or {}) do
                        if EntityHasTag(wand_action, "card_action") then
                            local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_action, "ItemComponent")

                            -- If action's slot matches delta index then cast it
                            if ComponentGetValue2(itemcomp, "inventory_slot") == DeltaIndex then
                                local itemactioncomp = EntityGetFirstComponentIncludingDisabled(wand_action,
                                        "ItemActionComponent")
                                local action_id = ComponentGetValue2(itemactioncomp, "action_id")
                                if action_id ~= "COPIS_THINGS_DELTA" then
                                    for _, data in ipairs(actions) do
                                        if (data.id == action_id) then
                                            local rec = check_recursion(data, recursion_level)
                                            if (data ~= nil) and (rec > -1) then
                                                data.action(rec)
                                            end
                                            break
                                        end
                                    end
                                end
                            end

                            -- If action is this card then update sprite
                            if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id and
                                current_action.id == "COPIS_THINGS_DELTA" then
                                ComponentSetValue2(itemcomp, "ui_sprite",
                                    table.concat({ "mods/copis_things/files/ui_gfx/gun_actions/delta/delta_",
                                        tostring(DeltaIndex + 1), ".png" }))
                            end
                        end
                    end

                    -- Update delta index
                    local abilitycomp = EntityGetFirstComponentIncludingDisabled(active_wand, "AbilityComponent")
                    local deck_capacity = ComponentObjectGetValue2(abilitycomp, "gun_config", "deck_capacity")
                    DeltaIndex = (DeltaIndex + 1) % deck_capacity
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_AUTO_ENEMIES",
        author = "Copi",
        name = "Paranoia Casting",
        description = "Your held wand fires when you're surrounded",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/auto_enemies.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/auto_enemies.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_AUTO_FRAME",
        author = "Copi",
        name = "Automatic Casting",
        description = "Your held wand fires constantly",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/auto_frame.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/auto_frame.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_AUTO_HOLSTER",
        author = "Copi",
        name = "Quick Draw Casting",
        description = "Your held wand fires when you equip your wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/auto_holster.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/auto_holster.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_AUTO_HP",
        author = "Copi",
        name = "Stress Casting",
        description = "Your held wand fires when you're on the verge of death",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/auto_hp.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/auto_hp.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_AUTO_HURT",
        author = "Copi",
        name = "Reactive Casting",
        description = "Your held wand fires when you're hurt",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/auto_hurt.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/auto_hurt.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_AUTO_PROJECTILE",
        author = "Copi",
        name = "Ballistic Casting",
        description = "Your held wand fires when you're around projectiles",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/auto_projectile.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/auto_projectile.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ICICLE_LANCE",
        author = "Copi",
        name = "Icicle Lance",
        description = "A rapidly accelerating icicle which impales itself into terrain",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/icicle_lance.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/icicle_lance.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "1,1,1,1,1,1",
        price = 175,
        mana = 25,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            add_projectile("mods/copis_things/files/entities/projectiles/icicle_lance.xml")
        end
    },
    {
        id = "COPIS_THINGS_STATIC_TO_EXPLOSION",
        author = "Copi",
        name = "Terrain Detonation",
        description = "Makes any hard, solid materials within a projectile's range explode violently",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/static_to_explosion.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/static_to_explosion.xml",
            "data/entities/particles/tinyspark_yellow.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4", -- STATIC_TO_SAND
        spawn_probability = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price = 140,
        mana = 70,
        max_uses = 8,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/static_to_explosion.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_LIQUID_TO_SOIL",
        author = "Copi",
        name = "Liquids to Soil",
        description = "Makes any fluids within a projectile's range turn earthly",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/liquid_to_soil.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/liquid_to_soil.xml",
            "data/entities/particles/tinyspark_yellow.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4", -- STATIC_TO_SAND
        spawn_probability = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price = 140,
        mana = 70,
        max_uses = 8,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/liquid_to_soil.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_POWDER_TO_WATER",
        author = "Copi",
        name = "Powders to water",
        description = "Makes any soft, powdery materials within a projectile's range dissolve into water",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/powder_to_water.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/powder_to_water.xml",
            "data/entities/particles/tinyspark_yellow.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4", -- STATIC_TO_SAND
        spawn_probability = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price = 140,
        mana = 70,
        max_uses = 8,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/powder_to_water.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_POWDER_TO_STEEL",
        author = "Copi",
        name = "Powders to steel",
        description = "Makes any soft, powdery materials within a projectile's range become hard like metal",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/powder_to_steel.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/powder_to_steel.xml",
            "data/entities/particles/tinyspark_yellow.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4", -- STATIC_TO_SAND
        spawn_probability = "0.3,0.3,0.3", -- STATIC_TO_SAND
        price = 140,
        mana = 70,
        max_uses = 8,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/powder_to_steel.xml,data/entities/particles/tinyspark_yellow.xml,"
            c.fire_rate_wait = c.fire_rate_wait + 60
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ZAP",
        author = "Copi",
        name = "Zap",
        description = "A short lived spark of electricity",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/zap.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/zap.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "1,3,4",
        spawn_probability = "1,1,1",
        price = 170,
        mana = 8,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/zap.xml",
        action = function()
            c.fire_rate_wait = c.fire_rate_wait - 5
            current_reload_time = current_reload_time - 5

            if reflecting then
                Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                return
            end

            local function zap(count)
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                BeginTriggerDeath()
                for i = 1, count, 1 do
                    BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                    EndProjectile()
                end
                register_action(c)
                SetProjectileConfigs()
                EndTrigger()
                EndProjectile()
            end

            if GameGetFrameNum() % 3 == 0 then
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                BeginTriggerDeath()
                zap(2)
                zap(2)
                register_action(c)
                SetProjectileConfigs()
                EndTrigger()
                EndProjectile()
            elseif GameGetFrameNum() % 3 == 1 then
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                BeginTriggerDeath()
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                EndProjectile()
                zap(1)
                register_action(c)
                SetProjectileConfigs()
                EndTrigger()
                EndProjectile()
            else
                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                BeginTriggerDeath()
                zap(1)
                EndTrigger()
                EndProjectile()

                BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
                BeginTriggerDeath()
                zap(1)
                EndTrigger()
                EndProjectile()
            end
        end
    },
    {
        id = "COPIS_THINGS_MATRA_MAGIC",
        author = "Copi",
        name = "Matra Magic",
        description = "Summon a seeking arcane missile",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/matra_magic.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/matra_magic.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "3,4,5,6",
        spawn_probability = "1,1,1,1",
        price = 180,
        mana = 52,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/matra_magic.xml")
            c.fire_rate_wait = c.fire_rate_wait + 33
            current_reload_time = current_reload_time + 33
        end
    },
    {
        id = "COPIS_THINGS_VOMERE",
        author = "Copi",
        name = "Vomeremancy",
        description = "Purge thy satiety, Allow oneself to feast again",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/vomeremancy.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/vomere.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "3,4,5,6",
        spawn_probability = "1,1,1,1",
        price = 180,
        mana = 52,
        max_uses = 30,
        custom_uses_logic = true,
        ai_never_uses = true,
        action = function()
            if reflecting then
                return
            end
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
                    if inventory_2_comp == nil then
                        return
                    end
                    local wand_id = ComponentGetValue2(inventory_2_comp, "mActiveItem")
                    for i, spell in ipairs(EntityGetAllChildren(wand_id)) do
                        spell_comp = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent")
                        if spell_comp ~= nil and
                            ComponentGetValue2(spell_comp, "mItemUid") == current_action.inventoryitem_id
                        then
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
                        add_projectile("mods/copis_things/files/entities/projectiles/vomere.xml")
                        c.fire_rate_wait = c.fire_rate_wait + 15
                        current_reload_time = current_reload_time + 33
                    end
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_CIRCLE_RANDOM",
        author = "Copi",
        name = "Circle of Chaos",
        description = "An expanding circle of a random material",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/circle_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/circle_random.xml" },
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,4", -- CIRCLE_FIRE
        spawn_probability = "0.4,0.4,0.4,0.4", -- CIRCLE_FIRE
        price = 170,
        mana = 20,
        max_uses = 15,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/circle_random.xml")
            c.fire_rate_wait = c.fire_rate_wait + 20
        end
    },
    {
        id = "COPIS_THINGS_CLOUD_RANDOM",
        author = "Copi",
        name = "Chaos Cloud",
        description = "Creates a rain of a random material",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/cloud_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/cloud_random.xml" },
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5", -- CLOUD_WATER
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- CLOUD_WATER
        price = 140,
        mana = 30,
        max_uses = 10,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/cloud_random.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },
    {
        id = "COPIS_THINGS_TOUCH_RANDOM",
        author = "Copi",
        name = "Touch of Chaos",
        description = "Transmutes everything in a short radius into a random material, including walls, creatures... and you",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/touch_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/touch_random.xml" },
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,4,5,6,7,10", -- TOUCH_WATER
        spawn_probability = "0,0,0,0,0.1,0.1,0.1,0.1", -- TOUCH_WATER
        price = 420,
        mana = 280,
        max_uses = 5,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/touch_random.xml")
        end
    },
    {
        id = "COPIS_THINGS_CHUNK_OF_RANDOM",
        author = "Copi",
        name = "Chunk of Chaos",
        description = "A blast of random material",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/chunk_of_random.xml" },
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,5", -- SOILBALL
        spawn_probability = "0.4,0.4,0.4,0.4", -- SOILBALL
        price = 50,
        mana = 50,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_random.xml")
        end
    },
    {
        id = "COPIS_THINGS_MATERIAL_RANDOM",
        author = "Copi",
        name = "Droplet of Chaos",
        description = "Transmute drops of a random material from nothing",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/material_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/material_random.xml" },
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,4,5", -- MATERIAL_WATER
        spawn_probability = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_WATER
        price = 110,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/material_random.xml")
            c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
                10 -- this is a hack to get the cement reload time back to 0
        end
    },
    {
        id = "COPIS_THINGS_SEA_RANDOM",
        author = "Copi",
        name = "Sea of Chaos",
        description = "Summons a large body of a random material below the caster",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/sea_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/sea_random.xml" },
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "0,4,5,6", -- SEA_LAVA
        spawn_probability = "0.2,0.2,0.2,0.2", -- SEA_LAVA
        price = 350,
        mana = 140,
        max_uses = 3,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/sea_random.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },
    {
        id = "COPIS_THINGS_SUMMON_ANVIL",
        author = "Copi",
        name = "Summon Anvil",
        description = "Summon a heavy anvil which can be kicked around and even moved by explosions",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/summon_anvil.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/anvil.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6", -- SUMMON_ROCK
        spawn_probability = "0.1,0.1,0.2,0.3,0.1,0.1,0.1", -- SUMMON_ROCK
        price = 227,
        mana = 143,
        max_uses = 3,
        --custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/summon_rock.xml",
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/anvil.xml")
        end
    },
    {
        id = "COPIS_THINGS_ARCANE_TURRET",
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
            if reflecting then
                return
            end

            local shooter = Entity.Current() -- Returns the entity shooting the wand
            local wand = Entity(shooter.Inventory2Component.mActiveItem)
            if not wand then
                return
            end

            local storage = Entity(EntityCreateNew("turret_storage")) -- Create a storage entity to pass our spell info to the turret
            local cards = GetSpells(wand)
            local store_deck = ""
            local store_inventory_item_id = "COPIS_THINGS_" -- The inventory_item_id is used to synchronize spell uses
            for k, v in ipairs(deck) do -- Generate ordered lists of cards to populate the turret wand
                store_deck = store_deck .. tostring(cards[v.deck_index + 1]:id()) .. ","
                store_inventory_item_id = store_inventory_item_id .. tostring(v.inventoryitem_id) .. ","
            end
            storage.variables.wand = tostring(wand:id()) -- Store relevant data in the storage entity for the turret to retrieve on spawn
            storage.variables.deck = store_deck
            storage.variables.inventoryitem_id = store_inventory_item_id
            for i, action in ipairs(deck) do
                table.insert(discarded, action)
            end -- Dump the rest of the deck into discard because they're consumed by the turret
            deck = {}
        end
    },
    {
        id = "COPIS_THINGS_ARCANE_TURRET_PATIENT",
        name = "Calculating Spell Turret",
        description = "Conjures a magical turret that casts spells from your wand, but only when enemies are in range",
        author = "Disco Witch",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/spell_turret_patient.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/spell_turret_patient.xml" },
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
            if reflecting then
                return
            end

            local shooter = Entity.Current() -- Returns the entity shooting the wand
            local wand = Entity(shooter.Inventory2Component.mActiveItem)
            if not wand then
                return
            end

            local storage = Entity(EntityCreateNew("turret_storage")) -- Create a storage entity to pass our spell info to the turret
            local cards = GetSpells(wand)
            local store_deck = ""
            local store_inventory_item_id = "COPIS_THINGS_" -- The inventory_item_id is used to synchronize spell uses
            for k, v in ipairs(deck) do -- Generate ordered lists of cards to populate the turret wand
                store_deck = store_deck .. tostring(cards[v.deck_index + 1]:id()) .. ","
                store_inventory_item_id = store_inventory_item_id .. tostring(v.inventoryitem_id) .. ","
            end
            storage.variables.wand = tostring(wand:id()) -- Store relevant data in the storage entity for the turret to retrieve on spawn
            storage.variables.deck = store_deck
            storage.variables.inventoryitem_id = store_inventory_item_id
            for i, action in ipairs(deck) do
                table.insert(discarded, action)
            end -- Dump the rest of the deck into discard because they're consumed by the turret
            deck = {}
        end
    },
    {
        id = "COPIS_THINGS_RECURSIVE_LARPA",
        author = "Copi",
        name = "Recursive Larpa",
        description = "Causes a spell to cast a perfect copy of itself on death",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/recursive_larpa.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = {},
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "6, 10",
        spawn_probability = "0.1, 0.2",
        price = 300,
        mana = 150,
        ai_never_uses = true,
        max_uses = -1,
        action = function()
            if reflecting then
                return
            end
            c.fire_rate_wait = c.fire_rate_wait + 60
            BeginProjectile("mods/copis_things/files/entities/projectiles/recursive_larpa_host.xml")
            BeginTriggerHitWorld()
            local shot = create_shot(1)
            shot.state.extra_entities =
                shot.state.extra_entities .. "mods/copis_things/files/entities/misc/recursive_larpa.xml,"
            draw_shot(shot, true)
            EndTrigger()
            EndProjectile()
        end
    },
    {
        id = "COPIS_THINGS_LARPA_FIELD",
        name = "Larpa Lens",
        description = "Creates a field that duplicates projectiles passing through it",
        author = "Disco Witch",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/larpa_lens.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/larpa_lens.xml" },
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6,10",
        spawn_probability = "0,0,0,0.1,0.1,0.1,0.2,0.3",
        price = 300,
        mana = 50,
        max_uses = 12,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/larpa_lens.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },
    {
        id = "COPIS_THINGS_SHIELD_SAPPER",
        author = "Copi",
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
        id = "COPIS_THINGS_PAPER_SHOT",
        author = "Copi",
        name = "Paper Shot",
        description = "Projectiles are affected by a very low terminal velocity",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/paper_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/misc/paper_shot.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4",
        spawn_probability = "0.5,0.4,0.3,0.2,0.1",
        price = 20,
        mana = 5,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/paper_shot.xml,"
            c.damage_slice_add = c.damage_slice_add + 0.2
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_FEATHER_SHOT",
        author = "Copi",
        name = "Feather Shot",
        description = "The projectile has reduced terminal velocity and added lifetime",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/feather_shot.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/misc/feather_shot.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,5",
        spawn_probability = "0.3,0.3,0.3",
        price = 100,
        mana = 3,
        action = function()
            c.lifetime_add = c.lifetime_add + 21
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/feather_shot.xml,"
            current_reload_time = current_reload_time - 6
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SCATTER_6",
        author = "Copi",
        name = "Sextuple scatter spell",
        description = "Simultaneously casts 6 spells with low accuracy",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/scatter_6.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/scatter_2_unidentified.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "1,2,3,4,5,6", -- SCATTER_4
        spawn_probability = "0.4,0.4,0.5,0.6,0.6,0.6", -- SCATTER_4
        price = 140,
        mana = 2,
        --max_uses = 100,
        action = function()
            draw_actions(6, true)
            c.spread_degrees = c.spread_degrees + 60.0
        end
    },
    {
        id = "COPIS_THINGS_SCATTER_8",
        author = "Copi",
        name = "Octuple scatter spell",
        description = "Simultaneously casts 8 spells with low accuracy",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/scatter_8.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/scatter_2_unidentified.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "1,2,3,4,5,6", -- SCATTER_4
        spawn_probability = "0.2,0.2,0.3,0.4,0.4,0.4", -- SCATTER_4
        price = 160,
        mana = 4,
        --max_uses = 100,
        action = function()
            draw_actions(8, true)
            c.spread_degrees = c.spread_degrees + 80.0
        end
    },
    {
        id = "COPIS_THINGS_CLOUD_MAGIC_LIQUID_HP_REGENERATION",
        author = "Copi",
        name = "Healthy Cloud",
        description = "Creates a soothing rain that cures your wounds",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/cloud_magic_liquid_hp_regeneration.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml" },
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5", -- CLOUD_WATER
        spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2", -- CLOUD_WATER
        price = 300,
        mana = 120,
        max_uses = 3,
        never_unlimited = true,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },
    {
        id = "COPIS_THINGS_CHAOS_SPRITES",
        author = "Copi",
        name = "Chaos Sprites",
        description = "Cast an uncontrolled burst of projectiles",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/chaos_sprites.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/chaos_sprites.xml", 5 },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "3,4,5,6",
        spawn_probability = "1,1,1,1",
        price = 260,
        mana = 42,
        max_uses = -1,
        never_unlimited = true,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
            add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
        end
    },
    {
        id = "COPIS_THINGS_SHIELD_GHOST",
        author = "Copi",
        name = "Summon Shielding Ghost",
        description = "Summons a tiny ethereal being to your help. It will fire protective shots that grant you an energy shield.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/shield_ghost.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/torch_unidentified.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.5,1,1,1,1", -- TINY_GHOST
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/shield_ghost.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_VACUUM_CLAW",
        author = "Copi",
        name = "Vacuum Claw",
        description = "A feral slash that sucks in your foes",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/vacuum_claw.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/vacuum_claw.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2,3,4,5",
        spawn_probability = "0.5,1,1,0.5",
        price = 120,
        mana = 35,
        action = function()
            current_reload_time = current_reload_time - 12
            c.fire_rate_wait = c.fire_rate_wait - 10
            if reflecting then
                return
            end
            add_projectile("mods/copis_things/files/entities/projectiles/vacuum_claw.xml")
        end
    },
    {
        id = "COPIS_THINGS_CAUSTIC_CLAW",
        author = "Copi",
        name = "Caustic Claw",
        description = "An acidic claw that melts your foes",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/caustic_claw.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/caustic_claw.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "1,2,3,4",
        spawn_probability = "0.5,1,1,0.5",
        price = 120,
        mana = 50,
        action = function()
            current_reload_time = current_reload_time + 12
            c.fire_rate_wait = c.fire_rate_wait + 10
            if reflecting then
                return
            end
            add_projectile("mods/copis_things/files/entities/projectiles/caustic_claw.xml")
        end
    },
    {
        id = "COPIS_THINGS_LUMINOUS_BLADE",
        author = "Copi",
        name = "Luminous Blade",
        description = "A sword of pure light, it slices through enemies with such grace it doesn't damage the environment",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/luminous_blade.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/luminous_blade.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,2,4,6",
        spawn_probability = "0.1,0.2,0.6,0.3",
        price = 150,
        mana = 40,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait - 20
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
                5 -- this is a hack to get the digger reload time back to 0
            if reflecting then
                return
            end
            add_projectile("mods/copis_things/files/entities/projectiles/luminous_blade.xml")
        end
    },
    {
        id = "COPIS_THINGS_INVERT",
        author = "Copi",
        name = "Invert Speed",
        description = "Reverses the direction a spell goes",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/invert.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,		3,		4,		5",
        spawn_probability = "0.2,		0.3,	0.4,	0.3",
        price = 75,
        mana = 1,
        --max_uses = 100,
        action = function()
            c.speed_multiplier = c.speed_multiplier * -1
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH",
        author = "Copi",
        name = "Small Teleport Bolt with Expiration Trigger",
        description = "A shortlived magical bolt that moves you and casts a spell wherever it ends up flying",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/teleport_projectile_short_trigger_death.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/teleport_projectile_short.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,4,5,6", -- TELEPORT_PROJECTILE
        spawn_probability = "0.4,0.6,0.7,0.4,0.3,0.2", -- TELEPORT_PROJECTILE
        price = 150,
        mana = 25,
        --max_uses = 80,
        custom_xml_file = "data/entities/misc/custom_cards/teleport_projectile_short.xml",
        action = function()
            add_projectile_trigger_death("data/entities/projectiles/deck/teleport_projectile_short.xml", 1)
            c.spread_degrees = c.spread_degrees - 2.0
        end
    },
    {
        id = "COPIS_THINGS_DEATH_CROSS_TRAIL",
        author = "Copi",
        name = "Death Cross Trail",
        description = "Projectiles leave a devastating trail of deathly crosses",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/death_cross_trail.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/death_cross_trail.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,4,5,6",
        spawn_probability = "0.2,0.5,0.7,0.4",
        price = 300,
        mana = 90,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 20
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/death_cross_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_GLITTERING_TRAIL",
        author = "Copi",
        name = "Glittering Trail",
        description = "Projectiles gain a trail of explosions",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/glittering_trail.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/glittering_trail.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.7,0.7,0.5,0.4,0.2",
        price = 120,
        mana = 10,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/glittering_trail.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET_RAY",
        author = "Copi",
        name = "Assault shot",
        description = "Makes a projectile rapidly fire silver bullets",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_ray.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.5,0.7,0.5,0.4", -- FIREBALL_RAY
        price = 300,
        mana = 130,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 30
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_ray.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET_RAY_6",
        author = "Copi",
        name = "Hexassault shot",
        description = "Makes a projectile fire silver bullets from it's sides",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray_6.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_ray.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.5,0.7,0.5,0.4", -- FIREBALL_RAY
        price = 300,
        mana = 100,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 40
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_ray_6.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET_ON_DEATH",
        author = "Copi",
        name = "Silver Scatter",
        description = "Makes a projectile fire silver bullets when it dies",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_on_death.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_on_death.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.5,0.7,0.5,0.4", -- FIREBALL_RAY
        price = 300,
        mana = 120,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_on_death.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET_RAY_SPIN",
        author = "Copi",
        name = "Silver Spread",
        description = "Makes a projectile fire silver bullets in a circle",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray_spin.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_ray_spin.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.5,0.7,0.5,0.4", -- FIREBALL_RAY
        price = 300,
        mana = 80,
        max_uses = 50,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 30
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_ray_spin.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SILVER_BULLET_RAY_ENEMY",
        author = "Copi",
        name = "Personal Silver Spread",
        description = "Causes hit enemies to spray out bullets",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray_enemy.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_silver_bullet_ray_enemy.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,10", -- FIREBALL_RAY
        spawn_probability = "0.5,0.7,0.5,0.4", -- FIREBALL_RAY
        price = 200,
        mana = 40,
        --max_uses = 20,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 30
            c.extra_entities =
                c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_silver_bullet_ray_enemy.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ICE_ORB",
        author = "Copi",
        name = "Frost Orb",
        description = "A chilling orb which shatters on death",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ice_orb.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/ice_orb.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2,3,4,5", -- SLOW_BULLET
        spawn_probability = "1,1,1,1", -- SLOW_BULLET
        price = 160,
        mana = 30,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 5

            if reflecting then
                Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/ice_orb.xml")
                return
            end

            BeginProjectile("mods/copis_things/files/entities/projectiles/ice_orb.xml")
            BeginTriggerDeath()
            BeginProjectile("mods/copis_things/files/entities/projectiles/ice_orb_fragment.xml")
            EndProjectile()
            BeginProjectile("mods/copis_things/files/entities/projectiles/ice_orb_fragment.xml")
            EndProjectile()
            BeginProjectile("mods/copis_things/files/entities/projectiles/ice_orb_fragment.xml")
            EndProjectile()
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()
        end
    },
    {
        id = "COPIS_THINGS_CHARM_FIELD",
        author = "Copi",
        name = "Circle of Persuasion",
        description = "A field of charming magic",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/charm_field.png",
        related_projectiles = { "data/entities/projectiles/deck/charm_field.xml" },
        type = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level = "0,1,2,3,4,5", -- TELEPORTATION_FIELD
        spawn_probability = "0.3,0.6,0.3,0.3,0.6,0.3", -- TELEPORTATION_FIELD
        price = 150,
        mana = 30,
        max_uses = 15,
        action = function()
            add_projectile("data/entities/projectiles/deck/charm_field.xml")
            c.fire_rate_wait = c.fire_rate_wait + 15
        end
    },
    {
        id = "COPIS_THINGS_MANA_RANDOM",
        author = "Copi",
        name = "Random Mana",
        description = "Adds or removes a random amount of mana to the wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/mana_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6", -- MANA_REDUCE
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8", -- MANA_REDUCE
        price = 300,
        mana = 0,
        --max_uses = 150,
        custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 5
            if reflecting then
                return
            end
            SetRandomSeed(GameGetFrameNum() + 978, GameGetFrameNum() + 663)
            local new_mana = mana + Random( -20, 60)

            if new_mana > mana then
                --
            else
                mana = mana - new_mana
            end
            mana = math.max(0, new_mana)

            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_WET_2X_DAMAGE_FREEZE",
        author = "Copi",
        name = "Snap Freeze",
        description = "Your projectile always deals 2x damage to wet enemies and freezes them",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_wet_2x_damage_freeze.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5",
        spawn_probability = "0.6,0.8,0.6,0.6",
        price = 160,
        mana = 50,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            c.extra_entities =
                c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_wet_2x_damage_freeze.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_BLOODY_2X_DAMAGE_POISONED",
        author = "Copi",
        name = "Viral Blood",
        description = "Your projectile always deals 2x damage to bloody enemies and poisons them",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_bloody_2x_damage_poisoned.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5",
        spawn_probability = "0.6,0.8,0.6,0.6",
        price = 160,
        mana = 50,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            c.extra_entities =
                c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_bloody_2x_damage_poisoned.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HITFX_OILED_2X_DAMAGE_BURN",
        author = "Copi",
        name = "Oil Ignition",
        description = "Your projectile always deals 2x damage to oiled enemies and engulfs them in flames",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_oiled_2x_damage_burn.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/burn_trail_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5",
        spawn_probability = "0.6,0.8,0.6,0.6",
        price = 160,
        mana = 50,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            c.extra_entities =
                c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_oiled_2x_damage_burn.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_BLINDNESS",
        author = "Copi",
        name = "Blinding Shot",
        description = "Your projectile blinds anyone it hits, including you",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/blindness.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,5,6",
        spawn_probability = "0.4,0.6,0.3",
        price = 100,
        mana = 100,
        max_uses = 50,
        custom_xml_file = "data/entities/misc/custom_cards/blindness.xml",
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            c.game_effect_entities =
                c.game_effect_entities ..
                "mods/copis_things/files/entities/misc/status_entities/effect_better_blindness.xml,"
            c.extra_entities = c.extra_entities .. "data/entities/particles/blindness.xml,"
            c.friendly_fire = true
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_MATERIAL_LAVA",
        author = "Copi",
        name = "$action_material_lava",
        description = "$actiondesc_material_lava",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/material_lava.png",
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,4,5", -- MATERIAL_WATER
        spawn_probability = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_WATER
        price = 110,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action = function()
            add_projectile("data/entities/projectiles/deck/material_lava.xml")
            c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_on_fire.xml,"
            c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
                10 -- this is a hack to get the cement reload time back to 0
        end
    },
    {
        id = "COPIS_THINGS_MATERIAL_MAGIC_LIQUID_POLYMORPH",
        author = "Copi",
        name = "Polymorphine",
        description = "Transmute globs of polymorphine from nothing",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/material_magic_liquid_polymorph.png",
        type = ACTION_TYPE_MATERIAL,
        spawn_level = "1,2,3,4,5", -- MATERIAL_WATER
        spawn_probability = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_WATER
        price = 110,
        mana = 0,
        sound_loop_tag = "sound_spray",
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/material_magic_liquid_polymorph.xml")
            c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_polymorph.xml,"
            c.fire_rate_wait = c.fire_rate_wait - 15
            current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
                10 -- this is a hack to get the cement reload time back to 0
        end
    },
    {
        id = "COPIS_THINGS_OPHIUCHUS",
        author = "Copi",
        name = "Ophiuchus Arts",
        description = "All your damage is halved then converted to healing, and your projectile can hit you. The next spell costs twice as much mana.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ophiuchus.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.1,0.1,0.1,0.1,0.6,0.1",
        price = 500,
        mana = 120,
        max_uses = 5,
        never_unlimited = true,
        action = function()
            copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/particles/healing.xml,mods/copis_things/files/entities/misc/ophiuchus.xml,"
            c.friendly_fire = true
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 12
            draw_actions(1, true)
            copi_state.mana_multiplier = copi_state.mana_multiplier / 2.0
        end
    },
    {
        id = "COPIS_THINGS_NUGGET_SHOT",
        author = "Copi",
        name = "Nugget Shot",
        description = "Hurl some of your hard earned gold at the enemy. Requires 10 gold",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/nugget_shot.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/nugget_shot.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2,3,4,5",
        spawn_probability = "0.6,0.6,0.6,0.6",
        price = 1000,
        mana = 30,
        action = function()
            local shooter = GetUpdatedEntityID()
            local wallet = EntityGetFirstComponent(shooter, "WalletComponent")
            if wallet ~= nil then
                local money = ComponentGetValue2(wallet, "money")
                local cost = 10
                if money >= cost then
                    add_projectile("mods/copis_things/files/entities/projectiles/nugget_shot.xml")
                    ComponentSetValue2(wallet, "money", money - cost)
                end
            end
        end
    },
    {
        id = "COPIS_THINGS_ASTRAL_VORTEX",
        author = "Copi",
        name = "Astral Vortex",
        description = "Summon a swirling phenomenon that fires 5 bursts of astral energy",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/astral_vortex.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/astral_beam.xml", 6 },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "3,4,5,6",
        spawn_probability = "0.5,1,1,0.5",
        price = 260,
        mana = 75,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 5

            if reflecting then
                Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/astral_vortex.xml")
                for i = 1, 6 do
                    Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
                end
                return
            end

            BeginProjectile("mods/copis_things/files/entities/projectiles/astral_vortex.xml")
            BeginTriggerTimer(10)
            BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
            EndProjectile()
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(20)
            BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
            EndProjectile()
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(30)
            BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
            EndProjectile()
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(40)
            BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
            EndProjectile()
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(50)
            BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
            EndProjectile()
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()
        end
    },
    {
        id = "COPIS_THINGS_LASER_EMITTER_SMALL",
        author = "Copi",
        name = "Plasma Shiv",
        description = "A short beam of light",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/laser_small.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/laser_unidentified.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/orb_laseremitter_small.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3", -- LASER
        spawn_probability = "0.6,1,1,0.6", -- LASER
        price = 180,
        mana = 10,
        action = function()
            add_projectile("mods/copis_things/files/entities/projectiles/orb_laseremitter_small.xml")
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_disintegrated.xml,"
        end
    },
    {
        id = "COPIS_THINGS_ACID",
        author = "Copi",
        name = "Acidic Shot",
        description = "Projectiles explode into dangerous acid",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/acid.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4",
        spawn_probability = "0.3,0.3,0.3",
        price = 120,
        mana = 20,
        action = function()
            c.material = "acid"
            c.material_amount = c.material_amount + 10
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_CEMENT",
        author = "Copi",
        name = "Cementing shot",
        description = "He really cemented himself a household name",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/cement.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/unstable_gunpowder_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4",
        spawn_probability = "0.3,0.3,0.3",
        price = 140,
        mana = 15,
        --max_uses    = 20,
        custom_xml_file = "data/entities/misc/custom_cards/unstable_gunpowder.xml",
        action = function()
            c.material = "cement"
            c.material_amount = c.material_amount + 10
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_LIFETIME_RANDOM",
        author = "Copi",
        name = "Randomize Lifetime",
        description = "Randomizes the lifetime of a projectile",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/lifetime_random.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,6,10", -- LIFETIME_DOWN
        spawn_probability = "0.5,0.5,0.5,0.5,0.1", -- LIFETIME_DOWN
        price = 90,
        mana = 10,
        --max_uses = 150,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/lifetime_random.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DELAY_2",
        author = "Copi",
        name = "Double Delay Spell",
        description = "Casts 2 spells in sequence",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/delay_2.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7",
        price = 150,
        mana = 0,
        --max_uses = 100,
        action = function()
            if reflecting then
                draw_actions(2, true)
                return
            end

            local firerate = c.fire_rate_wait + 9
            local old_c = c
            c = {}
            shot_effects = {}
            --reset_modifiers(c);

            BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
            BeginTriggerDeath()
            BeginProjectile("mods/copis_things/files/entities/projectiles/burst_fire.xml")
            BeginTriggerTimer(1)
            for index, value in pairs(old_c) do
                c[index] = value
            end
            old_c = c
            draw_actions(1, true)
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(firerate + 1)
            for index, value in pairs(old_c) do
                c[index] = value
            end
            old_c = c
            draw_actions(1, true)
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()
            c.lifetime_add = firerate + 1
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()

            c = old_c
        end
    },
    {
        id = "COPIS_THINGS_DELAY_3",
        author = "Copi",
        name = "Triple Delay Spell",
        description = "Casts 3 spells in sequence",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/delay_3.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5",
        price = 150,
        mana = 0,
        --max_uses = 100,
        action = function()
            if reflecting then
                draw_actions(3, true)
                return
            end

            local firerate = c.fire_rate_wait + 9
            local old_c = c
            c = {}
            shot_effects = {}
            --reset_modifiers(c);

            BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
            BeginTriggerDeath()
            BeginProjectile("mods/copis_things/files/entities/projectiles/burst_fire.xml")
            BeginTriggerTimer(1)
            for index, value in pairs(old_c) do
                c[index] = value
            end
            old_c = c
            draw_actions(1, true)
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(firerate + 1)
            for index, value in pairs(old_c) do
                c[index] = value
            end
            old_c = c
            draw_actions(1, true)
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            BeginTriggerTimer(firerate * 2 + 1)
            for index, value in pairs(old_c) do
                c[index] = value
            end
            old_c = c
            draw_actions(1, true)
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()
            c.lifetime_add = firerate * 2 + 1
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()

            c = old_c
        end
    },
    {
        id = "COPIS_THINGS_DELAY_X",
        author = "Copi",
        name = "Total Delay Spell",
        description = "Casts all remaining spells in sequence",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/delay_x.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "5,6,10",
        spawn_probability = "0.2,0.2,0.5",
        price = 500,
        mana = 50,
        max_uses = 30,
        action = function()
            if reflecting then
                return
            end

            local firerate = c.fire_rate_wait + 9
            local old_c = c
            c = {}
            shot_effects = {}
            --reset_modifiers(c);

            BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
            BeginTriggerDeath()
            local n = 0
            BeginProjectile("mods/copis_things/files/entities/projectiles/burst_fire.xml")
            while (#deck > 0) do
                BeginTriggerTimer(firerate * n + 1)
                for index, value in pairs(old_c) do
                    c[index] = value
                end
                old_c = c
                draw_actions(1, true)
                register_action(c)
                SetProjectileConfigs()
                EndTrigger()
                n = n + 1
            end
            EndProjectile()
            c.lifetime_add = firerate * n + 1
            register_action(c)
            SetProjectileConfigs()
            EndTrigger()
            EndProjectile()

            c = old_c
        end
    },
    {
        id = "COPIS_THINGS_CHAOS_RAY",
        author = "Copi",
        name = "Pandora Shot",
        description = "Your projectile fires out random projectiles",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/chaos_ray.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/chaos_ray.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5", -- FIREBALL_RAY
        spawn_probability = "0.3,0.5,0.3", -- FIREBALL_RAY
        price = 260,
        mana = 140,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/chaos_ray.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ORDER_DECK",
        author = "Copi",
        name = "Order Deck",
        description = "Your wand casts spells in order",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/order_deck.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "0,1,2,3,4", -- TINY_GHOST
        spawn_probability = "1,1,1,1,1", -- TINY_GHOST
        price = 100,
        mana = 7,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/order_deck.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_MANA_EFFICENCY",
        author = "Copi",
        name = "Mana Efficiency",
        description = "The next spell costs half as much mana",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/mana_efficiency.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "3,4,5,6",
        spawn_probability = "0.2,0.2,0.2,0.2",
        price = 150,
        mana = 0,
        action = function()
            copi_state.mana_multiplier = copi_state.mana_multiplier * 0.5
            draw_actions(1, true)
            copi_state.mana_multiplier = copi_state.mana_multiplier * 2
        end
    },
    {
        id = "COPIS_THINGS_ULT_DAMAGE",
        author = "Copi",
        name = "Empower",
        description = "The next spell deals 5x more damage but costs 3x more mana",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ult_damage.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6,10",
        spawn_probability = "0.12,0.12,0.12,0.24,0.24,0.36",
        price = 500,
        mana = 20,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ult_damage.xml",
        action = function()
            copi_state.mana_multiplier = copi_state.mana_multiplier * 3.0
            c.damage_projectile_add = c.damage_projectile_add + 0.08
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_damage.xml,"
            draw_actions(1, true)
            copi_state.mana_multiplier = copi_state.mana_multiplier / 3.0
        end
    },
    {
        id = "COPIS_THINGS_ULT_DRAW_MANY",
        author = "Copi",
        name = "Stack",
        description = "Fire all remaining spells with stat improvements proportional to spells drawn.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ult_draw_many.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "2,3,4,5,6,10",
        spawn_probability = "0.12,0.12,0.12,0.24,0.24,0.36",
        price = 500,
        mana = 25,
        max_uses = 10,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ult_draw_many.xml",
        recursive = true,
        never_ac = true,
        action = function(recursion_level, iteration)
            if reflecting then
                return
            end
            if (recursion_level or iteration) ~= nil then
                return
            end

            local n = 1
            while (#deck > 0) do
                n = n + 1
                draw_actions(1, true)
            end

            c.spread_degrees = c.spread_degrees + (n * 2.5)
            c.fire_rate_wait = c.fire_rate_wait + (n * 6)
            c.screenshake = c.screenshake + (n * 1)
            c.damage_critical_chance = c.damage_critical_chance + (n * 2)
            c.lifetime_add = c.lifetime_add + (n * 1)
            c.damage_projectile_add = c.damage_projectile_add + (n * 0.05)
            c.speed_multiplier = c.speed_multiplier + (n * 0.2)
            c.gore_particles = c.gore_particles + (n * 2)
            c.bounces = c.bounces + math.floor(n * 0.25)
            if n >= 20 then
                c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_white.xml,"
                c.ragdoll_fx = 3
            elseif n >= 10 then
                c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_white_weak.xml,"
                c.ragdoll_fx = 4
                c.explosion_radius = c.explosion_radius + math.floor(n * 0.25)
            end
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + (n * 1)
        end
    },
    {
        id = "COPIS_THINGS_ULT_LIFETIME",
        author = "Copi",
        name = "Bind",
        description = "Cast a spell that drains 30 mana every second, but doesn't die unless your wand runs out of mana.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ult_lifetime.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6,10",
        spawn_probability = "0.12,0.12,0.12,0.24,0.24,0.36",
        price = 150,
        mana = 30,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ult_lifetime.xml",
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 64
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_lifetime.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ULT_CONTROL",
        author = "Copi",
        name = "Impose",
        description = "The spell follows the cursor",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ult_control.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6,10",
        spawn_probability = "0.12,0.12,0.12,0.24,0.24,0.36",
        price = 80,
        mana = 10,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ult_control.xml",
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 32
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_control.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ULT_RECHARGE",
        author = "Copi",
        name = "Haste",
        description = "Double mana cost to dramatically reduce the next spell's cast delay and recharge time",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ult_recharge.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6,10",
        spawn_probability = "0.12,0.12,0.12,0.24,0.24,0.36",
        price = 140,
        mana = 30,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ult_recharge.xml",
        action = function()
            if reflecting then
                copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
                c.fire_rate_wait = c.fire_rate_wait / 3
                current_reload_time = current_reload_time / 3
                draw_actions(1, true)
                copi_state.mana_multiplier = copi_state.mana_multiplier / 2.0
                return
            end
            copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
            c.fire_rate_wait = math.min(c.fire_rate_wait / 3, c.fire_rate_wait - 16)
            current_reload_time = math.min(current_reload_time / 3, current_reload_time - 16)
            draw_actions(1, true)
            copi_state.mana_multiplier = copi_state.mana_multiplier / 2.0
        end
    },
    {
        id = "COPIS_THINGS_ULT_PROTECTION",
        author = "Copi",
        name = "Fortify",
        description = "Cast the next spell with a 3x higher mana cost, but it can not directly damage you",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ult_protection.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "1,1,1,1,1,1,1",
        price = 200,
        mana = 23,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ult_protection.xml",
        action = function()
            copi_state.mana_multiplier = copi_state.mana_multiplier * 3.0
            c.fire_rate_wait = c.fire_rate_wait + 17
            current_reload_time = current_reload_time + 17
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_protection.xml,"
            draw_actions(1, true)
            copi_state.mana_multiplier = copi_state.mana_multiplier / 3.0
        end
    },
    {
        id = "COPIS_THINGS_BALLOON",
        author = "Copi",
        name = "Alchemia Balloon",
        description = "A balloon that's filled with a material from your potions",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/balloon.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/balloon.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "1,1,1,1,1,1,1",
        price = 90,
        mana = 12,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 12
            add_projectile("mods/copis_things/files/entities/projectiles/balloon.xml")
        end
    },
    {
        id = "COPIS_THINGS_HOMING_SEEKER",
        author = "Copi",
        name = "Seeker Shot",
        description = "Projectiles rotate and accelerate towards the nearest target in front of them",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/homing_seeker.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "0.1,0.2,0.3,0.4,0.5,0.4,0.3",
        price = 280,
        mana = 22,
        action = function()
            c.bounces = c.bounces + 1
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_seeker.xml,"
            c.speed_multiplier = c.speed_multiplier * 0.65
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_PERSISTENT_SHOT",
        author = "Copi",
        name = "Persistent Shot",
        description = "Cast 2 spells that keep moving in the direction they were cast",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/persistent_shot.png",
        type = ACTION_TYPE_DRAW_MANY,
        spawn_level = "0,1,2,3,4",
        spawn_probability = "0.4,0.4,0.4,0.4,0.4",
        price = 160,
        mana = 17,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/persistent_shot.xml,"
            draw_actions(2, true)
        end
    },
    {
        id = "COPIS_THINGS_HYPER_BOUNCE",
        author = "Copi",
        name = "Hyper Bounce",
        description = "Cast a spell with unrivaled bouncing potential",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/hyper_bounce.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4",
        spawn_probability = "0.8,0.8,0.8",
        price = 300,
        mana = 15,
        action = function()
            c.bounces = c.bounces + 100
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hyper_bounce.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ULTRAKILL",
        author = "Copi",
        name = "Steel Sole",
        description = "Kick nearby projectiles to launch them forwards. Costs 5 mana per projectile",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ultrakill.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price = 280,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/ultrakill.xml",
        action = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_WOOD_BRUSH",
        author = "Copi",
        name = "Engineering Shot",
        description = "Cast a spell which leaves sturdy wood in it's wake",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/wood_brush.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4",
        spawn_probability = "0.3,0.3,0.3,0.3",
        price = 300,
        mana = 30,
        action = function()
            c.speed_multiplier = c.speed_multiplier * 0.75
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/wood_brush.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_HOMING_ANTI_SHOOTER",
        author = "Copi",
        name = "Repulsion Shot",
        description = "Projectiles will be repelled from the caster",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/homing_anti_shooter.png",
        related_extra_entities = {
            "mods/copis_things/files/entities/misc/homing_anti_shooter.xml,data/entities/particles/tinyspark_white_weak.xml"
        },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6", -- HOMING
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,6", -- HOMING
        price = 100,
        mana = 12,
        action = function()
            c.extra_entities =
                c.extra_entities ..
                "mods/copis_things/files/entities/misc/homing_anti_shooter.xml,data/entities/particles/tinyspark_white_weak.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ALCOHOL_SHOT",
        author = "Copi",
        name = "Inebriation",
        description = "Makes a projectile get the enemies it hits drunk",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/inebriation.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5",
        spawn_probability = "0.4,0.4,0.4,0.4,0.4",
        price = 70,
        mana = 10,
        action = function()
            c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_drunk.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_SPREAD_DAMAGE",
        author = "Copi",
        name = "Area Damage",
        description = "Projectiles deal their damage in a radius around them, but cost 2x more mana to cast",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/spread_damage.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.5,0.5,0.5,0.5,0.5",
        price = 150,
        mana = 10,
        action = function()
            copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
            if not c.extra_entities:find("mods/copis_things/files/entities/misc/spread_damage_unique.xml,") then
                c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/spread_damage_unique.xml,"
            end
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/spread_damage.xml,"
            draw_actions(1, true)
            copi_state.mana_multiplier = copi_state.mana_multiplier / 2.0
        end
    },
    {
        id = "COPIS_THINGS_SUMMON_JAR_URINE",
        author = "Copi",
        name = "Jarate",
        description = "Jar-based Karate",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/summon_jar_urine.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "2,		3,		4,		5,		6",
        spawn_probability = "0.025,	0.033,	0.050,	0.033,	0.025",
        price = 200,
        mana = 45,
        max_uses = 30,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 10
            current_reload_time = current_reload_time + 20
            add_projectile("data/entities/items/pickup/jar_of_urine.xml")
        end
    },
    {
        id = "COPIS_THINGS_ORBIT_SHOOTER",
        author = "Copi",
        name = "Orbital Shot",
        description = "Causes the projectile to orbit the shooter",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/orbit_shooter.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/orbit_shooter.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_TELEPORT_CORPSE",
        author = "Copi",
        name = "Deathbound teleport bolt",
        description = "A magical bolt that curses a body to carry you postmortem",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/teleport_corpse.png",
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/teleport_corpse.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DAMAGE_BOUNCE",
        author = "Copi",
        name = "Bouncing Damage",
        description = "Increases the damage done by a projectile every time it bounces",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/damage_bounce.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.bounces = c.bounces + 3
            c.damage_projectile_add = c.damage_projectile_add + 0.1
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_bounce.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_DIE",
        author = "Copi",
        name = "Die",
        description = "Reverses the flow of mana in your body, giving you a quick and painless death.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/die.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "6,10",
        spawn_probability = "0.2,1",
        price = 250,
        mana = 0,
        action = function()
            if reflecting then
                return
            end
            local entity_id = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                local x, y = EntityGetTransform(entity_id)
                EntityLoad("data/entities/particles/image_emitters/player_disappear_effect_right.xml", x, y) -- gfx
                EntityInflictDamage(entity_id, 99999999999999999999999999999999999999999999999999999999999999999,
                    "DAMAGE_PHYSICS_BODY_DAMAGED", "death.", "DISINTERGRATED", 0, 0, entity_id, x, y, 10)
                EntityKill(entity_id)
            end
        end
    },
    {
        id = "COPIS_THINGS_CORPSE_BOMB",
        author = "Copi",
        name = "Detonecromation",
        description = "Causes the corpses of killed enemies to violently explode into noxious gasses",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/corpse_bomb.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/corpse_bomb.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_ENERGY_SHIELD_DIRECTIONAL",
        author = "Copi",
        name = "Smart Energy Shield",
        description = "A denser energy shield which turns towards projectiles.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/energy_shield_directional.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/energy_shield_sector_unidentified.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.05,0.6,0.6,0.6,0.6,0.6", -- ENERGY_SHIELD_SECTOR
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/energy_shield_directional.xml",
        action = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_CLEANING_TOOL",
        author = "Copi",
        name = "Mop",
        description = "Clean the ground around you!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/cleaning_tool.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/energy_shield_sector_unidentified.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.01,0.2,0.3,0.2,0.2,0.2", -- ENERGY_SHIELD_SECTOR
        price = 160,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/cleaning_tool.xml",
        action = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_COIN",
        author = "Copi",
        name = "Toss Coin",
        description = "Toss a coin in the air. Requires 10 gold. Maybe you can shoot it?",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/ricoinshot.png",
        type = ACTION_TYPE_UTILITY,
        spawn_level = "1, 2, 3, 4, 5, 6",
        spawn_probability = "0.6, 0.3, 0.1,	0.1, 0.1, 0.1",
        price = 25,
        mana = 0,
        action = function()
            if not reflecting then
                local shooter = GetUpdatedEntityID()
                local wallet_component = EntityGetFirstComponentIncludingDisabled(shooter, "WalletComponent")
                local money = ComponentGetValue2(wallet_component, "money")
                if money >= 10 then
                    ComponentSetValue2(wallet_component, "money", money - 10)
                    add_projectile("mods/copis_things/files/entities/projectiles/coin.xml")
                end
            end
            c.fire_rate_wait = c.fire_rate_wait + 10
            current_reload_time = current_reload_time + 20
        end
    },
    {
        id = "COPIS_THINGS_ALT_FIRE_COIN",
        author = "Copi",
        name = "Alt Fire Toss Coin",
        description = "Toss a coin in the air when you alt fire. Requires 10 gold. Maybe you can shoot it?",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_ricoinshot.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1, 2, 3, 4, 5, 6",
        spawn_probability = "0.8, 0.7, 0.5,	0.3, 0.1, 0.1",
        price = 30,
        mana = 0,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_coin.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_VERTICAL_ARC",
        name = "Vertical Path",
        description = "Forces a projectile on a vertical path, but increases its damage",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/vertical_arc.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/sinewave_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/vertical_arc.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,3,5", -- HORIZONTAL_ARC
        spawn_probability = "0.4,0.4,0.4", -- HORIZONTAL_ARC
        price = 20,
        mana = 0,
        --max_uses = 150,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/vertical_arc.xml,"
            draw_actions(1, true)
            c.damage_projectile_add = c.damage_projectile_add + 0.3
            c.fire_rate_wait        = c.fire_rate_wait - 6
        end,
    },
    {
        id = "COPIS_THINGS_ARC_CONCRETE",
        name = "Concrete Arc",
        description = "Creates arcs of concrete between projectiles. Make sure not to get stuck! (requires 2 projectile spells)",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/arc_concrete.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/arc_fire_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/arc_concrete.xml" },
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5", -- ARC_POISON
        spawn_probability = "0.4,0.4,0.4,0.4,0.4", -- ARC_POISON
        price = 160,
        --max_uses 	= 15,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/arc_concrete.xml,"
            draw_actions(1, true)
        end,
    },
    {
        id = "COPIS_THINGS_MANA_ENGINE",
        name = "Mana Engine",
        description = "Adds additional mana when you fire consecutively.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/mana_engine.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
        price = 220,
        mana = 0,
        action = function()
            if reflecting then
                return
            end
            local caster = GetUpdatedEntityID()
            if IsPlayer(caster) then
                local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
                if controls_component ~= nil then
                    LastShootingStart = LastShootingStart or 0
                    Revs = Revs or 0
                    local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
                    local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

                    if not shooting_now then
                        Revs = 0
                    else
                        if LastShootingStart ~= shooting_start then
                            Revs = 0
                        else
                            Revs = Revs + 1
                            local mana_add = math.min(80, math.ceil((Revs / 5) ^ 1.5) * 5)
                            local delay_add = math.min(40, Revs ^ (1 / 3))
                            mana = mana + mana_add
                            c.fire_rate_wait = c.fire_rate_wait + delay_add
                        end
                    end
                    LastShootingStart = shooting_start
                    draw_actions(1, true)
                end
            end
        end,
    },
    {
        id = "COPIS_THINGS_RECHARGE_ENGINE",
        name = "Recharge Engine",
        description = "Reduces time between spellcasts when you fire consecutively.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/recharge_engine.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
        price = 220,
        mana = 20,
        action = function()
            if reflecting then
                return
            end
            local caster = GetUpdatedEntityID()
            if IsPlayer(caster) then
                local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
                if controls_component ~= nil then
                    LastShootingStart = LastShootingStart or 0
                    Revs = Revs or 0
                    local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
                    local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

                    if not shooting_now then
                        Revs = 0
                    else
                        if LastShootingStart ~= shooting_start then
                            Revs = 0
                        else
                            Revs = Revs + 1
                            local reload_reduce = math.min(80, Revs ^ (1 / 2))
                            current_reload_time = current_reload_time - reload_reduce
                            c.fire_rate_wait = c.fire_rate_wait - reload_reduce
                            c.spread_degrees = c.spread_degrees + math.min(Revs ^ (1 / 4), 75)
                        end
                    end
                    LastShootingStart = shooting_start
                    draw_actions(1, true)
                end
            end
        end,
    },
    {
        id = "COPIS_THINGS_DAMAGE_ENGINE",
        name = "Overheat Engine",
        description = "Adds burning damage when you fire consecutively, but you may catch on fire!",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/damage_engine.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
        price = 220,
        mana = 10,
        action = function()
            if reflecting then
                c.damage_fire_add = c.damage_fire_add + 0.08
                return
            end
            local caster = GetUpdatedEntityID()
            if IsPlayer(caster) then
                local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
                if controls_component ~= nil then
                    LastShootingStart = LastShootingStart or 0
                    Revs = Revs or 0
                    local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
                    local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

                    if not shooting_now then
                        Revs = 0
                    else
                        if LastShootingStart ~= shooting_start then
                            Revs = 0
                        else
                            Revs = Revs + 1
                            c.damage_fire_add = c.damage_fire_add + math.min(0.64, Revs / 100)
                            if math.random(0, 100) < math.min(Revs, 200) / 2 then
                                GetGameEffectLoadTo(caster, "ON_FIRE", false)
                            end
                        end
                    end
                    LastShootingStart = shooting_start
                    draw_actions(1, true)
                end
            end
        end,
    },
    {
        id = "COPIS_THINGS_SHIELD_ENGINE",
        name = "Shield Engine",
        description = "Bolsters your defences while you fire consecutively",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/shield_engine.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
        price = 220,
        mana = 4,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/shield_engine.xml",
        action = function()
            if reflecting then
                return
            end
            local caster = GetUpdatedEntityID()
            if IsPlayer(caster) then
                local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
                if controls_component ~= nil then
                    LastShootingStart = LastShootingStart or 0
                    Revs = Revs or 0
                    local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
                    local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

                    if not shooting_now then
                        Revs = 0
                    else
                        if LastShootingStart ~= shooting_start then
                            Revs = 0
                        else
                            Revs = Revs + 1
                        end
                    end
                    LastShootingStart = shooting_start
                    GlobalsSetValue("PLAYER_REVS", Revs)
                    draw_actions(1, true)
                end
            end
        end,
    },
    --[[ WHY NO WORK??
    {
        id = "COPIS_THINGS_RECHARGE_UNSTABLE",
        name = "Unstable Recharge",
        description = "Greatly reduces the time between spellcasts, with an increasing chance to malfunction.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/recharge_unstable.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "1,2,3,4,5,6",
        spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
        price = 220,
        mana = 8,
        action = function()
            if reflecting then
                c.fire_rate_wait = c.fire_rate_wait - 10
                current_reload_time = current_reload_time - 20
            else
                RechargesUnstable = (RechargesUnstable or 0) + 1
                local time_delta = -100
                if math.random(0 , 100) < math.max(RechargesUnstable, 0)/3 - 5 then
                    -- Reset Counter + Explode Player
                    RechargesUnstable = 0
                    local x, y = EntityGetTransform(GetUpdatedEntityID())
                    EntityLoad("data/entities/projectiles/deck/explosion.xml", x, y)
                    -- Increase Recharge
                    time_delta = 60
                end
                -- Reduce Recharge
                c.fire_rate_wait = c.fire_rate_wait + time_delta/2
                current_reload_time = current_reload_time + time_delta
                GamePrint(tostring(current_reload_time))
            end
        end,
    },]]
    {
        id = "COPIS_THINGS_RAINBOW_TRAIL",
        name = "Rainbow Trail",
        description = "Show your colour",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/rainbow_trail.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "0.8,0.6,0.4,0.2,0.2,0.2,0.2",
        price = 10,
        mana = 0,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/rainbow_trail.xml,"
            draw_actions(1, true)
        end,
    },
    {
        id = "COPIS_THINGS_ALT_FIRE_BOMB",
        author = "Copi",
        name = "Alt Fire Bomb",
        description = "Summons a bomb that destroys ground very efficiently when you alt fire. Consumes 25 mana per shot.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_bomb.png",
        type = ACTION_TYPE_PASSIVE,
        spawn_level = "0,1,2,3,4,5,6", -- BOMB
        spawn_probability = "1,1,1,1,1,1,1", -- BOMB
        price = 250,
        mana = 0,
        max_uses = 3,
        custom_uses_logic = true,
        custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_bomb.xml",
        action = function()
            draw_actions(1, true)
        end
    },
    {
        id                  = "COPIS_THINGS_QUESTIONABLE",
        name                = "?",
        description         = "joke content -- todo remove",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/dotpng.png",
        sprite_unidentified = "mods/copis_things/files/ui_gfx/gun_actions/dotpng.png",
        spawn_requires_flag = "secret_fruit",
        type                = ACTION_TYPE_OTHER,
        recursive           = true,
        spawn_level         = "0,1,2,3,4,5,6", -- BOMB
        spawn_probability   = "1,1,1,1,1,1,1", -- BOMB
        price               = 600,
        mana                = 300,
        max_uses            = 1,
        never_unlimited     = true,
        custom_uses_logic   = true,
        action              = function(recursion_level, iteration)
            if not reflecting then
                c.fire_rate_wait = c.fire_rate_wait + 150
                current_reload_time = current_reload_time + 40
                local boss_kill_count = tonumber(GlobalsGetValue("GLOBAL_BOSS_KILL_COUNT", "0"))
                current_action.uses_remaining = boss_kill_count
                if boss_kill_count > 0 then
                    for i = 1, boss_kill_count do
                        dofile_once("data/scripts/streaming_integration/event_list.lua")
                        local choice = streaming_events[math.random(1, #streaming_events)]
                        choice.action(choice)
                    end
                else
                    GamePrintImportant("A powerful entity is sealing an unknown power!")
                end
            else
                c.fire_rate_wait = c.fire_rate_wait - 150
                current_reload_time = current_reload_time - 40
            end
        end,
    },
    --[[
    {
        id = "COPIS_THINGS_TARGET_TRIGGER",
        author = "Copi",
        name = "Target with expiration trigger",
        description = "A target which fires a projectile when it is destroyed.",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/target_death_trigger.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/target.xml" },
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "0,1,2,3,4,5,6",
        spawn_probability = "1,1,1,1,1,1,1",
        price = 90,
        mana = 2,
        action = function()
            c.fire_rate_wait = c.fire_rate_wait + 12
            current_reload_time = current_reload_time + 12
            if reflecting then
                Reflection_RegisterProjectile( "mods/copis_things/files/entities/projectiles/target.xml" )
                return
            end

            BeginProjectile( "mods/copis_things/files/entities/projectiles/target.xml" )
                BeginTriggerDeath()
                    draw_shot( create_shot( 1 ), true )
                EndTrigger()
            EndProjectile()
        end
    },]]
}

-- SPEEDY loop
for i = 1, #actions_to_insert do
    actions[#actions + 1] = actions_to_insert[i]
end
