copi_state = {
    mana_multiplier = 1.0,
    old = {
        _order_deck = order_deck,
    }
}

function WandGetActive(entity)
    local chosen_wand = nil;
    local wands = {};
    local children = EntityGetAllChildren(entity) or {};
    for key, child in pairs(children) do
        if EntityGetName(child) == "inventory_quick" then
            wands = EntityGetChildrenWithTag(child, "wand");
            break;
        end
    end
    if #wands > 0 then
        local inventory2 = EntityGetFirstComponent(entity, "Inventory2Component");
        local active_item = ComponentGetValue2(inventory2, "mActiveItem");
        for _, wand in pairs(wands) do
            if wand == active_item then
                chosen_wand = wand;
                break;
            end
        end
        return chosen_wand;
    end
end

function EntityGetChildrenWithTag(entity_id, tag)
    local valid_children = {};
    local children = EntityGetAllChildren(entity_id) or {};
    for index, child in pairs(children) do
        if EntityHasTag(child, tag) then
            table.insert(valid_children, child);
        end
    end
    return valid_children;
end

function order_deck()
    local force_sorted = false;
    local player = GetUpdatedEntityID();
    local base_wand = WandGetActive(player);
    if base_wand ~= nil then
        local wand_children = EntityGetAllChildren(base_wand) or {};
        for _, wand_child in pairs(wand_children) do
            if EntityHasTag(wand_child, "card_action") then
                local components = (EntityGetAllComponents(wand_child) or {});
                for _, component in ipairs(components) do
                    if ComponentGetTypeName(component) == "ItemActionComponent" then
                        if ComponentGetValue2(component, "action_id") == "COPIS_THINGS_ORDER_DECK" then
                            force_sorted = true;
                        end
                    end
                end
            end
        end
    end

    if force_sorted then
        local before = gun.shuffle_deck_when_empty;
        gun.shuffle_deck_when_empty = false;
        copi_state.old._order_deck();
        gun.shuffle_deck_when_empty = before;
    else
        copi_state.old._order_deck();
    end

    -- This allows me to hook into the mana access and call an arbitrary function. Very tricksy
    for _, action in pairs(deck) do
        if action.copi_mana_calculated == nil then
            if action.type == ACTION_TYPE_PROJECTILE or action.type == ACTION_TYPE_STATIC_PROJECTILE or
                action.type == ACTION_TYPE_MATERIAL or action.type == ACTION_TYPE_UTILITY then
                local base_mana = action.mana or 0;
                action.mana = nil;
                local action_meta = {
                    __index = function(table, key)
                        if key == "mana" then
                            return base_mana * copi_state.mana_multiplier;
                        end
                    end
                }
                setmetatable(action, action_meta);
            end
            action.copi_mana_calculated = true;
        end
    end
end
