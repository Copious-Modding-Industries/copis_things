dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
edit_component( entity_id, "ProjectileComponent", function(comp,vars)
    vars.go_through_this_material = "wood_player"
end)