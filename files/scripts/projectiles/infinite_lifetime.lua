dofile("data/scripts/lib/utilities.lua")
local EZWand = dofile_once("mods/yourmod/lib/EZWand/EZWand.lua")

local function get_active_item()
    local player = EntityGetWithTag("player_unit")[1]
    local inv = EntityGetComponent(player, "Inventory2Component")[1]
    return ComponentGetValueInt(inv, "mActiveItem")   
end

-- Returns true if entity is a wand
local function entity_is_wand(entity_id)
    local ability_component = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")
    return ComponentGetValue2(ability_component, "use_gun_script") == true
end

local active_item = get_active_item()
if entity_is_wand(active_item) then
  local wand = EZWand(active_item)
  wand.capacity = 10
end