local perk_pickup_old = perk_pickup
local function perk_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks )

    local valid = false
    do  -- Get if perk can be recursed
        local vscs = EntityGetComponent(entity_item, "VariableStorageComponent") or {}
        for i=1, #vscs do
            if ComponentGetValue2( vscs[i], "name" ) == "perk_id" then
                ---@diagnostic disable-next-line: undefined-global
                local data = get_perk_with_id( perk_list, ComponentGetValue2( vscs[i], "value_string" ) )
                valid = (data ~= nil) and (data.stackable == true)
                break
            end
        end
    end

    local count = 1
    if valid then -- Set count to pick up
        local vscs = EntityGetComponent(entity_who_picked, "VariableStorageComponent") or {}
        for i=1, #vscs do
            if ComponentGetValue2( vscs[i], "name" ) == "copi_recursion_stacks" then
                count = ComponentGetValue2( vscs[i], "value_int" )
                ComponentSetValue2( vscs[i], "value_int", 0 )
                break
            end
        end
    end

    -- Give perk
    for i=1,count do
        perk_pickup_old(entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks)
    end
end

return {perk_pickup=perk_pickup}