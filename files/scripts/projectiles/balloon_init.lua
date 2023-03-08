local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if comp ~= nil then
    local who_shot = ComponentGetValue2(comp, "mWhoShot")
    local potion = nil
    local inventories = EntityGetAllChildren(who_shot) or {}
    for inventory_index = 1, #inventories do
        if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
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
        local suc = EntityGetFirstComponentIncludingDisabled(potion, "MaterialSuckerComponent")
        local inv = EntityGetFirstComponentIncludingDisabled(potion, "MaterialInventoryComponent")
        if inv ~= nil and suc ~= nil then
            local counts = ComponentGetValue2(inv, "count_per_material_type")
            local capacity = ComponentGetValue2(suc, "barrel_size")
            local total = 0
            for i = 1, #counts do
                total = total + counts[i]
            end
            if total > 0 then
                for i=1, #counts do
                    local mat = {
                        id     = CellFactory_GetName(i-1),
                        amount = (capacity / 10) * (counts[i] / total)
                    }
                    AddMaterialInventoryMaterial(entity_id, mat.id, mat.amount)
                    AddMaterialInventoryMaterial(potion, mat.id, math.max(0, counts[i] - mat.amount))
                end
            end
        end
    end
end
