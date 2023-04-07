local function create_shot( num_of_cards_to_draw )
    local shot = copi_state.old._create_shot(num_of_cards_to_draw)
    return shot
end
return {create_shot = create_shot}