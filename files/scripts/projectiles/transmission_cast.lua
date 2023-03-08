local entity_id = GetUpdatedEntityID()
local comp = EntityGetComponent(entity_id, "TeleportProjectileComponent") or {}
if not (#comp > 1) then
    EntityAddComponent2(entity_id, "TeleportProjectileComponent", {
        min_distance_from_wall = 4
    })
end