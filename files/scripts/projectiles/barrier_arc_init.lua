local projectile = GetUpdatedEntityID()
if EntityGetName(projectile) ~= "separator" then
    EntityAddTag(projectile, "BARRIER_ARC")
end