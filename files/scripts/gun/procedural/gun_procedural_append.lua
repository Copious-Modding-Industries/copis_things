
local generate_gun_old = generate_gun
function generate_gun( cost, level, force_unshuffle )
    generate_gun_old( cost, level, force_unshuffle)

    local entity_id = GetUpdatedEntityID()


    EntityAddComponent2(entity_id, "VariableStorageComponent", {
        name = "COPI_WAND_MODIFIED"
    })


end