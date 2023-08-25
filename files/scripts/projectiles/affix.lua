-- This breaks shit
local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if proj then
    EntityAddChild(ComponentGetValue2(proj, "mWhoShot"), entity_id)
end