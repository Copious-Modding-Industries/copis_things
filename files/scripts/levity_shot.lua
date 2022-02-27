dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
  end)