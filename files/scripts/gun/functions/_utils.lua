local state_per_cast = function(state)
    copi_state.skipping = false
    copi_state.mana_multiplier = 1.0
end

local discard_action = function()
    discarded[#discarded + 1] = table.remove(deck, 1)
end

local deck_from_actions = function(actions, start_index)
    local deck = {}
    for action_index = (start_index or 1), #actions do
        deck[#deck + 1] = actions[action_index]
    end
    return deck
end

local temporary_deck = function(deck_fn, new_deck, new_hand, new_discarded)
    -- Save old cardpiles
    local old = {
        _deck = deck,
        _hand = hand,
        _discarded = discarded,
    }

    -- Temporarily set cardpiles
    deck = new_deck
    hand = new_hand
    discarded = new_discarded

    -- Run fn
    deck_fn(deck, hand, discarded)

    -- Restore old cardpiles
    deck = old._deck
    hand = old._hand
    discarded = old._discarded
end

--- ### Gets the current card entity.
--- ***
--- @param wand integer The wand to inspect, should match held wand. Use `current_wand(shooter)` to get.
--- @return integer|nil card The *Entity ID* of the card being played.
local current_card = function (wand)
    local wand_actions = EntityGetAllChildren(wand) or {}
    for j = 1, #wand_actions do
        local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[j], "ItemComponent")
        if itemcomp then
            if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id then
                return wand_actions[j]
            end
        end
    end
    return nil
end

--- ### Gets the held item, and returns if it is a wand
--- ***
--- @param shooter integer The entity which you wish to check
--- @return integer|nil item The held item
--- @return boolean is_wand If the item is a wand
local current_wand = function (shooter)
    local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
    if inv2comp then
        local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
        return activeitem, EntityHasTag(activeitem, "wand")
    end
    error("No Inventory2Component!")
    return nil, false
end

--- ### Updates the held wand icon
--- ***
--- @param wand integer The wand you wish to update
--- @param keep_unique boolean|nil If you want to keep unique wand sprites
--- @return boolean updated If the sprite updated
local update_wand_sprite = function (wand, keep_unique)
    --[[ /data/scripts/gun/procedural/gun_procedural.lua MODIFIED ]]

    local function clamp(a, b, c)
        return math.min(math.max(a, b), c)
    end
    
    local function wand_diff( gun_a, gun_b )
        local score = 0
        score = score + ( math.abs( gun_a.fire_rate_wait            - wand.fire_rate_wait           ) * 02 )
        score = score + ( math.abs( gun_a.actions_per_round         - wand.actions_per_round        ) * 20 )
        score = score + ( math.abs( gun_a.shuffle_deck_when_empty   - wand.shuffle_deck_when_empty  ) * 30 )
        score = score + ( math.abs( gun_a.deck_capacity             - wand.deck_capacity            ) * 05 )
        score = score + ( math.abs( gun_a.spread_degrees            - wand.spread_degrees           ) )
        score = score + ( math.abs( gun_a.reload_time               - wand.reload_time              ) )
        return score
    end

    function GetWand( gun )
        dofile_once("data/scripts/gun/procedural/wands.lua")
        local gun_in_wand_space = {
            fire_rate_wait          = clamp(((gun["fire_rate_wait"]+5)/7)-1,    0, 4),
            actions_per_round       = clamp(gun["actions_per_round"]-1,         0, 2),
            shuffle_deck_when_empty = clamp(gun["shuffle_deck_when_empty"],     0, 1),
            deck_capacity           = clamp((gun["deck_capacity"]-3)/3,         0, 7),
            spread_degrees          = clamp(((gun["spread_degrees"]+5)/5)-1,    0, 2),
            reload_time             = clamp(((gun["reload_time"]+5)/25)-1,      0, 2),
        }
        local best = {
            wand = nil,
            score = 1000
        }

        for i = 1, #wands do
            local curr_wand = wands[i]
            local score = wand_diff( gun_in_wand_space, curr_wand )

            if score <= best.score then
                best.wand = curr_wand
                best.score = score
                -- just randomly return one of them...
                if( score == 0 and Random(0,100) < 33 ) then
                    return best.wand
                end
            end
        end
        return best.wand
    end

    local ability = EntityGetComponentIncludingDisabled(wand, "AbilityComponent")
    if type(ability) == "number" then
        local sprite_file = ComponentGetValue2(ability, "sprite_file")
        if keep_unique and (sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil) then
            return false
        end
    end

    return false
end

--- ### Applies a table of changes to a wand
--- ***
--- @param ability integer the AbilityComponent
--- @param changes table the changes to apply
local update_ability = function (ability, changes)
    for i=1,#changes do
        local change = changes[i]
        if change.object~=nil then  -- object stuff
            if change.modify~=nil then
                local old = ComponentObjectGetValue2(ability, change.object, change.key)
                ComponentObjectSetValue2(ability, change.object, change.key, change.modify(old))
            elseif change.value~=nil then
                ComponentObjectSetValue2(ability, change.object, change.key, change.value)
            else
                error('no change defined!')
            end
        else    -- cbb to not do it this way just use the func as intended
            if change.modify~=nil then
                local old = ComponentGetValue2(ability, change.key)
                ComponentSetValue2(ability, change.key, change.modify(old))
            elseif change.value~=nil then
                ComponentSetValue2(ability, change.key, change.value)
            else
                error('no change defined!')
            end
        end
    end
end

--- ### Returns a lookup table of spells by ID
--- ***
--- @return table lookup_spells the AbilityComponent
local lookup_spells = function ()
    if copi_state.lookup_spells == nil then
        copi_state.lookup_spells = {}
        for i=1,#actions do
            copi_state.lookup_spells[actions[i].id] = actions[i]
            copi_state.lookup_spells[actions[i].id]['index'] = i
        end
    end
    return copi_state.lookup_spells
end


--- o/ sorry this file isn't the cleanest as-is
return {
    lookup_spells = lookup_spells,
    update_ability = update_ability,
    current_wand = current_wand,
    current_card = current_card,
    state_per_cast = state_per_cast,
    discard_action = discard_action,
    deck_from_actions = deck_from_actions,
    temporary_deck = temporary_deck,
}