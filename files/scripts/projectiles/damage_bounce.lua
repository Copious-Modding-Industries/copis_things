local entity_id = GetUpdatedEntityID()

local projectilecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if projectilecomp ~= nil then
    local bounces = ComponentGetValue2(projectilecomp, "bounces_left")
    local vsc = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "bounces_lastframe" );
    if vsc ~= nil then
        local bounces_lastframe = ComponentGetValue2( vsc, "value_int" )
        if bounces < bounces_lastframe then
            ComponentSetValue2( vsc, "value_int", bounces );
            ComponentSetValue2(projectilecomp, "damage", ComponentGetValue2(projectilecomp, "damage") + 0.4)
        end
    end
end