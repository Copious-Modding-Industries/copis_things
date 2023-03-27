local entity_id = GetUpdatedEntityID()

local projectilecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if projectilecomp ~= nil then
    local bounces = ComponentGetValue2(projectilecomp, "bounces_left")
    local bounces_lastframe = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "bounces_lastframe" )
    local bounced_frame = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "bounced_frame" )
    if (bounces_lastframe ~= nil) and (bounced_frame ~= nil) then
        local value_int = ComponentGetValue2( bounces_lastframe, "value_int" )
        if bounces < value_int then
            GamePrint(tostring(bounces))
            ComponentSetValue2( bounces_lastframe, "value_int", bounces )
            ComponentSetValue2( bounced_frame, "value_int", GameGetFrameNum() )
        end
    end
end