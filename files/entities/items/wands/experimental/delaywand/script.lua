local generator = dofile_once("mods/copis_things/files/entities/items/wands/wand_generator.lua")
-- re-enable frozen when it's not broken as fuck :pensive:
generator({
    id = GetUpdatedEntityID(),
    --is_frozen = true,
    name = "Experimental Wand: Automated",
    stats = {
        mana_max = 500,
        mana_charge_speed = 100,
    },
    gun_config = {
        actions_per_round = 1,
        shuffle_deck_when_empty = false,
        reload_time = 30,
    },
    gunaction_config = {
        spread_degrees = 0,
        speed_multiplier = 0.8,
        fire_rate_wait = 30,
    },
    actions = {
        permanently_attached = {
            -- None
        },
        regular = {
            -- Long Distance Cast
            {
                id = "LONG_DISTANCE_CAST",
                --frozen = true
            },
            -- Add Mana
            {
                id = "MANA_REDUCE",
            },
            -- Burst Fire
            {
                id = "COPITH_BURST_FIRE",
                --frozen = true
            },
            -- Auto-Aim
            {
                id = "AUTOAIM",
                --frozen = true
            },
            -- Spark Bolt
            {
                id = "LIGHT_BULLET",
            },
            -- Empty Slot
            {
                blank = true
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