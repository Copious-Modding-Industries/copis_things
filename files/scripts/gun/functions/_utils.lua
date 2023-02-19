local utils = {

    state_per_cast = function(state)
        copi_state.skipping = false
        copi_state.mana_multiplier = 1.0
    end,

    discard_action = function()
        discarded[#discarded + 1] = table.remove(deck, 1)
    end,

    deck_from_actions = function(actions, start_index)
        local deck = {}
        for action_index = (start_index or 1), #actions do
            deck[#deck + 1] = actions[action_index]
        end
        return deck
    end,

    temporary_deck = function(deck_fn, new_deck, new_hand, new_discarded)
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
    end,
}
return utils