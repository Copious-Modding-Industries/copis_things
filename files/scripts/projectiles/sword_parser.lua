local projectile = GetUpdatedEntityID()
if EntityGetName(projectile) ~= "separator" then
    EntityAddTag(projectile, "SWORD_FORMATION")
end