local entity_id    = EntityGetRootEntity( GetUpdatedEntityID() )
local vscs = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
for i=1, #vscs do
    if ComponentGetValue2(vscs[i], "name") == "grappling_hook_shot_count" then
        local how_many = ComponentGetValue2(vscs[i], "value_int")
        ComponentSetValue2(vscs[i], "value_int", how_many+1)
        break
    end
end