local function get_force_sorted(caster)
    local force_sorted = false
    local flip_every_other = false
    local base_wand = nil
    local wands = {}
    local inventories = EntityGetAllChildren(caster) or {}
    for inventory_index = 1, #inventories do
        if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
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
                local iac = EntityGetFirstComponentIncludingDisabled( wand_children[i], "ItemActionComponent" ) --[[@cast iac number]]
                local action_id = ComponentGetValue2( iac, "action_id" )
                if action_id == "COPIS_THINGS_ORDER_DECK" then
                    force_sorted = true
                --[[elseif action_id == "COPIS_THINGS_FLIP_EVERY_OTHER" then
                    flip_every_other = true]] break
                end
            end
        end
    end
    return force_sorted--, flip_every_other
end

local function order_deck()

    copi_state.skip_type = {
        [0] = false,
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [5] = false,
        [6] = false,
        [7] = false,
    }

    local shooter = GetUpdatedEntityID()
    local force_sorted--[[, flip_every_other]] = get_force_sorted(shooter)

    if force_sorted then
        local before = gun.shuffle_deck_when_empty
        gun.shuffle_deck_when_empty = false
        copi_state.old._order_deck()
        gun.shuffle_deck_when_empty = before
    else
        copi_state.old._order_deck()
    end

    local vscs = EntityGetComponent(shooter, "VariableStorageComponent") or {}
    local vid = nil
    for i=1, #vscs do
        if ComponentGetValue2( vscs[i], "name" ) == "mana_efficiency_mult" then
            vid = vscs[i]
            break
        end
    end
    local shooter_mult = ComponentGetValue2(vid, "value_float") or 1.0
    --[[
    if flip_every_other then
        copi_state.flip_deck = not copi_state.flip_deck
        if copi_state.flip_deck then
            table.sort(deck, function(x, y) return x.deck_index > y.deck_index end)
            print("HEY!")
        end
        shooter_mult = shooter_mult/2
    end]]


    --[[
    print(string.rep("\n", 3))
    print(string.rep("=", 131))
    ]]
    -- This allows me to hook into the mana access and call an arbitrary function. Very tricksy :^)
    for _, action in pairs(deck) do
        --[[
        print(string.rep("\n", 3))
        print(string.rep("-", 131))
        for key, value in pairs(action) do
            print(string.format("%-60s | %70s", tostring(key), GameTextGetTranslatedOrNot(tostring(value))))
        end
        ]]
        if action.copi_mana_calculated == nil then
            local meta = {}
            if action.skip_mana then
                action.mana = 0
            elseif action.type == ACTION_TYPE_PROJECTILE or action.type == ACTION_TYPE_STATIC_PROJECTILE or
                action.type == ACTION_TYPE_MATERIAL or action.type == ACTION_TYPE_UTILITY then
                local base_mana = action.mana or 0
                action.mana = nil
                meta['__index'] = function(table, key)
                    if key == "mana" then
                        return (base_mana * copi_state.mana_multiplier) * shooter_mult
                    end
                end
            end
            setmetatable(action, meta)
            action.copi_mana_calculated = true
        end
    end
end

return {order_deck = order_deck}