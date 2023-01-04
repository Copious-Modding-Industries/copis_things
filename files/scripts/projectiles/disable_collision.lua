local projcomp = EntityGetFirstComponent(GetUpdatedEntityID(), "ProjectileComponent")
if projcomp then ComponentSetValue2(projcomp, "collide_with_world", false) end