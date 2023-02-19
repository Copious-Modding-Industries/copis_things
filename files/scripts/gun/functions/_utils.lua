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
    GamePrint("!!")
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

return {
    state_per_cast = state_per_cast,
    discard_action = discard_action,
    deck_from_actions = deck_from_actions,
    temporary_deck = temporary_deck,
}