dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
local entity = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled( entity, "ProjectileComponent" );
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0;
    local aim_angle = 0;
    local components = EntityGetAllComponents( shooter ) or {};
    for _,component in pairs( components ) do
        if ComponentGetTypeName( component ) == "ControlsComponent" then
            local ax, ay = ComponentGetValue2( component, "mAimingVector" );
            if ax ~= nil and ay ~= nil then
                aim_angle = math.atan2( ay, ax );
            end
            break;
        end
    end
    self.var_float.copis_things_persistent_shot_angle = aim_angle
end