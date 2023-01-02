local entity_id = GetUpdatedEntityID()

local projectilecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if projectilecomp ~= nil then
    local bounces = ComponentGetValue2(projectilecomp, "bounces_left")
    local vsc = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "bounces_lastframe" );
    if vsc ~= nil then
        ComponentSetValue2( vsc, "value_int", bounces );
    end
end