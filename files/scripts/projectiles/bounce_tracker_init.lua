local entity_id = GetUpdatedEntityID()

local projectilecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if projectilecomp ~= nil then
    local bounces = ComponentGetValue2(projectilecomp, "bounces_left")
    local bounces_lastframe = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "bounces_lastframe" );
    if bounces_lastframe ~= nil then
        ComponentSetValue2( bounces_lastframe, "value_int", bounces );
    end
end