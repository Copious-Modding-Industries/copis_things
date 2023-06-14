
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
        if count > 1 then   -- Indoctrate the children.
            -- This was a fucking migraine to get working. Please, don't touch.
            local children = EntityGetAllChildren(entity_who_picked) or {}
            for i=1,#children do
                if EntityHasTag(children[i], "perk_entity") then
                    local uic = EntityGetFirstComponentIncludingDisabled(children[i], "UIIconComponent") --[[@cast uic number]]
                    if ComponentGetValue2(uic, "icon_sprite_file") == "mods/copis_things/files/ui_gfx/perk_icons/recursion.png" then
                        ComponentSetValue2(uic, "icon_sprite_file", "mods/copis_things/files/ui_gfx/perk_icons/recursion_used.png")
                        ComponentSetValue2(uic, "name", "$perk_name_copis_things_recursion_used")
                        ComponentSetValue2(uic, "description", "$perk_desc_copis_things_recursion_used")
                    end
                end
            end
        end
    end

    -- Give perk
    for i=1,count do
        -- cant be bothered to make custom particle emitter for this, it'd be cool if it did some fancier gfx if you pick up while doing recursion
        old.perk_pickup(entity_item, entity_who_picked, item_name, (i==1 and do_cosmetic_fx), kill_other_perks)
    end
end

return {perk_pickup=perk_pickup}