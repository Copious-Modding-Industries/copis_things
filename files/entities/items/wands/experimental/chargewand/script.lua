local generator = dofile_once("mods/copis_things/files/entities/items/wands/wand_generator.lua")
-- re-enable frozen when it's not broken as fuck :pensive:
generator({
    id = GetUpdatedEntityID(),
    name = "Experimental Wand: Charging",
    --is_frozen = true,
    stats = {
        mana_max = 500,
        mana_charge_speed = 100,
    },
    gun_config = {
        actions_per_round = 1,
        shuffle_deck_when_empty = false,
        reload_time = 10,
    },
    gunaction_config = {
        spread_degrees = 30,
        speed_multiplier = 1,
        fire_rate_wait = 10,
    },
    actions = {
        permanently_attached = {
            -- None
        },
        regular = {
            -- Sword Formation
            {
                id = "COPITH_SWORD_FORMATION",
                --frozen = true
            },
            -- Stored Cast
            {
                id = "COPITH_STORED_SHOT",
                --frozen = true
            },
            -- Overheat Engine
            {
                id = "COPITH_DAMAGE_ENGINE",
                --frozen = true
            },
            -- Concentrated Light
            {
                id = "LASER",
                --frozen = true
            },
            -- Empty Slot
            {
                blank = true
            },
            -- Empty Slot
            {
                blank = true
            },
        }
    }
})