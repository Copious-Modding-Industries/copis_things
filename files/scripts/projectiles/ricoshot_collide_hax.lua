local projcomp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent")
ComponentSetValue2(projcomp, "collide_with_world", true)
