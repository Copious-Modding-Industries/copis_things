-- State
copi_state = {
    mana_multiplier = 1.0,
    old = {
        _order_deck = order_deck,
        _draw_shot = draw_shot,
        _add_projectile = add_projectile,
        _add_projectile_trigger_timer = add_projectile_trigger_timer,
        _add_projectile_trigger_hit_world = add_projectile_trigger_hit_world,
        _add_projectile_trigger_death = add_projectile_trigger_death,
        _set_current_action = set_current_action,
    }
}

-- Consts
Shooter = GetUpdatedEntityID();

-- Hook into add projectile funcs for perk
--dofile_once("mods/copis_things/files/scripts/gun/gun_append_upgrade_projectile.lua")

Cast = 0

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
    local base_wand = WandGetActive(Shooter);
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

    Cast = Cast + 1
end







-- SORRY FOR OVERWRITING THIS :(
function set_current_action( action )
    -- CAST STATE VALUE             |       -- ACTION VALUE             |   -- FALLBACK
	c.action_id                	            = action.id
	c.action_name              	            = action.name
	c.action_sprite_filename   	            = action.sprite
	c.action_type              	            = action.type
	c.action_recursive                      = action.recursive
	c.action_spawn_level       	            = action.spawn_level
	c.action_spawn_probability 	            = action.spawn_probability
	c.action_spawn_requires_flag            = action.spawn_requires_flag
	c.action_spawn_manual_unlock            = action.spawn_manual_unlock    or false
	c.action_max_uses          	            = action.max_uses
	c.custom_xml_file          	            = action.custom_xml_file
	c.action_ai_never_uses		            = action.ai_never_uses          or false
	c.action_never_unlimited	            = action.never_unlimited        or false
	c.action_is_dangerous_blast             = action.is_dangerous_blast
	c.sound_loop_tag                        = action.sound_loop_tag
	c.action_mana_drain                     = action.mana                   or ACTION_MANA_DRAIN_DEFAULT
	c.action_unidentified_sprite_filename   = action.sprite_unidentified    or ACTION_UNIDENTIFIED_SPRITE_DEFAULT

    if reflecting then
        c.action_description                = action.description
    end

	current_action = action
end







NewCast = nil

function draw_shot( shot, instant_reload_if_empty )
    -- ??? wtf it works I guess
    local call_end_cast = false
    if NewCast == nil then
        call_end_cast = true
        NewCast = false
        local state = tonumber(GlobalsGetValue("GLOBAL_CAST_STATE", "0"))
        GlobalsSetValue("GLOBAL_CAST_STATE", tostring( state + 1))
    end

    if call_end_cast then
        NewCast = nil
    end

    copi_state.old._draw_shot( shot, instant_reload_if_empty )
end