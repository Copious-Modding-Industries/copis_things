local projectile = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(projectile, "ProjectileComponent")
ComponentSetValue2(projcomp, "penetrate_world", false )