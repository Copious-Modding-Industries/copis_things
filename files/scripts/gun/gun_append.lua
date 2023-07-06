---@diagnostic disable: lowercase-global
-- State
copi_state = {
    -- Mana multiplier and stuff
    mana_multiplier = 1.0,
    duplicating_action = false,
    recursion_count = 0,

    -- Used in skip spells
    skip_count = 0,
    skipping = false,
    skip_type = {                                                                   ---@type table
        [0] = false,                                                                    ---@type boolean
        [1] = false,                                                                    ---@type boolean
        [2] = false,                                                                    ---@type boolean
        [3] = false,                                                                    ---@type boolean
        [4] = false,                                                                    ---@type boolean
        [5] = false,                                                                    ---@type boolean
        [6] = false,                                                                    ---@type boolean
        [7] = false,                                                                    ---@type boolean
    },

    -- Various draw related variables
    draw_depth = 0,
    peeking_depth = 0,
    add_projectile_depth = 0,
    draw_cancel = false,

    -- Used to capture drawn actions, doesnt do much *yet*
    draw_actions_capture = nil,

    -- I forgot what this is for
    instant_reload_if_empty = true,

    -- Used to measure if we're doing a new cast, to increment cast state global
    new_cast = nil,

    --- Stores the lookup table for spells
    ---@see GunUtils.lookup_spells function
    lookup_spells = nil,

    --- Should we do a full clone of actions for deck and card playing?
    ---@see clone_action function
    full_clone = true,

    --- Do we flip the deck when ordering?
    ---@see order_deck
    flip_deck = false,

    -- Old functions to monkey patch
    old = {                                                                         ---@type table
        _order_deck                         = order_deck,                               ---@type function
        _draw_shot                          = draw_shot,                                ---@type function
        _add_projectile                     = add_projectile,                           ---@type function
        _add_projectile_trigger_timer       = add_projectile_trigger_timer,             ---@type function
        _add_projectile_trigger_hit_world   = add_projectile_trigger_hit_world,         ---@type function
        _add_projectile_trigger_death       = add_projectile_trigger_death,             ---@type function
        _set_current_action                 = set_current_action,                       ---@type function
        _draw_actions                       = draw_actions,                             ---@type function
        _draw_action                        = draw_action,                              ---@type function
        _register_action                    = register_action,                          ---@type function
        _create_shot                        = create_shot,                              ---@type function
        _clone_action                       = clone_action,                             ---@type function
    }
}

--[[
gun.*:
    shuffle_deck_when_empty
    deck_capacity
    actions_per_round
    reload_time
]]

--- ### Utility Functions
--- ***
--- @class Utilities
--- @field lookup_spells function Returns a lookup table of spells
--- @field update_ability function Updates an AbilityComponent's values
--- @field current_wand function Returns the current wand
--- @field current_card function Returns the current card
--- @field state_per_cast function Resets the state per cast
--- @field discard_action function Discards an action
--- @field deck_from_actions function Generates a deck from actions
--- @field temporary_deck function Creates a temporary deck
GunUtils            = dofile_once("mods/copis_things/files/scripts/gun/functions/_utils.lua")                                       ---@type Utilities

-- Monkey Patching
order_deck          = dofile_once("mods/copis_things/files/scripts/gun/functions/order_deck.lua").order_deck                        ---@type function
draw_shot           = dofile_once("mods/copis_things/files/scripts/gun/functions/draw_shot.lua").draw_shot                          ---@type function
draw_action         = dofile_once("mods/copis_things/files/scripts/gun/functions/draw_action.lua").draw_action                      ---@type function
register_action     = dofile_once("mods/copis_things/files/scripts/gun/functions/register_action.lua").register_action              ---@type function
add_projectile      = dofile_once("mods/copis_things/files/scripts/gun/functions/add_projectile.lua").add_projectile                ---@type function
create_shot         = dofile_once("mods/copis_things/files/scripts/gun/functions/create_shot.lua").create_shot                      ---@type function
set_current_action  = dofile_once("mods/copis_things/files/scripts/gun/functions/set_current_action.lua").set_current_action        ---@type function
clone_action        = dofile_once("mods/copis_things/files/scripts/gun/functions/clone_action.lua").clone_action                    ---@type function
draw_actions        = draw_actions --[[ TODO: Patch this, only here for annotation ]]                                               ---@type function

-- New Funcs
peek_draw_actions   = dofile_once("mods/copis_things/files/scripts/gun/functions/peek_draw_actions.lua").peek_draw_actions          ---@type function
peek_draw_action    = dofile_once("mods/copis_things/files/scripts/gun/functions/peek_draw_action.lua").peek_draw_action            ---@type function