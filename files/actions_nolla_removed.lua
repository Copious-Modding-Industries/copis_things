---@diagnostic disable: undefined-global


table.insert(actions,
{
    id          = "TESTBULLET", -- REMOVE THIS ONCE PHYSICS_EXPLOSION_POWER IS ADJUSTED, JUST FOR TESTING
    name 		= "$action_testbullet",
    description = "actiondesc_testbullet",
    sprite 		= "data/debug/icon_testbullet.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- TESTBULLET
    spawn_probability                        = "", -- TESTBULLET
    price = 100,
    mana = 0,
    max_uses = 999,
    action 		= function()
        add_projectile("data/entities/animals/boss_centipede/firepillar.xml")
        c.fire_rate_wait = 0
        current_reload_time = current_reload_time * 0.01
    end
})

table.insert(actions,
{
    id          = "DECOY",
    name 		= "$action_decoy",
    description = "$actiondesc_decoy",
    sprite 		= "data/ui_gfx/gun_actions/decoy.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/decoy_unidentified.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- DECOY
    spawn_probability                 = "", -- DECOY
    price = 130,
    mana = 60,
    max_uses    = 10, 
    custom_xml_file = "data/entities/misc/custom_cards/decoy.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/deck/decoy.xml")
        c.fire_rate_wait = c.fire_rate_wait + 40
    end
})

table.insert(actions,
{
    id          = "DECOY_TRIGGER",
    name 		= "$action_decoy_trigger",
    description = "$actiondesc_decoy_trigger",
    sprite 		= "data/ui_gfx/gun_actions/decoy_trigger.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/decoy_trigger_unidentified.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- DECOY_TRIGGER
    spawn_probability                 = "", -- DECOY_TRIGGER
    price = 150,
    mana = 80,
    max_uses    = 10, 
    custom_xml_file = "data/entities/misc/custom_cards/decoy_trigger.xml",
    action 		= function()
        add_projectile_trigger_death("data/entities/projectiles/deck/decoy_trigger.xml", 1)
        c.fire_rate_wait = c.fire_rate_wait + 40
    end
})


table.insert(actions,
{
    id          = "PIPE_BOMB_DETONATOR",
    name 		= "$action_pipe_bomb_detonator",
    description = "$actiondesc_pipe_bomb_detonator",
    sprite 		= "data/ui_gfx/gun_actions/pipe_bomb_detonator.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/pipe_bomb_detonator_unidentified.png",
    related_projectiles	= {"data/entities/projectiles/deck/pipe_bomb_detonator.xml"},
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "2,3,4,5,6", -- PIPE_BOMB_DETONATOR
    spawn_probability                 = "1,1,1,1,1", -- PIPE_BOMB_DETONATOR
    price = 50,
    mana = 50,
    --max_uses = 50,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/pipe_bomb_detonator.xml")
        c.fire_rate_wait = c.fire_rate_wait + 5
        --current_reload_time = current_reload_time + 5
    end,
})

table.insert(actions,
{
    id          = "BLOODTENTACLE",
    name 		= "$action_bloodtentacle",
    description = "$actiondesc_bloodtentacle",
    spawn_requires_flag = "card_unlocked_pyramid",
    sprite 		= "data/ui_gfx/gun_actions/bloodtentacle.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/tentacle_unidentified.png",
    related_projectiles	= {"data/entities/projectiles/deck/bloodtentacle.xml"},
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "3,4,5,6", -- TENTACLE
    spawn_probability                 = "0.2,0.5,1,1", -- TENTACLE
    price = 170,
    mana = 30,
    --max_uses = 40,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/bloodtentacle.xml")
        c.fire_rate_wait = c.fire_rate_wait + 20
    end,
})

table.insert(actions,
{
    id          = "ICETHROWER",
    name 		= "$action_icethrower",
    description = "$actiondesc_icethrower",
    sprite 		= "data/ui_gfx/gun_actions/icethrower.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- ICETHROWER
    spawn_probability                        = "", -- ICETHROWER
    price = 260,
    mana = 20,
    max_uses = 60,
    custom_xml_file = "data/entities/misc/custom_cards/icethrower.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/icethrower.xml")
        c.spread_degrees = c.spread_degrees + 2.0
    end,
})

table.insert(actions,
{
    id          = "KNIFE",
    name 		= "$action_knife",
    description = "$actiondesc_knife",
    sprite 		= "data/ui_gfx/gun_actions/knife.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- KNIFE
    spawn_probability                 = "", -- KNIFE
    price = 200,
    mana = 50, 
    max_uses    = 5, 
    custom_xml_file = "data/entities/misc/custom_cards/knife.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/deck/knife.xml")
    end,
})


table.insert(actions,
{
    id          = "CIRCLESHOT_A",
    name 		= "$action_circleshot_a",
    description = "$actiondesc_circleshot_a",
    sprite 		= "data/ui_gfx/gun_actions/phantomshot_a.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- CIRCLESHOT_A
    spawn_probability                        = "", -- CIRCLESHOT_A
    price = 100,
    mana = 80,
    custom_xml_file = "data/entities/misc/custom_cards/circleshot_a.xml",
    max_uses    = 40, 
    action 		= function()
        add_projectile("data/entities/projectiles/orbspawner_green.xml")
        current_reload_time = current_reload_time + 80
    end,
})


table.insert(actions,
{
    id          = "CIRCLESHOT_B",
    name 		= "$action_circleshot_b",
    description = "$actiondesc_circleshot_b",
    sprite 		= "data/ui_gfx/gun_actions/phantomshot_b.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- CIRCLESHOT_B
    spawn_probability                        = "", -- CIRCLESHOT_B
    price = 100,
    mana = 80,
    max_uses    = 40, 
    custom_xml_file = "data/entities/misc/custom_cards/circleshot_b.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/orbspawner.xml")
        current_reload_time = current_reload_time + 80
    end,
})


table.insert(actions,
{
    id          = "BLOOMSHOT",
    name 		= "$action_bloomshot",
    description = "$actiondesc_bloomshot",
    sprite 		= "data/ui_gfx/gun_actions/bloomshot.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- BLOOMSHOT
    spawn_probability                        = "", -- BLOOMSHOT
    price = 150,
    mana = 80,
    max_uses    = 30, 
    custom_xml_file = "data/entities/misc/custom_cards/bloomshot.xml",
    -- max_uses    = 10, 
    action 		= function()
        add_projectile("data/entities/projectiles/bloomshot.xml")
        current_reload_time = current_reload_time + 40
    end,
})

table.insert(actions,
{
    id          = "ICECIRCLE",
    name 		= "$action_icecircle",
    description = "$actiondesc_icecircle",
    sprite 		= "data/ui_gfx/gun_actions/icecircle.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- ICECIRCLE
    spawn_probability                        = "", -- ICECIRCLE
    price = 130,
    mana = 100,
    max_uses    = 30, 
    custom_xml_file = "data/entities/misc/custom_cards/icecircle.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/iceskull_explosion.xml")
        current_reload_time = current_reload_time + 60
    end,
})

table.insert(actions,
{
    id          = "PINK_ORB",
    name 		= "$action_pink_orb",
    description = "$actiondesc_pink_orb",
    sprite 		= "data/ui_gfx/gun_actions/pink_orb.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- PINK_ORB
    spawn_probability                        = "", -- PINK_ORB
    price = 160,
    mana = 60,
    max_uses    = 25, 
    custom_xml_file = "data/entities/misc/custom_cards/pink_orb.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/deck/pink_orb.xml")
        current_reload_time = current_reload_time + 40
    end,
})

table.insert(actions,
{
    id          = "COMMANDER_BULLET",
    name 		= "$action_commander_bullet",
    description = "$actiondesc_commander_bullet",
    sprite 		= "data/ui_gfx/gun_actions/commander_bullet.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- COMMANDER_BULLET
    spawn_probability                 = "", -- COMMANDER_BULLET
    price = 160,
    mana = 50,
    --max_uses = 80,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/commander_bullet.xml")
        c.fire_rate_wait = c.fire_rate_wait + 10
        draw_actions( 3, true )
    end,
})

table.insert(actions,
{
    id          = "PLASMA_FLARE",
    name 		= "$action_plasma_flare",
    description = "$actiondesc_plasma_flare",
    sprite 		= "data/ui_gfx/gun_actions/plasma_flare.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- PLASMA_FLARE
    spawn_probability                        = "", -- PLASMA_FLARE
    price = 230,
    mana = 40,
    max_uses    = 30, 
    custom_xml_file = "data/entities/misc/custom_cards/plasma_flare.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/orb_pink_fast.xml")
    end,
})

table.insert(actions,
{
    id          = "KEYSHOT",
    name 		= "$action_keyshot",
    description = "$actiondesc_keyshot",
    sprite 		= "data/ui_gfx/gun_actions/keyshot.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- KEYSHOT
    spawn_probability                        = "", -- KEYSHOT
    price = 999,
    mana = 300,
    max_uses    = 3, 
    action 		= function()
        add_projectile("data/entities/projectiles/deck/keyshot.xml")
        current_reload_time = current_reload_time + 100
    end,
})

table.insert(actions,
{
    id          = "MANA",
    name 		= "$action_mana",
    description = "$actiondesc_mana",
    sprite 		= "data/ui_gfx/gun_actions/mana.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- MANA
    spawn_probability                        = "", -- MANA
    price = 100,
    mana = -200,
    max_uses    = 5, 
    custom_xml_file = "data/entities/misc/custom_cards/mana.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/deck/mana.xml")
    end,
})


table.insert(actions,
{
    id          = "SKULL",
    name 		= "$action_skull",
    description = "$actiondesc_skull",
    sprite 		= "data/ui_gfx/gun_actions/skull.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- SKULL
    spawn_probability                        = "", -- SKULL
    price = 150,
    mana = 60,
    max_uses    = 20, 
    action 		= function()
        add_projectile("data/entities/projectiles/deck/skull.xml")
    end,
})


table.insert(actions,
{
    id          = "BUILDING_BOARD_WOOD",
    name 		= "$action_building_board_wood",
    description = "$actiondesc_building_board_wood",
    sprite 		= "data/ui_gfx/gun_actions/building_board_wood.png",
    type 		= ACTION_TYPE_MATERIAL,
    spawn_level                       = "", -- BUILDING_BOARD_WOOD
    spawn_probability                 = "", -- BUILDING_BOARD_WOOD
    price = 100,
    mana = 1,
    max_uses    = 3,
    custom_uses_logic = true,
    custom_xml_file = "data/entities/misc/custom_cards/action_building_board_wood.xml",
    action 		= function()
        c.fire_rate_wait = c.fire_rate_wait + 0
        current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
    end,
})


table.insert(actions,
{
    id          = "TELEPORT_HOME",
    name 		= "$action_teleport_home",
    description = "$actiondesc_teleport_home",
    sprite 		= "data/ui_gfx/gun_actions/teleport_home.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- TELEPORT_HOME
    spawn_probability                 = "", -- TELEPORT_HOME
    price = 100,
    mana = 70,
    max_uses    = 5,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/teleport_home.xml")
        c.fire_rate_wait = c.fire_rate_wait + 30
        c.screenshake = c.screenshake + 5.0
    end,
})


table.insert(actions,
{
    id          = "LEVITATION_PROJECTILE",
    name 		= "$action_levitation_projectile",
    description = "$actiondesc_levitation_projectile",
    sprite 		= "data/ui_gfx/gun_actions/levitation_projectile.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- LEVITATION_PROJECTILE
    spawn_probability                        = "", -- LEVITATION_PROJECTILE
    price = 100,
    mana = 80,
    custom_xml_file = "data/entities/misc/custom_cards/levitation_projectile.xml",
    action 		= function()
        add_projectile("data/entities/projectiles/deck/levitation_projectile.xml")
        c.fire_rate_wait = c.fire_rate_wait + 3
        c.screenshake = c.screenshake + 0.5
        c.spread_degrees = c.spread_degrees - 1.0
    end,
})

table.insert(actions,
{
    id          = "HIGH_EXPLOSIVE",
    name 		= "$action_high_explosive",
    description = "$actiondesc_high_explosive",
    sprite 		= "data/ui_gfx/gun_actions/high_explosive.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- HIGH_EXPLOSIVE
    spawn_probability                        = "", -- HIGH_EXPLOSIVE
    price = 100,
    max_uses    = 5,
    custom_xml_file = "data/entities/misc/custom_cards/high_explosive.xml",
    action 		= function()
        c.explosion_radius = c.explosion_radius + 64.0
        c.damage_explosion = c.damage_explosion + 3.2
        c.fire_rate_wait   = c.fire_rate_wait + 10
        c.speed_multiplier = c.speed_multiplier * 0.75
        c.ragdoll_fx = 2
        c.explosion_damage_to_materials = c.explosion_damage_to_materials + 300000
    end,
})

table.insert(actions,
{
    id          = "DRONE",
    name 		= "$action_drone",
    description = "$actiondesc_drone",
    sprite 		= "data/ui_gfx/gun_actions/drone.png",
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "", -- DRONE
    spawn_probability                        = "", -- DRONE
    price = 100,
    mana = 60,
    max_uses    = 5,
    custom_xml_file = "data/entities/misc/custom_cards/action_drone.xml",
    action 		= function()
        add_projectile("data/entities/misc/player_drone.xml")
        c.fire_rate_wait = c.fire_rate_wait + 60
    end,
})

table.insert(actions,
{
    id          = "LIFETIME_INFINITE",
    name 		= "$action_lifetime_infinite",
    description = "$actiondesc_lifetime_infinite",
    sprite 		= "data/ui_gfx/gun_actions/lifetime_infinite.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "3,4,5,6", -- LIFETIME
    spawn_probability                 = "0.5,0.5,0.5,0.5", -- LIFETIME
    spawn_requires_flag	= "card_unlocked_infinite",
    price = 350,
    mana = 120,
    max_uses = 3,
    custom_xml_file = "data/entities/misc/custom_cards/lifetime_infinite.xml",
    action 		= function()
        c.extra_entities = c.extra_entities .. "data/entities/misc/lifetime_infinite.xml,"
        c.fire_rate_wait = c.fire_rate_wait + 13
        draw_actions( 1, true )
    end,
})

table.insert(actions,
{
    id          = "PENETRATE_WALLS",
    name 		= "$action_penetrate_walls",
    description = "$actiondesc_penetrate_walls",
    sprite 		= "data/ui_gfx/gun_actions/penetrate_walls.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- PENETRATE_WALLS
    spawn_probability                        = "", -- PENETRATE_WALLS
    price = 100,
    action 		= function()
        penetration_power = penetration_power + 1
    end,
})

table.insert(actions,
{
    id          = "HOMING_PROJECTILE",
    name 		= "$action_homing_projectile",
    description = "$actiondesc_homing_projectile",
    sprite 		= "data/ui_gfx/gun_actions/homing_projectile.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "2,3,4,5,6", -- HOMING_SHOOTER
    spawn_probability                 = "0.2,0.2,0.2,0.2,0.2", -- HOMING_SHOOTER
    price = 100,
    mana = 10,
    --max_uses = 100,
    action 		= function()
        c.extra_entities = c.extra_entities .. "data/entities/misc/homing_projectile.xml,data/entities/particles/tinyspark_white.xml,"
        draw_actions( 1, true )
    end,
})

table.insert(actions,
{
    id          = "TELEPATHY_FIELD",
    name 		= "$action_telepathy_field",
    description = "$actiondesc_telepathy_field",
    sprite 		= "data/ui_gfx/gun_actions/telepathy_field.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/telepathy_field_unidentified.png",
    type 		= ACTION_TYPE_STATIC_PROJECTILE,
    spawn_level                       = "", -- TELEPATHY_FIELD
    spawn_probability                 = "", -- TELEPATHY_FIELD
    price = 150,
    mana = 60,
    max_uses = 10,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/telepathy_field.xml")
        c.fire_rate_wait = c.fire_rate_wait + 15
    end,
})

table.insert(actions,
{
    id          = "TELEPORTATION",
    name 		= "$action_teleportation",
    description = "$actiondesc_teleportation",
    sprite 		= "data/ui_gfx/gun_actions/teleportation.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- TELEPORTATION
    spawn_probability                        = "", -- TELEPORTATION
    price = 100,
    mana = 10,
    max_uses = 50,
    custom_xml_file = "data/entities/misc/custom_cards/teleportation.xml",
    action 		= function()
        c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_teleportation.xml,"
        c.extra_entities = c.extra_entities .. "data/entities/particles/teleportation.xml,"
    end,
})

table.insert(actions,
{
    id          = "TELEPATHY",
    name 		= "$action_telepathy",
    description = "$actiondesc_telepathy",
    sprite 		= "data/ui_gfx/gun_actions/telepathy.png",
    type 		= ACTION_TYPE_OTHER,
    spawn_level                       = "", -- TELEPATHY
    spawn_probability                        = "", -- TELEPATHY
    price = 100,
    mana = 10,
    max_uses = 50,
    --custom_xml_file = "data/entities/misc/custom_cards/freeze.xml",
    action 		= function()
        c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_telepathy.xml,"
    end,
})

table.insert(actions,
{
    id          = "X_RAY_MODIFIER",
    name 		= "$action_x_ray_modifier",
    description = "$actiondesc_x_ray_modifier",
    sprite 		= "data/ui_gfx/gun_actions/x_ray.png",
    sprite_unidentified = "data/ui_gfx/gun_actions/x_ray_unidentified.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- X_RAY_MODIFIER
    spawn_probability                 = "", -- X_RAY_MODIFIER
    price = 150,
    mana = 8,
    --max_uses = 50,
    custom_xml_file = "data/entities/misc/fogofwar_radius.xml",
    action 		= function()
        c.lightning_count = c.lightning_count + 1
        c.damage_electricity_add = c.damage_electricity_add + 0.1
        c.extra_entities = c.extra_entities .. "data/entities/particles/electricity.xml,"
        draw_actions( 1, true )
    end,
})

table.insert(actions,
{
    id          = "DUCK",
    name 		= "$action_duck",
    description = "$actiondesc_duck",
    sprite 		= "data/ui_gfx/gun_actions/duck.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- DUCK
    spawn_probability                        = "", -- DUCK
    price = 100,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/duck.xml")
        c.damage_critical_chance = c.damage_critical_chance + 5
    end,
})

table.insert(actions,
{
    id          = "DUPLICATE_ON_DEATH",
    name 		= "$action_duplicate_on_death",
    description = "$actiondesc_duplicate_on_death",
    sprite 		= "data/ui_gfx/gun_actions/duplicate_on_death.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- DUPLICATE_ON_DEATH
    spawn_probability                        = "", -- DUPLICATE_ON_DEATH
    price = 100,
    action 		= function()
        duplicates = duplicates + 1
    end,
})

table.insert(actions,
{
    id          = "MISFIRE",
    name 		= "$action_misfire",
    description = "$actiondesc_misfire",
    sprite 		= "data/ui_gfx/gun_actions/misfire.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- MISFIRE
    spawn_probability                        = "", -- MISFIRE
    price = 100,
    action 		= function()
        discard_random_action()
    end,
})

table.insert(actions,
{
    id          = "MISFIRE_CRITICAL",
    name 		= "$action_misfire_critical",
    description = "$actiondesc_misfire_critical",
    sprite 		= "data/ui_gfx/gun_actions/misfire_critical.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- MISFIRE_CRITICAL
    spawn_probability                        = "", -- MISFIRE_CRITICAL
    price = 100,
    action 		= function()
        destroy_random_action()
    end,
})

table.insert(actions,
{
    id          = "GENERATE_RANDOM_DECK_5",
    name 		= "$action_generate_random_deck_5",
    description = "$actiondesc_generate_random_deck_5",
    sprite 		= "data/ui_gfx/gun_actions/generate_random_deck_5.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- GENERATE_RANDOM_DECK_5
    spawn_probability                        = "", -- GENERATE_RANDOM_DECK_5
    price = 100,
    action 		= function()
        generate_random_deck(5)
    end,
})

table.insert(actions,
{
    id          = "GORE",
    name 		= "Gore",
    description = "Extra blood",
    sprite 		= "data/ui_gfx/gun_actions/gore.png",
    type 		= ACTION_TYPE_MODIFIER,
    spawn_level                       = "", -- GORE
    spawn_probability                        = "", -- GORE
    mana = 0,
    action 		= function()
        c.ragdoll_fx = 3
        shot_effects.recoil_knockback = shot_effects.recoil_knockback + 90.0
    end,
})


table.insert(actions,
{
    id          = "BUILDING_BOARD_WOOD",
    name 		= "Wooden mold",
    description = "Useful for cement construction. REQUIRES SOLAR POWER TO RECHARGE.",
    sprite 		= "data/ui_gfx/gun_actions/building_board_wood.png",
    type 		= ACTION_TYPE_MATERIAL,
    spawn_level                       = "", -- BUILDING_BOARD_WOOD
    spawn_probability                 = "", -- BUILDING_BOARD_WOOD
    mana = 1,
    max_uses    = 3,
    custom_uses_logic = true,
    custom_xml_file = "data/entities/misc/custom_cards/action_building_board_wood.xml",
    action 		= function()
        c.fire_rate_wait = c.fire_rate_wait + 0
        current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
    end,
})

--[[
table.insert(actions,
)
]]--