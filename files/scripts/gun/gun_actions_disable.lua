-- Disable unwanted actions
for i = 1, #actions do
    local action = actions[i]
    if not ModSettingGet("CopisThings.spelltoggle" .. action.id) then
        local replacement = {
            disabled = true,
            id = action.id,
            name = action.name,
            description = "This content is disabled via Copi's Things.",
            sprite = action.sprite,
            type = action.type,
            spawn_level = "0",
            spawn_probability = "0",
            spawn_requires_flag = "this_should_never_spawn",
            price = 0,
            mana = 0,
            action = function()
                if not reflecting then
                    local shooter = GetUpdatedEntityID()
                    local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
                    if inv2comp then
                        local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
                        if EntityHasTag(activeitem, "wand") then
                            local wand_actions = EntityGetAllChildren(activeitem) or {}
                            for j = 1, #wand_actions do
                                local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[j], "ItemComponent")
                                if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id then
                                    EntityKill(wand_actions[j])
                                    print(table.concat{"[COPIS THINGS]: ACTION ", action.id, " WHICH IS DISABLED HAS BEEN CASTED!"})
                                end
                            end
                        end
                    end
                end
            end
        }
        actions[i] = replacement
    end
end
