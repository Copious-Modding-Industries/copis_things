local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if comp ~= nil then
    -- Find shooter inventory
    local who_shot = ComponentGetValue2(comp, "mWhoShot")
    local potion = nil
    local inventories = EntityGetAllChildren(who_shot) or {}
    for inventory_index = 1, #inventories do
        if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
            -- Find last potion tagged item
            local children = EntityGetAllChildren(inventories[inventory_index]) or {}
            for i = 1, #children do
                if EntityHasTag(children[i], "potion") then
                    potion = children[i]
                end
            end
            break
        end
    end
    if potion ~= nil then
        -- Capacity is held in the suckercomp, and how much it has is in matinvcomp
        local suc = EntityGetFirstComponentIncludingDisabled(potion, "MaterialSuckerComponent")
        local inv = EntityGetFirstComponentIncludingDisabled(potion, "MaterialInventoryComponent")
        if inv ~= nil and suc ~= nil then
            local counts = ComponentGetValue2(inv, "count_per_material_type")
            local capacity = ComponentGetValue2(suc, "barrel_size")
            local total = 0
            -- Build a counter for total material remaining
            for i = 1, #counts do
                total = total + counts[i]
            end
            -- Go over all materials, do maths
            if total > 0 then
                for i=1, #counts do
                    local mat = {
                        id     = CellFactory_GetName(i-1),
                        amount = (capacity / 10) * (counts[i] / total)
                    }
                    -- This is a lie: it *sets* the remaining amount
                    AddMaterialInventoryMaterial(entity_id, mat.id, mat.amount)
                    AddMaterialInventoryMaterial(potion, mat.id, math.max(0, counts[i] - mat.amount))
                end
            end
        end
    end
end
