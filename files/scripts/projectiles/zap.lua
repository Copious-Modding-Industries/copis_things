---@diagnostic disable: param-type-mismatch, redundant-parameter
local entity = GetUpdatedEntityID();
local velocity = EntityGetFirstComponentIncludingDisabled( entity, "VelocityComponent" );
if velocity ~= nil then
    local comp = EntityGetFirstComponent( entity, "VariableStorageComponent", "zap_frames" );
    if comp ~= nil then
        local frame = ComponentGetValue2( comp, "value_int" ) + 1
        ComponentSetValue2( comp, "value_int", frame);
        local vx,vy = ComponentGetValue2( velocity, "mVelocity", vx, vy );
        local scale = math.min( 1, 0.25 * frame * 0.5 );
        local angle = math.atan2( vy, vx ) + (math.random() - 0.5) * math.pi * scale;
        local magnitude = math.sqrt( vx * vx + vy * vy );
        ComponentSetValue2( velocity, "mVelocity", math.cos( angle ) * magnitude, math.sin( angle ) * magnitude );
    end
end