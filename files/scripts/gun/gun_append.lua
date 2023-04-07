---@diagnostic disable: lowercase-global
-- State
copi_state = {
    mana_multiplier = 1.0,
    duplicating_action = false,
    recursion_count = 0,

    skip_count = 0,
    skipping = false,
    skip_type = {
        [0] = false,
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [5] = false,
        [6] = false,
        [7] = false,
    },

    draw_depth = 0,
    peeking_depth = 0,
    add_projectile_depth = 0,

    draw_actions_capture = nil,

    instant_reload_if_empty = true,

    new_cast = nil,

    old = { -- Old functions
        _order_deck                         = order_deck,
        _draw_shot                          = draw_shot,
        _add_projectile                     = add_projectile,
        _add_projectile_trigger_timer       = add_projectile_trigger_timer,
        _add_projectile_trigger_hit_world   = add_projectile_trigger_hit_world,
        _add_projectile_trigger_death       = add_projectile_trigger_death,
        _set_current_action                 = set_current_action,
        _draw_actions                       = draw_actions,
        _draw_action                        = draw_action,
        _register_action                    = register_action,
        _create_shot                        = create_shot,
    }
}

--[[
gun.*:
    shuffle_deck_when_empty
    deck_capacity
    actions_per_round
    reload_time
]]

-- Utility Functions
GunUtils            = dofile_once("mods/copis_things/files/scripts/gun/functions/_utils.lua")

-- SORRY FOR OVERWRITING THIS :(
set_current_action  = dofile_once("mods/copis_things/files/scripts/gun/functions/set_current_action.lua").set_current_action

-- Monkey Patching
order_deck          = dofile_once("mods/copis_things/files/scripts/gun/functions/order_deck.lua").order_deck
draw_shot           = dofile_once("mods/copis_things/files/scripts/gun/functions/draw_shot.lua").draw_shot
draw_action         = dofile_once("mods/copis_things/files/scripts/gun/functions/draw_action.lua").draw_action
register_action     = dofile_once("mods/copis_things/files/scripts/gun/functions/register_action.lua").register_action
add_projectile      = dofile_once("mods/copis_things/files/scripts/gun/functions/add_projectile.lua").add_projectile
create_shot         = dofile_once("mods/copis_things/files/scripts/gun/functions/create_shot.lua").create_shot

-- New Funcs
peek_draw_actions   = dofile_once("mods/copis_things/files/scripts/gun/functions/peek_draw_actions.lua").peek_draw_actions
peek_draw_action    = dofile_once("mods/copis_things/files/scripts/gun/functions/peek_draw_action.lua").peek_draw_action