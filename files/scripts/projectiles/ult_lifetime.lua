local function EntityGetChildrenWithTag( entity_id, tag )
    local valid_children = {};
    local children = EntityGetAllChildren( entity_id ) or {};
    for index, child in pairs( children ) do
        if EntityHasTag( child, tag ) then
            table.insert( valid_children, child );
        end
    end
    return valid_children;
end

local function get_entity_held_or_random_wand( entity, or_random )
    if or_random == nil then or_random = true; end
    local base_wand = nil;
    local wands = {};
    local children = EntityGetAllChildren( entity ) or {};
    for key,child in pairs( children ) do
        if EntityGetName( child ) == "inventory_quick" then
            wands = EntityGetChildrenWithTag( child, "wand" );
            break;
        end
    end
    if #wands > 0 then
        local inventory2 = EntityGetFirstComponent( entity, "Inventory2Component" );
            if inventory2 then
            local active_item = ComponentGetValue2( inventory2, "mActiveItem" );
            for _,wand in pairs( wands ) do
                if wand == active_item then
                    base_wand = wand;
                    break;
                end
            end
            if base_wand == nil and or_random then
                SetRandomSeed( EntityGetTransform( entity ) );
                base_wand =  Random( 1, #wands );
            end
        end
    end
    return base_wand;
end

--[[
local wands = {}
local base_wand = nil;
-- get inventory
for _, shooter_child in shooter:children().ipairs() do
    if shooter_child:name() == "inventory_quick" then
        -- get wands
        for _, inventory_child in shooter_child:children().ipairs() do
            if inventory_child:hasTag("wand") then
                table.insert(wands, inventory_child)
            end
        end
        break
    end
end
if #wands > 0 then
    if shooter.Inventory2Component then
        local active_item = shooter.Inventory2Component.mActiveItem
        for _,wand in pairs( wands ) do
            if wand == active_item then
                base_wand = wand;
                break;
            end
        end
    end
end
]]

dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()

if self.ProjectileComponent then
    -- get shooter
    local shooter = self.ProjectileComponent.mWhoShot
    if shooter and shooter ~= 0 then
        local wand = get_entity_held_or_random_wand(shooter, false)
        if wand then
            if wand.AbilityComponent then
                local mana = wand.AbilityComponent.mana
                local mana_drain = 0.5
                if mana > mana_drain then
                    wand.AbilityComponent.mana = math.max(mana - mana_drain, 0)
                else
                    self:kill()
                end
            end
        else
            self:kill()
        end
    end
end
