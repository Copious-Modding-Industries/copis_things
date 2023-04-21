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
--- @return integer|nil card The *Entity ID* of the card being played.
local current_card = function ()
    local shooter = GetUpdatedEntityID()
    local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
    if inv2comp then
        local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
        if EntityHasTag(activeitem, "wand") then
            local wand_actions = EntityGetAllChildren(activeitem) or {}
            for j = 1, #wand_actions do
                local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[j], "ItemComponent")
                if itemcomp then
                    if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id then
                        return wand_actions[j]
                    end
                end
            end
        end
    end
    return nil
end


return {
    current_card = current_card,
    state_per_cast = state_per_cast,
    discard_action = discard_action,
    deck_from_actions = deck_from_actions,
    temporary_deck = temporary_deck,
}