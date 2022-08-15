dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local shooter = Entity(self.ProjectileComponent.mWhoShot)

if shooter ~= nil then
    local inventory = shooter:children():search(function(ent) return ent:name() == "inventory_quick" end)
    local items = inventory:children()
    if items then
        for _, item in items:ipairs() do
            if item:hasTag("potion") then
                local count_per_material_type = item.MaterialInventoryComponent.count_per_material_type
                local item_capacity = item.MaterialSuckerComponent.barrel_size
                local total = 0
                for material_index, material_value in ipairs(count_per_material_type) do
                    total = total + material_value
                end
                if total > 0 then
                    for material_index, material_value in ipairs(count_per_material_type) do
                        local mat = {
                            id      = material_index - 1,
                            amount  = (item_capacity/10) * (material_value/total)
                        }
                        self:setMaterialCount(mat.id, mat.amount)
                        item:setMaterialCount(mat.id, math.max(0,material_value - mat.amount))
                    end
                    break
                end
            end
        end
    end
end