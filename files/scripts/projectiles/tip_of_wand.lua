dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local player = EntityGetWithTag( "player_unit" )[1]
local pos_x, pos_y = EntityGetTransform( player )
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

edit_component( entity_id, "ProjectileComponent", function(comp,vars)
    vars.die_on_low_velocity = 0
end)
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






function WandGetActive( entity )
    local chosen_wand = nil;
    local wands = {};
    local children = EntityGetAllChildren( entity )  or {};
    for key, child in pairs( children ) do
        if EntityGetName( child ) == "inventory_quick" then
            wands = EntityGetChildrenWithTag( child, "wand" );
            break;
        end
    end
    if #wands > 0 then
        local inventory2 = EntityGetFirstComponent( entity, "Inventory2Component" );
        local active_item = ComponentGetValue2( inventory2, "mActiveItem" );
        for _,wand in pairs( wands ) do
            if wand == active_item then
                chosen_wand = wand;
                break;
            end
        end
        return chosen_wand;
    end
end