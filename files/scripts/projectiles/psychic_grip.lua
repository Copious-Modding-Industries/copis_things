dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local pcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
local shooter = ComponentGetValue2( pcomp, "mWhoShot" ) or 0;
ComponentSetValue2(pcomp, "die_on_low_velocity", false)
local pos_x, pos_y = EntityGetTransform( shooter )
local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")
if (mouse_x == nil or mouse_y == nil) then return end
local aim_x = mouse_x - pos_x
local aim_y = mouse_y - pos_y
local len = math.sqrt((aim_x^2) + (aim_y^2))
local length = 25

local angle = math.atan(aim_y/aim_x)
if aim_x < 0 then
    angle = angle + 3.14159
end



--[[
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
    vars.gravity_x = 0
    vars.air_friction= 0
    vars.mass= 0
    ComponentSetValueVector2( comp, "mVelocity", 0, 0)
end)
]]

EntitySetTransform( entity_id, pos_x+(aim_x/len*length), pos_y+(aim_y/len*length), angle)