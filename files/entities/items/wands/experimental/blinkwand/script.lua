local generator = dofile_once("mods/copis_things/files/entities/items/wands/wand_generator.lua")
-- re-enable frozen when it's not broken as fuck :pensive:
generator({
    id = GetUpdatedEntityID(),
    name = "Experimental Wand: Blink",
    --is_frozen = true,
    stats = {
        mana_max = 200,
        mana_charge_speed = 50,
    },
    gun_config = {
        actions_per_round = 5,
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
            -- Transmission Cast
            {
                id = "COPIS_THINGS_TRANSMISSION_CAST",
            },
        },
        regular = {
            -- Sword Formation
            {
                id = "SUPER_TELEPORT_CAST",
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