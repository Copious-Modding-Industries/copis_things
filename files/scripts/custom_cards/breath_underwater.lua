dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)

if root ~= nil and root ~= 0 then
    local damage_model_component = EntityGetFirstComponent(root, "DamageModelComponent")
    ComponentSetValue2(damage_model_component, "air_in_lungs", 7)
end