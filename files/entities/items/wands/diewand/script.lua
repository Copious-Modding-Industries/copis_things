local generator = dofile_once("mods/copis_things/files/entities/items/wands/wand_generator.lua")
-- re-enable frozen when it's not broken as fuck :pensive:
generator({
    id = GetUpdatedEntityID(),
    name = "Wand of Death",
    --is_frozen = true,
    stats = {
        mana_max = 9432700,
        mana_charge_speed = 832890,
    },
    gun_config = {
        actions_per_round = 5,
        shuffle_deck_when_empty = false,
        reload_time = 10,
    },
    gunaction_config = {
        spread_degrees = 0,
        speed_multiplier = 0.1,
        fire_rate_wait = 10,
        screenshake = 20,
    },
    actions = {
        permanently_attached = {
            -- Transmission Cast
            {
                id = "COPITH_DIE",
            },
        },
        regular = {
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
            { blank = true },
        }
    }
})