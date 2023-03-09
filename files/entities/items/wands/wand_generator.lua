dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local generate_wand = function( wand_data )

    local acomp = EntityGetFirstComponentIncludingDisabled(wand_data.id, "AbilityComponent")
    local icomp = EntityGetFirstComponentIncludingDisabled(wand_data.id, "ItemComponent")

    for key, value in pairs(wand_data.stats) do
        ComponentSetValue2(acomp, key, value)
    end

    for key, value in pairs(wand_data.gun_config) do
        ComponentObjectSetValue2(acomp, "gun_config", key, value)
    end

    for key, value in pairs(wand_data.gunaction_config) do
        ComponentObjectSetValue2(acomp, "gunaction_config", key, value)
    end

    if wand_data.name ~= nil then
        ComponentSetValue2(icomp, "item_name", wand_data.name)
        ComponentSetValue2(icomp, "always_use_item_name_in_ui", true)
    end

    if wand_data.is_frozen == true then
        ComponentSetValue2(icomp, "is_frozen", true)
    end

    -- Add Capacity
    ComponentObjectSetValue2(acomp, "gun_config", "deck_capacity",
    #wand_data.actions.permanently_attached + #wand_data.actions.regular)

    -- Add always cast spells
    for i = 1, #wand_data.actions.permanently_attached do
        local action = wand_data.actions.permanently_attached[i]
        local action_id = CreateItemActionEntity(action.id)
        EntityAddChild(wand_data.id, action_id)
        EntitySetComponentsWithTagEnabled(action_id, "enabled_in_world", false)
        local item = EntityGetFirstComponentIncludingDisabled(action_id, "ItemComponent")
        ComponentSetValue(item, "permanently_attached", "1")
    end

    -- Add regular spells
    for i = 1, #wand_data.actions.regular do
        local action = wand_data.actions.regular[i]
        if not action.blank or action.id ~= nil then
            local action_id = CreateItemActionEntity(action.id)
            EntityAddChild(wand_data.id, action_id)
            EntitySetComponentsWithTagEnabled(action_id, "enabled_in_world", false)
            if action.frozen then
                local item = EntityGetFirstComponentIncludingDisabled(action_id, "ItemComponent")
                ComponentSetValue2(item, "is_frozen", true)
            end
        else
            local action_id = CreateItemActionEntity("KILL_THIS")
            EntityAddChild(wand_data.id, action_id)
            EntitySetComponentsWithTagEnabled(action_id, "enabled_in_world", false)
        end
    end

    -- Kill blank spells
    local wand_actions = EntityGetAllChildren(wand_data.id) or {}
    for i = 1, #wand_actions do
        if EntityHasTag(wand_actions[i], "card_action") then
            local iac = EntityGetFirstComponentIncludingDisabled(wand_actions[i], "ItemActionComponent")
            if ComponentGetValue2(iac, "action_id") == "KILL_THIS" then
                EntityKill(wand_actions[i])
            end
        end
    end
end

return generate_wand