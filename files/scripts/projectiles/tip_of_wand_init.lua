dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

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

local self = Entity.Current()

self.var_int.offset_x = true
self.var_int.offset_y = true

local shooter = 0

if self.ProjectileComponent then
    shooter = self.ProjectileComponent.mWhoShot
end


local active_wand = WandGetActive( shooter );
if active_wand ~= nil then
    local wx, wy = EntityGetTransform( active_wand );
    EntityApplyTransform( entity, wx + math.cos( aim_angle + angle_offset ) * distance, wy + math.sin( aim_angle + angle_offset ) * distance );
end
