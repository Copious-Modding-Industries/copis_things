local projectile = GetUpdatedEntityID()
if EntityGetName(projectile) ~= "separator" then
    EntityAddTag(projectile, "LINK_FORMATION")
end