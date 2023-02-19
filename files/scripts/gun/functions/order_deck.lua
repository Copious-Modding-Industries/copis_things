local function get_force_sorted(caster)
    local force_sorted = false
    local base_wand = nil
    local wands = {}
    local inventories = EntityGetAllChildren(caster) or {}
    for inventory_index = 1, #inventories do
        if inventories[inventory_index] == "inventory_quick" then
            local children = EntityGetAllChildren(inventories[inventory_index]) or {}
            for i = 1, #children do
                if EntityHasTag(children[i], "wand") then
                    wands[#wands+1] = children[i]
                end
            end
            break
        end
    end
    if #wands > 0 then
        local inventory2 = EntityGetFirstComponent(caster, "Inventory2Component")
        local active_item = ComponentGetValue2(inventory2, "mActiveItem")
        for wand_index = 1, #wands do
            if wands[wand_index] == active_item then
                base_wand = wands[wand_index]
                break
            end
        end
    end
    if base_wand ~= nil then
        local wand_children = EntityGetAllChildren(base_wand) or {}
        for i=1,#wand_children do
            if EntityHasTag( wand_children[i], "card_action" ) then
                local components = EntityGetComponent( wand_children[i], "ItemActionComponent" ) or {}
                for iac_index = 1, #components do
                    if ComponentGetValue2( components[iac_index] "action_id" ) == "GKBRKN_ORDER_DECK" then
                        force_sorted = true
                        GamePrint("Force Sorted")
                        break
                    end
                end
            end
            if force_sorted then
                break
            end
        end
    end
    return force_sorted
end

local function order_deck()
    local force_sorted = get_force_sorted(Shooter)

    if force_sorted then
        local before = gun.shuffle_deck_when_empty
        gun.shuffle_deck_when_empty = false
        copi_state.old._order_deck()
        gun.shuffle_deck_when_empty = before
    else
        copi_state.old._order_deck()
    end

    -- This allows me to hook into the mana access and call an arbitrary function. Very tricksy :^)
    for _, action in pairs(deck) do
        if action.copi_mana_calculated == nil then
            if action.type == ACTION_TYPE_PROJECTILE or action.type == ACTION_TYPE_STATIC_PROJECTILE or
                action.type == ACTION_TYPE_MATERIAL or action.type == ACTION_TYPE_UTILITY then
                local base_mana = action.mana or 0
                action.mana = nil
                local action_meta = {
                    __index = function(table, key)
                        if key == "mana" then
                            return base_mana * copi_state.mana_multiplier
                        end
                    end
                }
                setmetatable(action, action_meta)
            end
            action.copi_mana_calculated = true
        end
    end
end

return {order_deck = order_deck}