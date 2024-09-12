dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local pcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
local shooter = ComponentGetValue2( pcomp, "mWhoShot" ) or 0;

local controls = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
if controls ~= nil then
    local mouse_x, mouse_y = ComponentGetValue2(controls, "mMousePosition")

    local speed = 400

    local velcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" )
    local vel_x, vel_y = ComponentGetValue2( velcomp, "mVelocity")

    local len = math.pow((mouse_x*mouse_x) + (mouse_y*mouse_y), 0.45)

    local force_x = vel_x + (mouse_x-pos_x)/len * speed
    local force_y = vel_y + (mouse_y-pos_y)/len * speed

    if get_magnitude(force_x, force_y) >= 400 then
        force_x, force_y = vec_normalize(force_x, force_y)
        force_x, force_y = vec_mult(force_x, force_y, 400)
    end

    ComponentSetValueVector2( velcomp, "mVelocity", force_x or 0, force_y or 0)
end