function peek_draw_action( shot, instant_reload_if_empty )
    local action = nil;

    if not reflecting then
        if #deck <= 0 then
            if instant_reload_if_empty then
                move_discarded_to_deck();
                order_deck();
                start_reload = true;
            else
                -- NOTE we are setting reloading to true here so that peek draw actions resolves correctly, but we were not (and are now) resetting this to false. IT IS GLOBAL STATE
                reloading = true;
                return true;
            end
        end

        if #deck > 0 then
            -- draw from the start of the deck
            action = table.remove( deck, 1 )

            -- update mana
            local action_mana_required = action.mana;
            if action.mana == nil then
                action_mana_required = ACTION_MANA_DRAIN_DEFAULT;
            end

            mana = mana - action_mana_required;
        end

        if action ~= nil then
            play_action( action );
        end

        return true;
    end

end
return {peek_draw_action}