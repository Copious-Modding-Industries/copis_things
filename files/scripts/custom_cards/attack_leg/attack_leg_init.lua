local entity_id = GetUpdatedEntityID()
dofile_once("data/scripts/lib/utilities.lua")
local x, y = EntityGetTransform(entity_id)






if is_enabled then
    EntityAddChild(entity_id, EntityLoad("mods/copis_things/files/entities/misc/attack_leg.xml"))
else
    for i, child_id in ipairs(EntityGetAllChildren(entity_id) or {}) do
        if EntityGetName(child_id) == "ATTACK_LEG" then
            EntityRemoveFromParent(child_id)
            EntityKill(child_id)
        end
    end
end

