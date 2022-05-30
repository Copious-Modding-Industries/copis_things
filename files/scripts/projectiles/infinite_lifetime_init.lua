dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
edit_component( entity_id, "ProjectileComponent", function(comp,vars)
  vars.lifetime = -1
end)